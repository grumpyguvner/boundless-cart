<?php 
class ControllerToolZencart extends Controller { 
	private $error = array();
        
    function install() {

    }
	
	public function index() {
		$this->load->language('tool/zencart');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
            
			$this->model_setting_setting->editSetting('zencart', $this->request->post);
            $this->config->set('zencart_host', $this->request->post['zencart_host']);
            $this->config->set('zencart_user', $this->request->post['zencart_user']);
            $this->config->set('zencart_password', $this->request->post['zencart_password']);
            $this->config->set('zencart_name', $this->request->post['zencart_name']);
            $this->config->set('zencart_products', $this->request->post['zencart_products']);
            $this->config->set('zencart_products_truncate', $this->request->post['zencart_products_truncate']);
            $this->config->set('zencart_products_debug', $this->request->post['zencart_products_debug']);
            $this->config->set('zencart_products_store', $this->request->post['zencart_products_store']);
            $this->config->set('zencart_customers', $this->request->post['zencart_customers']);
            $this->config->set('zencart_orders', $this->request->post['zencart_orders']);
            $this->config->set('zencart_orders_truncate', $this->request->post['zencart_orders_truncate']);
            $this->config->set('zencart_orders_limit', $this->request->post['zencart_orders_limit']);
            $this->config->set('zencart_orders_debug', $this->request->post['zencart_orders_debug']);
            $this->config->set('zencart_stockists', $this->request->post['zencart_stockists']);
            $this->config->set('zencart_testimonials', $this->request->post['zencart_testimonials']);
            
            if ($this->request->post['zencart_products_truncate'])
            {
                $this->load->model('tool/zencart_product');
                $this->model_tool_zencart_product->truncate();
            }
            
            if ($this->request->post['zencart_products'])
            {
                $this->load->model('tool/zencart_product');
                $this->model_tool_zencart_product->import();
                $this->session->data['success'] = $this->language->get('text_success');
            }
            
            if ($this->request->post['zencart_orders_truncate'])
            {
                $this->load->model('tool/zencart_customer');
                $this->model_tool_zencart_customer->truncate();
            }
            
            if ($this->request->post['zencart_customers'])
            {
                $this->load->model('tool/zencart_customer');
                $this->model_tool_zencart_customer->import();
                $this->session->data['success'] = $this->language->get('text_success');
            }
            
            if ($this->request->post['zencart_stockists'])
            {
                $this->load->model('tool/zencart_stockists');
                $this->model_tool_zencart_stockists->import();
                $this->session->data['success'] = $this->language->get('text_success');
            }
            
            if ($this->request->post['zencart_testimonials'])
            {
                $this->load->model('tool/zencart_testimonials');
                $this->model_tool_zencart_testimonials->import();
                $this->session->data['success'] = $this->language->get('text_success');
            }
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		  
        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_import'] = $this->language->get('button_import');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
		
		$this->data['tab_general'] = $this->language->get('tab_general');
        
		$this->data['text_default'] = $this->language->get('text_default');
        
		$this->data['entry_zencart_host'] = $this->language->get('entry_zencart_host');
		$this->data['entry_zencart_user'] = $this->language->get('entry_zencart_user');
		$this->data['entry_zencart_password'] = $this->language->get('entry_zencart_password');
		$this->data['entry_zencart_name'] = $this->language->get('entry_zencart_name');
		$this->data['entry_zencart_products'] = $this->language->get('entry_zencart_products');
		$this->data['entry_zencart_products_truncate'] = $this->language->get('entry_zencart_products_truncate');
		$this->data['entry_zencart_products_debug'] = $this->language->get('entry_zencart_products_debug');
		$this->data['entry_zencart_products_store'] = $this->language->get('entry_zencart_products_store');
		$this->data['entry_zencart_customers'] = $this->language->get('entry_zencart_customers');
		$this->data['entry_zencart_orders'] = $this->language->get('entry_zencart_orders');
		$this->data['entry_zencart_orders_truncate'] = $this->language->get('entry_zencart_orders_truncate');
		$this->data['entry_zencart_orders_limit'] = $this->language->get('entry_zencart_orders_limit');
		$this->data['entry_zencart_orders_debug'] = $this->language->get('entry_zencart_orders_debug');
		$this->data['entry_zencart_stockists'] = $this->language->get('entry_zencart_stockists');
		$this->data['entry_zencart_testimonials'] = $this->language->get('entry_zencart_testimonials');

		if (isset($this->request->post['zencart_host'])) {
			$this->data['zencart_host'] = $this->request->post['zencart_host'];
		} else {
			$this->data['zencart_host'] = $this->config->get('zencart_host');			
		}

		if (isset($this->request->post['zencart_user'])) {
			$this->data['zencart_user'] = $this->request->post['zencart_user'];
		} else {
			$this->data['zencart_user'] = $this->config->get('zencart_user');			
		}
                
		if (isset($this->request->post['zencart_password'])) {
			$this->data['zencart_password'] = $this->request->post['zencart_password'];
		} else {
			$this->data['zencart_password'] = $this->config->get('zencart_password');			
		}
                
		if (isset($this->request->post['zencart_name'])) {
			$this->data['zencart_name'] = $this->request->post['zencart_name'];
		} else {
			$this->data['zencart_name'] = $this->config->get('zencart_name');			
		}
                
		if (isset($this->request->post['zencart_products'])) {
			$this->data['zencart_products'] = $this->request->post['zencart_products'];
		} else {
			$this->data['zencart_products'] = $this->config->get('zencart_products');			
		}
                
		if (isset($this->request->post['zencart_products_truncate'])) {
			$this->data['zencart_products_truncate'] = $this->request->post['zencart_products_truncate'];
		} else {
			$this->data['zencart_products_truncate'] = $this->config->get('zencart_products_truncate');			
		}
                
		if (isset($this->request->post['zencart_products_debug'])) {
			$this->data['zencart_products_debug'] = $this->request->post['zencart_products_debug'];
		} else {
			$this->data['zencart_products_debug'] = $this->config->get('zencart_products_debug');			
		}
        
        $this->load->model('setting/store');

        $this->data['stores'] = $this->model_setting_store->getStores();

        if (isset($this->request->post['zencart_products_store'])) {
            $this->data['zencart_products_store'] = $this->request->post['zencart_products_store'];
        } elseif (is_array($this->config->get('zencart_products_store'))) {
            $this->data['zencart_products_store'] = $this->config->get('zencart_products_store');
        } else {
            $this->data['zencart_products_store'] = array(0);
        }
                
		if (isset($this->request->post['zencart_customers'])) {
			$this->data['zencart_customers'] = $this->request->post['zencart_customers'];
		} else {
			$this->data['zencart_customers'] = $this->config->get('zencart_customers');			
		}
                
		if (isset($this->request->post['zencart_orders'])) {
			$this->data['zencart_orders'] = $this->request->post['zencart_orders'];
		} else {
			$this->data['zencart_orders'] = $this->config->get('zencart_orders');			
		}
                
		if (isset($this->request->post['zencart_orders_truncate'])) {
			$this->data['zencart_orders_truncate'] = $this->request->post['zencart_orders_truncate'];
		} else {
			$this->data['zencart_orders_truncate'] = $this->config->get('zencart_orders_truncate');			
		}
                
		if (isset($this->request->post['zencart_orders_limit'])) {
			$this->data['zencart_orders_limit'] = $this->request->post['zencart_orders_limit'];
		} else {
			$this->data['zencart_orders_limit'] = $this->config->get('zencart_orders_limit');			
		}
                
		if (isset($this->request->post['zencart_orders_debug'])) {
			$this->data['zencart_orders_debug'] = $this->request->post['zencart_orders_debug'];
		} else {
			$this->data['zencart_orders_debug'] = $this->config->get('zencart_orders_debug');			
		}
                
		if (isset($this->request->post['zencart_stockists'])) {
			$this->data['zencart_stockists'] = $this->request->post['zencart_stockists'];
		} else {
			$this->data['zencart_stockists'] = $this->config->get('zencart_stockists');			
		}
                
		if (isset($this->request->post['zencart_testimonials'])) {
			$this->data['zencart_testimonials'] = $this->request->post['zencart_testimonials'];
		} else {
			$this->data['zencart_testimonials'] = $this->config->get('zencart_testimonials');			
		}
                
 		if (isset($this->error['zencart_host'])) {
			$this->data['error_zencart_host'] = $this->error['zencart_host'];
		} else {
			$this->data['error_zencart_host'] = '';
		}
                
 		if (isset($this->error['zencart_user'])) {
			$this->data['error_zencart_user'] = $this->error['zencart_user'];
		} else {
			$this->data['error_zencart_user'] = '';
		}
                
 		if (isset($this->error['zencart_password'])) {
			$this->data['error_zencart_password'] = $this->error['zencart_password'];
		} else {
			$this->data['error_zencart_password'] = '';
		}
                
 		if (isset($this->error['zencart_name'])) {
			$this->data['error_zencart_name'] = $this->error['zencart_name'];
		} else {
			$this->data['error_zencart_name'] = '';
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
			'href'      => $this->url->link('tool/zencart', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->data['action'] = $this->url->link('tool/zencart', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['import'] = $this->url->link('tool/zencart/import', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');

		$this->template = 'tool/zencart.tpl';
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

			// send the categories, products and options as a spreadsheet file
			$this->load->model('tool/zencart');
			$this->model_tool_zencart->import();

		} else {

			// return a permission error page
			return $this->forward('error/permission');
		}
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'tool/zencart')) {
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