<?php

include_once('wms_core.php');

class ModelToolWMSProduct extends ModelToolWMS {

    private $season = '2013';

    function import($stylenumber = "") {


        $msc = microtime(true);

        $this->debugMode = $this->config->get('wms_products_debug');

        $this->debug("fetching " . ($stylenumber == "" ? "ALL STYLES" : "style " . $stylenumber) . " from wms");

        $this->truncate();

        if (!$this->cacheWMSData($stylenumber))
            return false;

        //FIX We need to add all filters to all categories
        $aCatgeories = $this->db->query('SELECT category_id FROM `' . DB_PREFIX . 'category`');
        foreach ($aCatgeories->rows AS $category) {
            $aFilters = $this->db->query('SELECT filter_id FROM `' . DB_PREFIX . 'filter` WHERE filter_id NOT IN (SELECT filter_id FROM `' . DB_PREFIX . 'category_filter` WHERE category_id = ' . $category['category_id'] . ')');
            foreach ($aFilters->rows AS $filter) {
                $this->db->query('INSERT INTO `' . DB_PREFIX . 'category_filter` SET category_id = ' . $category['category_id'] . ', filter_id = ' . $filter['filter_id']);
            }
        }

        $msc = microtime(true) - $msc;

        $this->debug("Import Complete" . ':' . round($msc, 2) . ' seconds');
        return true;
    }

