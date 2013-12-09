<?php

class ModelCatalogProduct extends Model {

    public function getAvailableAttributeFilters($data = array()) {

        //Before searching need to unset start and limit so that 
        // and attribute filter so that all products are returned
        unset($data['start']);
        unset($data['limit']);
        if (isset($data['filters'])) {
            foreach ($data['filters'] as $key => $filter) {
                if ($filter['type'] == "attribute")
                    unset($data['filters'][$key]);
            }
        }
        $results = $this->getProductsAFiltered($data);

        $category_attributes = array();
        foreach ($results as $product) {
            $attribute_groups = $this->model_catalog_product->getProductAttributes($product['product_id']);
            foreach ($attribute_groups as $group) {

                if ($group['name'] == "Filter") {
                    foreach ($group['attribute'] as $attribute) {
                        if (!isset($category_attributes[$attribute['attribute_id']])) {
                            $category_attributes[$attribute['attribute_id']] = array(
                                'attribute_id' => $attribute['attribute_id'],
                                'name' => $attribute['name'],
                                'values' => array()
                            );
                        }
                        if (!in_array($attribute['text'], $category_attributes[$attribute['attribute_id']]['values'])) {
                            $category_attributes[$attribute['attribute_id']]['values'][] = $attribute['text'];
                        }
                    }
                    asort($category_attributes[$attribute['attribute_id']]['values']);
                }
            }
        }

        return $category_attributes;
    }

    public function getTotalProductsAFiltered($data = array()) {
        //Before searching need to unset start and limit so that 
        //all products are counted
        unset($data['start']);
        unset($data['limit']);
        $result = $this->getProductsAFiltered($data);
        return count($result);
    }

    public function getProductsAFiltered($data = array()) {

        if ($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }

        $cache = md5(http_build_query($data));

        $product_data = $this->cache->get('product.' . $cache . '.' . $customer_group_id);
//		$product_data = false;


        if (!$product_data) {

            $sql = $this->constructSQL($data);

            $product_data = array();
            $product_data1 = array();
//print_r($sql . '<br/>');

            $query = $this->db->query($sql);
            foreach ($query->rows as $result) {
                if ($this->displayProduct($result, $data))
                    $product_data1[$result['product_id']] = $this->getProduct($result['product_id']);
            }

            if (isset($data['start']) && isset($data['limit'])) {
                if ($data['start'] < 0)
                    $data['start'] = 0;

                if ($data['limit'] < 1)
                    $data['limit'] = 5;

                $i = 0; //$data['start'];
                $j = count($product_data1); //$data['limit'];
                $k = $data['start'] + (int) $data['limit'];

                foreach ($product_data1 as $key => $value) {
                    if (($i >= $data['start']) && ( $i < $k ))
                        $product_data[$key] = $value;
                    $i++;
                }
            } else {
                $product_data = $product_data1;
            }

            $this->cache->set('product.' . $cache . '.' . $customer_group_id, $product_data);
        }

        return $product_data;
    }

    private function constructSQL($data) {

        $myCategories = array();
        $myAttributes = array();

        if (isset($data['filters'])) {
            foreach ($data['filters'] as $filter) {
                switch ($filter['type']) {
                    case "category":
                        $myCategories[$filter['group']][] = $filter['value'];
                        break;
                    case "attribute":
                        $myAttributes[$filter['group']][] = $filter['value'];
                        break;
                    default:
                        //ignore
                        break;
                }
            }
        }

        $sql = "SELECT p.product_id, (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)";

        if (!empty($data['filter_tag'])) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_tag pt ON (p.product_id = pt.product_id)";
        }

        if (!empty($myCategories)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";			
        }

        $sql .= " WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "'";

        if (!empty($data['filter_name']) || !empty($data['filter_tag'])) {
            $sql .= " AND (";

            if (!empty($data['filter_name'])) {
                $implode = array();

                $words = explode(' ', trim(preg_replace('/\s\s+/', ' ', $data['filter_name'])));

                foreach ($words as $word) {
                    if (!empty($data['filter_description'])) {
                        $implode[] = "LCASE(pd.name) LIKE '%" . $this->db->escape(utf8_strtolower($word)) . "%' OR LCASE(pd.description) LIKE '%" . $this->db->escape(utf8_strtolower($word)) . "%'";
                    } else {
                        $implode[] = "LCASE(pd.name) LIKE '%" . $this->db->escape(utf8_strtolower($word)) . "%'";
                    }
                }

                if ($implode) {
                    $sql .= " " . implode(" OR ", $implode) . "";
                }
            }

            if (!empty($data['filter_name']) && !empty($data['filter_tag'])) {
                $sql .= " OR ";
            }

            if (!empty($data['filter_tag'])) {
                $implode = array();

                $words = explode(' ', trim(preg_replace('/\s\s+/', ' ', $data['filter_tag'])));

                foreach ($words as $word) {
                    $implode[] = "LCASE(pt.tag) LIKE '%" . $this->db->escape(utf8_strtolower($word)) . "%'";
                }

                if ($implode) {
                    $sql .= " " . implode(" OR ", $implode) . " AND pt.language_id = '" . (int) $this->config->get('config_language_id') . "'";
                }
            }

            $sql .= ")";
        }

