<?php
class ModelCatalogEvent extends Model {
	public function addEvent($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "event SET sort_order = '" . (int)$this->request->post['sort_order'] . "', status = '" . (int)$data['status'] . "', event_date = '" . $this->request->post['event_date'] . "', allow_subscribe = '" . $this->request->post['allow_subscribe'] . "', no_of_sub = '" . $this->request->post['no_of_sub'] . "'");

		$event_id = $this->db->getLastId(); 
		
		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "event SET image = '" . $this->db->escape($data['image']) . "' WHERE event_id = '" . (int)$event_id . "'");
		}
		if (isset($data['product_related']) && is_array($data['product_related'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "event SET product_related = '" . serialize($data['product_related']). "' WHERE event_id = '" . (int)$event_id . "'");
		}
		
			
		foreach ($data['event_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "event_description SET event_id = '" . (int)$event_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}
		
		if (isset($data['event_store'])) {
			foreach ($data['event_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "event_to_store SET event_id = '" . (int)$event_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		if (isset($data['event_layout'])) {
			foreach ($data['event_layout'] as $store_id => $layout) {
				if ($layout) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "event_to_layout SET event_id = '" . (int)$event_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}
                
                $this->load->model('module/url_alias');
                	
		if (isset($data['keyword'])) {
                    $url = array('keyword' => $data['keyword'],
                                 'query' => 'event_id=' . (int)$event_id,
                                 'language_id' => 0);
                    $this->model_module_url_alias->addUrlAlias($url);
                }
		
		$this->cache->delete('event');
	}
	
	public function editEvent($event_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "event SET sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "',event_date = '" . $data['event_date'] . "', allow_subscribe = '" . $data['allow_subscribe'] . "', no_of_sub = '" . $data['no_of_sub'] . "' WHERE event_id = '" . (int)$event_id . "'");
		
		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "event SET image = '" . $this->db->escape($data['image']) . "' WHERE event_id = '" . (int)$event_id . "'");
		}
		
		if (isset($data['product_related']) && is_array($data['product_related'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "event SET product_related = '" . serialize($data['product_related']). "' WHERE event_id = '" . (int)$event_id . "'");
		}else{
			$this->db->query("UPDATE " . DB_PREFIX . "event SET product_related = '' WHERE event_id = '" . (int)$event_id . "'");
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "event_description WHERE event_id = '" . (int)$event_id . "'");
					
		foreach ($data['event_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "event_description SET event_id = '" . (int)$event_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "event_to_store WHERE event_id = '" . (int)$event_id . "'");
		
		if (isset($data['event_store'])) {
			foreach ($data['event_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "event_to_store SET event_id = '" . (int)$event_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "event_to_layout WHERE event_id = '" . (int)$event_id . "'");

		if (isset($data['event_layout'])) {
			foreach ($data['event_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "event_to_layout SET event_id = '" . (int)$event_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}
                
                $this->load->model('module/url_alias');
                	
		if (isset($data['keyword'])) {
                    $url = array('keyword' => $data['keyword'],
                                 'query' => 'event_id=' . (int)$event_id,
                                 'language_id' => 0);
                    $this->model_module_url_alias->addUrlAlias($url);
                }
		
		$this->cache->delete('event');
	}
	
	public function deleteEvent($event_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "event WHERE event_id = '" . (int)$event_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "event_description WHERE event_id = '" . (int)$event_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "event_to_store WHERE event_id = '" . (int)$event_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "event_to_layout WHERE event_id = '" . (int)$event_id . "'");
                
                $this->load->model('module/url_alias');
                $this->model_module_url_alias->deleteUrlAliasByQuery('event_id=' . (int)$event_id);

		$this->cache->delete('event');
	}	

	public function getEvent($event_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'event_id=" . (int)$event_id . "' and language_id = 0 ORDER BY date_added DESC LIMIT 1) AS keyword FROM " . DB_PREFIX . "event WHERE event_id = '" . (int)$event_id . "'");
		
		return $query->row;
	}
		
	public function getEvents($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "event i LEFT JOIN " . DB_PREFIX . "event_description id ON (i.event_id = id.event_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "'";
		
			$sort_data = array(
				'id.title',
				'i.sort_order'
			);		
		
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY id.title";	
			}
			
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
			$event_data = $this->cache->get('event.' . $this->config->get('config_language_id'));
		
			if (!$event_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "event i LEFT JOIN " . DB_PREFIX . "event_description id ON (i.event_id = id.event_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY id.title");
	
				$event_data = $query->rows;
			
				$this->cache->set('event.' . $this->config->get('config_language_id'), $event_data);
			}	
	
			return $event_data;			
		}
	}
	
	public function getEventDescriptions($event_id) {
		$event_description_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "event_description WHERE event_id = '" . (int)$event_id . "'");

		foreach ($query->rows as $result) {
			$event_description_data[$result['language_id']] = array(
				'title'       => $result['title'],
				'description' => $result['description']
			);
		}
		
		return $event_description_data;
	}
	
	public function getEventStores($event_id) {
		$event_store_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "event_to_store WHERE event_id = '" . (int)$event_id . "'");

		foreach ($query->rows as $result) {
			$event_store_data[] = $result['store_id'];
		}
		
		return $event_store_data;
	}

	public function getEventLayouts($event_id) {
		$event_layout_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "event_to_layout WHERE event_id = '" . (int)$event_id . "'");
		
		foreach ($query->rows as $result) {
			$event_layout_data[$result['store_id']] = $result['layout_id'];
		}
		
		return $event_layout_data;
	}
		
	public function getTotalEvents() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "event");
		
		return $query->row['total'];
	}	
	
	public function getTotalEventsByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "event_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}	
}
?>