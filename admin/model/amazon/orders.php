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

	public function orderExists($amazon_order_id)
    {
        $query = $this->db->query('SELECT order_id from `'.DB_PREFIX.'order` where `amazon_order_id`="' . $amazon_order_id . '"') ;

        return( isset($query->row['order_id']) &&  ! empty($query->row['order_id']) ? $query->row['order_id'] : false);
	}

	public function isProductAvailable($sku, $asin)
    {
        $query = $this->db->query('SELECT `product_id`, `model`, `quantity` from `'.DB_PREFIX.'product` WHERE `asin`="' . $asin . '" or `sku`="' . $sku . '" or product_id = "' . $sku . '"') ;

        return( isset($query->row['product_id']) && ! empty($query->row['product_id']) ? $query->row : false);
	}

	public function decreaseQuantity($product_id, $quantity)
    {
        $query = 'UPDATE `'.DB_PREFIX.'product` SET `quantity` = `quantity` - ' . intval($quantity) . ' WHERE `product_id`=' . intval($product_id) ;

        return( $this->db->query($query) );
	}


    private function _insert($query, $data)
    {
        $sql = '' ;

        foreach($data as $field => $value)
        {
          if ( empty($value) )   continue ;

          if ( is_numeric($value) && ! preg_match('/postcode/i', $field) )
            $sql .= " " . $field . "=" . $this->db->escape($value) . "," ;
          else
            $sql .= " " . $field . "='" . $this->db->escape($value) . "'," ;
        }
        $sql = rtrim($sql, ',') ;

        if ( ! ($result = $this->db->query($query . $sql)) ) return(false) ;

        return( $this->db->getLastId() ) ;
    }

	public function addOrder($order)
    {
        $sql = 'INSERT INTO `'.DB_PREFIX.'order` set' ;

        return(self::_insert($sql, $order)) ;
	}

	public function addProduct($product)
    {
        $sql = 'INSERT INTO `'.DB_PREFIX.'order_product` set' ;

        return(self::_insert($sql, $product)) ;
	}

    public function addSubTotal($subtotal)
    {
        $sql = 'INSERT INTO `'.DB_PREFIX.'order_total` set' ;

        return(self::_insert($sql, $subtotal)) ;
    }
    public function addOrderHistory($subtotal)
    {
        $sql = 'INSERT INTO `'.DB_PREFIX.'order_history` set' ;

        return(self::_insert($sql, $subtotal)) ;
    }


    public function removeOrder($order_id)
    {
        $pass = true ;

        if ( ! ($query = $this->db->query('DELETE FROM `'.DB_PREFIX.'order` WHERE `order_id`="' . intval($order_id) . '"')) ) $pass = false ;

        if ( ! ($query = $this->db->query('DELETE FROM `'.DB_PREFIX.'order_product` WHERE `order_id`="' . intval($order_id) . '"')) ) $pass = false ;

        if ( ! ($query = $this->db->query('DELETE FROM `'.DB_PREFIX.'order_total` WHERE `order_id`="' . intval($order_id) . '"')) ) $pass = false ;

        if ( ! ($query = $this->db->query('DELETE FROM `'.DB_PREFIX.'order_history` WHERE `order_id`="' . intval($order_id) . '"')) ) $pass = false ;

        return($pass);
    }

	public function getZoneToGeoZoneByCountryId($country_id) {
      	$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "zone_to_geo_zone` WHERE country_id = '" . (int)$country_id . "'");

		return $query->row ;
	}

	public function getTaxByGeoZoneId($geo_zone_id) {
      	$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "tax_rate` WHERE geo_zone_id = " . (int)$geo_zone_id);
		return $query->row ;
	}
}
?>