    function truncate() {

        if ($this->config->get('wms_products_truncate')) {

            $this->debug("truncating tables");

//            $this->db->query("TRUNCATE " . DB_PREFIX . "attribute");
//            $this->db->query("TRUNCATE " . DB_PREFIX . "attribute_description");
//            $this->db->query("TRUNCATE " . DB_PREFIX . "attribute_group");
//            $this->db->query("TRUNCATE " . DB_PREFIX . "attribute_group_description");

            $this->db->query("TRUNCATE `" . DB_PREFIX . "category`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "category_description`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "category_to_layout`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "category_to_store`");

            $this->db->query("TRUNCATE `" . DB_PREFIX . "filter`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "filter_description`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "filter_group`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "filter_group_description`");

            $this->db->query("TRUNCATE `" . DB_PREFIX . "manufacturer`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "manufacturer_to_store`");

            $this->db->query("TRUNCATE `" . DB_PREFIX . "product`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_attribute`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_filter`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_description`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_image`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_option`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_option_value`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_related`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_reward`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_special`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_category`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_download`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_layout`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_store`");

            $this->db->query("TRUNCATE `" . DB_PREFIX . "option`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "option_description`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "option_value`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "option_value_description`");

            $this->db->query('DELETE FROM `' . DB_PREFIX . 'url_alias` WHERE query LIKE "product_id=%" OR query LIKE "category_id=%"');
        }
    }

    function cacheWMSData($stylenumber = "", $forceRefresh = false) {
        $this->debug("fetching products from wms");
//        $aProduct = $this->dbQF->Execute('SELECT * FROM styles WHERE IFNULL(styles.stylenumber,"") <> "" AND styles.inactive = 0 AND styles.webenabled = 1 AND (styles.available_stock > 0 OR styles.season LIKE "2013%") ORDER BY styles.stylenumber');
        $limit = intval($this->config->get('wms_products_limit'));
        $aProductSql = 'SELECT * FROM styles WHERE IFNULL(styles.stylenumber,"") ' . ($stylenumber == "" ? '<> ""' : '= "' . $stylenumber . '"' ) . ' ' . ($stylenumber == "" ? ' AND styles.inactive = 0 AND styles.webenabled = 1 AND (styles.available_stock > 0 OR styles.season LIKE "' . $this->season . '%") ' : '' ) . ' ORDER BY styles.stylenumber' . ($limit > 0 ? ' LIMIT ' . $limit : '');
        $this->debug($aProductSql);
        $aProduct = $this->dbQF->Execute($aProductSql);

        $myModel = "";
        $product_id = 0;
        $myProductIds = array();
        $myProductOptionIds = array();
        $error = false;

        $cnt = 10;
        if ($aProduct->RecordCount() > 0) {
            while (!$aProduct->EOF) {
                //delay execution so other processes have a chance
                $cnt--;
                if ($cnt < 1) {
                    $this->debug("Pausing import for 5 secs");
                    sleep(5);
                    $cnt = 9;
                }
                $this->debug("=================================================================================================");
                $this->debug("processing product " . $aProduct->fields['stylenumber'] . " " . $aProduct->fields['stylename'] . "");

                if ($aProduct->fields['webenabled'] && !$aProduct->fields['inactive']) {


                    $filter_size_group_id = $this->createFilter("Size", 0, "Taille");
                    $filter_colour_group_id = $this->createFilter("Colour", 0, "Couleur");

                    $this->debug("initializing category array");
                    $myCategoryIds = array();
                    $myFilterIds = array();

                    $genders = array("womens");
                    $this->debug("fetching product gender(s)");
                    $aGender = $this->dbQF->Execute('SELECT g.* FROM genders g WHERE g.uuid = "' . $aProduct->fields['genderid'] . '"');
                    if ($aGender->RecordCount() > 0) {
                        switch (strtolower($aGender->fields['name'])) {
                            case "unisex":
                                $genders[] = "mens";
                                break;
                            case "mens":
                                $genders = array("mens");
                                break;
                        }
                    }

                    // Loop round all genders and create relevant categories
                    foreach ($genders as $gender) {

                        $this->debug("fetching product categories");
                        $aCategories = $this->dbQF->Execute('SELECT c.* FROM categories c WHERE c.uuid IN (SELECT categoryid FROM stylestocategories WHERE styleid = "' . $aProduct->fields['uuid'] . '")');
                        $type = "";
                        $myCategory = "";

                        // Always add product to "Product" Category
                        $category = seoUrl((string) "Product");
                        $category_description = array(
                            $this->languageId => array(
                                'name' => (string) "Product",
                                'meta_keyword' => "Product",
                                'keyword' => seoUrl("Product"),
                                'meta_description' => "",
                                'description' => "All products",
                                'description' => "All products"
                            ),
                            $this->languageFr => array(
                                'name' => (string) "Produit",
                                'meta_keyword' => "Produit",
                                'keyword' => seoUrl("Produit"),
                                'meta_description' => "",
                                'description' => "All produits"
                                ));
                        if ($myCategory != $category) {
                            $myCategory = $category;
                            $parent_type_id = $this->createCategory($gender, $category, $category_description, null, 0);
                            $filter_group_id = $this->createFilter("Product", 0, "Produit");
                        }
                        if ($parent_type_id) {
                            if (!in_array($parent_type_id, $myCategoryIds))
                                $myCategoryIds[] = $parent_type_id;
                        } else {
                            $error = true;
                        }

                        if ($aCategories->RecordCount() > 0) {
                            while (!$aCategories->EOF) {
                                $aCategory = $this->dbQF->Execute('SELECT c.* FROM categories c WHERE c.uuid = "' . ($aCategories->fields['parentid'] != "" ? $aCategories->fields['parentid'] : $aCategories->fields['uuid']) . '"');
                                $enCategory = $this->dbQF->Execute('SELECT o.* FROM category_overrides o WHERE o.categoryid = "' . ($aCategories->fields['parentid'] != "" ? $aCategories->fields['parentid'] : $aCategories->fields['uuid']) . '" AND o.site="www.soactive.com"');
                                $frCategory = $this->dbQF->Execute('SELECT o.* FROM category_overrides o WHERE o.categoryid = "' . ($aCategories->fields['parentid'] != "" ? $aCategories->fields['parentid'] : $aCategories->fields['uuid']) . '" AND o.site="www.attractive.fr"');
                                // only continue if we have a record for soactive
                                if ($enCategory->RecordCount() > 0) {
                                    $this->debug("processing category " . $aCategory->fields['webdisplayname'] . "");

                                    $myName = ((string) $enCategory->fields['webdisplayname'] != "" ? (string) $enCategory->fields['webdisplayname'] : (string) $aCategory->fields['webdisplayname']);
                                    $frName = ((string) $frCategory->fields['webdisplayname'] != "" ? (string) $frCategory->fields['webdisplayname'] : $myName);
                                    $myDesc = ((string) $enCategory->fields['webdescription'] != "" ? (string) $enCategory->fields['webdescription'] : (string) $aCategory->fields['webdescription']);
                                    $frDesc = ((string) $frCategory->fields['webdescription'] != "" ? (string) $frCategory->fields['webdescription'] : $myDesc);

                                    //initialise category variables
                                    $category = seoUrl($myName);
                                    $category_description = array(
                                        $this->languageId => array(
                                            'name' => $myName,
                                            'meta_keyword' => $myName,
                                            'keyword' => seoUrl($myName),
                                            'meta_description' => "",
                                            'description' => $myDesc
                                        ),
                                        $this->languageFr => array(
                                            'name' => (string) $frName,
                                            'meta_keyword' => $frName,
                                            'keyword' => seoUrl($frName),
                                            'meta_description' => "",
                                            'description' => $frDesc
                                            ));
                                    if ($myCategory != $category) {
                                        $myCategory = $category;
                                        $category_id = $this->createCategory($gender, $category, $category_description, $aCategory->fields['google_taxonomy'], $parent_type_id);
                                        $filter_id = $this->createFilter($myName, $filter_group_id, $frName);
                                    }
                                    if ($category_id) {
                                        if (!in_array($category_id, $myCategoryIds))
                                            $myCategoryIds[] = $category_id;
                                    } else {
                                        $error = true;
                                    }
                                    if ($filter_id) {
                                        if (!in_array($filter_id, $myFilterIds))
                                            $myFilterIds[] = $filter_id;
                                    } else {
                                        $error = true;
                                    }
                                }

                                $aCategories->MoveNext();
                            }
                        }

                        $this->debug("fetching product sports categories");
                        $aCategories = $this->dbQF->Execute('SELECT c.* FROM sports c WHERE c.uuid IN (SELECT sportid FROM stylestosports WHERE styleid = "' . $aProduct->fields['uuid'] . '")');
                        $type = "";
                        $myCategory = "";

                        // Always add product to "Activity" Category
                        $category = seoUrl((string) "Sport");
                        $category_description = array(
                            $this->languageId => array(
                                'name' => (string) "Sport",
                                'meta_keyword' => "Sport",
                                'keyword' => seoUrl("Sport"),
                                'meta_description' => "",
                                'description' => "All sports"
                            ),
                            $this->languageFr => array(
                                'name' => (string) "Sport",
                                'meta_keyword' => "Sport",
                                'keyword' => seoUrl("Sport"),
                                'meta_description' => "",
                                'description' => "All sports"
                                ));
                        if ($myCategory != $category) {
                            $myCategory = $category;
                            $parent_activity_id = $this->createCategory($gender, $category, $category_description, null, 0);
                            $filter_group_id = $this->createFilter("Sport", 0, "Sport");
                        }
                        if ($parent_activity_id) {
                            if (!in_array($parent_activity_id, $myCategoryIds))
                                $myCategoryIds[] = $parent_activity_id;
                        } else {
                            $error = true;
                        }

                        if ($aCategories->RecordCount() > 0) {
                            while (!$aCategories->EOF) {
                                $aCategory = $this->dbQF->Execute('SELECT c.* FROM sports c WHERE c.uuid = "' . ($aCategories->fields['parentid'] != "" ? $aCategories->fields['parentid'] : $aCategories->fields['uuid']) . '"');
                                $enCategory = $this->dbQF->Execute('SELECT o.* FROM sport_overrides o WHERE o.sportid = "' . ($aCategories->fields['parentid'] != "" ? $aCategories->fields['parentid'] : $aCategories->fields['uuid']) . '" AND o.site="www.soactive.com"');
                                $frCategory = $this->dbQF->Execute('SELECT o.* FROM sport_overrides o WHERE o.sportid = "' . ($aCategories->fields['parentid'] != "" ? $aCategories->fields['parentid'] : $aCategories->fields['uuid']) . '" AND o.site="www.attractive.fr"');
                                // only continue if we have a record for soactive
                                if ($enCategory->RecordCount() > 0) {
                                    $this->debug("processing category " . $aCategory->fields['webdisplayname'] . "");

                                    $myName = ((string) $enCategory->fields['webdisplayname'] != "" ? (string) $enCategory->fields['webdisplayname'] : (string) $aCategory->fields['webdisplayname']);
                                    $frName = ((string) $frCategory->fields['webdisplayname'] != "" ? (string) $frCategory->fields['webdisplayname'] : $myName);
                                    $myDesc = ((string) $enCategory->fields['webdescription'] != "" ? (string) $enCategory->fields['webdescription'] : (string) $aCategory->fields['webdescription']);
                                    $frDesc = ((string) $frCategory->fields['webdescription'] != "" ? (string) $frCategory->fields['webdescription'] : $myDesc);

                                    //initialise category variables
                                    $category = seoUrl($myName);
                                    $category_description = array(
                                        $this->languageId => array(
                                            'name' => $myName,
                                            'meta_keyword' => $myName,
                                            'keyword' => seoUrl($myName),
                                            'meta_description' => "",
                                            'description' => $myDesc
                                        ),
                                        $this->languageFr => array(
                                            'name' => (string) $frName,
                                            'meta_keyword' => $frName,
                                            'keyword' => seoUrl($frName),
                                            'meta_description' => "",
                                            'description' => $frDesc
                                            ));
                                    if ($myCategory != $category) {
                                        $myCategory = $category;
                                        $category_id = $this->createCategory($gender, $category, $category_description, null, $parent_activity_id);
                                        $filter_id = $this->createFilter($myName, $filter_group_id, $frName);
                                    }
                                    if ($category_id) {
                                        if (!in_array($category_id, $myCategoryIds))
                                            $myCategoryIds[] = $category_id;
                                    } else {
                                        $error = true;
                                    }
                                    if ($filter_id) {
                                        if (!in_array($filter_id, $myFilterIds))
                                            $myFilterIds[] = $filter_id;
                                    } else {
                                        $error = true;
                                    }
                                }

                                $aCategories->MoveNext();
                            }
                        }

                        $this->debug("fetching product brand details");
                        $aBrand = $this->dbQF->Execute('SELECT s.* FROM suppliers s WHERE s.uuid = "' . $aProduct->fields['supplierid'] . '"');

                        // Always add product to "Brand" Category
                        $category = seoUrl((string) "Brand");
                        $category_description = array(
                            $this->languageId => array(
                                'name' => (string) "Brand",
                                'meta_keyword' => "Brand",
                                'keyword' => seoUrl("Brand"),
                                'meta_description' => "",
                                'description' => "All brands"
                            ),
                            $this->languageFr => array(
                                'name' => (string) "Marque",
                                'meta_keyword' => "Marque",
                                'keyword' => seoUrl("Marque"),
                                'meta_description' => "",
                                'description' => "All marques"
                                ));
                        if ($myCategory != $category) {
                            $myCategory = $category;
                            $parent_brand_id = $this->createCategory($gender, $category, $category_description, null, 0);
                            $filter_group_id = $this->createFilter("Brand", 0, "Marque");
                        }
                        if ($parent_brand_id) {
                            if (!in_array($parent_brand_id, $myCategoryIds))
                                $myCategoryIds[] = $parent_brand_id;
                        } else {
                            $error = true;
                        }

                        if ($aBrand->RecordCount() > 0) {
                            while (!$aBrand->EOF) {
                                $this->debug("processing brand " . $aBrand->fields['name'] . "");

                                $myName = (string) $aBrand->fields['name'];
                                $myDesc = (string) $aBrand->fields['name'];
                                $frName = (string) $aBrand->fields['name'];
                                $frDesc = (string) $aBrand->fields['name'];

                                //initialise category variables
                                $category = seoUrl($myName);
                                $category_description = array(
                                    $this->languageId => array(
                                        'name' => $myName,
                                        'meta_keyword' => $myName,
                                        'keyword' => seoUrl($myName),
                                        'meta_description' => "",
                                        'description' => $myDesc
                                    ),
                                    $this->languageFr => array(
                                        'name' => (string) $frName,
                                        'meta_keyword' => $frName,
                                        'keyword' => seoUrl($frName),
                                        'meta_description' => "",
                                        'description' => $frDesc
                                        ));
                                if ($myCategory != $category) {
                                    $myCategory = $category;
                                    $category_id = $this->createCategory($gender, $category, $category_description, null, $parent_brand_id);
                                    $this->debug("category id = " . $category_id . "");
                                    $brand_id = $this->createBrand($myName);
                                    $this->debug("brand id = " . $brand_id . "");

                                    $filter_id = $this->createFilter($myName, $filter_group_id, $frName);
                                }
                                if ($category_id) {
                                    if (!in_array($category_id, $myCategoryIds))
                                        $myCategoryIds[] = $category_id;
                                } else {
                                    $error = true;
                                }
                                if ($filter_id) {
                                    if (!in_array($filter_id, $myFilterIds))
                                        $myFilterIds[] = $filter_id;
                                } else {
                                    $error = true;
                                }

                                $aBrand->MoveNext();
                            }
                        }
                    }

                    //Size guide
                    $sg_name = "";
                    $sg_html = "";
                    $aSizeGuide = $this->dbQF->Execute('SELECT * FROM sizeguides WHERE uuid = "' . $aProduct->fields['sizeguideid'] . '"');
                    if (!$aSizeGuide->EOF) {
                        $sg_name = ((string) $aSizeGuide->fields['webdisplayname'] != "" ? (string) $aSizeGuide->fields['webdisplayname'] : (string) $aSizeGuide->fields['name']);
                        $sg_html = (string) $aSizeGuide->fields['webdescription'];
                    }

                    $stock_item = array(
                        "name" => (string) $aProduct->fields['stylename'],
                        "nameFr" => (string) $aProduct->fields['stylename'],
                        "brief_summary" => $aProduct->fields['description'],
                        "brief_summaryFr" => $aProduct->fields['description'],
                        "description" => $aProduct->fields['webdescription'],
                        "descriptionFr" => $aProduct->fields['webdescription'],
                        "keywords" => $aProduct->fields['keywords'],
                        "keywordsFr" => $aProduct->fields['keywords'],
                        "status" => (int) $aProduct->fields['webenabled'],
                        "price" => (float) $aProduct->fields['unitprice'],
                        "saleprice" => (float) $aProduct->fields['saleprice'],
                        "sku" => "",
                        "size" => "",
                        "sizeFr" => "",
                        "sizeguide_name" => (string) $sg_name,
                        "sizeguide_html" => (string) $sg_html,
                        "style" => (string) $aProduct->fields['stylenumber'],
                        "colourid" => 0,
                        "quantity" => 0,
                        "categories" => $myCategoryIds,
                        "filters" => $myFilterIds,
                        "manufacturer_id" => $brand_id,
                    );

                    $frProduct = $this->dbQF->Execute('SELECT * FROM styles_translations WHERE styleid = "' . $aProduct->fields['uuid'] . '" AND site = "www.attractive.fr"');
                    if (!$frProduct->EOF) {
                        $stock_item["nameFr"] = (string) $frProduct->fields['stylename'];
                        $stock_item["brief_summaryFr"] = (string) $frProduct->fields['description'];
                        $stock_item["descriptionFr"] = (string) $frProduct->fields['webdescription'];
                        $stock_item["keywordsFr"] = (string) $frProduct->fields['keywords'];
                    }

                    $this->debug("initializing sku lookup array");
                    $aStock = $this->dbQF->Execute('SELECT products.* FROM products LEFT JOIN colours ON products.colourid = colours.uuid LEFT JOIN sizes ON products.sizeid = sizes.uuid WHERE styleid = "' . $aProduct->fields['uuid'] . '" ORDER BY colours.priority, sizes.priority');
                    if ($aStock->RecordCount() > 0) {
                        while (!$aStock->EOF) {
                            $this->debug("processing sku " . $aStock->fields['bleepid'] . "");
                            //initialise sku variables
                            $sizeEn = "one size";
                            $sizeFr = "taille unique";
                            $size_filter_id = array();
                            $aSize = $this->dbQF->Execute('SELECT * FROM sizes WHERE uuid = "' . $aStock->fields['sizeid'] . '"');
                            if (!$aSize->EOF) {
                                $sizeEn = (string) $aSize->fields['name'];

                                $sizes = explode(",", (string) $aSize->fields['custom5']);
                                $sizesFr = explode(",", (string) $aSize->fields['custom6']);
                                foreach ($sizes as $key => $size) {
                                    $sizeFr = (isset($sizesFr[$key]) ? $sizesFr[$key] : $size);
                                    if (!empty($size)) {
                                        $temp_id = $this->createFilter($size, $filter_size_group_id, $sizeFr);

                                        if ((float) $aStock->fields['available_stock']) {
                                            $size_filter_id[] = $temp_id;
                                        }
                                    }
                                }
                            }
                            $enSize = $this->dbQF->Execute('SELECT * FROM sizes_translations WHERE sizeid = "' . $aStock->fields['sizeid'] . '" AND site = "www.soactive.com"');
                            if (!$enSize->EOF)
                                $sizeEn = (string) $enSize->fields['name'];
                            $frSize = $this->dbQF->Execute('SELECT * FROM sizes_translations WHERE sizeid = "' . $aStock->fields['sizeid'] . '" AND site = "www.attractive.fr"');
                            if (!$frSize->EOF)
                                $sizeFr = (string) $frSize->fields['name'];
                            else
                                $sizeFr = $size;
//                        $size_filter_id = $this->createFilter($size, $filter_size_group_id, $sizeFr);

                            $colour = "";
                            $colourid = "0000";
                            $colour_filter_id = array();
                            $aColour = $this->dbQF->Execute('SELECT * FROM colours WHERE uuid = "' . $aStock->fields['colourid'] . '"');
                            if (!$aColour->EOF) {
                                $colour = (string) $aColour->fields['name'];
                                $colourid = str_pad((string) $aColour->fields['bleepid'], 4, "0", STR_PAD_LEFT);

                                $colours = explode(",", (string) $aColour->fields['custom5']);
                                $coloursFr = explode(",", (string) $aColour->fields['custom6']);
                                foreach ($colours as $key => $colour) {
                                    $colourFr = (isset($coloursFr[$key]) ? $coloursFr[$key] : $colour);
                                    if (!empty($colour))
                                        $colour_filter_id[] = $this->createFilter($colour, $filter_colour_group_id, $colourFr);
                                }
                            }
                            $enColour = $this->dbQF->Execute('SELECT * FROM colours_translations WHERE colourid = "' . $aStock->fields['colourid'] . '" AND site = "www.soactive.com"');
                            if (!$enColour->EOF)
                                $colour = (string) $enColour->fields['name'];
                            $frColour = $this->dbQF->Execute('SELECT * FROM colours_translations WHERE colourid = "' . $aStock->fields['colourid'] . '" AND site = "www.attractive.fr"');
                            if (!$frColour->EOF)
                                $colourFr = (string) $frColour->fields['name'];

                            $quantity = (float) $aStock->fields['available_stock'];

                            $model = (string) $aProduct->fields['stylenumber'] . "-" . $colourid;

                            $stock_item["sku"] = (string) $aStock->fields['bleepid'];
                            $stock_item["size"] = $sizeEn;
                            $stock_item["sizeFr"] = $sizeFr;
                            $stock_item["colourid"] = (int) $colourid;
                            $stock_item["quantity"] = $quantity;
                            $stock_item["location"] = $aStock->fields['location'];

                            if ($myModel != $model) {
                                $myModel = $model;
                                $product_id = $this->createProduct($model, $stock_item);
                            }
                            if ($product_id) {
                                //Manually Add Size & Colour Filter Ids
                                foreach ($size_filter_id as $add_filter_id)
                                    $this->db->query("INSERT IGNORE INTO " . DB_PREFIX . "product_filter SET product_id = '" . (int) $product_id . "', filter_id = '" . (int) $add_filter_id . "'");
                                foreach ($colour_filter_id as $add_filter_id)
                                    $this->db->query("INSERT IGNORE INTO " . DB_PREFIX . "product_filter SET product_id = '" . (int) $product_id . "', filter_id = '" . (int) $add_filter_id . "'");

                                if (!in_array($product_id, $myProductIds))
                                    $myProductIds[] = $product_id;
                                $product_option_id = $this->createProductOption($product_id, $stock_item);
                                if ($product_option_id) {
                                    if (!in_array($product_option_id, $myProductOptionIds))
                                        $myProductOptionIds[] = $product_option_id;
                                } else {
                                    $error = true;
                                }
                            } else {
                                $error = true;
                            }
                            $aStock->MoveNext();
                        }
                    }
                    $this->debug("sku lookup array initialized");
                } else {
                    $query = $this->db->query("UPDATE " . DB_PREFIX . "product set status = 0 WHERE model LIKE '" . $aProduct->fields['stylenumber'] . "-%'");
                }
                $aProduct->MoveNext();
            }
        }

        return true;
    }

    function createCategory($gender, $category, $wms_category_description, $google_taxonomy = null, $parent_id = 0) {
        if (!is_array($wms_category_description) || is_array($gender))
            return false;

        // Currently we only deal with 2 genders, not unisex and not childrens
        // so if not mens then assume womens
        switch (strtolower($gender)) {
            case "mens":
            case "male":
                $myGender = "mens";
                $myGenderFR = "hommes";
                $category = $myGender . "-" . $category;
                break;
            default:
                $myGender = "womens";
                $myGenderFR = "femmes";
                $category = $category;
                break;
        }

        foreach ($wms_category_description as $key => $description) {
            if (isset($description['keyword']) && !empty($description['keyword'])) {
                switch ($key) {
                    case 1:
                        $wms_category_description[$key]['keyword'] = $myGender . "-" . $description['keyword'];
                        break;
                    case 2:
                        $wms_category_description[$key]['keyword'] = $myGenderFR . '-' . $description['keyword'];
                        break;
                }
            }
        }

        //We only create a new category the first time it is encountered as 
        // many fields will be controlled via backoffice and we dont want to overwrite.
        $this->load->model('catalog/category');
        $category_info = $this->model_catalog_category->getCategoryByKeyword($category);

        $data = array(
            "parent_id" => (int) $parent_id,
            "top" => (int) 0,
            "column" => (int) 1,
            "sort_order" => (int) 999,
            "status" => (int) 1,
            'category_description' => $wms_category_description,
            'keyword' => $category,
            'category_store' => $this->config->get('wms_products_store'),
            'googlebase_text' => $google_taxonomy
        );

        if ($category_info) {
            $category_id = $category_info['category_id'];

            $data = array_merge($data, $category_info);

            $data["parent_id"] = $parent_id;
            $data["keyword"] = $category;
            $data['category_store'] = $this->config->get('wms_products_store');
            $data["category_description"] = (array) $this->model_catalog_category->getCategoryDescriptions($category_id);
            $data["googlebase_text"] = $google_taxonomy;

            foreach ($data["category_description"] as $key => $description) {
                if (isset($wms_category_description[$key]['keyword'])) {
                    $data["category_description"][$key]['keyword'] = $wms_category_description[$key]['keyword'];
                }
            }

            $data['category_filter'] = $this->model_catalog_category->getCategoryFilters($category_id);

            $this->model_catalog_category->editCategory($category_id, $data);
        } else {
            $category_description = $wms_category_description;

            // if product doesn't exist then create it
            $category_id = $this->model_catalog_category->addCategory($data);

            $this->db->query('INSERT INTO `' . DB_PREFIX . 'category_filter` (category_id, filter_id) SELECT ' . $category_id . ' as category_id, filter_id FROM `' . DB_PREFIX . 'filter`');

            // fetch the newly created product
            $category_info = $this->model_catalog_category->getCategory($category_id);
        }

        if (!$category_info) {
            // if product still doesn't exist then we have a problem
            return false;
        }

        return $category_id;
    }

    function createFilter($filter, $group_id = 0, $filterFr = "") {
        //We only create a new filter the first time it is encountered as 
        // many fields will be controlled via backoffice and we dont want to overwrite.
        $filter = trim($filter);
        $filterFr = trim($filterFr);
        $this->load->model('catalog/filter');
        $filter_info = $this->model_catalog_filter->getFilterByName($filter, $group_id);

        if (!$filter_info) {
            // if filter doesn't exist then create it
            if ($group_id == 0) {
                $this->db->query("INSERT INTO `" . DB_PREFIX . "filter_group` SET sort_order = '999'");
                $filter_group_id = $this->db->getLastId();
                $this->db->query("INSERT INTO " . DB_PREFIX . "filter_group_description SET filter_group_id = '" . (int) $filter_group_id . "', language_id = '" . $this->languageId . "', name = '" . $this->db->escape($filter) . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "filter_group_description SET filter_group_id = '" . (int) $filter_group_id . "', language_id = '" . $this->languageFr . "', name = '" . $this->db->escape(($filterFr == "" ? $filter : $filterFr)) . "'");
            } else {
                $this->db->query("INSERT INTO `" . DB_PREFIX . "filter` SET filter_group_id = '" . $group_id . "', sort_order = '999'");
                $filter_id = $this->db->getLastId();
                $this->db->query("INSERT INTO " . DB_PREFIX . "filter_description SET filter_id = '" . (int) $filter_id . "', filter_group_id = '" . (int) $group_id . "', language_id = '" . $this->languageId . "', name = '" . $this->db->escape($filter) . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "filter_description SET filter_id = '" . (int) $filter_id . "', filter_group_id = '" . (int) $group_id . "', language_id = '" . $this->languageFr . "', name = '" . $this->db->escape(($filterFr == "" ? $filter : $filterFr)) . "'");
            }
            // fetch the newly created filter
            $filter_info = $this->model_catalog_filter->getFilterByName($filter);
        }

        if (!$filter_info) {
            // if filter still doesn't exist then we have a problem
            return false;
        }

        if ($group_id == 0)
            return $filter_info['filter_group_id'];
        else
            return $filter_info['filter_id'];
    }

    function createBrand($brand) {
        //We only create a new filter the first time it is encountered as 
        // many fields will be controlled via backoffice and we dont want to overwrite.
        $brand = trim($brand);

        $this->load->model('catalog/manufacturer');
        $brand_info = $this->model_catalog_manufacturer->getManufacturerByName($brand);

        if (!$brand_info) {

            $data = array('name' => $brand,
                'sort_order' => 999);

            $this->model_catalog_manufacturer->addManufacturer($data);

            $brand_info = $this->model_catalog_manufacturer->getManufacturerByName($brand);
        }

        if (!$brand_info) {
            // if filter still doesn't exist then we have a problem
            return false;
        }

        return $brand_info['manufacturer_id'];
    }

    function createProduct($model, $stock_item) {
        if (!is_array($stock_item) || !array_key_exists("sku", $stock_item))
            return false;

        //Fetch the product image
        $images = array();
        $aImage = $this->dbQF->Execute("SELECT DISTINCT i.id, i.image_name, i.alt_text
                                     FROM styles_images i
                                     JOIN styles s ON (i.styleid = s.uuid)
                                     JOIN colours ON (i.colourid = colours.uuid)
                                WHERE s.stylenumber = '" . $stock_item['style'] . "'
                                      AND colours.bleepid =" . $stock_item['colourid'] . "
                                  AND i.webenabled = 1 AND i.inactive = 0
                             ORDER BY i.displayorder");
        $imgCount = 0;
        if ($aImage->RecordCount() > 0) {
            while (!$aImage->EOF) {
                $url = 'http://' . $this->config->get('wms_host') . '/modules/activewms/styles_image.php?id=' . $aImage->fields['id'];

                if (!is_dir(DIR_IMAGE . 'data/products/'))
                    mkdir(DIR_IMAGE . 'data/products/', 0755);
                $saveto = DIR_IMAGE . 'data/products/' . $model . ($imgCount > 0 ? '-' . $imgCount : '') . '.jpg';
                if (file_exists($saveto))
                    unlink($saveto);
                if (!file_exists($saveto)) {
                    $this->debug("retrieving " . $url . " and saving as " . $saveto . "");
                    grab_image($url, $saveto);
                }
                if ($imgCount > 0) {
                    $images[] = array(
                        'image' => 'data/products/' . $model . ($imgCount > 0 ? '-' . $imgCount : '') . '.jpg',
                        'sort_order' => $imgCount
                    );
                }
                $imgCount++;
                $aImage->MoveNext();
            }
        }

        $image = (file_exists($saveto) ? 'data/products/' . $model . '.jpg' : "data/soactive-logo.png");
        $this->debug("using " . $image . " as image");


        $attribute = array();
        if (!empty($stock_item['sizeguide_name'])) {
            $attribute_id = $this->tableLookUp(DB_PREFIX . "attribute_description", 'attribute_id', array('name' => 'Size Guide'));
            if (!$attribute_id) {
                // need to create the attribute
                $attribute_group_id = $this->tableLookUp(DB_PREFIX . "attribute_group_description", 'attribute_group_id', array('name' => 'Product Tabs'));
                if (!$attribute_group_id) {
                    // need to create the attribute group
                    $this->load->model('catalog/attribute_group');
                    $info_data = array(
                        'sort_order' => '999',
                        'attribute_group_description' => array(
                            $this->languageId => array(
                                'name' => "Product Tabs"
                            ),
                            $this->languageFr => array(
                                'name' => "Product Tabs"
                            )
                        )
                    );
                    $attribute_group_id = $this->model_catalog_attribute_group->addAttributeGroup($info_data);
                }
                $this->load->model('catalog/attribute');
                $info_data = array(
                    'attribute_group_id' => $attribute_group_id,
                    'sort_order' => '999',
                    'attribute_description' => array(
                        $this->languageId => array(
                            'name' => "Size Guide"
                        ),
                        $this->languageFr => array(
                            'name' => "Size Guide"
                        )
                    )
                );
                $attribute_id = $this->model_catalog_attribute->addAttribute($info_data);
            }
            $information_id = (string) $this->tableLookUp(DB_PREFIX . "information_description", 'information_id', array('category' => 'Size Guides', 'title' => $stock_item['sizeguide_name']));

            $this->load->model('catalog/information');

            if (!$information_id) {
                // need to create the information page
                $info_data = array(
                    'sort_order' => '999',
                    'status' => 1,
                    'information_description' => array(
                        $this->languageId => array(
                            'category' => "Size Guides",
                            'title' => $stock_item['sizeguide_name'],
                            'description' => $stock_item['sizeguide_html'],
                            'meta_title' => "",
                            'meta_keyword' => "",
                            'meta_description' => ""
                        ),
                        $this->languageFr => array(
                            'category' => "Size Guides",
                            'title' => $stock_item['sizeguide_name'],
                            'description' => $stock_item['sizeguide_html'],
                            'meta_title' => "",
                            'meta_keyword' => "",
                            'meta_description' => ""
                        )
                    ),
                    'information_store' => $this->config->get('wms_products_store')
                );
                $information_id = $this->model_catalog_information->addInformation($info_data);
            } else {
                $info_data = $this->model_catalog_information->getInformation($information_id);

                $info_data['information_description'] = $this->model_catalog_information->getInformationDescriptions($information_id);
                $info_data['information_store'] = $this->config->get('wms_products_store');

                foreach ($info_data['information_description'] as $key => $value) {
                    $info_data['information_description'][$key]['title'] = $stock_item['sizeguide_name'];
                    $info_data['information_description'][$key]['description'] = $stock_item['sizeguide_html'];
                }
                $this->model_catalog_information->editInformation($information_id, $info_data);
            }
            $attribute[] = array(
                'attribute_id' => $attribute_id,
                'product_attribute_description' => array(
                    $this->languageId => array(
                        'text' => "information_id=" . (string) $information_id
                    ),
                    $this->languageFr => array(
                        'text' => "information_id=" . (string) $information_id
                )));
        };

        $special = array();
        if ($stock_item['saleprice'] > 0 && $stock_item['saleprice'] < $stock_item['price']) {
            $customer_group_id = (string) $this->tableLookUp(DB_PREFIX . "customer_group_description", 'customer_group_id', array('name' => 'Default'));
            $special[] = array(
                'customer_group_id' => $customer_group_id,
                'priority' => 0,
                'price' => round($stock_item['saleprice'] / 1.2, 4)
            );
        };

        //We only create a new product the first time it is encountered as 
        // many fields will be controlled via backoffice and we dont want to overwrite.
        $this->load->model('catalog/product');
        $product_info = $this->model_catalog_product->getProductByModel($model);
        $data = array(
            'model' => $model,
            'sku' => "",
            'upc' => "",
            'ean' => "",
            'jan' => "",
            'isbn' => "",
            'mpn' => "",
            'location' => $stock_item['location'],
            'quantity' => 0,
            'minimum' => "",
            'subtract' => 1,
            'stock_status_id' => $this->config->get('config_stock_status_id'),
            'forward' => 0,
            'date_available' => date("Y-m-d"),
            'manufacturer_id' => $stock_item['manufacturer_id'],
            'shipping' => 1,
            'price' => round($stock_item['price'] / 1.2, 4),
            'points' => 0,
            'weight' => NULL,
            'weight_class_id' => NULL,
            'length' => NULL,
            'width' => NULL,
            'height' => NULL,
            'length_class_id' => NULL,
            'status' => $stock_item['status'],
            'tax_class_id' => 9, //TODO: lookup "STANDARD" VAT code instead of hard code
            'sort_order' => 999, //Set to 999 so that manually entered orders appear first
            'image' => $image,
            'product_image' => $images,
            'product_description' => array(
                $this->languageId => array(
                    'name' => ((string) $stock_item['stylename'] == "" ? (string) $stock_item['name'] : (string) $stock_item['stylename']),
                    'meta_title' => ((string) $stock_item['stylename'] == "" ? (string) $stock_item['name'] : (string) $stock_item['stylename']),
                    'meta_keyword' => ((string) $stock_item['keywords'] == "" ? (string) $product_info['keywords'] : (string) $stock_item['keywords']),
                    'meta_description' => ((string) $stock_item['brief_summary'] == "" ? (string) $product_info['brief_summary'] : (string) $stock_item['brief_summary']),
                    'brief_summary' => ((string) $stock_item['brief_summary'] == "" ? (string) $product_info['brief_summary'] : (string) $stock_item['brief_summary']),
                    'description' => ((string) $stock_item['description'] == "" ? (string) $product_info['description'] : (string) $stock_item['description']),
                    'keyword' => seoUrl($model . " " . (string) $stock_item['name']) . ".html",
                    'tag' => NULL
                ),
                $this->languageFr => array(
                    'name' => (string) $stock_item['nameFr'],
                    'meta_title' => (string) $stock_item['nameFr'],
                    'meta_keyword' => (string) $stock_item['keywordsFr'],
                    'meta_description' => (string) $stock_item['brief_summaryFr'],
                    'brief_summary' => (string) $stock_item['brief_summaryFr'],
                    'description' => (string) $stock_item['descriptionFr'],
                    'keyword' => seoUrl($model . " " . (string) $stock_item['nameFr']) . ".html",
                    'tag' => NULL
            )),
            'product_attribute' => $attribute,
            'product_special' => $special,
            'keyword' => seoUrl($model . " " . (string) $stock_item['name']) . ".html",
            'product_category' => $stock_item['categories'],
            'product_filter' => $stock_item['filters'],
            'product_store' => $this->config->get('wms_products_store')
        );

        if (!$product_info) {
            // if product doesn't exist then create it
            $product_id = $this->model_catalog_product->addProduct($data);
            // fetch the newly created product
            $product_info = $this->model_catalog_product->getProduct($product_id);
        } else {

            $product_id = $product_info['product_id'];

            $data['date_available'] = $product_info['date_available'];
            $data['product_store'] = $this->model_catalog_product->getProductStores($product_id);
            $data['product_option'] = $this->model_catalog_product->getProductOptions($product_id);
            $data['product_discount'] = $this->model_catalog_product->getProductDiscounts($product_id);
//            $data['product_special'] = $this->model_catalog_product->getProductSpecials($product_id);
//            $data['product_image'] = $this->model_catalog_product->getProductImages($product_id);
            $data['product_download'] = $this->model_catalog_product->getProductDownloads($product_id);
//            $data['product_asset'] = $this->model_catalog_product->getProductAssets($product_id);
//            $data['product_category'] = $this->model_catalog_product->getProductCategories($product_id);
            $data['product_related'] = $this->model_catalog_product->getProductRelated($product_id);
            $data['product_reward'] = $this->model_catalog_product->getProductRewards($product_id);
            $data['product_layout'] = $this->model_catalog_product->getProductLayouts($product_id);
            $this->model_catalog_product->editProduct($product_id, $data);
        }
        if (!$product_info) {
            // if product still doesn't exist then we have a problem
            return false;
        }

        return $product_info['product_id'];
    }

    function createProductOption($product_id, $stock_item) {
        if (!is_array($stock_item) || !array_key_exists("sku", $stock_item))
            return false;

        $quantity = $stock_item['quantity'];

        $option_id = $this->getSizeOptionId();
        $option_value_id = $this->getSizeOptionValueId($option_id, $stock_item['size'], $stock_item['sizeFr']);
        $product_option_id = $this->getProductOptionId($product_id, $option_id);

        $database = & $this->db;
        $sql = "SELECT product_option_value_id FROM " . DB_PREFIX . "product_option_value WHERE product_option_id = '" . (int) $product_option_id . "' AND product_id = '" . (int) $product_id . "' AND option_id = '" . (int) $option_id . "' AND option_value_id = '" . (int) $option_value_id . "'";
        $result = $this->db->query($sql);
        if ($result->rows) {
            $product_option_value_id = $result->rows[0]['product_option_value_id'];
            $this->db->query("UPDATE " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int) $product_option_id . "', product_id = '" . (int) $product_id . "', option_id = '" . (int) $option_id . "', option_value_id = '" . (int) $option_value_id . "', sku = '" . $stock_item['sku'] . "', quantity = '" . (int) $quantity . "', subtract = '1', price = '0', price_prefix = '+', points = '0', points_prefix = '+', weight = '0', weight_prefix = '+' WHERE product_option_value_id = '" . (int) $product_option_value_id . "'");
        } else {
            $this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int) $product_option_id . "', product_id = '" . (int) $product_id . "', option_id = '" . (int) $option_id . "', option_value_id = '" . (int) $option_value_id . "', sku = '" . $stock_item['sku'] . "', quantity = '" . (int) $quantity . "', subtract = '1', price = '0', price_prefix = '+', points = '0', points_prefix = '+', weight = '0', weight_prefix = '+'");
            $product_option_value_id = (int) $this->db->getLastId();
        }

