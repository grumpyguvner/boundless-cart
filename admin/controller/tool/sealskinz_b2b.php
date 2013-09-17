<?php 
class ControllerToolSealskinzB2b extends Controller { 
	private $error = array();
        
    function install() {

    }
	
	public function index() {
            
                if (!$this->user->isSuperuser()) {
                    $this->redirect($this->url->link('admin', 'token=' . $this->session->data['token'] . $url, 'SSL'));
                }
            
		$this->load->language('tool/sealskinz_b2b');
		$this->document->setTitle($this->language->get('heading_title'));

                $this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
                        $this->model_setting_setting->editSetting('sealskinz_b2b', $this->request->post);
                        $this->load->model('tool/sealskinz_b2b');
                        $this->model_tool_sealskinz_b2b->import();
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		  
                $this->data['button_save'] = $this->language->get('button_save');
                $this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_import'] = $this->language->get('button_import');
		
		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['entry_b2b_server_url'] = $this->language->get('entry_b2b_server_url');

		if (isset($this->request->post['b2b_server_url'])) {
			$this->data['b2b_server_url'] = $this->request->post['b2b_server_url'];
		} else {
			$this->data['b2b_server_url'] = $this->config->get('b2b_server_url');			
		}

 		if (isset($this->error['b2b_server_url'])) {
			$this->data['error_b2b_server_url'] = $this->error['b2b_server_url'];
		} else {
			$this->data['error_b2b_server_url'] = '';
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
			'href'      => $this->url->link('tool/sealskinz_b2b', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->data['action'] = $this->url->link('tool/sealskinz_b2b', 'token=' . $this->session->data['token'], 'SSL');

                $this->data['import'] = $this->url->link('tool/sealskinz_b2b', 'token=' . $this->session->data['token'], 'SSL');
                
		$this->template = 'tool/sealskinz_b2b.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		$this->response->setOutput($this->render());
	}

	public function import() {
		
        $this->import_stocklist();
        
	}

    public function import_stockist() {
            if ($this->validate()) {
            
            if ($this->process_start('import_stocklist'))
            {
                // send the categories, products and options as a spreadsheet file
                $this->load->model('tool/sealskinz_b2b');
                $this->model_tool_sealskinz_b2b->import;
                
                $this->process_end('import_stocklist');
            }

		} else {

			// return a permission error page
			return $this->forward('error/permission');
		}
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'tool/sealskinz_b2b')) {
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
}
?>