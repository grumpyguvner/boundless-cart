<?php

class ModelCatalogCategory extends Model {

    public function getParentCategory($category_id) {

        $query = $this->db->query("SELECT parent_id FROM " . DB_PREFIX . "category WHERE category_id = '" . (int) $category_id . "'");

        if ($query->num_rows) {

            return $query->row['parent_id'];
        } else {

            return false;
        }
    }

    public function getProductCategories($prodid) {
        $query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . $prodid . "'");
        if ($query->num_rows > 0) {
            return $query->rows;
        } else {
            return false;
        }
    }

    public function getCategoryFilters($category_id, $data = array()) {
        if ($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }
        
        $cache = md5(http_build_query($data));

        $filter_group_data = $this->cache->get('product.filter.' . (int) $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id') . '.' . (int) $customer_group_id . '.' . (int) $category_id . '.' . $cache);

        if (is_null($filter_group_data)) {
        
            $filter_group_data = array();

            $sql = "SELECT f.filter_group_id, fgd.name as fgd_name, f.filter_id, fd.name, COUNT(DISTINCT p.product_id) as total, ";
            
            if (!empty($data['filter_filter']) || !empty($data['filter_option']) || isset($data['filter_new']) || (!empty($data['filter_sale']) && $data['filter_sale']) || !empty($data['filter_product_min_price']) || !empty($data['filter_product_max_price']))
            {
                $sql .= "IF (COUNT(DISTINCT p.product_id) > 0, (";
                
                $filter_groups = (!empty($data['filter_filter'])) ? explode(':', $data['filter_filter']) : array();
                $option_groups = (!empty($data['filter_option'])) ? explode(':', $data['filter_option']) : array();

                $sql .= "SELECT COUNT(DISTINCT sub_p.product_id) ";
                $sql .= " FROM oc_product sub_p ";
                $sql .= " INNER JOIN oc_product_to_category sub_p2c ON sub_p2c.product_id = sub_p.product_id ";
                $sql .= " INNER JOIN oc_product_filter sub_pf ON (sub_pf.product_id = sub_p.product_id) ";
                $sql .= " INNER JOIN oc_filter sub_f ON sub_f.filter_id = sub_pf.filter_id ";
                foreach ($filter_groups as $key => $filters) {
                    $implode = array();

                    $filters = explode(',', $filters);

                    foreach ($filters as $filter_id) {
                        $implode[] = (int) $filter_id;
                    }
                    $sql .= " INNER JOIN oc_product_filter sub_pf" . $key . " ON (sub_pf" . $key . ".product_id = sub_p.product_id AND (sub_pf" . $key . ".filter_id IN (" . implode(',', $implode) . "))) ";
                    $sql .= " INNER JOIN oc_filter sub_f" . $key . " ON sub_f" . $key . ".filter_id = sub_pf" . $key . ".filter_id AND (sub_f" . $key . ".filter_id = sub_f.filter_id OR sub_f" . $key . ".filter_group_id <> sub_f.filter_group_id) ";
                }

                foreach ($option_groups as $key => $value)
                {
                    $implode = array();

                    $options = explode(',', $options);

                    foreach ($options as $option_id) {
                        $implode[] = (int) $option_id;
                    }
                    $sql .= " INNER JOIN " . DB_PREFIX . "product_option_value sub_pov" . $key . " ON (sub_pov" . $key . ".product_id = sub_p.product_id AND sub_pov" . $key . ".option_value_id IN (" . implode(',', $implode) . ")) ";
                }
                $sql .= " INNER JOIN oc_product_description sub_pd ON (sub_pd.product_id = sub_p.product_id) ";
                $sql .= " INNER JOIN oc_product_to_store sub_p2s ON (sub_p.product_id = sub_p2s.product_id) ";
                $sql .= " WHERE sub_p2c.category_id = cf.category_id AND sub_pf.filter_id = cf.filter_id AND sub_p.status = '1' AND sub_p.date_available <= NOW() AND sub_p.quantity > 0 AND sub_pd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND sub_p2s.store_id = '" . (int) $this->config->get('config_store_id') . "' ";

                if (isset($data['filter_new'])) {
                    if ($data['filter_new']) {
                        $sql .= " AND sub_p.date_added > '" . date("Y-m-d", strtotime('-' . (int) $this->config->get('config_new_product_age') . ' day')) . "'";
                    } else {
                        $sql .= " AND sub_p.date_added < '" . date("Y-m-d", strtotime('-' . (int) $this->config->get('config_new_product_age') . ' day')) . "'";
                    }
                }

                if ($this->config->get('config_category_instockonly')) {
                    $sql .= " AND sub_p.quantity > 0";
                }

                if (!empty($data['filter_sale']) && $data['filter_sale']) {
                    if ($this->config->get('config_sale_item')) {
                        $sql .= " AND sub_p.sale = 1 ";
                    } else {
                        $sql .= " AND (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = sub_p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0";
                    }
                }

                if (!empty($data['filter_product_min_price'])) {
                    $sql .= " AND IFNULL((SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = sub_p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1),sub_p.price) >= " . (float) $data['filter_product_min_price'];
                }

                if (!empty($data['filter_product_max_price'])) {
                    $sql .= " AND IFNULL((SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = sub_p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1),sub_p.price) <= " . (float) $data['filter_product_max_price'];
                }   
                $sql .= "), 0) ";
            } else {
                $sql .= "COUNT(DISTINCT p.product_id) ";
            }
            
            $sql .= " as filter_total "
                  . "FROM " . DB_PREFIX . "category_filter cf "
                  . "JOIN " . DB_PREFIX . "filter f ON f.filter_id = cf.filter_id "
                  . "LEFT JOIN " . DB_PREFIX . "filter_description fd ON (fd.filter_id = f.filter_id) "
                  . "LEFT JOIN " . DB_PREFIX . "filter_group fg ON (fg.filter_group_id = f.filter_group_id) "
                  . "LEFT JOIN " . DB_PREFIX . "filter_group_description fgd ON (fgd.filter_group_id = fg.filter_group_id) "
                  . "LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON p2c.category_id = cf.category_id "
                  . "LEFT JOIN " . DB_PREFIX . "product_filter pf ON pf.filter_id = f.filter_id AND pf.product_id = p2c.product_id "
                  . "LEFT JOIN " . DB_PREFIX . "product p ON p.product_id = pf.product_id "
                  . "LEFT JOIN " . DB_PREFIX . "product_description pd ON (pd.product_id = p.product_id) "
                  . "LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p2s.product_id = p.product_id) "
                  . "WHERE cf.category_id = '" . (int) $category_id . "' AND fgd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND fd.language_id = '" . (int) $this->config->get('config_language_id') . "' "
                  . "AND p.status = '1' AND p.date_available <= NOW() AND pd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "' ";

            if ($this->config->get('config_category_instockonly')) {
                $sql .= " AND p.quantity > 0 ";
            }

            $sql .= "GROUP BY f.filter_id "
                  . "ORDER BY fg.sort_order ASC, LCASE(fgd.name) ASC, f.sort_order ASC, LCASE(fd.name) ASC";

            $query = $this->db->query($sql);

            if ($query->num_rows)
            {
                foreach ($query->rows as $row)
                {
                    $temp = array('filter_id' => $row['filter_id'],
                                  'name' => $row['name'],
                                  'total' => $row['total'],
                                  'filter_total' => $row['filter_total']);

                    if (!isset($filter_group_data[$row['filter_group_id']]))
                    {
                        $filter_group_data[$row['filter_group_id']] = array(
                                                                        'filter_group_id' => $row['filter_group_id'],
                                                                        'name' => $row['fgd_name'],
                                                                        'filter' => array()
                                                                    );
                    }

                    $filter_group_data[$row['filter_group_id']]['filter'][] = $temp;
                }
            }
            
            $this->cache->set('product.filter.' . (int) $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id') . '.' . (int) $customer_group_id . '.' . (int) $category_id . '.' . $cache, $filter_group_data);
        }

        return $filter_group_data;
    }
    
    public function getCategoryOptions($category_id, $data = array()) {
        
        if ($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }
        
        $cache = md5(http_build_query($data));

        $option_data = $this->cache->get('product.options.' . (int) $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id') . '.' . (int) $customer_group_id . '.' . (int) $category_id . '.' . $cache);

        if (is_null($option_data)) {
        
            $option_data = array();

            $sql = "SELECT o.option_id, od.name as od_name, ov.option_value_id, ovd.name, COUNT(DISTINCT p.product_id) as total, ";
            
            if (!empty($data['filter_filter']) || !empty($data['filter_option']) || isset($data['filter_new']) || (!empty($data['filter_sale']) && $data['filter_sale']) || !empty($data['filter_product_min_price']) || !empty($data['filter_product_max_price']))
            {
                $sql .= "IF (COUNT(DISTINCT p.product_id) > 0, (";
                
                $filter_groups = (!empty($data['filter_filter'])) ? explode(':', $data['filter_filter']) : array();
                $option_groups = (!empty($data['filter_option'])) ? explode(':', $data['filter_option']) : array();

                $sql .= "SELECT COUNT(DISTINCT sub_p.product_id) ";
                $sql .= " FROM oc_product sub_p ";
                $sql .= " INNER JOIN oc_product_to_category sub_p2c ON sub_p2c.product_id = sub_p.product_id ";
                $sql .= " INNER JOIN " . DB_PREFIX . "product_option_value sub_pov ON (sub_pov.product_id = sub_p2c.product_id) ";
                $sql .= " INNER JOIN oc_option_value sub_ov ON sub_ov.option_value_id = sub_pov.option_value_id ";
                foreach ($filter_groups as $key => $filters) {
                    $implode = array();

                    $filters = explode(',', $filters);

                    foreach ($filters as $filter_id) {
                        $implode[] = (int) $filter_id;
                    }
                    $sql .= " INNER JOIN oc_product_filter sub_pf" . $key . " ON (sub_pf" . $key . ".product_id = sub_p.product_id AND (sub_pf" . $key . ".filter_id IN (" . implode(',', $implode) . "))) ";
                }

                foreach ($option_groups as $key => $value)
                {
                    $implode = array();

                    $options = explode(',', $options);

                    foreach ($options as $option_id) {
                        $implode[] = (int) $option_id;
                    }
                    $sql .= " INNER JOIN " . DB_PREFIX . "product_option_value sub_pov" . $key . " ON (sub_pov" . $key . ".product_id = sub_p.product_id AND sub_pov" . $key . ".option_value_id IN (" . implode(',', $implode) . ")) ";
                    $sql .= " INNER JOIN oc_option_value sub_ov" . $key . " ON sub_ov" . $key . ".option_value_id = sub_pov" . $key . ".option_value_id AND (sub_ov" . $key . ".option_value_id = sub_ov.option_value_id OR sub_ov" . $key . ".option_id <> sub_ov.option_id) ";
                }
                $sql .= " INNER JOIN oc_product_description sub_pd ON (sub_pd.product_id = sub_p.product_id) ";
                $sql .= " INNER JOIN oc_product_to_store sub_p2s ON (sub_p.product_id = sub_p2s.product_id) ";
                $sql .= " WHERE sub_p2c.category_id = '" . (int) $category_id . "' AND sub_p.status = '1' AND sub_p.date_available <= NOW() AND sub_p.quantity > 0 AND sub_pd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND sub_p2s.store_id = '" . (int) $this->config->get('config_store_id') . "' ";

                if (isset($data['filter_new'])) {
                    if ($data['filter_new']) {
                        $sql .= " AND sub_p.date_added > '" . date("Y-m-d", strtotime('-' . (int) $this->config->get('config_new_product_age') . ' day')) . "'";
                    } else {
                        $sql .= " AND sub_p.date_added < '" . date("Y-m-d", strtotime('-' . (int) $this->config->get('config_new_product_age') . ' day')) . "'";
                    }
                }

                if ($this->config->get('config_category_instockonly')) {
                    $sql .= " AND sub_p.quantity > 0";
                }

                if (!empty($data['filter_sale']) && $data['filter_sale']) {
                    if ($this->config->get('config_sale_item')) {
                        $sql .= " AND sub_p.sale = 1 ";
                    } else {
                        $sql .= " AND (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = sub_p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) > 0";
                    }
                }

                if (!empty($data['filter_product_min_price'])) {
                    $sql .= " AND IFNULL((SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = sub_p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1),sub_p.price) >= " . (float) $data['filter_product_min_price'];
                }

                if (!empty($data['filter_product_max_price'])) {
                    $sql .= " AND IFNULL((SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = sub_p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1),sub_p.price) <= " . (float) $data['filter_product_max_price'];
                }   
                $sql .= "), 0) ";
            } else {
                $sql .= "COUNT(DISTINCT p.product_id) ";
            }
            
            $sql .= " as filter_total "
            
            
                  . "FROM " . DB_PREFIX . "option_value ov "
                  . "LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) "
                  . "LEFT JOIN " . DB_PREFIX . "option o ON (ov.option_id = o.option_id) "
                  . "LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) "
                  . "LEFT JOIN " . DB_PREFIX . "product_option_value pov ON (pov.option_value_id = ov.option_value_id) "
                  . "LEFT JOIN " . DB_PREFIX . "product p ON p.product_id = pov.product_id "
                  . "LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON p2c.product_id = p.product_id "
                  . "LEFT JOIN " . DB_PREFIX . "product_description pd ON (pd.product_id = p.product_id) "
                  . "LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p2s.product_id = p.product_id) "
                  . "WHERE o.is_filter = 1 and p2c.category_id = '" . (int) $category_id . "' AND od.language_id = '" . (int) $this->config->get('config_language_id') . "' AND ovd.language_id = '" . (int) $this->config->get('config_language_id') . "' "
                  . "AND p.status = '1' AND p.date_available <= NOW() AND pd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "' ";

            if ($this->config->get('config_category_instockonly')) {
                $sql .= " AND p.quantity > 0 ";
            }

            $sql .= "GROUP BY ov.option_value_id "
                  . "ORDER BY o.sort_order, LCASE(od.name), ov.sort_order, LCASE(ovd.name)";

            $query = $this->db->query($sql);

            if ($query->num_rows)
            {
                foreach ($query->rows as $row)
                {
                    $temp = array('option_value_id' => $row['option_value_id'],
                                  'name' => $row['name'],
                                  'total' => $row['total'],
                                  'filter_total' => $row['filter_total']);

                    if (!isset($option_data[$row['option_id']]))
                    {
                        $option_data[$row['option_id']] = array(
                                                                        'option_id' => $row['option_id'],
                                                                        'name' => $row['od_name'],
                                                                        'option_value' => array()
                                                                    );
                    }

                    $option_data[$row['option_id']]['option_value'][] = $temp;
                }
            }
            
            $this->cache->set('product.options.' . (int) $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id') . '.' . (int) $customer_group_id . '.' . (int) $category_id . '.' . $cache, $option_data);
        }

        return $option_data;
    }

    public function getCategory($category_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.category_id = '" . (int) $category_id . "' AND cd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int) $this->config->get('config_store_id') . "' AND c.status = '1'");

        return $query->row;
    }

    public function getCategories($parent_id = 0) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int) $parent_id . "' AND cd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int) $this->config->get('config_store_id') . "'  AND c.status = '1' ORDER BY c.sort_order, LCASE(cd.name)");

        return $query->rows;
    }

    public function getCategoryPriceRange($category_id) {
        
        if ($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }
        
        $sql = "SELECT MIN(IFNULL(ps.price, p.price)) as min, MAX(IFNULL(ps.price, p.price)) as max "
             . "FROM " . DB_PREFIX . "product p "
             . "INNER JOIN " . DB_PREFIX . "product_to_category p2c ON (p2c.product_id = p.product_id) "
             . "LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p2s.product_id = p2c.product_id) "
             . "LEFT JOIN " . DB_PREFIX . "product_special ps ON (ps.product_id = p.product_id) AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) "
             . "WHERE p.status = '1' AND p.date_available <= NOW() AND p2c.category_id = '" . (int) $category_id . "' AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' ";

        if ($this->config->get('config_category_instockonly')) {
            $sql .= " AND p.quantity > 0 ";
        }
        
        $query = $this->db->query($sql);

        return $query->row;
    }

    public function getAttributes() {
        $query = $this->db->query("SELECT name, (SELECT agd.name FROM " . DB_PREFIX . "attribute_group_description agd WHERE agd.attribute_group_id = a.attribute_group_id AND agd.language_id = '" . (int) $this->config->get('config_language_id') . "') AS attribute_group FROM " . DB_PREFIX . "attribute a LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (a.attribute_id = ad.attribute_id) WHERE ad.language_id = '" . (int) $this->config->get('config_language_id') . "'");

        return $query->rows;
    }

    public function getCategoryAttributes($category_id = 0) {
        // Get all attributes for current category

        $data = array();

        $data['filter_category_id'] = $category_id;
        $data['filters'] = $this->category->getFilterData();

        $results = $this->model_catalog_product->getProductsAFiltered($data);

        foreach ($results as $product) {

            $attributes = $this->model_catalog_product->getProductAttributes($product['product_id']);

            $category_attributes[] = $attributes; // mutat din forul de mai jos

            foreach ($attributes as $attribute) {

                if (is_array($attribute['attribute'])) {

                    foreach ($attribute['attribute'] as $attribute_value) {

                        $category_attributes_values[$attribute_value['attribute_id']][] = array(
                            'attribute_text' => $attribute_value['text'],
                            'attribute_name' => $attribute_value['name'], // name added

                            'attribute_id' => $attribute_value['attribute_id']
                        );
                    };
                } else {
                    $category_attributes_values[$attribute['attribute_id']][] = array(
                        'attribute_text' => '', //$option_value['name'],
                        'attribute_name' => '', //added
                        'attribute_id' => 0//$option_value['option_value_id']
                    );
                }
            }
        }

        unset($attributes);

        $big_array = array();

        if (isset($category_attributes)) {

            $i = 0;

            foreach ($category_attributes as $pattribute) { // parcurg produsele
                foreach ($pattribute as $gattribute) { // pentru toate grupele de atribute - fiecare grup al fiecarui produs
                    $attribute_array = $gattribute['attribute'];

                    // start get big attribute
                    $j = $gattribute['attribute_group_id'];
                    $mybool = false;
                    $myattr = false;
                    foreach ($big_array as $barray) {
                        if (in_array($j, $barray)) {
                            $mybool = true;
                        }
                        if (in_array($gattribute['attribute'], $barray)) {
                            $myattr = true;
                        }
                    }
                    if (!($mybool)) {
                        $big_array[$i]['attribute_group_id'] = $j;
                        $big_array[$i]['name'] = $gattribute['name'];
                        $big_array[$i]['attribute_types'] = array(); //$gattribute['attribute'][0]['attribute_id'];
                        //$big_array[$i]['attribute'][] = $gattribute['attribute'];
                        $i++;
                    }

                    // eng get bit attribute

                    foreach ($attribute_array as $att_array) { // pentru fiecare attribut - al fiecarui grup
                        $attribute_ids[] = $att_array['attribute_id'];

                        // start experiment
                        //	$big_array[$i]['attribute'][]

                        $all_attribs[$att_array['attribute_id']][] = array(
                            'attribute_text' => $attribute_value['text'],
                            'attribute_name' => $attribute_value['name']
                        );
                        // end experiment
                    }
                }
            }

            $i = 0;

            foreach ($big_array as $barray) {

                foreach ($category_attributes as $pattribute) {

                    foreach ($pattribute as $gattribute) {

                        $attribute_array = $gattribute['attribute'];

                        if ($big_array[$i]['attribute_group_id'] == $gattribute['attribute_group_id']) {

                            foreach ($attribute_array as $att_array) {

                                if (!in_array($att_array['attribute_id'], $big_array[$i]['attribute_types'])) {

                                    $big_array[$i]['attribute_types'][] = $att_array['attribute_id'];
                                }
                            }
                        };
                    };
                };

                $i++;
            };

            if (isset($attribute_ids)) {

                $attributes_ids = array_unique($attribute_ids); // or should it by unique by name?/ text
            } else {

                $attributes_ids = array();
            }


            $attributes = array();

            foreach ($attributes_ids as $attribute_id) { // pentru fiecare Attribute ID unic
                $i = $attribute_id;
                $attributes[$i] = array();

                foreach ($category_attributes_values[$i] as $pgroup) { // foreach of all products attributes groups (deja unice) - arrayuri de valori non-unice
                    if (!in_array($pgroup, $attributes[$i])) {

                        $attributes[$i][] = $pgroup;

                        //$found = true;	
                    }
                }
            }


            $big_array2 = array();
            $i = 0;

            foreach ($big_array as $barray) {

                if ($barray['name'] != "Product Tabs") {
                    $big_array2[$i]['attribute_group_id'] = $barray['attribute_group_id'];
                    $big_array2[$i]['name'] = $barray['name'];
                    $big_array2[$i]['attribute_types'] = array();

                    $types = $barray['attribute_types'];

                    $j = 0;

                    foreach ($types as $type) {

                        $big_array2[$i]['attribute_types'][$j]['type_id'] = $type;
                        $big_array2[$i]['attribute_types'][$j]['type_name'] = $attributes[$type][0]['attribute_name'];
                        $big_array2[$i]['attribute_types'][$j]['types'] = array();
                        foreach ($attributes[$type] as $atts) {

                            $big_array2[$i]['attribute_types'][$j]['types'][] = $atts['attribute_text'];
                        }

                        $j++;
                    }
                    $i++;
                }
            }
        }
        // END get all attributes for current category
        if (isset($big_array2))
            return $big_array2;
        else
            return array();
    }

    public function getCategoriesByParentId($category_id) {
        $category_data = array();

        $category_query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "category WHERE parent_id = '" . (int) $category_id . "'");

        foreach ($category_query->rows as $category) {
            $category_data[] = $category['category_id'];

            $children = $this->getCategoriesByParentId($category['category_id']);

            if ($children) {
                $category_data = array_merge($children, $category_data);
            }
        }

        return $category_data;
    }

    public function getCategoryLayoutId($category_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int) $category_id . "' AND store_id = '" . (int) $this->config->get('config_store_id') . "'");

        if ($query->num_rows) {
            return $query->row['layout_id'];
        } else {
            return $this->config->get('config_layout_category');
        }
    }

    public function getTotalCategoriesByCategoryId($parent_id = 0) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int) $parent_id . "' AND c2s.store_id = '" . (int) $this->config->get('config_store_id') . "' AND c.status = '1'");

        return $query->row['total'];
    }

}

?>