        if (!empty($myCategories)) {
            foreach ($myCategories as $myGroup) {
                $implode_data = array();

                foreach ($myGroup as $category_id) {
                    $implode_data[] = (int) $category_id;
                }
                if (!empty($data['filter_sub_category'])) {

                    $this->load->model('catalog/category');

                    $categories = $this->model_catalog_category->getCategoriesByParentId($data['filter_category_id']);

                    foreach ($categories as $category_id) {
                        $implode_data[] = (int) $category_id;
                    }
                }

                $sql .= " AND (SELECT COUNT(p2c.category_id) FROM " . DB_PREFIX . "product_to_category p2c WHERE (p.product_id = p2c.product_id) AND p2c.category_id IN (" . implode(', ', $implode_data) . ")) > 0";
            }
        }

        if (!empty($data['filter_manufacturer_id'])) {
            $sql .= " AND p.manufacturer_id = '" . (int) $data['filter_manufacturer_id'] . "'";
        }
        
        if ($this->config->get('config_category_instockonly')) {
            $sql .= " AND p.quantity > 0";
        }

        $sql .= " GROUP BY p.product_id";

        $sort_data = array(
            'pd.name',
            'p.model',
            'p.quantity',
            'p.price',
            'rating',
            'p.sort_order',
            'p.date_added'
        );
        
