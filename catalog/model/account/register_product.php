<?php
class ModelAccountRegisterProduct extends Model {
	public function register($name = '', $email = '', $location = '', $date = '', $barcode = '') {
		
		if (!$email) return;
        
		$query = $this->db->query("INSERT INTO " . DB_PREFIX . "register_product SET email = '" . $this->db->escape($email) . "', name = '" . $this->db->escape($name) . "', location = '" . $this->db->escape($location) . "', date_purchased = '" . $this->db->escape($date). "', barcode = '" . $this->db->escape($barcode) . "'");
            
//		
//		$this->language->load('mail/register_product');
//
//		$subject = sprintf($this->language->get('text_subject'), $this->config->get('config_name'));
//
//		$message = sprintf($this->language->get('text_welcome'), $this->config->get('config_name')) . "\n\n";
//
//		$message .= $this->language->get('text_details') . "\n\n";
//		$message .= $this->language->get('text_thanks') . "\n";
//		$message .= sprintf($this->language->get('text_signoff'), $this->config->get('config_name'));
//
//		$mail = new Mail();
//		$mail->protocol = $this->config->get('config_mail_protocol');
//		$mail->parameter = $this->config->get('config_mail_parameter');
//		$mail->hostname = $this->config->get('config_smtp_host');
//		$mail->username = $this->config->get('config_smtp_username');
//		$mail->password = $this->config->get('config_smtp_password');
//		$mail->port = $this->config->get('config_smtp_port');
//		$mail->timeout = $this->config->get('config_smtp_timeout');
//                $mail->setTo($email);
//		$mail->setFrom($this->config->get('config_email'));
//		$mail->setSender($this->config->get('config_name'));
//		$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
//		$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
//		$mail->send();
//
//		// Send to main admin email if new account email is enabled
//		if ($this->config->get('config_account_mail')) {
//                        $subject = sprintf($this->language->get('text_notify_subject'), $this->config->get('config_name'));
//                        $message = sprintf($this->language->get('text_notify_details'), $email);
//
//                        $mail->setTo($this->config->get('config_email'));
//                        $mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
//                        $mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
//			$mail->send();
//
//			// Send to additional alert emails if new account email is enabled
//			$emails = explode(',', $this->config->get('config_alert_emails'));
//
//			foreach ($emails as $email) {
//				if (strlen($email) > 0 && preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $email)) {
//					$mail->setTo($email);
//					$mail->send();
//				}
//			}
//		}
	}
}
?>