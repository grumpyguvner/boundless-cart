<?php 
class ModelSaleRedeemTheme extends Model {
	public function addRedeemTheme($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "redeem_theme SET content = '" . $this->db->escape(html_entity_decode($data['content'], ENT_QUOTES, 'UTF-8')) . "'");
		
		$redeem_theme_id = $this->db->getLastId();
		
		foreach ($data['redeem_theme_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "redeem_theme_description SET redeem_theme_id = '" . (int)$redeem_theme_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "'");
		}
		
		$this->cache->delete('redeem_theme');
	}

	public function editRedeemTheme($redeem_theme_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "redeem_theme SET content = '" . $this->db->escape(html_entity_decode($data['content'], ENT_QUOTES, 'UTF-8')) . "' WHERE redeem_theme_id = '" . (int)$redeem_theme_id . "'");
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "redeem_theme_description WHERE redeem_theme_id = '" . (int)$redeem_theme_id . "'");

		foreach ($data['redeem_theme_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "redeem_theme_description SET redeem_theme_id = '" . (int)$redeem_theme_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "'");
		}
				
		$this->cache->delete('redeem_theme');
	}
	
	public function deleteRedeemTheme($redeem_theme_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "redeem_theme WHERE redeem_theme_id = '" . (int)$redeem_theme_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "redeem_theme_description WHERE redeem_theme_id = '" . (int)$redeem_theme_id . "'");
	
		$this->cache->delete('redeem_theme');
	}
		
	public function getRedeemTheme($redeem_theme_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "redeem_theme vt LEFT JOIN " . DB_PREFIX . "redeem_theme_description vtd ON (vt.redeem_theme_id = vtd.redeem_theme_id) WHERE vt.redeem_theme_id = '" . (int)$redeem_theme_id . "' AND vtd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
		
		return $query->row;
	}
		
	public function getRedeemThemes($data = array()) {
      	if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "redeem_theme vt LEFT JOIN " . DB_PREFIX . "redeem_theme_description vtd ON (vt.redeem_theme_id = vtd.redeem_theme_id) WHERE vtd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY vtd.name";	
			
			if (isset($data['order']) && ($data['order'] == 'DESC')) {
				$sql .= " DESC";
			} else {
				$sql .= " ASC";
			}
			
			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}				

				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}	
			
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}	
			
			$query = $this->db->query($sql);
			
			return $query->rows;
		} else {
			$redeem_theme_data = $this->cache->get('redeem_theme.' . (int)$this->config->get('config_language_id'));
		
			if (!$redeem_theme_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "redeem_theme vt LEFT JOIN " . DB_PREFIX . "redeem_theme_description vtd ON (vt.redeem_theme_id = vtd.redeem_theme_id) WHERE vtd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY vtd.name");
	
				$redeem_theme_data = $query->rows;
			
				$this->cache->set('redeem_theme.' . (int)$this->config->get('config_language_id'), $redeem_theme_data);
			}	
	
			return $redeem_theme_data;				
		}
	}
	
	public function getRedeemThemeDescriptions($redeem_theme_id) {
		$redeem_theme_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "redeem_theme_description WHERE redeem_theme_id = '" . (int)$redeem_theme_id . "'");
		
		foreach ($query->rows as $result) {
			$redeem_theme_data[$result['language_id']] = array('name' => $result['name']);
		}
		
		return $redeem_theme_data;
	}
	
	public function getTotalRedeemThemes() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "redeem_theme");
		
		return $query->row['total'];
	}	
}
?>