<?php
class ControllerModulePostcodeAnywhere extends Controller {

    private $error = array();

    public function index() {
        $this->load->language('module/postcode_anywhere');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('postcode_anywhere', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');

        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_account_code'] = $this->language->get('entry_account_code');
        $this->data['entry_key'] = $this->language->get('entry_key');
        $this->data['entry_check_credit'] = $this->language->get('entry_check_credit');
        $this->data['entry_geolocation'] = $this->language->get('entry_geolocation');
        $this->data['entry_international'] = $this->language->get('entry_international');
        $this->data['entry_cache'] = $this->language->get('entry_cache');
        $this->data['entry_cache_expire'] = $this->language->get('entry_cache_expire');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');

        if (isset($this->request->post['postcode_anywhere_status'])) {
            $this->data['postcode_anywhere_status'] = $this->request->post['postcode_anywhere_status'];
        } elseif ($this->config->get('postcode_anywhere_status')) {
            $this->data['postcode_anywhere_status'] = $this->config->get('postcode_anywhere_status');
        } else {
            $this->data['postcode_anywhere_status'] = 0;
        }
        
        if (isset($this->request->post['postcode_anywhere_account_code'])) {
            $this->data['postcode_anywhere_account_code'] = $this->request->post['postcode_anywhere_account_code'];
        } elseif ($this->config->get('postcode_anywhere_account_code')) {
            $this->data['postcode_anywhere_account_code'] = $this->config->get('postcode_anywhere_account_code');
        } else {
            $this->data['postcode_anywhere_account_code'] = '';
        }
        
        if (isset($this->request->post['postcode_anywhere_key'])) {
            $this->data['postcode_anywhere_key'] = $this->request->post['postcode_anywhere_key'];
        } elseif ($this->config->get('postcode_anywhere_key')) {
            $this->data['postcode_anywhere_key'] = $this->config->get('postcode_anywhere_key');
        } else {
            $this->data['postcode_anywhere_key'] = '';
        }
        
        if (isset($this->request->post['postcode_anywhere_international'])) {
            $this->data['postcode_anywhere_international'] = $this->request->post['postcode_anywhere_international'];
        } elseif ($this->config->get('postcode_anywhere_international')) {
            $this->data['postcode_anywhere_international'] = $this->config->get('postcode_anywhere_international');
        } else {
            $this->data['postcode_anywhere_international'] = '1';
        }
        
        if (isset($this->request->post['postcode_anywhere_geolocation'])) {
            $this->data['postcode_anywhere_geolocation'] = $this->request->post['postcode_anywhere_geolocation'];
        } elseif ($this->config->get('postcode_anywhere_geolocation')) {
            $this->data['postcode_anywhere_geolocation'] = $this->config->get('postcode_anywhere_geolocation');
        } else {
            $this->data['postcode_anywhere_geolocation'] = '1';
        }
        
        if (isset($this->request->post['postcode_anywhere_check_credit'])) {
            $this->data['postcode_anywhere_check_credit'] = $this->request->post['postcode_anywhere_check_credit'];
        } elseif ($this->config->get('postcode_anywhere_check_credit')) {
            $this->data['postcode_anywhere_check_credit'] = $this->config->get('postcode_anywhere_check_credit');
        } else {
            $this->data['postcode_anywhere_check_credit'] = '0';
        }
        
        if (isset($this->request->post['postcode_anywhere_cache'])) {
            $this->data['postcode_anywhere_cache'] = $this->request->post['postcode_anywhere_cache'];
        } elseif ($this->config->get('postcode_anywhere_cache')) {
            $this->data['postcode_anywhere_cache'] = $this->config->get('postcode_anywhere_cache');
        } else {
            $this->data['postcode_anywhere_cache'] = '0';
        }
        
        if (isset($this->request->post['postcode_anywhere_cache_expire'])) {
            $this->data['postcode_anywhere_cache_expire'] = $this->request->post['postcode_anywhere_cache_expire'];
        } elseif ($this->config->get('postcode_anywhere_cache_expire')) {
            $this->data['postcode_anywhere_cache_expire'] = $this->config->get('postcode_anywhere_cache_expire');
        } else {
            $this->data['postcode_anywhere_cache_expire'] = '3600';
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
            'href' => $this->url->link('module/postcode_anywhere', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['action'] = $this->url->link('module/postcode_anywhere', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        $this->template = 'module/postcode_anywhere.tpl';
        $this->children = array(
            'common/header',
            'common/footer',
        );

        $this->response->setOutput($this->render());
    }

    private function validate() {
        if (!$this->user->hasPermission('modify', 'module/postcode_anywhere')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

}

?>