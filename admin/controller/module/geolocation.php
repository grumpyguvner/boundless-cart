<?php

class ControllerModuleGeolocation extends Controller {

    private $error = array();

    public function index() {
        $this->load->language('module/geolocation');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('geolocation', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');
        $this->data['text_default'] = $this->language->get('text_default');

        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_country'] = $this->language->get('entry_country');
        $this->data['entry_currency'] = $this->language->get('entry_currency');
        $this->data['entry_language'] = $this->language->get('entry_language');
        $this->data['entry_catalog_mode'] = $this->language->get('entry_catalog_mode');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
        $this->data['button_add_module'] = $this->language->get('button_add_module');
        $this->data['button_remove'] = $this->language->get('button_remove');

        if (isset($this->request->post['geolocation_status'])) {
            $this->data['geolocation_status'] = $this->request->post['geolocation_status'];
        } elseif ($this->config->get('geolocation_status')) {
            $this->data['geolocation_status'] = $this->config->get('geolocation_status');
        } else {
            $this->data['geolocation_status'] = 0;
        }

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('module/geolocation', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['action'] = $this->url->link('module/geolocation', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        if (isset($this->error['country_id'])) {
            $this->data['error_country_id'] = $this->error['country_id'];
        } else {
            $this->data['error_country_id'] = array();
        }


        if (isset($this->request->post['geolocation_status'])) {
            $this->data['geolocation_status'] = $this->request->post['geolocation_status'];
        } elseif ($this->config->get('language_manager_status')) {
            $this->data['geolocation_status'] = $this->config->get('geolocation_status');
        } else {
            $this->data['geolocation_status'] = 0;
        }

        if (isset($this->request->post['geolocation_countries'])) {
            $this->data['geolocation_countries'] = $this->request->post['geolocation_countries'];
        } elseif ($this->config->get('geolocation_countries')) {
            $this->data['geolocation_countries'] = $this->config->get('geolocation_countries');
        } else {
            $this->data['geolocation_countries'] = array();
        }

        $this->load->model('localisation/country');
        $this->data['countries'] = $this->model_localisation_country->getCountries();

        $this->load->model('localisation/currency');

        $this->data['currencies'] = array();

        $results = $this->model_localisation_currency->getCurrencies();

        foreach ($results as $result) {

            $this->data['currencies'][] = array(
                'currency_id' => $result['currency_id'],
                'title' => $result['title'],
                'code' => $result['code'],
                'value' => $result['value']
            );
        }

        $this->load->model('localisation/language');

        $this->data['languages'] = array();

        $languages_results = $this->model_localisation_language->getLanguages();

        foreach ($languages_results as $language) {

            $this->data['languages'][] = array(
                'language_id' => $language['language_id'],
                'name' => $language['name'],
                'code' => $language['code']
            );
        }

        $this->template = 'module/geolocation.tpl';
        $this->children = array(
            'common/header',
            'common/footer',
        );

        $this->response->setOutput($this->render());
    }

    private function validate() {
        if (!$this->user->hasPermission('modify', 'module/geolocation')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (isset($this->request->post['geolocation_countries'])) {
            foreach ($this->request->post['geolocation_countries'] as $key => $value) {
                if (empty($value['iso_code_2'])) {
                    $this->error['country_id'][$key] = $this->language->get('error_country_id');
                }
            }
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

}

?>