<?php
class ControllerModuleLogin extends Controller {

    private $error = array();
    
    public function index() {
        $this->load->model('account/customer');

        if ($this->customer->isLogged()) {
            $this->redirect($this->url->link('account/account', '', 'SSL'));
        }

        $this->language->load('module/login');

        $this->document->setTitle($this->language->get('heading_title'));

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            unset($this->session->data['guest']);

            // Default Shipping Address
            $this->load->model('account/address');

            $address_info = $this->model_account_address->getAddress($this->customer->getAddressId());

            if ($address_info) {
                if ($this->config->get('config_tax_customer') == 'shipping') {
                    $this->session->data['shipping_country_id'] = $address_info['country_id'];
                    $this->session->data['shipping_zone_id'] = $address_info['zone_id'];
                    $this->session->data['shipping_postcode'] = $address_info['postcode'];
                }

                if ($this->config->get('config_tax_customer') == 'payment') {
                    $this->session->data['payment_country_id'] = $address_info['country_id'];
                    $this->session->data['payment_zone_id'] = $address_info['zone_id'];
                }
            } else {
                unset($this->session->data['shipping_country_id']);
                unset($this->session->data['shipping_zone_id']);
                unset($this->session->data['shipping_postcode']);
                unset($this->session->data['payment_country_id']);
                unset($this->session->data['payment_zone_id']);
            }

            // Added strpos check to pass McAfee PCI compliance test (http://forum.opencart.com/viewtopic.php?f=10&t=12043&p=151494#p151295)
            if (isset($this->request->post['redirect']) && (strpos($this->request->post['redirect'], $this->config->get('config_url')) !== false || strpos($this->request->post['redirect'], $this->config->get('config_ssl')) !== false)) {
                $this->redirect(str_replace('&amp;', '&', $this->request->post['redirect']));
            } else {
                $this->redirect($this->url->link('account/account', '', 'SSL'));
            }
        }

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_new_customer'] = $this->language->get('text_new_customer');
        $this->data['text_register'] = $this->language->get('text_register');
        $this->data['text_register_account'] = $this->language->get('text_register_account');
        $this->data['text_returning_customer'] = $this->language->get('text_returning_customer');
        $this->data['text_i_am_returning_customer'] = $this->language->get('text_i_am_returning_customer');
        $this->data['text_forgotten'] = $this->language->get('text_forgotten');

        $this->data['entry_email'] = $this->language->get('entry_email');
        $this->data['entry_password'] = $this->language->get('entry_password');

        $this->data['button_continue'] = $this->language->get('button_continue');
        $this->data['button_login'] = $this->language->get('button_login');

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        $this->data['action'] = $this->url->link('account/login', '', 'SSL');
        $this->data['register'] = $this->url->link('account/register', '', 'SSL');
        $this->data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');

        // Added strpos check to pass McAfee PCI compliance test (http://forum.opencart.com/viewtopic.php?f=10&t=12043&p=151494#p151295)
        if (isset($this->request->post['redirect']) && (strpos($this->request->post['redirect'], $this->config->get('config_url')) !== false || strpos($this->request->post['redirect'], $this->config->get('config_ssl')) !== false)) {
            $this->data['redirect'] = $this->request->post['redirect'];
        } elseif (isset($this->session->data['redirect'])) {
            $this->data['redirect'] = $this->session->data['redirect'];

            unset($this->session->data['redirect']);
        } else {
            $this->data['redirect'] = '';
        }

        if (isset($this->session->data['success'])) {
            $this->data['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $this->data['success'] = '';
        }

        if (isset($this->request->post['email'])) {
            $this->data['email'] = $this->request->post['email'];
        } else {
            $this->data['email'] = '';
        }

        if (isset($this->request->post['password'])) {
            $this->data['password'] = $this->request->post['password'];
        } else {
            $this->data['password'] = '';
        }
        
        if ($this->extensions->isInstalled('fbconnect', 'module') && $this->config->get('fbconnect_status')) {
             $this->language->load('module/fbconnect'); 

             if (!$this->customer->isLogged()) {

            if (!isset($this->fbconnect)) {
                require_once(DIR_SYSTEM . 'vendor/facebook-sdk/facebook.php');
                $this->fbconnect = new Facebook(array(
                            'appId' => $this->config->get('fbconnect_apikey'),
                            'secret' => $this->config->get('fbconnect_apisecret'),
                        ));
            }

            $this->data['fbconnect_url'] = $this->fbconnect->getLoginUrl(
                    array(
                        'scope' => 'email,user_birthday,user_location,user_hometown',
                        'redirect_uri' => $this->url->link('account/fbconnect', '', 'SSL')
                    )
            );

            if ($this->config->get('fbconnect_button_' . $this->config->get('config_language_id'))) {
                $this->data['fbconnect_button'] = html_entity_decode($this->config->get('fbconnect_button_' . $this->config->get('config_language_id')));
            }
            else
                $this->data['fbconnect_button'] = $this->language->get('heading_title');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/fbconnect.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/module/fbconnect.tpl';
            } else {
                $this->template = 'default/template/module/fbconnect.tpl';
            }

            $this->render();
        }
        } else {
            $this->data['fbconnect_url'] = '';
            $this->data['fbconnect_button'] = '';
        }

        $this->setTemplate('module/login.tpl');

        $this->response->setOutput($this->render());
    }

    public function auth() {
        $this->load->model('account/customer');
        
        $this->language->load('module/login');
        
        $json = array();
        
        $json['error'] = false;
        $json['success'] = false;
        
        if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
            $json['error'] = $this->language->get('error_login');
        }

        $customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);

        if ($customer_info && !$customer_info['approved']) {
            $json['error'] = $this->language->get('error_approved');
        }
        
        if (!$json['error'])
        {
            $json['success'] = true;
        }
        
        $this->response->setOutput(json_encode($json));
    }
    

    private function validate() {
        if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
            $this->error['warning'] = $this->language->get('error_login');
        }

        $customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);

        if ($customer_info && !$customer_info['approved']) {
            $this->error['warning'] = $this->language->get('error_approved');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

}

?>