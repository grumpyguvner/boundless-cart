<?php

class ModelToolSysproProducts extends Model {

    private $languageId = 0;
    
    private $size_option_id = 0;
    
    private $tax_codes = array();

    private function getDefaultLanguageId() {
        $code = $this->config->get('config_language');
        $sql = "SELECT language_id FROM `" . DB_PREFIX . "language` WHERE code = '$code'";
        $result = $this->db->query($sql);
        $this->languageId = 1;
        if ($result->rows) {
            foreach ($result->rows as $row) {
                $this->languageId = $row['language_id'];
                break;
            }
        }
        return $this->languageId;
    }

    function runSchedulerOperation() {
                $this->import();
    }

    function import($importRefs = array()) {

        //Prevent php from timing out during import
        set_time_limit(0);
        
        if (!empty($importRefs) && !is_array($importRefs))
            $importRefs = enforce_array ($importRefs);
        foreach ($importRefs as $key => $value) {
            if ($value=="")
                unset ($importRefs[$key]);
        }

        $this->log->write("Begining import of product information from Syspro");
        if (!$this->cacheSysproData($importRefs)) {
            $this->log->write("Unable to fetch data from Syspro, aborting.");
            return false;
        }

        $this->languageId = $this->getDefaultLanguageId();

        // Initialise the tax codes array from Syspro
        $this->fetchSysproTaxCodes();

        $myModel = "";
        $product_id = 0;
        $myProductIds = array();
        $myProductOptionValueIds = array();
        $ignore = false;
        $error = false;
        // Check & update existing record cache
        $sql = "SELECT * FROM `" . DB_PREFIX . "syspro_stock_item` 
                        WHERE IFNULL(TIMESTAMPDIFF(MINUTE, date_processed, date_modified),1) > 0
                     ORDER BY stock_item_code";
        $result = $this->db->query($sql);
        if ($result->rows) {
            foreach ($result->rows as $row) {
                
                // Check to see if any product options already exist and update them
                $sql = "SELECT product_id, product_option_value_id FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$product_id . "' AND sku = '" . (string)$row['stock_item_code'] . "'";
                $option_result = $this->db->query($sql);
                if ($option_result->rows) {
                    $product_id = 0;
                    $product_option_value_id = 0;
                    $this->log->write("updating records for " . $row['stock_item_code'] . ":" . $row['stock_item_name']);
                    $stock_item = $this->fetchSysproData($row['stock_item_code'], false);
                    if (!empty($stock_item)) {
                        foreach ($option_result->rows as $option_row) {
                            $product_id = $option_row['product_id'];
                            $product_option_value_id = $option_row['product_option_value_id'];
                            $this->db->query("UPDATE " . DB_PREFIX . "product_option_value 
                                SET quantity = '" . (int)$stock_item['free_stock_quantity'] . "', 
                                    subtract = '1', 
                                    price = '0', 
                                    price_prefix = '+', 
                                    points = '0', 
                                    points_prefix = '+', 
                                    weight = '0', 
                                    weight_prefix = '+' 
                                 WHERE product_option_value_id = '" . (int)$product_option_value_id . "'");
                            $this->db->query("UPDATE " . DB_PREFIX . "product 
                                SET quantity = (SELECT SUM(quantity) 
                                                  FROM " . DB_PREFIX . "product_option_value 
                                                 WHERE product_id = '" . (int)$product_id . "') 
                              WHERE product_id = '" . (int)$product_id . "'");
                        }
                    } else {
                        $this->log->write("ERROR: Unable to retrieve data.");
                        $error = true;
                    }
                } else {
                    
                    //The product model is obtained from the first 5 characters of the SKU code
                    $model = substr($row['stock_item_code'], 0, 5);
                    if ($myModel != $model) {
                        $ignore = false;
                        $product_id = 0;
                        $product_option_value_id = 0;
                    }
                    if ($ignore) {
                        $this->log->write("ignoring " . $row['stock_item_code'] . ":" . $row['stock_item_name']);
                    } else {
                        $this->log->write("processing " . $row['stock_item_code'] . ":" . $row['stock_item_name']);
                        $stock_item = $this->fetchSysproData($row['stock_item_code'], false);
                        if (!empty($stock_item)) {
                            if ($myModel != $model) {
                                $this->log->write("checking for product " . $myModel);
                                $product_id = $this->createProduct($model, $stock_item);
                            }
                            if ($product_id) {
                                if (!in_array($product_id, $myProductIds))
                                    $myProductIds[] = $product_id;
                                $this->log->write("checking for product option " . $row['stock_item_code']);
                                $product_option_value_id = $this->getProductOptionValue($product_id, $stock_item);
                                if ($product_option_value_id) {
                                    $myModel = $model;
                                    if (!in_array($product_option_value_id, $myProductOptionValueIds))
                                        $myProductOptionValueIds[] = $product_option_value_id;
                                } else {
                                    $this->log->write("ERROR: " . $row['stock_item_code'] . " not found");
                                    $error = true;
                                }
                            } else {
                                $ignore = true;
                                if ($this->config->get('syspro_create_products')) {
                                    $this->log->write("ERROR: " . $myModel. " not found");
                                    $error = true;
                                } else {
                                    $this->log->write($myModel. " not found, being ignored.");
                                }
                            }
                        }
                    }
                    
                }
                
                if ($product_id && $product_option_value_id) {
                    $this->log->write("updating syspro cache data");
                    $sql = "UPDATE `" . DB_PREFIX . "syspro_stock_item` SET date_processed = NOW(), product_id = " . $product_id . ", product_option_value_id = " . $product_option_value_id . " WHERE stock_item_id = " . (int) $row['stock_item_id'];
                    $this->db->query($sql);
                }
                
            }

        }
        // only delete old products if no errors were encountered
        if ($error) {
            $this->log->write("Errors were encountered whilst importing products.");
            return false;
        }

        // Delete any products with no options
//                $this->load->model('catalog/product');
//                $sql = "SELECT DISTINCT p.product_id FROM `".DB_PREFIX."product` p LEFT JOIN `".DB_PREFIX."product_option` po ON (p.product_id = po.product_id) WHERE po.product_id IS NULL";
//                $result = $this->db->query( $sql );
//                if ($result->rows) {
//                        foreach ($result->rows as $row) {
//                            $this->model_catalog_product->deleteProduct($row['product_id']);
//                        }
//                }

        $this->log->write("Import Complete");
        return true;
    }

    private function cacheSysproData($importRefs = array(), $forceRefresh = false) {
        
        if (!empty($importRefs) && !is_array($importRefs))
            $importRefs = enforce_array ($importRefs);

        $this->log->write("Fetching cache of product header information from Syspro");
        // Since it takes around 60 minutes to fetch all of the data from syspro
        // we don't normally want to be running this more than once per day.
//        if (!count($importRefs) && !$forceRefresh) {
//            $sql = "SELECT TIMESTAMPDIFF(MINUTE, date_modified, NOW()) AS last_run FROM `" . DB_PREFIX . "syspro_stock_item` ORDER BY date_modified LIMIT 1";
//            $result = $this->db->query($sql);
//            if ($result->num_rows && (int) $result->row['last_run'] < 1440) {
//                $this->log->write("oldest record in the cache is less than a day old so not refreshing cache.");
//                return true;
//            }
//        }
        if ($forceRefresh) 
            $this->log->write("force refreshing cache.");
        if (count($importRefs)) 
            $this->log->write("importing: " . implode(", ", $importRefs));

        foreach (glob($this->config->get('syspro_input_folder') . "/b2c-stock_item_detail_*.xml") as $filename) {
            $this->log->write("importing: " . basename($filename));

            $response = fopen($filename, "r");
            if ($response) {
                $xml = simplexml_load_file($filename);

                //Convert the XML into a useable array
                foreach ($xml->children() as $second_gen) {
                    switch (strtolower((string) $second_gen->getName())) {
                        case "debug":
                            //Ignore
                            break;
                        case "stock_item":
                            $stock_item = $second_gen;
                            if (!count($importRefs) || in_array((string)$stock_item->code, $importRefs)) {
                                // Create a record if one doesn't already exist for this stock item
                                // 2013-05-17 Modified to always convert stock_item_code to uppercase due to some codes being entered in syspro in upper and lower case
                                //            this does mean that they cannot use lower case codes and was explained to Matt Boyce and Andy May
                                $sql = "INSERT INTO `" . DB_PREFIX . "syspro_stock_item` (`stock_item_code`, `stock_item_name`, `filename`, `data`, `date_added`, `date_modified`)
                                                    VALUES ( '" . strtoupper($this->db->escape((string)$stock_item->code)) . "', '" . $this->db->escape((string)$stock_item->name) . "', '" . $this->db->escape((string)basename($filename)) . "', '" . $this->db->escape($stock_item->asXML()) . "', NOW(), NOW())
                                               ON DUPLICATE KEY UPDATE
                                                                    `stock_item_code` = '" . strtoupper($this->db->escape((string)$stock_item->code)) . "', 
                                                                    `stock_item_name` = '" . $this->db->escape((string)$stock_item->name) . "', 
                                                                    `filename` = '" . $this->db->escape((string)basename($filename)) . "', 
                                                                    `data` = '" . $this->db->escape($stock_item->asXML()) . "', 
                                                                    `date_modified` = NOW()
                                               ";
                                $this->db->query($sql);
                            }
                    }

                }
            }
            
            if (copy($filename, $this->config->get('syspro_processed_folder') . "/" .basename($filename)))
                unlink ($filename);
        }
        
        return true;
    }

    private function fetchSysproData($stock_item_code, $forceRefresh = false) {

        $sql = "SELECT 
                        `" . DB_PREFIX . "syspro_stock_item`.*, 
                        TIMESTAMPDIFF(MINUTE, date_processed, date_modified) AS last_modified, 
                        TIMESTAMPDIFF(MINUTE, date_processed, NOW()) AS last_run 
                FROM `" . DB_PREFIX . "syspro_stock_item` WHERE stock_item_code = '" . strtoupper($this->db->escape((string)$stock_item_code)) . "'";
        $result = $this->db->query($sql);

        $stock_item = array();

        $response =  $result->rows[0]['data'];
        
        if (!$response == 0) {
            $xml = simplexml_load_string($response);
            
            //Convert the XML into a useable array
                        foreach ($xml->children() as $third_gen) {
                            if ($third_gen->count() > 0) {
                                foreach ($third_gen->children() as $fourth_gen) {
                                    switch (strtolower((string) $third_gen->getName())) {
                                        case "pricebands":
                                            $stock_item[strtolower((string) $third_gen->getName())][strtolower((string) $fourth_gen->attributes()->name)] = (float) $fourth_gen;
                                            break;
                                        default:
                                            $stock_item[strtolower((string) $third_gen->getName())][strtolower($fourth_gen->getName())] = (string) $fourth_gen;
                                    }
                                }

                            } else {
                                switch (strtolower((string) $third_gen->getName())) {
                                    case "id":
                                    case "tax_code_id":
                                        //Treat as integers
                                        $stock_item[strtolower((string) $third_gen->getName())] = (int) $third_gen;
                                        break;

                                    case "free_stock_quantity":
                                    case "stock_mult_of_base_unit":
                                    case "sparenumber1":
                                    case "sparenumber2":
                                    case "sparenumber3":
                                        //Treat as numbers
                                        $stock_item[strtolower((string) $third_gen->getName())] = (float) $third_gen;
                                        break;

                                    case "allow_sales_trading":
                                    case "sparebit1":
                                    case "sparebit2":
                                    case "sparebit3":
                                        //Treat as booleans
                                        $stock_item[strtolower((string) $third_gen->getName())] = (boolean)(int) $third_gen;
                                        break;

                                    case "code":
                                        // 2013-05-17 Modified to always convert stock_item_code to uppercase due to some codes being entered in syspro in upper and lower case
                                        //            this does mean that they cannot use lower case codes and was explained to Matt Boyce and Andy May
                                        $stock_item[strtolower((string) $third_gen->getName())] = strtoupper((string) $third_gen);
                                        break;

                                    default:
                                        //Treat everything else as a string
                                        $stock_item[strtolower((string) $third_gen->getName())] = (string) $third_gen;
                                        break;
                                }
                            }
                        }

            }
        
        return $stock_item;

    }

    private function createProduct($model, $stock_item) {
        if (!is_array($stock_item) || !array_key_exists("code", $stock_item))
            return false;
        
        //We only create a new product the first time it is encountered as 
        // many fields will be controlled via backoffice and we dont want to overwrite.
        $this->load->model('catalog/product');
        $product_info = $this->model_catalog_product->getProductByModel($model);
        
        //If we have found a product then we need to update
        if ($product_info) {
            $product_id = $product_info['product_id'];
            
            //Now update selected data

            $product_info['tax_class_id'] = ( in_array('tax_code_id', $stock_item) ? $this->getTaxClassId($stock_item['tax_code_id']) : $product_info['tax_class_id'] );
            
            $product_info['product_discount'] = $this->model_catalog_product->getProductDiscounts($product_id);
            
            $pricebands = $stock_item['pricebands'];
            $product_info['price'] = (isset($pricebands[$this->config->get('syspro_default_priceband')]) ? $pricebands[$this->config->get('syspro_default_priceband')] : $product_info['price'] );
            
            //$product_info['status'] = ($stock_item['status'] == "Active" ? 1 : 0);
            
            //Load all existing data for product
            $product_info['product_description'] = $this->model_catalog_product->getProductDescriptions($product_id);
            $product_info['product_attribute'] = $this->model_catalog_product->getProductAttributes($product_id);
            $product_info['product_option'] = $this->model_catalog_product->getProductOptions($product_id);
            $product_info['product_store'] = $this->model_catalog_product->getProductStores($product_id);
            $product_info['product_special'] = $this->model_catalog_product->getProductSpecials($product_id);
            $product_info['product_image'] = $this->model_catalog_product->getProductImages($product_id);
            $product_info['product_download'] = $this->model_catalog_product->getProductDownloads($product_id);
            $product_info['product_category'] = $this->model_catalog_product->getProductCategories($product_id);
            $product_info['product_related'] = $this->model_catalog_product->getProductRelated($product_id);
            $product_info['product_reward'] = $this->model_catalog_product->getProductRewards($product_id);
            $product_info['product_layout'] = $this->model_catalog_product->getProductLayouts($product_id);
            
            $this->log->write($stock_item['description'] . "(" . $model . ") being updated");
            $this->model_catalog_product->editProduct($product_id, $product_info);
            return $product_id;
        }
        
        
        
        //We are currently importing products from zencart so we will not be creating them here
        if (!$product_info && !$this->config->get('syspro_create_products')) 
            return false;

        if (!$product_info) {
            // if product doesn't exist then create it
            $product_info = array(
                'model' => $model,
                'sku' => "",
                'upc' => "",
                'ean' => "",
                'jan' => "",
                'isbn' => "",
                'mpn' => "",
                'location' => "",
                'quantity' => 0,
                'minimum' => "",
                'subtract' => 1,
                'stock_status_id' => NULL,
                'forward' => 0,
                'date_available' => NULL,
                'manufacturer_id' => NULL,
                'shipping' => 1,
                'price' => 0,
                'points' => 0,
                'weight' => NULL,
                'weight_class_id' => NULL,
                'length' => NULL,
                'width' => NULL,
                'height' => NULL,
                'length_class_id' => NULL,
                'status' => 0, //We don't want to enable newly created products because of missing data
                'tax_class_id' => ( in_array('tax_code_id', $stock_item) ? $this->getTaxClassId($stock_item['tax_code_id']) : NULL ),
                'sort_order' => NULL,
                'image' => NULL,
                'product_description' => array(
                    $this->languageId => array(
                        'name' => (string) $stock_item['description'],
                        'meta_title' => "",
                        'meta_keyword' => (string) $stock_item['description'],
                        'meta_description' => "",
                        'description' => "",
                        'tag' => NULL
                )),
                'keyword' => seoUrl($model . " " . (string) $stock_item['description']) . ".html",
                'product_category' => null,
                'product_store' => array(0)
            );
            
            $pricebands = $stock_item['pricebands'];
            $product_info['price'] = (isset($pricebands[$this->config->get('syspro_default_priceband')]) ? $pricebands[$this->config->get('syspro_default_priceband')] : 0 );
            
            $this->log->write($stock_item['description'] . "(" . $model . ") being added");
            $product_id = $this->model_catalog_product->addProduct($product_info);
            return $product_id;
        }

        return false;
    }

    private function getProductOptionValue($product_id, $stock_item) {
        if (!is_array($stock_item) || !array_key_exists("code", $stock_item))
            return false;
        
        $product_option_value_id = 0;
        // Check to see if product option already exists, 
        // we cannot currently create them at the moment as missing size info
        $sql = "SELECT product_option_value_id FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$product_id . "' AND sku = '" . (string)$stock_item['code'] . "'";
        $result = $this->db->query($sql);
        if ($result->rows) {
            $product_option_value_id = $result->rows[0]['product_option_value_id'];
            $this->db->query("UPDATE " . DB_PREFIX . "product_option_value 
                SET quantity = '" . (int)$stock_item['free_stock_quantity'] . "', 
                    subtract = '1', 
                    price = '0', 
                    price_prefix = '+', 
                    points = '0', 
                    points_prefix = '+', 
                    weight = '0', 
                    weight_prefix = '+' 
                 WHERE product_option_value_id = '" . (int)$product_option_value_id . "'");
        }
        return $product_option_value_id;
        
    }

    private function createProductOption($product_id, $stock_item) {
        if (!is_array($stock_item) || !array_key_exists("code", $stock_item))
            return false;
        
        $size = "ONE SIZE";
        if (strlen($stock_item['name']) > strlen($stock_item['description']))
            $size = trim(substr($stock_item['name'], strlen($stock_item['description'])));
        $quantity = $stock_item['free_stock_quantity'];

        $option_id = $this->getSizeOptionId();
        $option_value_id = $this->getSizeOptionValueId($option_id, $size);
        $product_option_id = $this->getProductOptionId($product_id, $option_id);

        $sql = "SELECT product_option_value_id FROM " . DB_PREFIX . "product_option_value WHERE product_option_id = '" . (int)$product_option_id . "' AND product_id = '" . (int)$product_id . "' AND option_id = '" . (int)$option_id . "' AND option_value_id = '" . (int)$option_value_id . "'";
        $result = $this->db->query($sql);
        if ($result->rows) {
            $product_option_value_id = $result->rows[0]['product_option_value_id'];
            $this->db->query("UPDATE " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$option_id . "', option_value_id = '" . (int)$option_value_id . "', quantity = '" . (int)$quantity . "', subtract = '1', price = '0', price_prefix = '+', points = '0', points_prefix = '+', weight = '0', weight_prefix = '+' WHERE product_option_value_id = '" . (int)$product_option_value_id . "'");
        } else {
            $this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$option_id . "', option_value_id = '" . (int)$option_value_id . "', quantity = '" . (int)$quantity . "', subtract = '1', price = '0', price_prefix = '+', points = '0', points_prefix = '+', weight = '0', weight_prefix = '+'");
            $product_option_value_id = (int)$this->db->getLastId();
        }

        $this->db->query("UPDATE " . DB_PREFIX . "product 
            SET quantity = (SELECT SUM(quantity) 
                              FROM " . DB_PREFIX . "product_option_value 
                             WHERE product_id = '" . (int)$product_id . "') 
          WHERE product_id = '" . (int)$product_id . "'");
        
        return $product_option_value_id;
    }

    private function getSizeOptionId() {
        if (!$this->size_option_id) {
            $sql = "SELECT option_id FROM `" . DB_PREFIX . "option_description` WHERE name = 'Size' AND language_id = '" . (int)$this->languageId . "'";
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
                    'name' => "Size"
                );
                $this->size_option_id = (int) $this->model_catalog_option->addOption($data);
            }
        }
        return $this->size_option_id;
    }

    private function getSizeOptionValueId($option_id, $name) {
        //We should be able to cache these in an array ?
        $sql = "SELECT option_value_id FROM `" . DB_PREFIX . "option_value_description` WHERE option_id = '" . (int)$option_id . "' AND name = '" . $this->db->escape($name) . "' AND language_id = '" . (int)$this->languageId . "'";
        $result = $this->db->query($sql);
        if ($result->rows)
            return (int) $result->rows[0]['option_value_id'];
        
        $this->db->query("INSERT INTO " . DB_PREFIX . "option_value SET option_id = '" . (int)$option_id . "', image = '', sort_order = '0'");
        $option_value_id = $this->db->getLastId();
        $this->db->query("INSERT INTO " . DB_PREFIX . "option_value_description SET option_value_id = '" . (int)$option_value_id . "', option_id = '" . (int)$option_id . "', name = '" .  $this->db->escape($name) . "', language_id = '" . (int)$this->languageId . "'");
        return (int)$option_value_id;
    }

    private function getProductOptionId($product_id, $option_id) {
        $sql = "SELECT product_option_id FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int)$product_id . "' AND option_id = '" . (int)$option_id . "'";
        $result = $this->db->query($sql);
        if ($result->rows)
            return (int) $result->rows[0]['product_option_id'];
        
        $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$option_id . "', required = '1'");
        return (int)$this->db->getLastId();
    }

