<?php

/* NOTICE OF LICENSE
 *
 * This source file is subject to a commercial license from SARL SMC
 * Use, copy, modification or distribution of this source file without written
 * license agreement from the SARL SMC is strictly forbidden.
 * In order to obtain a license, please contact us: olivier@common-services.com
 * ...........................................................................
 * INFORMATION SUR LA LICENCE D'UTILISATION
 *
 * L'utilisation de ce fichier source est soumise a une licence commerciale
 * concedee par la societe SMC
 * Toute utilisation, reproduction, modification ou distribution du present
 * fichier source sans contrat de licence ecrit de la part de la SARL SMC est
 * expressement interdite.
 * Pour obtenir une licence, veuillez contacter la SARL SMC a l'adresse: olivier@common-services.com
 * ...........................................................................
 * @package    Amazon Market Place
 * @copyright  Copyright (c) 2011-2011 S.A.R.L SMC (http://www.common-services.com)
 * @copyright  Copyright (c) 2011-2011 Olivier B.
 * @author     Olivier B.
 * @license    Commercial license
 * Support by mail  :  olivier@common-services.com
 * Support on forum :  delete
 * Skype : delete13_fr
 * Phone : +33.970465505
 */

class ModelAmazonOrders extends Model {

    public function orderExists($amazon_order_id) {
        $query = $this->db->query('SELECT order_id from `' . DB_PREFIX . 'order` where `amazon_order_id`="' . $amazon_order_id . '"');

        return( isset($query->row['order_id']) && !empty($query->row['order_id']) ? $query->row['order_id'] : false);
    }

    public function isProductAvailable($sku, $asin, $language_id) {
        
        list($product_id, $product_option_value_id) = explode('-', $sku);

        $sql = 'SELECT p.`product_id`, p.`model`, IF(pov.product_option_value_id IS NULL, p.quantity, pov.quantity) as quantity, po.product_option_id, pov.product_option_value_id, o.`name` as option_name, od.`name` as option_description_name, ovd.`name` as option_value_name
                from `' . DB_PREFIX . 'product` p
                  LEFT join `' . DB_PREFIX . 'product_option` po on (po.`product_id` = p.`product_id`)
                  LEFT join `' . DB_PREFIX . 'option` o on (o.`option_id` = po.`option_id`)
                  LEFT join `' . DB_PREFIX . 'option_description` od on (od.`option_id` = po.`option_id` and od.`language_id` = ' . intval($language_id) . ')
                  LEFT join `' . DB_PREFIX . 'product_option_value` pov on (pov.`product_option_id` = po.`product_option_id`)
                  LEFT join `' . DB_PREFIX . 'option_value_description` ovd on (ovd.`option_value_id` = pov.`option_value_id` and ovd.`language_id` = ' . intval($language_id) . ')
                WHERE IF(pov.product_option_value_id IS NULL, p.`asin`, pov.`asin`) = "' . $asin . '" or IF(pov.product_option_value_id IS NULL, p.`sku`, pov.`sku`) = "' . $sku . '" or IF(pov.product_option_value_id IS NULL, p.product_id = "' . (int)$product_id . '", p.product_id = "' . (int)$product_id . '" and pov.product_option_value_id = "' . (int)$product_option_value_id . '")';
        $query = $this->db->query($sql);

        return( isset($query->row['product_id']) && !empty($query->row['product_id']) ? $query->row : false);
    }

    public function decreaseQuantity($sku, $quantity) {
        
        $query = 'UPDATE `' . DB_PREFIX . 'product` p
                    LEFT join `' . DB_PREFIX . 'product_option` po on (po.`product_id` = p.`product_id`)
                    LEFT join `' . DB_PREFIX . 'product_option_value` pov on (pov.`product_option_id` = po.`product_option_id`)
                  SET pov.`quantity` = pov.`quantity` - ' . intval($quantity) . ',
                      p.`quantity` = p.`quantity` - ' . intval($quantity) . '
                  WHERE pov.`sku` = "' . $this->db->escape($sku) . '"';
        
        $this->db->query($query);
        
        $query = 'UPDATE `' . DB_PREFIX . 'product` SET `quantity` = `quantity` - ' . intval($quantity) . ' WHERE `sku`="' . $this->db->escape($sku) . '"';

        return( $this->db->query($query) );
    }

    private function _insert($query, $data) {
        $sql = '';

        foreach ($data as $field => $value) {
            if (empty($value))
                continue;

            if (is_numeric($value) && !preg_match('/postcode/i', $field))
                $sql .= " " . $field . "=" . $this->db->escape($value) . ",";
            else
                $sql .= " " . $field . "='" . $this->db->escape($value) . "',";
        }
        $sql = rtrim($sql, ',');

        if (!($result = $this->db->query($query . $sql)))
            return(false);

        return( $this->db->getLastId() );
    }

    public function addOrder($order) {
        $sql = 'INSERT INTO `' . DB_PREFIX . 'order` set';

        return(self::_insert($sql, $order));
    }

    public function addProduct($product) {
        $sql = 'INSERT INTO `' . DB_PREFIX . 'order_product` set';

        return(self::_insert($sql, $product));
    }

    public function addProductOption($product) {
        $sql = 'INSERT INTO `' . DB_PREFIX . 'order_option` set';

        return(self::_insert($sql, $product));
    }

    public function addSubTotal($subtotal) {
        $sql = 'INSERT INTO `' . DB_PREFIX . 'order_total` set';

        return(self::_insert($sql, $subtotal));
    }

    public function addOrderHistory($subtotal) {
        $sql = 'INSERT INTO `' . DB_PREFIX . 'order_history` set';

        return(self::_insert($sql, $subtotal));
    }

    public function removeOrder($order_id) {
        $pass = true;

        if (!($query = $this->db->query('DELETE FROM `' . DB_PREFIX . 'order` WHERE `order_id`="' . intval($order_id) . '"')))
            $pass = false;

        if (!($query = $this->db->query('DELETE FROM `' . DB_PREFIX . 'order_product` WHERE `order_id`="' . intval($order_id) . '"')))
            $pass = false;
        
        if (!($query = $this->db->query('DELETE FROM `' . DB_PREFIX . 'order_option` WHERE `order_id`="' . intval($order_id) . '"')))
            $pass = false;

        if (!($query = $this->db->query('DELETE FROM `' . DB_PREFIX . 'order_total` WHERE `order_id`="' . intval($order_id) . '"')))
            $pass = false;

        if (!($query = $this->db->query('DELETE FROM `' . DB_PREFIX . 'order_history` WHERE `order_id`="' . intval($order_id) . '"')))
            $pass = false;

        return($pass);
    }

    public function getZoneToGeoZoneByCountryId($country_id) {
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "zone_to_geo_zone` WHERE country_id = '" . (int) $country_id . "'");

        return $query->row;
    }

    public function getTaxByGeoZoneId($geo_zone_id) {
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "tax_rate` WHERE geo_zone_id = " . (int) $geo_zone_id);
        return $query->row;
    }

}

?>