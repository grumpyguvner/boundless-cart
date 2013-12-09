<?php
class ModelLocalisationZone extends Model {
	public function getZone($zone_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone WHERE zone_id = '" . (int)$zone_id . "' AND status = '1'");
		
		return $query->row;
	}		
	
	public function getZonesByCountryId($country_id) {
		$zone_data = $this->cache->get('zone.' . (int)$country_id);
	
		if (!$zone_data) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone WHERE country_id = '" . (int)$country_id . "' AND status = '1' ORDER BY name");
	
			$zone_data = $query->rows;
			
			$this->cache->set('zone.' . (int)$country_id, $zone_data);
		}
	
		return $zone_data;
	}	
	
	public function getZoneByName($name, $country_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone WHERE name = '" . $this->db->escape($name) . "' and country_id = '" . (int)$country_id . "' AND status = '1' ORDER BY name");
	
		return $query->row;
	}
	
	public function getZoneByCode($code, $country_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone WHERE code = '" . $this->db->escape($code) . "' and country_id = '" . (int)$country_id . "' AND status = '1' ORDER BY name");
	
		return $query->row;
	}
        
	public function addZone($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "zone SET status = '" . (int)$data['status'] . "', name = '" . $this->db->escape($data['name']) . "', code = '" . $this->db->escape($data['code']) . "', country_id = '" . (int)$data['country_id'] . "'");
                
		$zone_id = $this->db->getLastId();
			
		$this->cache->delete('zone');
                
                return $zone_id;
	}
}
?>