    private function getCustomerGroupId($name, $tax_rate = "") {
        $this->load->model('sale/customer_group');
        $customer_group = $this->model_sale_customer_group->getCustomerGroupByName($name);
        
        if (!$customer_group) {
            $data = array(
		'approval' => 0,
                'company_id_display' => 1,
                'company_id_required' => 0,
                'tax_id_display' => 0,
                'tax_id_required' => 0,
                'sort_order' => 999,
		'customer_group_description' => array(
                    $this->languageId => array(
                        'name' => (string) $name,
                        'description' => ""
                ))
            );
            if (!$tax_rate == "")
                $data['customer_group_tax_rate'] = array(
                        $this->getTaxClassId($tax_rate)
                    );
            return (int) $this->model_sale_customer_group->addCustomerGroup($data);
        }
        return (int) $customer_group['customer_group_id'];
    }

    private function getTaxClassId($syspro_tax_code) {
        if (!isset($this->tax_codes[$syspro_tax_code]))
            return 0;
        
        $sql = "SELECT tax_class_id
                FROM `" . DB_PREFIX . "syspro_tax_code` WHERE tax_code = '" . $this->db->escape((string)$syspro_tax_code) . "'";
        $result = $this->db->query($sql);

        if ($result->count > 0)
            return $result->rows[0]['tax_class_id'];

        return 0;
    }

