<?php
class ModelAmazonStatistics extends Model {

    public function getCatalogProductsQuantity($options) {

        $ext = '';

        if (isset($options['active']) && intval($options['active']))
            $ext .= ' AND status = 1';

        if (isset($options['instock']) && intval($options['instock']))
            $ext .= ' AND IF(pov.product_option_value_id IS NULL, p.quantity, pov.quantity) >= 1';

        $query = $this->db->query('SELECT count(*) as total FROM `' . DB_PREFIX . 'product` p
                    LEFT join `' . DB_PREFIX . 'product_option` po on (po.`product_id` = p.`product_id`)
                    LEFT join `' . DB_PREFIX . 'product_option_value` pov on (pov.`product_option_id` = po.`product_option_id`)
                                       WHERE 1' . $ext);

        return array_shift($query->rows);
    }

    public function getCatalogProductsWithoutSKU($options) {
        $ext = '';

        if (isset($options['active']) && intval($options['active']))
            $ext .= ' AND status = 1';

        if (isset($options['instock']) && intval($options['instock']))
            $ext .= ' AND IF(pov.product_option_value_id IS NULL, p.quantity, pov.quantity) >= 1';

        $query = $this->db->query('SELECT count(*) as total FROM `' . DB_PREFIX . 'product` p
                    LEFT join `' . DB_PREFIX . 'product_option` po on (po.`product_id` = p.`product_id`)
                    LEFT join `' . DB_PREFIX . 'product_option_value` pov on (pov.`product_option_id` = po.`product_option_id`)
                                       WHERE LENGTH(IF(pov.product_option_value_id IS NULL, p.`sku`, pov.`sku`)) < 1 ' . $ext);

        return array_shift($query->rows);
    }

    public function getCatalogProductsWithoutSKU_UPC($options) {
        $ext = '';

        if (isset($options['active']) && intval($options['active']))
            $ext .= ' AND status = 1';

        if (isset($options['instock']) && intval($options['instock']))
            $ext .= ' AND quantity >= 1';

        $query = $this->db->query('SELECT count(*) as total FROM `' . DB_PREFIX . 'product` p
                                       WHERE LENGTH(p.`sku`) < 1 AND
                                       ( LENGTH(p.`ean`) < 1 OR LENGTH(p.`upc`) < 1 )' . $ext);

        return array_shift($query->rows);
    }

    public function getCatalogProductsDuplicateSKU($options) {
        $ext = '';

        if (isset($options['active']) && intval($options['active']))
            $ext .= ' AND status = 1';

        if (isset($options['instock']) && intval($options['instock']))
            $ext .= ' AND quantity >= 1';

        $query = $this->db->query('SELECT count(`product_id`) as `total` FROM `' . DB_PREFIX . 'product`
                                       WHERE `sku` in (
                                          SELECT `sku` from `' . DB_PREFIX . 'product` WHERE 1 ' . $ext . '
                                          AND LENGTH(`sku`) > 1
                                          GROUP BY `sku`
                                          HAVING count(`sku`) > 1)');

        return array_shift($query->rows);
    }

    //------- Downloads --------


    public function getCatalogProductsWithoutSKU_Download($options) {
        $ext = '';

        if (isset($options['active']) && intval($options['active']))
            $ext .= ' AND status = 1';

        if (isset($options['instock']) && intval($options['instock']))
            $ext .= ' AND quantity >= 1';

        if (isset($options['language']) && intval($options['language']))
            $ext .= ' AND language_id = ' . intval($options['language']);

        $query = $this->db->query('SELECT DISTINCT p.`product_id`, p.`model`, p.`sku`, p.`upc`, pd.`name`, p.`quantity`, p.`status`
                                        FROM `' . DB_PREFIX . 'product` p
                                        LEFT JOIN `' . DB_PREFIX . 'product_description` pd on (p.product_id = pd.product_id)
                                        WHERE LENGTH(p.`sku`) < 1 ' . $ext);

        return $query->rows;
    }

    public function getCatalogProductsWithoutSKU_UPC_Download($options) {
        $ext = '';

        if (isset($options['active']) && intval($options['active']))
            $ext .= ' AND status = 1';

        if (isset($options['instock']) && intval($options['instock']))
            $ext .= ' AND quantity >= 1';

        if (isset($options['language']) && intval($options['language']))
            $ext .= ' AND language_id = ' . intval($options['language']);

        $query = $this->db->query('SELECT DISTINCT p.`product_id`, p.`model`, p.`sku`, p.`upc`, pd.`name`, p.`quantity`, p.`status`
                                        FROM `' . DB_PREFIX . 'product` p
                                        LEFT JOIN `' . DB_PREFIX . 'product_description` pd on (p.product_id = pd.product_id)
                                        WHERE LENGTH(p.`sku`) < 1 AND
                                       LENGTH(p.`upc`) < 1 ' . $ext);

        return $query->rows;
    }

    public function getCatalogProductsDuplicateSKU_Download($options) {
        $ext = '';

        if (isset($options['active']) && intval($options['active']))
            $ext .= ' AND status = 1';

        if (isset($options['instock']) && intval($options['instock']))
            $ext .= ' AND quantity >= 1';

        if (isset($options['language']) && intval($options['language']))
            $ext .= ' AND language_id = ' . intval($options['language']);

        $query = $this->db->query('SELECT DISTINCT p.`product_id`, p.`model`, p.`sku`, p.`upc`, pd.`name`, p.`quantity`, p.`status`
                                        FROM `' . DB_PREFIX . 'product` p
                                        LEFT JOIN `' . DB_PREFIX . 'product_description` pd on (p.product_id = pd.product_id)
                                        WHERE p.`sku` in (
                                          SELECT `sku` from `' . DB_PREFIX . 'product` WHERE 1 ' . $ext . '
                                          AND LENGTH(`sku`) > 1
                                          HAVING count(`sku`) > 1)');

        return $query->rows;
    }

}

?>