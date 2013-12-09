<?php
class ControllerModuleRegisterProduct extends Controller {

	protected function index($setting) {
		$this->name = basename(__FILE__, '.php');
        
		if ($setting['store_id'] == $this->config->get('config_store_id')) {

			$this->data = array_merge($this->data, $this->load->language('module/' . $this->name));

	        if (isset($this->request->get['route'])) {
        		$this->data['action'] = (HTTP_SERVER . 'index.php?route=' . $this->request->get['route']);
			} else {
				$this->data['action'] = HTTP_SERVER;
			}

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/'.$this->name.'.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/module/'.$this->name.'.tpl';
			} else {
				$this->template = 'default/template/module/'.$this->name.'.tpl';
			}


			$this->render();
		}
  	}

  	public function callback() {

		$this->language->load('module/register_product');

		if (!$this->request->get['name']) {
			$this->response->setOutput($this->language->get('error_name'), $this->config->get('config_compression'));
			return;
		}

		if (!$this->request->get['email']) {
			$this->response->setOutput($this->language->get('error_email'), $this->config->get('config_compression'));
			return;
		}

		$pattern = '/^[^\@]+@.*\.[a-z]{2,6}$/i';

    	if (!preg_match($pattern, $this->request->get['email'])) {
      		$this->response->setOutput($this->language->get('error_email'), $this->config->get('config_compression'));
			return;
    	}

		if (!$this->request->get['location']) {
			$this->response->setOutput($this->language->get('error_location'), $this->config->get('config_compression'));
			return;
		}

		if (!$this->request->get['date']) {
			$this->response->setOutput($this->language->get('error_date'), $this->config->get('config_compression'));
			return;
		}

		if (!$this->request->get['email']) {
			$this->response->setOutput($this->language->get('error_email'), $this->config->get('config_compression'));
			return;
		}
            
		if (!$this->request->get['barcode'] || strlen(trim($this->request->get['barcode'])) != 13) {
			$this->response->setOutput($this->language->get('error_barcode'), $this->config->get('config_compression'));
			return;
		}

		$this->load->model('account/register_product');

		$this->model_account_register_product->register($this->request->get['name'], $this->request->get['email'], $this->request->get['location'], $this->request->get['date'], $this->request->get['barcode']);
        $this->response->setOutput($this->language->get('text_registered'), $this->config->get('config_compression'));
			
	}

}
?>