    private function getGeoZoneId($name) {
        
        $this->load->model('localisation/geo_zone');
        $geo_zone = $this->model_localisation_geo_zone->getGeoZoneByName($name);

        if (!$geo_zone) {
            $data = array(
                'name' => $name,
                'description' => ""
            );
            
            return $this->model_localisation_geo_zone->addGeoZone($data);
        }
        
        return (int) $geo_zone['geo_zone_id'];
    }

    private function fetchSysproTaxCodes() {

        foreach (glob($this->config->get('syspro_input_folder') . "/b2c-tax_codes_*.xml") as $filename) {
            $this->log->write("importing: " . basename($filename));
            
            $response = fopen($filename, "r");
            if ($response) {
                $xml = simplexml_load_file($filename);

                //Convert the XML into a useable array
                foreach ($xml->children() as $second_gen) {
                    switch (strtolower((string) $second_gen->getName())) {
                        case "debug":
                            //Ignore
                            break;
                        case "tax_codes":
                            foreach ($second_gen->children() as $tax_code) {
                                $tax_class_id = $this->createTaxClassId((string)$tax_code->code, (string)$tax_code->name, (string)$tax_code->rate);
                                $sql = "INSERT INTO `" . DB_PREFIX . "syspro_tax_code` (`tax_code`, `tax_name`, `tax_rate`, `filename`, `data`, `tax_class_id`, `date_added`, `date_modified`)
                                                    VALUES ( '" . strtoupper($this->db->escape((string)$tax_code->code)) . "', '" . $this->db->escape((string)$tax_code->name) . "', '" . $this->db->escape((string)$tax_code->rate) . "', '" . $this->db->escape((string)basename($filename)) . "', '" . $this->db->escape($tax_code->asXML()) . "', '" . $this->db->escape($tax_class_id) . "', NOW(), NOW())
                                               ON DUPLICATE KEY UPDATE
                                                    `tax_code` = '" . strtoupper($this->db->escape((string)$tax_code->code)) . "', 
                                                    `tax_name` = '" . $this->db->escape((string)$tax_code->name) . "', 
                                                    `tax_rate` = '" . $this->db->escape((string)$tax_code->rate) . "', 
                                                    `filename` = '" . $this->db->escape((string)basename($filename)) . "', 
                                                    `data` = '" . $this->db->escape($tax_code->asXML()) . "', 
                                                    `tax_class_id` = '" . $this->db->escape($tax_class_id) . "', 
                                                    `date_modified` = NOW()
                                               ";
                                $this->db->query($sql);
                            }
                    }

                }
            }

            if (copy($filename, $this->config->get('syspro_processed_folder') . "/" .basename($filename)))
                unlink ($filename);
        }
    }
    

