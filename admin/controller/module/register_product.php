<?php
class ControllerModuleRegisterProduct extends Controller {
	private $error = array();
	private $name = '';

	public function index() {

		if (!isset($this->session->data['token'])) {
			$this->session->data['token'] = 0;
		}
		$this->data['token'] = $this->session->data['token'];

		$this->checkdb();

		$this->name = basename(__FILE__, '.php');

		$this->data = array_merge($this->data, $this->load->language('module/' . $this->name));

		$this->data['classname'] = $this->name;

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting($this->name, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['title'])) {
			$this->data['error_title'] = $this->error['title'];
		} else {
			$this->data['error_title'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/' . $this->name, 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['action'] = $this->url->link('module/' . $this->name, 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['modules'] = array();

		if (isset($this->request->post[$this->name . '_module'])) {
			$this->data['modules'] = $this->request->post[$this->name . '_module'];
		} elseif ($this->config->get($this->name . '_module')) {
			$this->data['modules'] = $this->config->get($this->name . '_module');
		}

		$this->load->model('design/layout');

		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('setting/store');

		$this->data['stores'] = $this->model_setting_store->getStores();
        
		$this->data['button_export'] = $this->language->get('button_export');
		$this->data['export'] = $this->url->link('module/register_product/download', 'token=' . $this->session->data['token'], 'SSL');

		$this->template = 'module/'.$this->name.'.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());
	}

	private function validate() {
		$this->name = basename(__FILE__, '.php');
		if (!$this->user->hasPermission('modify', 'module/'.$this->name)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function checkdb() {

		$sql = "
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "register_product` (
			`register_product_id` int(11) NOT NULL auto_increment,
			`email` varchar(64) NOT NULL default '',
			`name` varchar(64) NOT NULL default '',
			`date_purchased` varchar(64) NOT NULL default '',
			`location` varchar(64) NOT NULL default '',
			`barcode` char(13) NOT NULL default '',
			PRIMARY KEY  (`register_product_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8";
		$this->db->query($sql);
	}
    
    public function download() {
		$this->load->language('module/register_product');
        
        // build column headings
        $headings = array();
        
        $headings[] = $this->language->get('column_name');
        $headings[] = $this->language->get('column_email');
        $headings[] = $this->language->get('column_location');
        $headings[] = $this->language->get('column_date');
        $headings[] = $this->language->get('column_barcode');
        
        // Get Model
		$this->load->model('sale/register_product');
        
		$results = $this->model_sale_register_product->getRegistered();
		
        $data = array();
		foreach ($results as $rownum => $result) {
            $data[$rownum][] = $result['name'];
			$data[$rownum][] = $result['email'];
			$data[$rownum][] = $result['location'];
			$data[$rownum][] = $result['date_purchased'];
			$data[$rownum][] = $result['barcode'];
		}
        
        // create data formats per column
        $settings = array();
        
        $settings[] = 'text';
        $settings[] = 'text';
        $settings[] = 'text';
        $settings[] = 'text';
        $settings[] = 'text';
        
        // load excel model
		$this->load->model('report/export');
        // send to excel builder and return spreadsheet
        $this->model_report_export->download('product_registration', 'Product Registration', $data, $headings, $settings);
        
		exit;
	}
}
?>