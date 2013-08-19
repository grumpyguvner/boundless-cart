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
class ModelAmazonSynchronize extends Model {

	public function getAmazonCatalog($startDate, $out_of_stock, $language_id, $categories)
    {
        $ext = '' ;

        if ( 1 )
            $ext .= ' AND status = 1' ;

        if ( 1 )
            $ext .= ' AND IF(pov.product_option_value_id IS NULL, p.quantity, pov.quantity) >= ' . intval($out_of_stock) ;

        if ( $categories )
            $ext .= ' AND p2c.`category_id` IN ('.$categories.') ' ;

		$sql = 'SELECT p.*, pd.*, IF(pov.product_option_value_id IS NULL, p.`ean`, pov.`ean`) as `ean`, IF(pov.product_option_value_id IS NULL, p.`sku`, pov.`sku`) as `sku`, IF(pov.product_option_value_id IS NULL, p.quantity, pov.quantity) as quantity, pov.product_option_value_id, ovd.name as option_value_name
                  FROM `' . DB_PREFIX . 'product` p
                  LEFT join `' . DB_PREFIX . 'product_description` pd on (p.`product_id` = pd.`product_id` and pd.`language_id` = ' . intval($language_id) . ')
                  LEFT join `' . DB_PREFIX . 'product_to_category` p2c on (p.`product_id` = p2c.`product_id`)
                  LEFT join `' . DB_PREFIX . 'product_option` po on (po.`product_id` = p.`product_id`)
                  LEFT join `' . DB_PREFIX . 'product_option_value` pov on (pov.`product_option_id` = po.`product_option_id`)
                  LEFT join `' . DB_PREFIX . 'option_value_description` ovd on (ovd.`option_value_id` = pov.`option_value_id` and ovd.`language_id` = ' . intval($language_id) . ')
                  WHERE (`date_added` > "' . $startDate . '" or `date_modified` > "' . $startDate . '")
                  AND ( IF(pov.product_option_value_id IS NULL, p.`ean`, pov.`ean`) != "" OR IF(pov.product_option_value_id IS NULL, p.`asin`, pov.`asin`) != "" OR `upc` != "" OR `isbn` != "" )
                  ' . $ext . ' GROUP by p.product_id, po.product_option_id, pov.product_option_value_id ' ;

        $query = $this->db->query($sql);

        return($query->rows);
	}

    public function isOnAmazon($productSKU, $language_id)
    {
      if ( ! isset( $product['sku'] ) )  return(false) ;

      $query = $this->db->query('SELECT DISTINCT product_id from `'.DB_PREFIX.'amazon_products` where `sku`= "' . $this->db->escape($productSKU) . '" and `language_id` = ' . intval($language_id) ) ;

      if ( isset($query->row) && isset($query->row['sku']) && $query->row['sku'] )  return(true) ;
      else return(false) ;
    }

	public function getTaxByClassId($tax_class_id)
    {
      	$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "tax_class` WHERE tax_class_id = '" . intval($tax_class_id) . "'");

		return $query->row ;
	}

}
?>