    private function createTaxClassId($tax_code, $tax_name, $tax_rate) {
        
        $this->load->model('localisation/tax_rate');
        $tax_info = $this->model_localisation_tax_rate->getTaxRateByName($tax_code);

        $data = array(
            'name' => $tax_name,
            'rate' => $tax_rate,
            'type' => "P", // P = Percentage
            'geo_zone_id' => $this->getGeoZoneId($tax_name . " Tax Zone")
        );

        if ($tax_info) {
            //Update the tax rate (percentage may have changed!)
            $tax_rate_id = $tax_info['tax_rate_id'];
            $this->model_localisation_tax_rate->editTaxRate($tax_rate_id, $data);
        } else {
            $tax_rate_id = $this->model_localisation_tax_rate->addTaxRate($data);
        }

        // We actually need to save the tax class against the product
        $this->load->model('localisation/tax_class');
        $class_info = $this->model_localisation_tax_class->getTaxClassByName($tax_name);
        
        $data = array(
            'title' => $tax_name,
            'description' => "",
            'tax_rule' => array (1 => array (
                'tax_rate_id' => $tax_rate_id,
                'based' => 'shipping',
                'priority' => 1
            ))
        );

        if ($class_info) {
            //Update the tax class
            $tax_class_id = $class_info['tax_class_id'];
            $this->model_localisation_tax_class->editTaxClass($tax_class_id, $data);
        } else {
            $tax_class_id = $this->model_localisation_tax_class->addTaxClass($data);
        }

        return $tax_class_id;
    }
}

function seoUrl($string) {
    //Unwanted:  {UPPERCASE} ; / ? : @ & = + $ , . ! ~ * ' ( )
    $string = strtolower($string);
    //Strip any unwanted characters
    $string = preg_replace("/[^a-z0-9_\s-]/", "", $string);
    //Clean multiple dashes or whitespaces
    $string = preg_replace("/[\s-]+/", " ", $string);
    //Convert whitespaces and underscore to dash
    $string = preg_replace("/[\s_]/", "-", $string);
    return $string;
}

?>