        if ($this->extensions->isInstalled('merchandising', 'module') && $this->config->get('merchandising_status')) {
            $sort_data[] = 'p2c.sort_order';
                
            if (isset($data['sort']) && $data['sort'] == 'p.sort_order')
            {
                $data['sort'] = 'p2c.sort_order';
            }
        }

        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            if ($data['sort'] == 'pd.name' || $data['sort'] == 'p.model') {
                $sql .= " ORDER BY LCASE(" . $data['sort'] . ")";
            } else {
                $sql .= " ORDER BY " . $data['sort'];
            }
        } elseif ($this->extensions->isInstalled('merchandising', 'module') && $this->config->get('merchandising_status')) {
            $sort_data[] = 'ORDER BY p2c.sort_order';
        } else {
            $sql .= " ORDER BY p.sort_order";
        }

        if (isset($data['order']) && ($data['order'] == 'DESC')) {
            $sql .= " DESC, LCASE(pd.name) DESC";
        } else {
            $sql .= " ASC, LCASE(pd.name) ASC";
        }

        return $sql;
    }

    private function displayProduct($result, $data) {

        $display_product = true;

        $myAttributes = array();

        if (isset($data['filters'])) {
            foreach ($data['filters'] as $filter) {
                switch ($filter['type']) {
                    case "attribute":
                        $myAttributes[$filter['group']][] = $filter['value'];
                        break;
                    default:
                        //ignore
                        break;
                }
            }
        }

        if (isset($myAttributes)) {
            foreach ($myAttributes as $key => $data_afilters) {
                $display_product = false;
                if (!is_array($data_afilters))
                    $data_afilters = explode(",", $data_afilters);
                foreach ($data_afilters as $attr) {
                    if ($this->productHasAtt($result['product_id'], $attr)) {
                        $display_product = true;
                    }
                }
            }
        }

        return $display_product;
    }

    private function productHasAtt($product_id, $att_value /* , $option_value_id */) {

        $hasAtt = false;

        if (!is_array($att_value))
            $att_value = explode(",", $att_value);

        $product_att = $this->getProductAttributes($product_id);

        foreach ($product_att as $product_ats) { // verific per group ID
            foreach ($product_ats['attribute'] as $product_at) {
                if (in_array(urlencode($product_at['text']), $att_value))
                    $hasAtt = true;
            }
        }

        return $hasAtt;
    }

    public function getProductCategories($product_id) {

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category pc LEFT JOIN " . DB_PREFIX . "category_description cd ON (pc.category_id = cd.category_id) WHERE product_id = '" . $product_id . "' AND language_id = '" . (int) $this->config->get('config_language_id') . "'");

        if ($query->num_rows > 0) {

            return $query->rows;
        } else {

            return false;
        }
    }

    public function getProductGoogleBaseCategories($product_id) {

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category pc LEFT JOIN " . DB_PREFIX . "category c ON (pc.category_id = c.category_id) WHERE product_id = '" . $product_id . "' and (c.googlebase_xml <> '' OR c.googlebase_text <> '') LIMIt 1");

        if ($query->num_rows > 0) {

            return $query->row;
        } else {

            return false;
        }
    }

    public function updateViewed($product_id) {
        $this->db->query("UPDATE " . DB_PREFIX . "product SET viewed = (viewed + 1) WHERE product_id = '" . (int) $product_id . "'");

        if (!isset($this->request->cookie['recently_viewed'])) {
            $recently_viewed = array();
        } else {
            $recently_viewed = explode(',', $this->request->cookie['recently_viewed']);
        }

        if (($pos = array_search($product_id, $recently_viewed)) !== false) {
            unset($recently_viewed[$pos]);
        }

        array_push($recently_viewed, $product_id);

        $this->request->cookie['recently_viewed'] = implode(',', $recently_viewed);

        if (defined('SITE_REGION')) {
            setcookie('recently_viewed', $this->request->cookie['recently_viewed'], time() + 60 * 60 * 24 * 30, '/' . SITE_REGION . '/', $this->request->server['HTTP_HOST']);
        } else {
            setcookie('recently_viewed', $this->request->cookie['recently_viewed'], time() + 60 * 60 * 24 * 30, '/', $this->request->server['HTTP_HOST']);
        }
    }

    public function getProduct($product_id) {
        if ($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }

        $query = $this->db->query("SELECT DISTINCT *, pd.name AS name, p.image, m.name AS manufacturer, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int) $customer_group_id . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special, (SELECT points FROM " . DB_PREFIX . "product_reward pr WHERE pr.product_id = p.product_id AND customer_group_id = '" . (int) $customer_group_id . "') AS reward, (SELECT ss.name FROM " . DB_PREFIX . "stock_status ss WHERE ss.stock_status_id = p.stock_status_id AND ss.language_id = '" . (int) $this->config->get('config_language_id') . "') AS stock_status, (SELECT wcd.unit FROM " . DB_PREFIX . "weight_class_description wcd WHERE p.weight_class_id = wcd.weight_class_id AND wcd.language_id = '" . (int) $this->config->get('config_language_id') . "') AS weight_class, (SELECT lcd.unit FROM " . DB_PREFIX . "length_class_description lcd WHERE p.length_class_id = lcd.length_class_id AND lcd.language_id = '" . (int) $this->config->get('config_language_id') . "') AS length_class, (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating, (SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review r2 WHERE r2.product_id = p.product_id AND r2.status = '1' GROUP BY r2.product_id) AS reviews, p.sort_order FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id) WHERE p.product_id = '" . (int) $product_id . "' AND pd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "'");

        if ($query->num_rows) {

            $price = ($query->row['discount'] ? $query->row['discount'] : $query->row['price']);

            if ((float) $query->row['special']) {
                $save = $price - $query->row['special'];
                $save_perc = ceil((($price * 100) - ($query->row['special'] * 100)) / ($price));
            } else {
                $save = false;
                $save_perc = false;
            }
            
            if ($this->config->get('config_sale_item')) {
                $sale = $query->row['sale'] ? true : false;
            } else {
                $sale = $save_perc ? true : false;
            }

            $days_left = floor((time() - strtotime($query->row['date_added'])) / ( 60 * 60 * 24));

            return array(
                'product_id' => $query->row['product_id'],
                'name' => $query->row['name'],
                'description' => $query->row['description'],
                'brief_summary' => $query->row['brief_summary'],
                'meta_description' => $query->row['meta_description'],
                'meta_keyword' => $query->row['meta_keyword'],
                'meta_title' => $query->row['meta_title'],
                'tag' => $query->row['tag'],
                'model' => $query->row['model'],
                'sku' => $query->row['sku'],
                'upc' => $query->row['upc'],
                'ean' => $query->row['ean'],
                'jan' => $query->row['jan'],
                'isbn' => $query->row['isbn'],
                'mpn' => $query->row['mpn'],
                'location' => $query->row['location'],
                'quantity' => $query->row['quantity'],
                'stock_status' => $query->row['stock_status'],
                'image' => $query->row['image'],
                'manufacturer_id' => $query->row['manufacturer_id'],
                'manufacturer' => $query->row['manufacturer'],
                'sale' => $sale,
                'price' => $price,
                'special' => $query->row['special'],
                'saving' => $save,
                'saving_percent' => $save_perc,
                'reward' => $query->row['reward'],
                'points' => $query->row['points'],
                'tax_class_id' => $query->row['tax_class_id'],
                'date_available' => $query->row['date_available'],
                'weight' => $query->row['weight'],
                'weight_class_id' => $query->row['weight_class_id'],
                'length' => $query->row['length'],
                'width' => $query->row['width'],
                'height' => $query->row['height'],
                'length_class_id' => $query->row['length_class_id'],
                'subtract' => $query->row['subtract'],
                'rating' => round($query->row['rating']),
                'reviews' => $query->row['reviews'],
                'minimum' => $query->row['minimum'],
                'new' => ($days_left <= (int) $this->config->get('config_new_product_age')) ? true : false,
                'sort_order' => $query->row['sort_order'],
                'status' => $query->row['status'],
                'date_added' => $query->row['date_added'],
                'date_modified' => $query->row['date_modified'],
                'viewed' => $query->row['viewed']
            );
        } else {
            return false;
        }
    }

    public function getProducts($data = array()) {
        if ($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }

        $cache = md5(http_build_query($data));

        $product_data = $this->cache->get('product.' . (int) $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id') . '.' . (int) $customer_group_id . '.' . $cache);

        if (!$product_data) {

            $myCategories = array();

            if (!empty($data['filter_category_id']))
                $myCategories[] = $data['filter_category_id'];

            if (isset($data['afilters'])) {

                if (isset($data['afilters'][0])) {
                    foreach ($data['afilters'][0] as $cat_id) {
                        if (!in_array($cat_id, $myCategories))
                            $myCategories[] = $cat_id;
                    }
                    unset($data['afilters'][0]);
                }
            } 
           
            $filter_groups = (!empty($data['filter_filter'])) ? explode(':', $data['filter_filter']) : array();
            $option_groups = (!empty($data['filter_option'])) ? explode(':', $data['filter_option']) : array();

            $sql = "SELECT p.product_id, (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int) $customer_group_id . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special";

            if (!empty($data['filter_category_id']) || !empty($data['filter_name']) || !empty($data['filter_filter']) || !empty($data['filter_option'])) {
                if (!empty($data['filter_sub_category'])) {
                    // $sql .= " FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (cp.category_id = p2c.category_id)";			
                    $sql .= " FROM " . DB_PREFIX . "product_to_category p2c";
                } else {
                    $sql .= " FROM " . DB_PREFIX . "product_to_category p2c";
                }
                
                foreach ($filter_groups as $key => $filters) {
                    $sql .= " LEFT JOIN " . DB_PREFIX . "product_filter pf" . $key . " ON (p2c.product_id = pf" . $key . ".product_id)";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " LEFT JOIN " . DB_PREFIX . "category_description cd ON (cd.category_id = p2c.category_id and cd.language_id = '" . (int) $this->config->get('config_language_id') . "')";
                    
                    $sql .= " LEFT JOIN " . DB_PREFIX . "product_filter pf ON (p2c.product_id = pf.product_id) LEFT JOIN " . DB_PREFIX . "product p ON (pf.product_id = p.product_id)";
                    $sql .= " LEFT JOIN " . DB_PREFIX . "filter_description fd ON (pf.filter_id = fd.filter_id and fd.language_id = '" . (int) $this->config->get('config_language_id') . "')";
                } else {
                    $sql .= " LEFT JOIN " . DB_PREFIX . "product p ON (p2c.product_id = p.product_id)";
                }
            } else {
                $sql .= " FROM " . DB_PREFIX . "product p";
            }
            
            foreach ($option_groups as $key => $value)
            {
                $sql .= " LEFT JOIN " . DB_PREFIX . "product_option_value pov" . $key . " ON (p.product_id = pov" . $key . ".product_id)";
            }

            $sql .= " LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "'";

            if (!empty($data['filter_name']) || !empty($data['filter_tag'])) {
                $sql .= " AND (";

                if (!empty($data['filter_name'])) {
                    $implode = array();

                    $words = explode(' ', trim(preg_replace('/\s\s+/', ' ', $data['filter_name'])));

                    foreach ($words as $word) {
                        $implode[] = "(pd.name LIKE '%" . $this->db->escape($word) . "%' OR cd.name LIKE '%" . $this->db->escape($word) . "%' OR fd.name LIKE '%" . $this->db->escape($word) . "%')";
                    }

                    if ($implode) {
                        $sql .= " (" . implode(" AND ", $implode) . ")";
                    }

                    if (!empty($data['filter_description'])) {
                        $sql .= " OR pd.description LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
                    }
                }

                if (!empty($data['filter_name']) && !empty($data['filter_tag'])) {
                    $sql .= " OR ";
                }

                if (!empty($data['filter_tag'])) {
                    $sql .= "pd.tag LIKE '%" . $this->db->escape($data['filter_tag']) . "%'";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " OR LCASE(p.model) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " OR LCASE(p.sku) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " OR LCASE(p.upc) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " OR LCASE(p.ean) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " OR LCASE(p.jan) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " OR LCASE(p.isbn) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " OR LCASE(p.mpn) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                }

                $sql .= ")";
            }

            if (!empty($myCategories)) {
                $implode_data = array();

                foreach ($myCategories as $category_id) {
                    $implode_data[] = "p2c.category_id = '" . (int) $category_id . "'";
                }
                if (!empty($data['filter_sub_category'])) {

                    $this->load->model('catalog/category');

                    $categories = $this->model_catalog_category->getCategoriesByParentId($data['filter_category_id']);

                    foreach ($categories as $category_id) {
                        $implode_data[] = "p2c.category_id = '" . (int) $category_id . "'";
                    }
                }

                $sql .= " AND (" . implode(' OR ', $implode_data) . ")";
                
                foreach ($filter_groups as $key => $filters) {
                    $implode = array();

                    $filters = explode(',', $filters);

                    foreach ($filters as $filter_id) {
                        $implode[] = (int) $filter_id;
                    }

                    $sql .= " AND pf" . $key . ".filter_id IN (" . implode(',', $implode) . ")";
                }


                foreach ($option_groups as $key => $options) {
                    $implode = array();

                    $options = explode(',', $options);

                    foreach ($options as $option_id) {
                        $implode[] = (int) $option_id;
                    }

                    $sql .= " AND pov" . $key . ".option_value_id IN (" . implode(',', $implode) . ")";
                }
            }

            if (!empty($data['filter_manufacturer_id'])) {
                $sql .= " AND p.manufacturer_id = '" . (int) $data['filter_manufacturer_id'] . "'";
            }

            if (isset($data['filter_new'])) {
                if ($data['filter_new']) {
                    $sql .= " AND p.date_added > '" . date("Y-m-d", strtotime('-' . (int) $this->config->get('config_new_product_age') . ' day')) . "'";
                } else {
                    $sql .= " AND p.date_added < '" . date("Y-m-d", strtotime('-' . (int) $this->config->get('config_new_product_age') . ' day')) . "'";
                }
            }

            if (!empty($data['filter_sale']) && $data['filter_sale']) {
                if ($this->config->get('config_sale_item')) {
                    $sql .= " AND sale = 1 ";
                } else {
                    $sql .= " AND (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0";
                }
            }

            if (!empty($data['filter_product_min_price'])) {
                $sql .= " AND IFNULL((SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1),price) >= " . (float) $data['filter_product_min_price'];
            }

            if (!empty($data['filter_product_max_price'])) {
                $sql .= " AND IFNULL((SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1),price) <= " . (float) $data['filter_product_max_price'];
            }
        
            if ($this->config->get('config_category_instockonly')) {
                $sql .= " AND p.quantity > 0";
            }

            $sql .= " GROUP BY p.product_id";

            $sort_data = array(
                'pd.name',
                'p.model',
                'p.quantity',
                'p.price',
                'rating',
                'p.sort_order',
                'p.date_added'
            );
        
            if (!empty($data['filter_category_id']) && $this->extensions->isInstalled('merchandising', 'module') && $this->config->get('merchandising_status')) {
                $sort_data[] = 'p2c.sort_order';
                
                if (isset($data['sort']) && $data['sort'] == 'p.sort_order')
                {
                    $data['sort'] = 'p2c.sort_order';
                }
            }

            if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
                if ($data['sort'] == 'pd.name' || $data['sort'] == 'p.model') {
                    $sql .= " ORDER BY LCASE(" . $data['sort'] . ")";
                } elseif ($data['sort'] == 'p.price') {
                    $sql .= " ORDER BY (CASE WHEN special IS NOT NULL THEN special WHEN discount IS NOT NULL THEN discount ELSE p.price END)";
                } else {
                    $sql .= " ORDER BY " . $data['sort'];
                }
            } elseif (!empty($data['filter_category_id']) && $this->extensions->isInstalled('merchandising', 'module') && $this->config->get('merchandising_status')) {
                $sql .= ' ORDER BY p2c.sort_order';
            } else {
                $sql .= " ORDER BY p.sort_order";
            }

            if (isset($data['order']) && ($data['order'] == 'DESC')) {
                $sql .= " DESC, LCASE(pd.name) DESC";
            } else {
                $sql .= " ASC, LCASE(pd.name) ASC";
            }

            if (isset($data['start']) || isset($data['limit'])) {
                if ($data['start'] < 0) {
                    $data['start'] = 0;
                }

                if ($data['limit'] < 1) {
                    $data['limit'] = 20;
                }

                $sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
            }

            $product_data = array();

            $query = $this->db->query($sql);

            foreach ($query->rows as $result) {
                $product_data[$result['product_id']] = $this->getProduct($result['product_id']);
            }

            $this->cache->set('product.' . (int) $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id') . '.' . (int) $customer_group_id . '.' . $cache, $product_data);
        }

        return $product_data;
    }

    public function getProductSpecials($data = array()) {
        if ($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }

        $sql = "SELECT DISTINCT ps.product_id, (SELECT AVG(rating) FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = ps.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating FROM " . DB_PREFIX . "product_special ps LEFT JOIN " . DB_PREFIX . "product p ON (ps.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "' AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) GROUP BY ps.product_id";

        $sort_data = array(
            'pd.name',
            'p.model',
            'ps.price',
            'rating',
            'p.sort_order'
        );

        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            if ($data['sort'] == 'pd.name' || $data['sort'] == 'p.model') {
                $sql .= " ORDER BY LCASE(" . $data['sort'] . ")";
            } else {
                $sql .= " ORDER BY " . $data['sort'];
            }
        } else {
            $sql .= " ORDER BY p.sort_order";
        }

        if (isset($data['order']) && ($data['order'] == 'DESC')) {
            $sql .= " DESC, LCASE(pd.name) DESC";
        } else {
            $sql .= " ASC, LCASE(pd.name) ASC";
        }

        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }

            $sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
        }

        $product_data = array();

        $query = $this->db->query($sql);

        foreach ($query->rows as $result) {
            $product_data[$result['product_id']] = $this->getProduct($result['product_id']);
        }

        return $product_data;
    }

    public function getLatestProducts($limit) {
        if ($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }

        $product_data = $this->cache->get('product.latest.' . (int) $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id') . '.' . $customer_group_id . '.' . (int) $limit);

        if (!$product_data) {
            $query = $this->db->query("SELECT p.product_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "' ORDER BY p.date_added DESC LIMIT " . (int) $limit);

            foreach ($query->rows as $result) {
                $product_data[$result['product_id']] = $this->getProduct($result['product_id']);
            }

            $this->cache->set('product.latest.' . (int) $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id') . '.' . $customer_group_id . '.' . (int) $limit, $product_data);
        }

        return $product_data;
    }

    public function getPopularProducts($limit) {
        $product_data = array();

        $query = $this->db->query("SELECT p.product_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "' ORDER BY p.viewed, p.date_added DESC LIMIT " . (int) $limit);

        foreach ($query->rows as $result) {
            $product_data[$result['product_id']] = $this->getProduct($result['product_id']);
        }

        return $product_data;
    }

    public function getBestSellerProducts($limit) {
        if ($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }

        $product_data = $this->cache->get('product.bestseller.' . (int) $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id') . '.' . $customer_group_id . '.' . (int) $limit);

        if (!$product_data) {
            $product_data = array();

            $query = $this->db->query("SELECT op.product_id, COUNT(*) AS total FROM " . DB_PREFIX . "order_product op LEFT JOIN `" . DB_PREFIX . "order` o ON (op.order_id = o.order_id) LEFT JOIN `" . DB_PREFIX . "product` p ON (op.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE o.order_status_id > '0' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "' GROUP BY op.product_id ORDER BY total DESC LIMIT " . (int) $limit);

            foreach ($query->rows as $result) {
                $product_data[$result['product_id']] = $this->getProduct($result['product_id']);
            }

            $this->cache->set('product.bestseller.' . (int) $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id') . '.' . $customer_group_id . '.' . (int) $limit, $product_data);
        }

        return $product_data;
    }

    public function getProductAttributes($product_id) {
        $product_attribute_group_data = array();

        $product_attribute_group_query = $this->db->query("SELECT ag.attribute_group_id, agd.name FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "attribute a ON (pa.attribute_id = a.attribute_id) LEFT JOIN " . DB_PREFIX . "attribute_group ag ON (a.attribute_group_id = ag.attribute_group_id) LEFT JOIN " . DB_PREFIX . "attribute_group_description agd ON (ag.attribute_group_id = agd.attribute_group_id) WHERE pa.product_id = '" . (int) $product_id . "' AND agd.language_id = '" . (int) $this->config->get('config_language_id') . "' GROUP BY ag.attribute_group_id ORDER BY ag.sort_order, agd.name");

        foreach ($product_attribute_group_query->rows as $product_attribute_group) {
            $product_attribute_data = array();

            $product_attribute_query = $this->db->query("SELECT a.attribute_id, ad.name, pa.text FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "attribute a ON (pa.attribute_id = a.attribute_id) LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (a.attribute_id = ad.attribute_id) WHERE pa.product_id = '" . (int) $product_id . "' AND a.attribute_group_id = '" . (int) $product_attribute_group['attribute_group_id'] . "' AND ad.language_id = '" . (int) $this->config->get('config_language_id') . "' AND pa.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY a.sort_order, ad.name");

            foreach ($product_attribute_query->rows as $product_attribute) {
                $product_attribute_data[] = array(
                    'attribute_id' => $product_attribute['attribute_id'],
                    'name' => $product_attribute['name'],
                    'text' => $product_attribute['text']
                );
            }

            $product_attribute_group_data[] = array(
                'attribute_group_id' => $product_attribute_group['attribute_group_id'],
                'name' => $product_attribute_group['name'],
                'attribute' => $product_attribute_data
            );
        }

        return $product_attribute_group_data;
    }

    public function getProductOptions($product_id) {
        $product_option_data = array();

        $product_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE po.product_id = '" . (int) $product_id . "' AND od.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY o.sort_order");

        foreach ($product_option_query->rows as $product_option) {
            if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') {
                $product_option_value_data = array();

                $product_option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_id = '" . (int) $product_id . "' AND pov.product_option_id = '" . (int) $product_option['product_option_id'] . "' AND ovd.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY ov.sort_order");

                foreach ($product_option_value_query->rows as $product_option_value) {
                    $product_option_value_data[] = array(
                        'product_option_value_id' => $product_option_value['product_option_value_id'],
                        'option_value_id' => $product_option_value['option_value_id'],
                        'name' => $product_option_value['name'],
                        'image' => $product_option_value['image'],
                        'quantity' => $product_option_value['quantity'],
                        'subtract' => $product_option_value['subtract'],
                        'price' => $product_option_value['price'],
                        'price_prefix' => $product_option_value['price_prefix'],
                        'weight' => $product_option_value['weight'],
                        'weight_prefix' => $product_option_value['weight_prefix']
                    );
                }

                $product_option_data[] = array(
                    'product_option_id' => $product_option['product_option_id'],
                    'option_id' => $product_option['option_id'],
                    'name' => $product_option['name'],
                    'type' => $product_option['type'],
                    'option_value' => $product_option_value_data,
                    'required' => $product_option['required']
                );
            } else {
                $product_option_data[] = array(
                    'product_option_id' => $product_option['product_option_id'],
                    'option_id' => $product_option['option_id'],
                    'name' => $product_option['name'],
                    'type' => $product_option['type'],
                    'option_value' => $product_option['option_value'],
                    'required' => $product_option['required']
                );
            }
        }

        return $product_option_data;
    }

    public function getProductDiscounts($product_id) {
        if ($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int) $product_id . "' AND customer_group_id = '" . (int) $customer_group_id . "' AND quantity > 1 AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY quantity ASC, priority ASC, price ASC");

        return $query->rows;
    }

    public function getProductImages($product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int) $product_id . "' ORDER BY sort_order ASC");

        return $query->rows;
    }

    public function getProductRelated($product_id) {
        $product_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_related pr LEFT JOIN " . DB_PREFIX . "product p ON (pr.related_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE pr.product_id = '" . (int) $product_id . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "'");

        foreach ($query->rows as $result) {
            $product_data[$result['related_id']] = $this->getProduct($result['related_id']);
        }

        return $product_data;
    }

    /* Customers also bought - added TF 20/07/2012 */

    public function getProductCustomersAlsoBought($product_id) {
        $product_data = array();

        $query = $this->db->query("SELECT op.product_id FROM " . DB_PREFIX . "order_product op INNER JOIN " . DB_PREFIX . "order_product opp ON opp.order_id = op.order_id and opp.product_id = '" . (int) $product_id . "' LEFT JOIN " . DB_PREFIX . "product p ON (op.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE op.product_id != '" . (int) $product_id . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "' GROUP BY op.product_id ORDER BY COUNT(op.product_id) * SUM(op.quantity)");

        foreach ($query->rows as $result) {
            $product_data[$result['product_id']] = $this->getProduct($result['product_id']);
        }

        return $product_data;
    }

    /* End customers also bought - added TF 20/07/2012 */

    public function getProductTags($product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_tag WHERE product_id = '" . (int) $product_id . "' AND language_id = '" . (int) $this->config->get('config_language_id') . "'");

        return $query->rows;
    }

    public function getProductLayoutId($product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int) $product_id . "' AND store_id = '" . (int) $this->config->get('config_store_id') . "'");

        if ($query->num_rows) {
            return $query->row['layout_id'];
        } else {
            return $this->config->get('config_layout_product');
        }
    }

    public function getCategories($product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int) $product_id . "'");

        return $query->rows;
    }

    public function getTotalProducts($data = array()) {
        if ($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }

        $cache = md5(http_build_query($data));

        $product_data = $this->cache->get('product.total.' . (int) $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id') . '.' . (int) $customer_group_id . '.' . $cache);

        if (is_null($product_data)) {
            $myCategories = array();

            if (!empty($data['filter_category_id']))
                $myCategories[] = $data['filter_category_id'];

            if (isset($data['afilters'])) {

                if (isset($data['afilters'][0])) {
                    foreach ($data['afilters'][0] as $cat_id) {
                        if (!in_array($cat_id, $myCategories))
                            $myCategories[] = $cat_id;
                    }
                    unset($data['afilters'][0]);
                }
            }
           
            $filter_groups = (!empty($data['filter_filter'])) ? explode(':', $data['filter_filter']) : array();
            $option_groups = (!empty($data['filter_option'])) ? explode(':', $data['filter_option']) : array();

            $sql = "SELECT COUNT(DISTINCT p.product_id) AS total";

            if (!empty($data['filter_category_id']) || !empty($data['filter_name']) || !empty($data['filter_option'])) {
                if (!empty($data['filter_sub_category'])) {
                    // $sql .= " FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (cp.category_id = p2c.category_id)";			
                    $sql .= " FROM " . DB_PREFIX . "product_to_category p2c";
                } else {
                    $sql .= " FROM " . DB_PREFIX . "product_to_category p2c";
                }
                
                foreach ($filter_groups as $key => $filters) {
                    $sql .= " LEFT JOIN " . DB_PREFIX . "product_filter pf" . $key . " ON (p2c.product_id = pf" . $key . ".product_id)";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " LEFT JOIN " . DB_PREFIX . "category_description cd ON (cd.category_id = p2c.category_id and cd.language_id = '" . (int) $this->config->get('config_language_id') . "')";
                    
                    $sql .= " LEFT JOIN " . DB_PREFIX . "product_filter pf ON (p2c.product_id = pf.product_id) LEFT JOIN " . DB_PREFIX . "product p ON (pf.product_id = p.product_id)";
                    $sql .= " LEFT JOIN " . DB_PREFIX . "filter_description fd ON (pf.filter_id = fd.filter_id and fd.language_id = '" . (int) $this->config->get('config_language_id') . "')";
                } else {
                    $sql .= " LEFT JOIN " . DB_PREFIX . "product p ON (p2c.product_id = p.product_id)";
                }
            } else {
                $sql .= " FROM " . DB_PREFIX . "product p";
            }
            
            foreach ($option_groups as $key => $value)
            {
                $sql .= " LEFT JOIN " . DB_PREFIX . "product_option_value pov" . $key . " ON (p.product_id = pov" . $key . ".product_id)";
            }

            $sql .= " LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE ";

            if (!empty($myCategories)) {
                $implode_data = array();

                foreach ($myCategories as $category_id) {
                    $implode_data[] = "p2c.category_id = '" . (int) $category_id . "'";
                }
                if (!empty($data['filter_sub_category'])) {

                    $this->load->model('catalog/category');

                    $categories = $this->model_catalog_category->getCategoriesByParentId($data['filter_category_id']);

                    foreach ($categories as $category_id) {
                        $implode_data[] = "p2c.category_id = '" . (int) $category_id . "'";
                    }
                }

                $sql .= " (" . implode(' OR ', $implode_data) . ") AND "; 
                
                foreach ($filter_groups as $key => $filters) {
                    $implode = array();

                    $filters = explode(',', $filters);

                    foreach ($filters as $filter_id) {
                        $implode[] = (int) $filter_id;
                    }

                    $sql .= " pf" . $key . ".filter_id IN (" . implode(',', $implode) . ") AND ";
                }


                foreach ($option_groups as $key => $options) {
                    $implode = array();

                    $options = explode(',', $options);

                    foreach ($options as $option_id) {
                        $implode[] = (int) $option_id;
                    }

                    $sql .= " pov" . $key . ".option_value_id IN (" . implode(',', $implode) . ") AND ";
                }
            }
            
            $sql .= " p.status = '1' AND p.date_available <= NOW() AND pd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "'";

            if (isset($data['filter_new'])) {
                if ($data['filter_new']) {
                    $sql .= " AND p.date_added > '" . date("Y-m-d", strtotime('-' . (int) $this->config->get('config_new_product_age') . ' day')) . "'";
                } else {
                    $sql .= " AND p.date_added < '" . date("Y-m-d", strtotime('-' . (int) $this->config->get('config_new_product_age') . ' day')) . "'";
                }
            }

            if (!empty($data['filter_manufacturer_id'])) {
                $sql .= " AND p.manufacturer_id = '" . (int) $data['filter_manufacturer_id'] . "'";
            }
        
            if ($this->config->get('config_category_instockonly')) {
                $sql .= " AND p.quantity > 0";
            }

            if (!empty($data['filter_name']) || !empty($data['filter_tag'])) {
                $sql .= " AND (";

                if (!empty($data['filter_name'])) {
                    $implode = array();

                    $words = explode(' ', trim(preg_replace('/\s\s+/', ' ', $data['filter_name'])));

                    foreach ($words as $word) {
                        $implode[] = "(pd.name LIKE '%" . $this->db->escape($word) . "%' OR cd.name LIKE '%" . $this->db->escape($word) . "%' OR fd.name LIKE '%" . $this->db->escape($word) . "%')";
                    }

                    if ($implode) {
                        $sql .= " (" . implode(" AND ", $implode) . ")";
                    }

                    if (!empty($data['filter_description'])) {
                        $sql .= " OR pd.description LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
                    }
                }

                if (!empty($data['filter_name']) && !empty($data['filter_tag'])) {
                    $sql .= " OR ";
                }

                if (!empty($data['filter_tag'])) {
                    $sql .= "pd.tag LIKE '%" . $this->db->escape($data['filter_tag']) . "%'";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " OR LCASE(p.model) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " OR LCASE(p.sku) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " OR LCASE(p.upc) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " OR LCASE(p.ean) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " OR LCASE(p.jan) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " OR LCASE(p.isbn) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                }

                if (!empty($data['filter_name'])) {
                    $sql .= " OR LCASE(p.mpn) = '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "'";
                }

                $sql .= ")";
            }

            if (!empty($data['filter_sale']) && $data['filter_sale']) {
                if ($this->config->get('config_sale_item')) {
                    $sql .= " AND p.sale = 1 ";
                } else {
                    $sql .= " AND (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0";
                }
            }

            if (!empty($data['filter_product_min_price'])) {
                $sql .= " AND IFNULL((SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1),price) >= " . (float) $data['filter_product_min_price'];
            }

            if (!empty($data['filter_product_max_price'])) {
                $sql .= " AND IFNULL((SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1),price) <= " . (float) $data['filter_product_max_price'];
            }

            $query = $this->db->query($sql);
            
            $product_data = $query->row['total'];

            $this->cache->set('product.total.' . (int) $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id') . '.' . (int) $customer_group_id . '.' . $cache, $product_data);
        }

        return $product_data;
    }

    public function getTotalProductSpecials() {
        if ($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }

        $query = $this->db->query("SELECT COUNT(DISTINCT ps.product_id) AS total FROM " . DB_PREFIX . "product_special ps LEFT JOIN " . DB_PREFIX . "product p ON (ps.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "' AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()))");

        if (isset($query->row['total'])) {
            return $query->row['total'];
        } else {
            return 0;
        }
    }

    public function getAttributesName($att_id) {
        $query = $this->db->query("SELECT pa.text, attribute_id FROM " . DB_PREFIX . "product_attribute pa WHERE pa.attribute_id = '" . (int) $att_id . "' AND pa.language_id = '" . (int) $this->config->get('config_language_id') . "'");

        return $query->rows;
    }

    public function getInfoPress($product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "news n LEFT JOIN " . DB_PREFIX . "news_description nd ON (n.news_id = nd.news_id) LEFT JOIN " . DB_PREFIX . "news_to_store n2s ON (n.news_id = n2s.news_id) LEFT JOIN " . DB_PREFIX . "news_related nr ON (n.news_id = nr.news_id) LEFT JOIN " . DB_PREFIX . "news_to_ncategory ntc ON (n.news_id = ntc.news_id) WHERE product_id = '" . (int) $product_id . "' AND n2s.store_id = '" . (int) $this->config->get('config_store_id') . "'");

        if ($query->num_rows > 0) {

            return $query->rows;
        } else {

            return false;
        }
    }

}

?>