<?php
class ModelSaleRedeem extends Model {
	public function addRedeem($data) {
      	$this->db->query("INSERT INTO " . DB_PREFIX . "redeem SET product_id = '" . $this->db->escape($data['product_id']) . "', order_id = '" . $this->db->escape($data['order_id']) . "', code = '" . $this->db->escape($data['code']) . "', status = '" . $this->db->escape($data['status']) . "', redeem = '" . $this->db->escape($data['redeem']) . "', date_added = NOW()");
	}
	
	public function editRedeem($redeem_id, $data) {
      	$this->db->query("UPDATE " . DB_PREFIX . "redeem SET status = '" . $this->db->escape($data['status']) . "', redeem = '" . $this->db->escape($data['redeem']) . "' WHERE redeem_id = '" . (int)$redeem_id . "'");
	}
	
	public function deleteRedeem($redeem_id) {
      	$this->db->query("DELETE FROM " . DB_PREFIX . "redeem WHERE redeem_id = '" . (int)$redeem_id . "'");
		//$this->db->query("DELETE FROM " . DB_PREFIX . "redeem_history WHERE redeem_id = '" . (int)$redeem_id . "'");
	}
	
        public function redeemRedeem($redeem_id) {
            $this->db->query("UPDATE " . DB_PREFIX . "redeem SET redeem = 1 WHERE redeem_id = '" . (int)$redeem_id . "'");
        }
        
	public function getRedeem($redeem_id) {
      	$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "redeem WHERE redeem_id = '" . (int)$redeem_id . "'");
		