        $this->db->query("UPDATE " . DB_PREFIX . "product p SET quantity = (SELECT SUM(quantity) FROM " . DB_PREFIX . "product_option_value pov WHERE pov.product_id = p.product_id) WHERE product_id = '" . (int) $product_id . "'");
        return $product_option_value_id;
    }

    function getSizeOptionId() {
        if (!$this->size_option_id) {
            $database = & $this->db;
            $sql = "SELECT option_id FROM `" . DB_PREFIX . "option_description` WHERE name = 'Size' AND language_id = '" . (int) $this->languageId . "'";
            $result = $this->db->query($sql);
            if ($result->rows) {
                $this->size_option_id = (int) $result->rows[0]['option_id'];
            } else {
                $this->load->model('catalog/option');
                // if size option doesn't exist then create it
                $data = array(
                    'option_id' => NULL,
                    'type' => "select",
                    'sort_order' => 0,
                    'option_description' => array(1 => array('name' => "Size"), 2 => array('name' => "Taille"))
                );
                $this->size_option_id = (int) $this->model_catalog_option->addOption($data);
            }
        }
        return $this->size_option_id;
    }

    function getSizeOptionValueId($option_id, $name, $nameFr = "") {
        //We should be able to cache these in an array ?
        $database = & $this->db;
        $sql = "SELECT option_value_id FROM `" . DB_PREFIX . "option_value_description` WHERE option_id = '" . (int) $option_id . "' AND name = '" . $this->db->escape($name) . "' AND language_id = '" . (int) $this->languageId . "'";
        $result = $this->db->query($sql);


        if ($result->rows) {
            $option_value_id = (int) $result->rows[0]['option_value_id'];
        } else {
            $this->db->query("INSERT INTO " . DB_PREFIX . "option_value SET option_id = '" . (int) $option_id . "', image = '', sort_order = '0'");
            $option_value_id = $this->db->getLastId();
        }

        $this->db->query("INSERT INTO " . DB_PREFIX . "option_value_description SET option_value_id = '" . (int) $option_value_id . "', option_id = '" . (int) $option_id . "', name = '" . $this->db->escape($name) . "', language_id = '" . (int) $this->languageId . "' ON DUPLICATE KEY UPDATE name = '" . $this->db->escape($name) . "'");
        $this->db->query("INSERT INTO " . DB_PREFIX . "option_value_description SET option_value_id = '" . (int) $option_value_id . "', option_id = '" . (int) $option_id . "', name = '" . $this->db->escape(($nameFr == "" ? $name : $nameFr)) . "', language_id = '" . (int) $this->languageFr . "' ON DUPLICATE KEY UPDATE name = '" . $this->db->escape(($nameFr == "" ? $name : $nameFr)) . "'");
        return (int) $option_value_id;
    }

    function getProductOptionId($product_id, $option_id) {
        $database = & $this->db;
        $sql = "SELECT product_option_id FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int) $product_id . "' AND option_id = '" . (int) $option_id . "'";
        $result = $this->db->query($sql);
        if ($result->rows)
            return (int) $result->rows[0]['product_option_id'];

        $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int) $product_id . "', option_id = '" . (int) $option_id . "', required = '1'");
        return (int) $this->db->getLastId();
    }

}
