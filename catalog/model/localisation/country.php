<?php
class ModelLocalisationCountry extends Model {
	public function getCountry($country_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "country WHERE country_id = '" . (int)$country_id . "' AND status = '1'");
		
		return $query->row;
        }
        
	public function getCountryByISO3($iso_code_3) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "country WHERE iso_code_3 = '" . $this->db->escape($iso_code_3) . "' AND status = '1'");
		
		return $query->row;
	}
	
	public function getCountries() {
		$country_data = $this->cache->get('country.status');
		
		if (!$country_data) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "country WHERE status = '1' ORDER BY name ASC");
	
			$country_data = $query->rows;
		
			$this->cache->set('country.status', $country_data);
		}

		return $country_data;
	}
        
	public function getCountryByIp($ipAddress, $timeout = 72) {
            
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "country_to_ip WHERE ip = '" . $ipAddress . "' and date_added > DATE_ADD(NOW(), INTERVAL -" . $timeout . " HOUR)");
		
		return $query->row;
        }
        
	public function insertCountryByIp($data) {
                
                $this->db->query("DELETE FROM " . DB_PREFIX . "country_to_ip WHERE ip = '" . $this->db->escape($data['ip']) . "'");
            
		$this->db->query("INSERT " . DB_PREFIX . "country_to_ip SET ip = '" . $this->db->escape($data['ip']) . "', iso_code_2 = '" . $this->db->escape($data['iso_code_2']) . "', iso_code_3 = '" . $this->db->escape($data['iso_code_3']) . "', country_id = '" . (int)$data['country_id'] . "'");
        }
        
	public function addCountry($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "country SET name = '" . $this->db->escape($data['name']) . "', iso_code_2 = '" . $this->db->escape($data['iso_code_2']) . "', iso_code_3 = '" . $this->db->escape($data['iso_code_3']) . "', address_format = '" . $this->db->escape($data['address_format']) . "', postcode_required = '" . (int)$data['postcode_required'] . "', status = '" . (int)$data['status'] . "'");
	
		$country_id = $this->db->getLastId();
			
		$this->cache->delete('country');
                
                return $country_id;
	}
}
?>