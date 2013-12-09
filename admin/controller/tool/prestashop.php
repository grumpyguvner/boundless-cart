<?php 
class ControllerToolPrestashop extends Controller { 
	private $error = array();
        
    function install() {

    }
	
	public function index() {
		$this->load->language('tool/prestashop');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
            
			$this->model_setting_setting->editSetting('prestashop', $this->request->post);
            $this->config->set('prestashop_host', $this->request->post['prestashop_host']);
            $this->config->set('prestashop_user', $this->request->post['prestashop_user']);
            $this->config->set('prestashop_password', $this->request->post['prestashop_password']);
            $this->config->set('prestashop_name', $this->request->post['prestashop_name']);
            $this->config->set('prestashop_products', $this->request->post['prestashop_products']);
            $this->config->set('prestashop_products_truncate', $this->request->post['prestashop_products_truncate']);
            $this->config->set('prestashop_products_debug', $this->request->post['prestashop_products_debug']);
            $this->config->set('prestashop_products_store', $this->request->post['prestashop_products_store']);
            $this->config->set('prestashop_customers', $this->request->post['prestashop_customers']);
            $this->config->set('prestashop_orders', $this->request->post['prestashop_orders']);
            $this->config->set('prestashop_orders_truncate', $this->request->post['prestashop_orders_truncate']);
            $this->config->set('prestashop_orders_limit', $this->request->post['prestashop_orders_limit']);
            $this->config->set('prestashop_orders_debug', $this->request->post['prestashop_orders_debug']);
            $this->config->set('prestashop_stockists', $this->request->post['prestashop_stockists']);
            $this->config->set('prestashop_testimonials', $this->request->post['prestashop_testimonials']);
            
            
                $this->load->model('tool/prestashop_customer');
                
            if ($this->request->post['prestashop_orders_truncate'])
            {
                $this->load->model('tool/prestashop_customer');
                $this->model_tool_prestashop_customer->truncate();
            }
            
            if ($this->request->post['prestashop_customers'])
            {
                $this->load->model('tool/prestashop_customer');
                $this->model_tool_prestashop_customer->import();
                $this->session->data['success'] = $this->language->get('text_success');
            }
            
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		  
        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_import'] = $this->language->get('button_import');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
		
		$this->data['tab_general'] = $this->language->get('tab_general');
        
		$this->data['text_default'] = $this->language->get('text_default');
        
		$this->data['entry_prestashop_host'] = $this->language->get('entry_prestashop_host');
		$this->data['entry_prestashop_user'] = $this->language->get('entry_prestashop_user');
		$this->data['entry_prestashop_password'] = $this->language->get('entry_prestashop_password');
		$this->data['entry_prestashop_name'] = $this->language->get('entry_prestashop_name');
		$this->data['entry_prestashop_products'] = $this->language->get('entry_prestashop_products');
		$this->data['entry_prestashop_products_truncate'] = $this->language->get('entry_prestashop_products_truncate');
		$this->data['entry_prestashop_products_debug'] = $this->language->get('entry_prestashop_products_debug');
		$this->data['entry_prestashop_products_store'] = $this->language->get('entry_prestashop_products_store');
		$this->data['entry_prestashop_customers'] = $this->language->get('entry_prestashop_customers');
		$this->data['entry_prestashop_orders'] = $this->language->get('entry_prestashop_orders');
		$this->data['entry_prestashop_orders_truncate'] = $this->language->get('entry_prestashop_orders_truncate');
		$this->data['entry_prestashop_orders_limit'] = $this->language->get('entry_prestashop_orders_limit');
		$this->data['entry_prestashop_orders_debug'] = $this->language->get('entry_prestashop_orders_debug');
		$this->data['entry_prestashop_stockists'] = $this->language->get('entry_prestashop_stockists');
		$this->data['entry_prestashop_testimonials'] = $this->language->get('entry_prestashop_testimonials');

		if (isset($this->request->post['prestashop_host'])) {
			$this->data['prestashop_host'] = $this->request->post['prestashop_host'];
		} else {
			$this->data['prestashop_host'] = $this->config->get('prestashop_host');			
		}

		if (isset($this->request->post['prestashop_user'])) {
			$this->data['prestashop_user'] = $this->request->post['prestashop_user'];
		} else {
			$this->data['prestashop_user'] = $this->config->get('prestashop_user');			
		}
                
		if (isset($this->request->post['prestashop_password'])) {
			$this->data['prestashop_password'] = $this->request->post['prestashop_password'];
		} else {
			$this->data['prestashop_password'] = $this->config->get('prestashop_password');			
		}
                
		if (isset($this->request->post['prestashop_name'])) {
			$this->data['prestashop_name'] = $this->request->post['prestashop_name'];
		} else {
			$this->data['prestashop_name'] = $this->config->get('prestashop_name');			
		}
                
		if (isset($this->request->post['prestashop_products'])) {
			$this->data['prestashop_products'] = $this->request->post['prestashop_products'];
		} else {
			$this->data['prestashop_products'] = $this->config->get('prestashop_products');			
		}
                
		if (isset($this->request->post['prestashop_products_truncate'])) {
			$this->data['prestashop_products_truncate'] = $this->request->post['prestashop_products_truncate'];
		} else {
			$this->data['prestashop_products_truncate'] = $this->config->get('prestashop_products_truncate');			
		}
                
		if (isset($this->request->post['prestashop_products_debug'])) {
			$this->data['prestashop_products_debug'] = $this->request->post['prestashop_products_debug'];
		} else {
			$this->data['prestashop_products_debug'] = $this->config->get('prestashop_products_debug');			
		}
        
        $this->load->model('setting/store');

        $this->data['stores'] = $this->model_setting_store->getStores();

        if (isset($this->request->post['prestashop_products_store'])) {
            $this->data['prestashop_products_store'] = $this->request->post['prestashop_products_store'];
        } elseif (is_array($this->config->get('prestashop_products_store'))) {
            $this->data['prestashop_products_store'] = $this->config->get('prestashop_products_store');
        } else {
            $this->data['prestashop_products_store'] = array(0);
        }
                
		if (isset($this->request->post['prestashop_customers'])) {
			$this->data['prestashop_customers'] = $this->request->post['prestashop_customers'];
		} else {
			$this->data['prestashop_customers'] = $this->config->get('prestashop_customers');			
		}
                
		if (isset($this->request->post['prestashop_orders'])) {
			$this->data['prestashop_orders'] = $this->request->post['prestashop_orders'];
		} else {
			$this->data['prestashop_orders'] = $this->config->get('prestashop_orders');			
		}
                
		if (isset($this->request->post['prestashop_orders_truncate'])) {
			$this->data['prestashop_orders_truncate'] = $this->request->post['prestashop_orders_truncate'];
		} else {
			$this->data['prestashop_orders_truncate'] = $this->config->get('prestashop_orders_truncate');			
		}
                
		if (isset($this->request->post['prestashop_orders_limit'])) {
			$this->data['prestashop_orders_limit'] = $this->request->post['prestashop_orders_limit'];
		} else {
			$this->data['prestashop_orders_limit'] = $this->config->get('prestashop_orders_limit');			
		}
                
		if (isset($this->request->post['prestashop_orders_debug'])) {
			$this->data['prestashop_orders_debug'] = $this->request->post['prestashop_orders_debug'];
		} else {
			$this->data['prestashop_orders_debug'] = $this->config->get('prestashop_orders_debug');			
		}
                
		if (isset($this->request->post['prestashop_stockists'])) {
			$this->data['prestashop_stockists'] = $this->request->post['prestashop_stockists'];
		} else {
			$this->data['prestashop_stockists'] = $this->config->get('prestashop_stockists');			
		}
                
		if (isset($this->request->post['prestashop_testimonials'])) {
			$this->data['prestashop_testimonials'] = $this->request->post['prestashop_testimonials'];
		} else {
			$this->data['prestashop_testimonials'] = $this->config->get('prestashop_testimonials');			
		}
                
 		if (isset($this->error['prestashop_host'])) {
			$this->data['error_prestashop_host'] = $this->error['prestashop_host'];
		} else {
			$this->data['error_prestashop_host'] = '';
		}
                
 		if (isset($this->error['prestashop_user'])) {
			$this->data['error_prestashop_user'] = $this->error['prestashop_user'];
		} else {
			$this->data['error_prestashop_user'] = '';
		}
                
 		if (isset($this->error['prestashop_password'])) {
			$this->data['error_prestashop_password'] = $this->error['prestashop_password'];
		} else {
			$this->data['error_prestashop_password'] = '';
		}
                
 		if (isset($this->error['prestashop_name'])) {
			$this->data['error_prestashop_name'] = $this->error['prestashop_name'];
		} else {
			$this->data['error_prestashop_name'] = '';
		}
                
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => FALSE
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('tool/prestashop', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->data['action'] = $this->url->link('tool/prestashop', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['import'] = $this->url->link('tool/prestashop/import', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');

		$this->template = 'tool/prestashop.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		$this->response->setOutput($this->render());
	}

	public function import() {
		if ($this->validate()) {

			// set appropriate timeout limit
			set_time_limit( 1800 );

                        $this->load->model('tool/prestashop_customer');
                        $this->load->model('tool/prestashop');
			// send the categories, products and options as a spreadsheet file
			$this->model_tool_prestashop->import();

		} else {

			// return a permission error page
			return $this->forward('error/permission');
		}
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'tool/prestashop')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
	
	public function uploadimage() {
		$this->load->language('common/filemanager');
		
		$json = array();
		
		if (isset($this->request->post['directory'])) {
			if (isset($this->request->files['image']) && $this->request->files['image']['tmp_name']) {
				$filename = basename(html_entity_decode($this->request->files['image']['name'], ENT_QUOTES, 'UTF-8'));
				
				if ((strlen($filename) < 3) || (strlen($filename) > 255)) {
					$json['error'] = $this->language->get('error_filename');
				}
					
				$directory = rtrim(DIR_IMAGE . 'data/' . str_replace('../', '', $this->request->post['directory']), '/');
				
				if (!is_dir($directory)) {
					$json['error'] = $this->language->get('error_directory');
				}
				
				if ($this->request->files['image']['size'] > 300000) {
					$json['error'] = $this->language->get('error_file_size');
				}
				
				$allowed = array(
					'image/jpeg',
					'image/pjpeg',
					'image/png',
					'image/x-png',
					'image/gif',
					'application/x-shockwave-flash'
				);
						
				if (!in_array($this->request->files['image']['type'], $allowed)) {
					$json['error'] = $this->language->get('error_file_type');
				}
				
				$allowed = array(
					'.jpg',
					'.jpeg',
					'.gif',
					'.png',
					'.flv'
				);
						
				if (!in_array(strtolower(strrchr($filename, '.')), $allowed)) {
					$json['error'] = $this->language->get('error_file_type');
				}

				if ($this->request->files['image']['error'] != UPLOAD_ERR_OK) {
					$json['error'] = 'error_upload_' . $this->request->files['image']['error'];
				}			
			} else {
				$json['error'] = $this->language->get('error_file');
			}
		} else {
			$json['error'] = $this->language->get('error_directory');
		}
		
//		if (!$this->user->hasPermission('modify', 'common/filemanager')) {
//                    $json['error'] = $this->language->get('error_permission');  
//                }
		
		if (!isset($json['error'])) {	
			if (@move_uploaded_file($this->request->files['image']['tmp_name'], $directory . '/' . $filename)) {		
				$json['success'] = $this->language->get('text_uploaded');
			} else {
				$json['error'] = $this->language->get('error_uploaded');
			}
		}
		
		$this->response->setOutput(json_encode($json));
	}
        
}
?>