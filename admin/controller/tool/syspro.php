<?php 
class ControllerToolSyspro extends Controller { 
	private $error = array();
        
    function install() {

    }
	
	public function index() {
            
                if (!$this->user->isSuperuser()) {
                    $this->redirect($this->url->link('admin', 'token=' . $this->session->data['token'] . $url, 'SSL'));
                }
            
		$this->load->language('tool/syspro');
		$this->document->setTitle($this->language->get('heading_title'));

                $this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
                        $this->model_setting_setting->editSetting('syspro', $this->request->post);
                        $this->load->model('tool/syspro_products');
                        $this->load->model('tool/syspro_orders');
                        if (isset($this->request->post['syspro_import_products'])) {
                            if ($this->model_tool_syspro_products->import((isset($this->request->post['syspro_selected_products']) ? explode(",", $this->request->post['syspro_selected_products']) : NULL))) {
                                    $this->session->data['success'] = $this->language->get('text_success');
    //                                $this->redirect($this->url->link('tool/syspro', 'token=' . $this->session->data['token'], 'SSL'));
                            }
                            else {
                                    $this->error['warning'] = $this->language->get('error_upload');
                            }
                        }
                        if (isset($this->request->post['syspro_import_orders'])) {
                            if ($this->model_tool_syspro_orders->import()) {
                                    $this->session->data['success'] = $this->language->get('text_success');
                                    $this->redirect($this->url->link('tool/syspro', 'token=' . $this->session->data['token'], 'SSL'));
                            }
                            else {
                                    $this->error['warning'] = $this->language->get('error_upload');
                            }
                        }
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		  
                $this->data['button_save'] = $this->language->get('button_save');
                $this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_import'] = $this->language->get('button_import');
		
		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['entry_syspro_input_folder'] = $this->language->get('entry_syspro_input_folder');
		$this->data['entry_syspro_output_folder'] = $this->language->get('entry_syspro_output_folder');
		$this->data['entry_syspro_processed_folder'] = $this->language->get('entry_syspro_processed_folder');
		$this->data['entry_syspro_warehouse'] = $this->language->get('entry_syspro_warehouse');
		$this->data['entry_syspro_create_products'] = $this->language->get('entry_create_products');
		$this->data['entry_syspro_default_priceband'] = $this->language->get('entry_default_priceband');

		if (isset($this->request->post['syspro_input_folder'])) {
			$this->data['syspro_input_folder'] = $this->request->post['syspro_input_folder'];
		} else {
			$this->data['syspro_input_folder'] = $this->config->get('syspro_input_folder');			
		}

		if (isset($this->request->post['syspro_output_folder'])) {
			$this->data['syspro_output_folder'] = $this->request->post['syspro_output_folder'];
		} else {
			$this->data['syspro_output_folder'] = $this->config->get('syspro_output_folder');			
		}

		if (isset($this->request->post['syspro_processed_folder'])) {
			$this->data['syspro_processed_folder'] = $this->request->post['syspro_processed_folder'];
		} else {
			$this->data['syspro_processed_folder'] = $this->config->get('syspro_processed_folder');			
		}
                
		if (isset($this->request->post['syspro_warehouse'])) {
			$this->data['syspro_warehouse'] = $this->request->post['syspro_warehouse'];
		} else {
			$this->data['syspro_warehouse'] = $this->config->get('syspro_warehouse');			
		}
                
		if (isset($this->request->post['syspro_create_products'])) {
			$this->data['syspro_create_products'] = $this->request->post['syspro_create_products'];
		} else {
			$this->data['syspro_create_products'] = $this->config->get('syspro_create_products');			
		}
                
		if (isset($this->request->post['syspro_default_priceband'])) {
			$this->data['syspro_default_priceband'] = $this->request->post['syspro_default_priceband'];
		} else {
			$this->data['syspro_default_priceband'] = $this->config->get('syspro_default_priceband');			
		}

 		if (isset($this->error['syspro_input_folder'])) {
			$this->data['error_syspro_input_folder'] = $this->error['syspro_input_folder'];
		} else {
			$this->data['error_syspro_input_folder'] = '';
		}
                
 		if (isset($this->error['syspro_output_folder'])) {
			$this->data['error_syspro_output_folder'] = $this->error['syspro_output_folder'];
		} else {
			$this->data['error_syspro_output_folder'] = '';
		}
                
 		if (isset($this->error['syspro_processed_folder'])) {
			$this->data['error_syspro_processed_folder'] = $this->error['syspro_processed_folder'];
		} else {
			$this->data['error_syspro_processed_folder'] = '';
		}
                
 		if (isset($this->error['syspro_warehouse'])) {
			$this->data['error_syspro_warehouse'] = $this->error['syspro_warehouse'];
		} else {
			$this->data['error_syspro_warehouse'] = '';
		}
                
 		if (isset($this->error['syspro_create_products'])) {
			$this->data['error_syspro_create_products'] = $this->error['syspro_create_products'];
		} else {
			$this->data['error_syspro_create_products'] = '';
		}
                
 		if (isset($this->error['syspro_default_priceband'])) {
			$this->data['error_syspro_default_priceband'] = $this->error['syspro_default_priceband'];
		} else {
			$this->data['error_syspro_default_priceband'] = '';
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
			'href'      => $this->url->link('tool/syspro', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->data['action'] = $this->url->link('tool/syspro', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['import'] = $this->url->link('tool/syspro/import', 'token=' . $this->session->data['token'], 'SSL');

		$this->template = 'tool/syspro.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		$this->response->setOutput($this->render());
	}

	public function import() {
		
        $this->import_products();
        $this->import_orders();
        
	}

    public function import_products() {
		if ($this->validate()) {
            
            if ($this->process_start('import_products'))
            {
                // send the categories, products and options as a spreadsheet file
                $this->load->model('tool/syspro_products');
                $this->model_tool_syspro_products->import();
                
                $this->process_end('import_products');
            }

		} else {

			// return a permission error page
			return $this->forward('error/permission');
		}
	}
    
    public function import_orders() {
		if ($this->validate()) {
            
            if ($this->process_start('import_orders'))
            {

                // send the categories, products and options as a spreadsheet file
                $this->load->model('tool/syspro_orders');
                $this->model_tool_syspro_orders->import();
                
                $this->process_end('import_orders');
            }

		} else {

			// return a permission error page
			return $this->forward('error/permission');
		}
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'tool/syspro')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
    
    private function process_start($process)
    {
        echo 'STARTING ' . $process . '...<br />';
        
        $timeout = defined('CRON_TIMEOUT') ? CRON_TIMEOUT : 1800;
        
        // set appropriate timeout limit
        set_time_limit($timeout);
        
        $filename = DIR_LOGS . 'cron_' . $process . '.txt';
        
        if (file_exists($filename))
        {
            if (filemtime($filename) < intval(time()-($timeout)))
            {
               echo 'PROCESS ' . $process . ' ALREADY RUNNING BUT OVER TIME LIMIT...<br />';
               unlink($filename);
            } else {
                
               echo 'PROCESS ' . $process . ' ALREADY RUNNING, ABORT!<br />';
               return false;
            }
        }
        
        echo 'PROCESSING ' . $process . '...<br />';
        $f = fopen($filename, "w");
        fwrite($f, 'inuse');
        fclose($f);
        
        return true;
    }
    
    private function process_end($process)
    {
        $filename = DIR_LOGS . 'cron_' . $process . '.txt';
        
        if (file_exists($filename))
        {
            unlink($filename);
        }
        
        echo 'ENDED PROCESS ' . $process . '!<br />';
        
        return true;
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