		return $query->row;
	}

	public function getRedeemByCode($code) {
      	$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "redeem WHERE code = '" . $this->db->escape($code) . "'");
		
		return $query->row;
	}
        
        public function getRedeemByOrderId($order_id) {
      	$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "redeem WHERE order_id = '" . $this->db->escape($order_id) . "'");
		
		return $query->rows;
	}
		
	public function getRedeems($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "redeem";
		
		$sort_data = array(
			'redeem_id',
			'product_id',
			'order_id',
			'code',
			'status',
			'redeem',
			'date_added'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY date_added";	
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
	}
		
	public function sendRedeem($redeem_id) {
		$redeem_info = $this->getRedeem($redeem_id);
		
		if ($redeem_info) {
			if ($redeem_info['order_id']) {
				$order_id = $redeem_info['order_id'];
			} else {
				$order_id = 0;
			}
			
			$this->load->model('sale/order');
			
			$order_info = $this->model_sale_order->getOrder($order_id);
			
			// If redeem belongs to an order
			if ($order_info) {
				$this->load->model('localisation/language');
				
				$language = new Language($order_info['language_directory'], $this->registry);
				$language->load($order_info['language_filename']);	
				$language->load('mail/redeem');
				
				// HTML Mail
				$template = new Template();				
				
				$template->data['title'] = sprintf($language->get('text_subject'), $redeem_info['from_name']);
				
				$template->data['text_greeting'] = sprintf($language->get('text_greeting'), $this->currency->format($redeem_info['amount'], $order_info['currency_code'], $order_info['currency_value']));
				$template->data['text_from'] = sprintf($language->get('text_from'), $redeem_info['from_name']);
				$template->data['text_message'] = $language->get('text_message');
				$template->data['text_redeem'] = sprintf($language->get('text_redeem'), $redeem_info['code']);
				$template->data['text_footer'] = $language->get('text_footer');	
				
				$this->load->model('sale/redeem_theme');
					
				$redeem_theme_info = $this->model_sale_redeem_theme->getRedeemTheme($redeem_info['redeem_theme_id']);
				
				if ($redeem_info && file_exists(DIR_IMAGE . $redeem_theme_info['image'])) {
					$template->data['image'] = HTTP_IMAGE . $redeem_theme_info['image'];
				} else {
					$template->data['image'] = '';
				}
				
				$template->data['store_name'] = $order_info['store_name'];
				$template->data['store_url'] = $order_info['store_url'];
				$template->data['message'] = nl2br($redeem_info['message']);
	
				$mail = new Mail(); 
				$mail->protocol = $this->config->get('config_mail_protocol');
				$mail->parameter = $this->config->get('config_mail_parameter');
				$mail->hostname = $this->config->get('config_smtp_host');
				$mail->username = $this->config->get('config_smtp_username');
				$mail->password = $this->config->get('config_smtp_password');
				$mail->port = $this->config->get('config_smtp_port');
				$mail->timeout = $this->config->get('config_smtp_timeout');			
				$mail->setTo($redeem_info['to_email']);
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSender($order_info['store_name']);
				$mail->setSubject(html_entity_decode(sprintf($language->get('text_subject'), $redeem_info['from_name']), ENT_QUOTES, 'UTF-8'));
				$mail->setHtml($template->fetch('mail/redeem.tpl'));				
				$mail->send();
			
			// If redeem does not belong to an order				
			}  else {
				$this->language->load('mail/redeem');
				
				$template = new Template();		
				
				$template->data['title'] = sprintf($this->language->get('text_subject'), $redeem_info['from_name']);
				
				$template->data['text_greeting'] = sprintf($this->language->get('text_greeting'), $this->currency->format($redeem_info['amount'], $order_info['currency_code'], $order_info['currency_value']));
				$template->data['text_from'] = sprintf($this->language->get('text_from'), $redeem_info['from_name']);
				$template->data['text_message'] = $this->language->get('text_message');
				$template->data['text_redeem'] = sprintf($this->language->get('text_redeem'), $redeem_info['code']);
				$template->data['text_footer'] = $this->language->get('text_footer');					
			
				$this->load->model('sale/redeem_theme');
					
				$redeem_theme_info = $this->model_sale_redeem_theme->getRedeemTheme($redeem_info['redeem_theme_id']);
				
				if ($redeem_info && file_exists(DIR_IMAGE . $redeem_theme_info['image'])) {
					$template->data['image'] = HTTP_IMAGE . $redeem_theme_info['image'];
				} else {
					$template->data['image'] = '';
				}
				
				$template->data['store_name'] = $this->config->get('config_name');
				$template->data['store_url'] = HTTP_CATALOG;
				$template->data['message'] = nl2br($redeem_info['message']);
	
				$mail = new Mail(); 
				$mail->protocol = $this->config->get('config_mail_protocol');
				$mail->parameter = $this->config->get('config_mail_parameter');
				$mail->hostname = $this->config->get('config_smtp_host');
				$mail->username = $this->config->get('config_smtp_username');
				$mail->password = $this->config->get('config_smtp_password');
				$mail->port = $this->config->get('config_smtp_port');
				$mail->timeout = $this->config->get('config_smtp_timeout');			
				$mail->setTo($redeem_info['to_email']);
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSender($this->config->get('config_name'));
				$mail->setSubject(html_entity_decode(sprintf($this->language->get('text_subject'), $redeem_info['from_name']), ENT_QUOTES, 'UTF-8'));
				$mail->setHtml($template->fetch('mail/redeem.tpl'));
				$mail->send();				
			}
		}
	}
			
	public function getTotalRedeems() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "redeem");
		
		return $query->row['total'];
	}	
	
	public function getTotalRedeemsByRedeemThemeId($redeem_theme_id) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "redeem WHERE redeem_theme_id = '" . (int)$redeem_theme_id . "'");
		
		return $query->row['total'];
	}	
	
	public function getRedeemHistories($redeem_id, $start = 0, $limit = 10) {
		if ($start < 0) {
			$start = 0;
		}
		
		if ($limit < 1) {
			$limit = 10;
		}	
				
		$query = $this->db->query("SELECT vh.order_id, CONCAT(o.firstname, ' ', o.lastname) AS customer, vh.amount, vh.date_added FROM " . DB_PREFIX . "redeem_history vh LEFT JOIN `" . DB_PREFIX . "order` o ON (vh.order_id = o.order_id) WHERE vh.redeem_id = '" . (int)$redeem_id . "' ORDER BY vh.date_added ASC LIMIT " . (int)$start . "," . (int)$limit);

		return $query->rows;
	}
	
	public function getTotalRedeemHistories($redeem_id) {
	  	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "redeem_history WHERE redeem_id = '" . (int)$redeem_id . "'");

		return $query->row['total'];
	}			
}
?>