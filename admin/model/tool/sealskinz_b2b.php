<?php

class ModelToolSealskinzB2b extends Model {

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

        $this->log->write("Begining import of product information from B2B");
        if (!$this->cacheB2BData($importRefs)) {
            $this->log->write("Unable to fetch data from B2B, aborting.");
            return false;
        }

        $this->languageId = $this->getDefaultLanguageId();

        $myModel = "";
        $product_id = 0;
        $myProductIds = array();
        $myProductOptionValueIds = array();
        $ignore = false;
        $error = false;
        // Check & update existing record cache
        $sql = "SELECT * FROM `" . DB_PREFIX . "b2b_stockist` 
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
                    $this->log->write("updating records for " . $row['stock_item_id'] . ":" . $row['stock_item_code'] . ":" . $row['stock_item_name']);
                    $stock_item = $this->fetchB2BData($row['stock_item_id'], false);
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
                        $this->log->write("ignoring " . $row['stock_item_id'] . ":" . $row['stock_item_code'] . ":" . $row['stock_item_name']);
                    } else {
                        $this->log->write("processing " . $row['stock_item_id'] . ":" . $row['stock_item_code'] . ":" . $row['stock_item_name']);
                        $stock_item = $this->fetchB2BData($row['stock_item_id'], false);
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
                                if ($this->config->get('sage_create_products')) {
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
                    $this->log->write("updating sage cache data");
                    $sql = "UPDATE `" . DB_PREFIX . "b2b_stockist` SET date_processed = NOW(), product_id = " . $product_id . ", product_option_value_id = " . $product_option_value_id . " WHERE stock_item_id = " . (int) $row['stock_item_id'];
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

    private function cacheB2BData($importRefs = array(), $forceRefresh = false) {
        
        if (!empty($importRefs) && !is_array($importRefs))
            $importRefs = enforce_array ($importRefs);

        $this->log->write("Fetching cache of product header information from B2B");
        // Since it takes around 60 minutes to fetch all of the data from sage
        // we don't normally want to be running this more than once per day.
        if (!count($importRefs) && !$forceRefresh) {
            $sql = "SELECT TIMESTAMPDIFF(MINUTE, date_modified, NOW()) AS last_run FROM `" . DB_PREFIX . "b2b_stockist` ORDER BY date_modified LIMIT 1";
            $result = $this->db->query($sql);
            if ($result->num_rows && (int) $result->row['last_run'] < 1440) {
                $this->log->write("oldest record in the cache is less than a day old so not refreshing cache.");
                return true;
            }
        }
        if ($forceRefresh) 
            $this->log->write("force refreshing cache.");
        if (count($importRefs)) 
            $this->log->write("importing: " . implode(", ", $importRefs));

        // Load XML Feed to fetch detail
        $this->load->helper('fetchxml');

        // Check for records
        // Load XML Feed
        $xml = new fetchXml();
        $response = $xml->get_array("http://" . $this->config->get('b2b_server_url'));
        if (empty($response))
            return false;
        
        $stock_items = $response['stockists'];
        foreach ($stock_items as $key => $value) {
            if (!count($importRefs) || in_array($value['id'], $importRefs)) {
                $sql = "INSERT INTO `" . DB_PREFIX . "b2b_stockist` (`stockist_id`, `stockist_name`, `data`, `date_added`, `date_modified`)
                                    VALUES ( " . (int) $value['id'] . ",'" . $this->db->escape($value['name']) . "','" . $this->db->escape(serialize($value)) . "', NOW(), NOW())
                               ON DUPLICATE KEY UPDATE
                                    `stockist_id` = " . (int) $value['id'] . ", 
                                    `stockist_name` = '" . $this->db->escape($value['name']) . "', 
                                    `data` = '" . $this->db->escape(serialize($value)) . "', 
                                    `date_modified` = NOW()
                               ";
                $this->db->query($sql);
            }
            
//            $this->fetchB2BData($value['id']);
        }

        return true;
    }

    private function fetchB2BData($stock_item_id, $forceRefresh = false) {

        $sql = "SELECT 
                        `" . DB_PREFIX . "b2b_stockist`.*, 
                        TIMESTAMPDIFF(MINUTE, date_processed, date_modified) AS last_modified, 
                        TIMESTAMPDIFF(MINUTE, date_processed, NOW()) AS last_run 
                FROM `" . DB_PREFIX . "b2b_stockist` WHERE stock_item_id = " . (int) $stock_item_id;
        $result = $this->db->query($sql);

        $stock_item = array();
        
        // Since it takes a few minutes to fetch all of the data from sage
        // we don't normally want to be running this more than once per hour 
        // unless we are forcing refresh or the data has changed since last
        // processed.
        
        if ((string) $result->rows[0]['data'] == "" || (int) $result->rows[0]['last_run'] > 60 || (int) $result->rows[0]['last_modified'] > 1 || $forceRefresh) {
            $time_start = microtime(true);
            $this->log->write("fetching xml from sage");
            // Load XML Feed to fetch detail
            $this->load->helper('fetchxml');

            $xml = new fetchXml();
            //Unable to use $xml->get_array method because pricebands uses attributes which are lost
            $response = $xml->get("http://" . $this->config->get('sage_server') . ":" . $this->config->get('sage_port') . "/DMC_SOP/warehouses/" . $this->config->get('sage_warehouse') . "/stock_items/" . $stock_item_id);
            if (!$response == 0) {
                $time_end = microtime(true);
                $time = $time_end - $time_start;
                $this->log->write("valid response in $time seconds");
                $xml = new SimpleXMLElement($response);
                $stock_item_code = (string) $xml->stock_item->code;
                $stock_item_name = (string) $xml->stock_item->name;

                $sql = "UPDATE `" . DB_PREFIX . "b2b_stockist` SET date_modified = NOW(), stock_item_code = '" . $this->db->escape($stock_item_code) . "', stock_item_name = '" . $this->db->escape($stock_item_name) . "', data = '" . $this->db->escape(serialize($response)) . "' WHERE stock_item_id = " . (int) $stock_item_id;
                $this->db->query($sql);
            }
            $time_end = microtime(true);
            $time = $time_end - $time_start;
            $this->log->write("xml fetched in $time seconds");
        } else {
            $response = unserialize($result->rows[0]['data']);
        }

        if (!$response == 0) {
            $xml = new SimpleXMLElement($response);

            //Convert the XML into a useable array
            foreach ($xml->children() as $second_gen) {
                switch (strtolower((string) $second_gen->getName())) {
                    case "debug":
                        //Ignore
                        break;
                    case "stock_item":
                        foreach ($second_gen->children() as $third_gen) {
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
                                        // 2013-05-17 Modified to always convert stock_item_code to uppercase due to some codes being entered in sage in upper and lower case
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
            $product_info['price'] = (isset($pricebands[$this->config->get('sage_default_priceband')]) ? $pricebands[$this->config->get('sage_default_priceband')] : $product_info['price'] );
            
            $product_info['status'] = ($stock_item['status'] == "Active" ? 1 : 0);
            
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
        if (!$product_info && !$this->config->get('sage_create_products')) 
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
            $product_info['price'] = (isset($pricebands[$this->config->get('sage_default_priceband')]) ? $pricebands[$this->config->get('sage_default_priceband')] : 0 );
            
            $this->log->write($stock_item['description'] . "(" . $model . ") being added");
            $product_id = $this->model_catalog_product->addProduct($product_info);
            return $product_id;
        }

        return false;
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
