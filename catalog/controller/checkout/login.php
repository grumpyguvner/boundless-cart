<?php  
class ControllerCheckoutLogin extends Controller { 
	public function index() {
		$this->language->load('checkout/checkout');
		
		$this->data['text_new_customer'] = $this->language->get('text_new_customer');
		$this->data['text_returning_customer'] = $this->language->get('text_returning_customer');
		$this->data['text_checkout'] = $this->language->get('text_checkout');
		$this->data['text_register'] = $this->language->get('text_register');
		$this->data['text_guest'] = $this->language->get('text_guest');
		$this->data['text_i_am_returning_customer'] = $this->language->get('text_i_am_returning_customer');
		$this->data['text_register_account'] = $this->language->get('text_register_account');
		$this->data['text_forgotten'] = $this->language->get('text_forgotten');
 
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_password'] = $this->language->get('entry_password');
		
		$this->data['button_continue'] = $this->language->get('button_continue');
		$this->data['button_login'] = $this->language->get('button_login');
		
		$this->data['guest_checkout'] = ($this->config->get('config_guest_checkout') && !$this->config->get('config_customer_price') && !$this->cart->hasDownload());
		
		if (isset($this->session->data['account'])) {
			$this->data['account'] = $this->session->data['account'];
		} else {
			$this->data['account'] = 'register';
		}
		
		$this->data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');
                
                if ($this->extensions->isInstalled('fbconnect', 'module') && $this->config->get('fbconnect_status')) {
            $this->language->load('module/fbconnect');

            if (!$this->customer->isLogged()) {

                if (!isset($this->fbconnect)) {
                    require_once(DIR_SYSTEM . 'vendor/facebook-sdk/facebook.php');
                    $this->fbconnect = new Facebook(array(
                                'appId' => $this->config->get('fbconnect_apikey'),
                                'secret' => $this->config->get('fbconnect_apisecret'),
                            ));
                }

                $this->data['fbconnect_url'] = $this->fbconnect->getLoginUrl(
                        array(
                            'scope' => 'email,user_birthday,user_location,user_hometown',
                            'redirect_uri' => $this->url->link('account/fbconnect', '', 'SSL')
                        )
                );

                if ($this->config->get('fbconnect_button_' . $this->config->get('config_language_id'))) {
                    $this->data['fbconnect_button'] = html_entity_decode($this->config->get('fbconnect_button_' . $this->config->get('config_language_id')));
                }
                else
                    $this->data['fbconnect_button'] = $this->language->get('heading_title');

                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/fbconnect.tpl')) {
                    $this->template = $this->config->get('config_template') . '/template/module/fbconnect.tpl';
                } else {
                    $this->template = 'default/template/module/fbconnect.tpl';
                }

                $this->render();
            }
        } else {
            $this->data['fbconnect_url'] = '';
            $this->data['fbconnect_button'] = '';
        }
		
		$this->setTemplate('checkout/login.tpl');
				
		$this->response->setOutput($this->render());
	}
	
	public function validate() {
		$this->language->load('checkout/checkout');
		
		$json = array();
		
		if ($this->customer->isLogged()) {
			$json['redirect'] = $this->url->link('checkout/checkout', '', 'SSL');			
		}
		
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$json['redirect'] = $this->url->link('checkout/cart');
		}	
		
		if (!$json) {
			if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
				$json['error']['warning'] = $this->language->get('error_login');
			}
		
			$this->load->model('account/customer');
		
			$customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);
			
			if ($customer_info && !$customer_info['approved']) {
				$json['error']['warning'] = $this->language->get('error_approved');
			}		
		}
		
		if (!$json) {
			unset($this->session->data['guest']);
				
			// Default Addresses
			$this->load->model('account/address');
				
			$address_info = $this->model_account_address->getAddress($this->customer->getAddressId());
									
			if ($address_info) {
				if ($this->config->get('config_tax_customer') == 'shipping') {
					$this->session->data['shipping_country_id'] = $address_info['country_id'];
					$this->session->data['shipping_zone_id'] = $address_info['zone_id'];
					$this->session->data['shipping_postcode'] = $address_info['postcode'];	
				}
				
				if ($this->config->get('config_tax_customer') == 'payment') {
					$this->session->data['payment_country_id'] = $address_info['country_id'];
					$this->session->data['payment_zone_id'] = $address_info['zone_id'];
				}
			} else {
				unset($this->session->data['shipping_country_id']);	
				unset($this->session->data['shipping_zone_id']);	
				unset($this->session->data['shipping_postcode']);
				unset($this->session->data['payment_country_id']);	
				unset($this->session->data['payment_zone_id']);	
			}					
				
			$json['redirect'] = $this->url->link('checkout/checkout', '', 'SSL');
		}
					
		$this->response->setOutput(json_encode($json));		
	}
}
?>