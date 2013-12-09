<?php
class ControllerLocalisationOrderStatusLabel extends Controller
{
	private $error = array();

	public function index()
	{
		$this->load->language('localisation/order_status');

		$this->document->setTitle($this->language->get('heading_title').' / Labels');

		$this->load->model('localisation/order_status');
		$this->load->model('localisation/order_status_label');

		// order_status_label NOT CREATED YET
		if (!$this->model_localisation_order_status_label->dbTableExists()) {
			$this->error['warning'] = 'ORDER STATUS LABELS feauture is not installed!';
		}

		$this->getForm();
	}

	public function update()
	{
		$this->load->language('localisation/order_status');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/order_status_label');

		// order_status_label NOT CREATED YET
		if (!$this->model_localisation_order_status_label->dbTableExists()) {
			$this->redirect($this->url->link('localisation/order_status_label', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm())
		{
      $this->model_localisation_order_status_label->editOrderStatusLabels($this->request->post);

			$this->session->data['success'] = trim($this->language->get('text_success'), '!.').' - labels!';

			$this->redirect($this->url->link('localisation/order_status_label', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->getForm();
	}


	private function getForm()
	{
		// TEXT
		$this->data['heading_title'] = $this->language->get('heading_title').' Labels';

		$this->data['column_name'] = $this->language->get('column_name');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		// ERRORS
		$this->data['error_warning'] = isset($this->error['warning']) ? $this->error['warning'] : '';

		$this->data['success'] = null;
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}

		// BREADCRUMBS
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title').' - Labels',
			'href'      => $this->url->link('localisation/order_status_label', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['update'] = $this->url->link('localisation/order_status_label/update', 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model('localisation/order_status');
		$this->load->model('localisation/order_status_label');

		$order_statuses = $this->model_localisation_order_status->getOrderStatuses();

		$this->model_localisation_order_status_label->setOrderStatusLabels($order_statuses);

		foreach ($order_statuses as $n=>$order_status) {
			$order_statuses[$n]['label_options'] = $this->model_localisation_order_status_label->getOrderStatusLabelOptions($order_status['label']);
		}

		$this->data['order_statuses'] = $order_statuses;

		$this->template = 'localisation/order_status_label_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	private function validateForm()
	{
		if (!$this->user->hasPermission('modify', 'localisation/order_status_label')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		return !$this->error;
	}

 }
