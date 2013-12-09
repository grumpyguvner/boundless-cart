<?php
class ModelCatalogAttribute extends Model {
    public function getAttributesByGroup() {
		
		$sql = "SELECT ag.attribute_group_id, agd.name as attribute_group_name, a.attribute_id, ad.name as attribute_name, pa.text "
             . "FROM " . DB_PREFIX . "attribute_group ag "
             . "LEFT JOIN " . DB_PREFIX . "attribute_group_description agd ON agd.attribute_group_id = ag.attribute_group_id "
             . "LEFT JOIN " . DB_PREFIX . "attribute a ON a.attribute_group_id = ag.attribute_group_id "
             . "LEFT JOIN " . DB_PREFIX . "attribute_description ad ON ad.attribute_id = a.attribute_id "
             . "LEFT JOIN " . DB_PREFIX . "product_attribute pa ON pa.attribute_id = a.attribute_id "
             . "WHERE agd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND "
             . "agd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND "
             . "agd.language_id = '" . (int) $this->config->get('config_language_id') . "' "
             . "GROUP BY a.attribute_id, pa.text ";
        
        $query = $this->db->query($sql);
        
        return $query;
	}
}
?>