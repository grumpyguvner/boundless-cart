<?php
/**
 * Admin Rebooted theme based on Twitter Bootstrap
 * copyright	2012 - pine3ree - maks feltrin - pine3ree(AT)gmail(DOT)com
 */
class ControllerModuleP3AdminRebooted extends Controller
{
	protected $error = array();

	public function index()
	{
		$this->load->language('module/p3adminrebooted');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		// FORM SUBMISSION
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate())
		{
			$settings = array(
				'p3adminrebooted_flavour'					=> isset($this->request->post['p3adminrebooted_flavour']) ? $this->request->post['p3adminrebooted_flavour'] : '',
				'p3adminrebooted_jui_full'				=> isset($this->request->post['p3adminrebooted_jui_full']) ? $this->request->post['p3adminrebooted_jui_full'] : 0,
				'p3adminrebooted_select2'					=> isset($this->request->post['p3adminrebooted_select2']) ? $this->request->post['p3adminrebooted_select2'] : 0,
				'p3adminrebooted_ckeditor4'				=> isset($this->request->post['p3adminrebooted_ckeditor4']) ? $this->request->post['p3adminrebooted_ckeditor4'] : 0,
				'p3adminrebooted_toggle_buttons'	=> isset($this->request->post['p3adminrebooted_toggle_buttons']) ? $this->request->post['p3adminrebooted_toggle_buttons'] : 0,
				'p3adminrebooted_menu_highlight'	=> isset($this->request->post['p3adminrebooted_menu_highlight']) ? $this->request->post['p3adminrebooted_menu_highlight'] : 0,
				'p3adminrebooted_hide_helpmenu'		=> isset($this->request->post['p3adminrebooted_hide_helpmenu']) ? (int)$this->request->post['p3adminrebooted_hide_helpmenu'] : 0,
			);

			$this->model_setting_setting->editSetting('p3adminrebooted', $settings);

			$this->session->data['success'] = $this->language->get('text_success');

			if (!$this->request->post['action_apply']) {
				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
			else {
				$this->data['success'] = $this->language->get('text_success');
				if (isset($this->session->data['success'])) {
					unset($this->session->data['success']);
				}
			}
		}
		else
		{
			$this->data['success'] = '';
		}

		// INSTALLOSL
		$this->load->model('localisation/order_status_label');
		if (isset($this->request->get['action']) and ($this->request->get['action']=='installosl'))
		{
			$this->installosl();
		}

		$this->data['heading_title'] = $this->language->get('heading_title');


		// BREADCRUMBS
		$this->data['breadcrumbs'] = array(
			array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => false,
			),
			array(
				'text'      => $this->language->get('text_module'),
				'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' / '
			),
			array(
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('module/p3adminrebooted', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' / '
			),
		);
                
                $this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
                
                $this->data['entry_flavour'] = $this->language->get('entry_flavour');
                $this->data['entry_jui_full'] = $this->language->get('entry_jui_full');
                $this->data['entry_select2'] = $this->language->get('entry_select2');
                $this->data['entry_toggle_buttons'] = $this->language->get('entry_toggle_buttons');
                $this->data['entry_ckeditor4'] = $this->language->get('entry_ckeditor4');
                $this->data['entry_menu_highlight'] = $this->language->get('entry_menu_highlight');
                $this->data['entry_hide_helpmenu'] = $this->language->get('entry_hide_helpmenu');

                $this->data['button_save'] = $this->language->get('button_save');
                $this->data['button_cancel'] = $this->language->get('button_cancel');
                
		$this->data['action'] = $this->url->link('module/p3adminrebooted', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$settings = $this->model_setting_setting->getSetting('p3adminrebooted');

		// DATA
		$this->data['p3adminrebooted_flavour'] = isset($this->request->post['p3adminrebooted_flavour']) ?
			$this->request->post['p3adminrebooted_flavour'] : $settings['p3adminrebooted_flavour'];

		$this->data['p3adminrebooted_jui_full'] = isset($this->request->post['p3adminrebooted_jui_full']) ?
			$this->request->post['p3adminrebooted_jui_full'] : $settings['p3adminrebooted_jui_full'];

		$this->data['p3adminrebooted_select2'] = isset($this->request->post['p3adminrebooted_select2']) ?
			$this->request->post['p3adminrebooted_select2'] : $settings['p3adminrebooted_select2'];

		$this->data['p3adminrebooted_ckeditor4'] = isset($this->request->post['p3adminrebooted_ckeditor4']) ?
			$this->request->post['p3adminrebooted_ckeditor4'] : $settings['p3adminrebooted_ckeditor4'];

		$this->data['p3adminrebooted_toggle_buttons'] = isset($this->request->post['p3adminrebooted_toggle_buttons']) ?
			$this->request->post['p3adminrebooted_toggle_buttons'] : $settings['p3adminrebooted_toggle_buttons'];

		$this->data['p3adminrebooted_menu_highlight'] = isset($this->request->post['p3adminrebooted_menu_highlight']) ?
			$this->request->post['p3adminrebooted_menu_highlight'] : $settings['p3adminrebooted_menu_highlight'];

		$this->data['p3adminrebooted_hide_helpmenu'] = isset($this->request->post['p3adminrebooted_hide_helpmenu']) ?
			$this->request->post['p3adminrebooted_hide_helpmenu']
			: isset($settings['p3adminrebooted_hide_helpmenu']) ? (int)$settings['p3adminrebooted_hide_helpmenu'] : 0;

		// OPTIONS
		$this->data['p3adminrebooted_flavour_options'] = array(
			array( 'value'=>'', 'label'=>'Default' ),
			array( 'value'=>'dark', 'label'=>'Dark' ),
			array( 'value'=>'red', 'label'=>'Red' ),
			array( 'value'=>'mint', 'label'=>'Mint' ),
		);

		$this->data['p3adminrebooted_jui_full_options'] = array(
			array( 'value'=>1, 'label'=>'jquery ui complete' ),
			array( 'value'=>0, 'label'=>'jquery ui autocomplete only' ),
		);
		$this->data['p3adminrebooted_ckeditor4_options'] = array(
			array( 'value'=>1, 'label'=>'CKEditor 4.0.1 (new)' ),
			array( 'value'=>0, 'label'=>'CKEditor 3.x (opencart default)' ),
		);

		// ORDER STATUS LABELS FEATURE
		$this->data['osl_installed'] = $this->model_localisation_order_status_label->dbTableExists(true);

		$this->data['installosl'] = $this->url->link(
			'module/p3adminrebooted',
			'&action=installosl' . '&token=' . $this->session->data['token'],
			'SSL'
		);

		// ERRORS
		$this->data['error_warning'] = isset($this->error['warning']) ? $this->error['warning'] : '';
		$this->data['error_db_permission'] = isset($this->error['db_permission']) ? $this->error['db_permission'] : false;

		// TEMPLATE
		$this->template = 'module/p3adminrebooted.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		// RENDER
		$this->response->setOutput($this->render());
	}

	private function validate()
	{
		if (!$this->user->hasPermission('modify', 'module/p3adminrebooted')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return (bool)(!$this->error);
	}

	public function install()
	{
		$this->load->model('setting/setting');

		$settings = array(
			'p3adminrebooted_flavour'					=> '',
			'p3adminrebooted_jui_full'				=> 0,
			'p3adminrebooted_select2'					=> 1,
			'p3adminrebooted_ckeditor4'				=> 1,
			'p3adminrebooted_toggle_buttons'	=> 1,
			'p3adminrebooted_menu_highlight'	=> 0,
			'p3adminrebooted_hide_helpmenu'		=> 0,
		);

		$this->model_setting_setting->editSetting('p3adminrebooted', $settings);
	}

	private function installosl()
	{
		if (!$this->validate()) {
			return false;
		}

		if ($this->model_localisation_order_status_label->canCreateDbTables()) {
			$this->model_localisation_order_status_label->createDbTable();
		}
		else {
			$this->error['db_permission'] = 'The database table was not created. Check database user privileges!';
		}
		return (bool)(!$this->error);
	}
}
