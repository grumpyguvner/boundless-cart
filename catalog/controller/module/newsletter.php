<?php
class ControllerModuleNewsletter extends Controller {

    protected function index($setting) {
        $this->name = basename(__FILE__, '.php');

        if ($setting['store_id'] == $this->config->get('config_store_id')) {

            $this->session->data['newsletter_name_required'] = $setting['name'];
            $this->data = array_merge($this->data, $this->load->language('module/' . $this->name));
            $this->data['heading_title'] = $setting['language_id'][$this->config->get('config_language_id')];

            if ($setting['name'] != 'off') {
                $this->data['name'] = $setting['name'];
            } else {
                $this->data['name'] = 'off';
            }

            if (isset($this->request->get['route'])) {
                $this->data['action'] = (HTTP_SERVER . 'index.php?route=' . $this->request->get['route']);
            } else {
                $this->data['action'] = HTTP_SERVER;
            }

            $this->setTemplate('module/' . $this->name . '.tpl');


            $this->render();
        }
    }

    public function callback() {

        $this->language->load('module/newsletter');
        
        $this->load->model('account/newsletter');

        if (!isset($this->request->get['subscribe'])) {
            $this->request->get['subscribe'] = true;
        }

        $success = null;
        $error = null;
        
        if (isset($this->request->get['listId'])) {
            $this->config->set('newsletter_mailchimp_listid', $this->request->get['listId']);
        }
        
        if (isset($this->request->get['firstname'])) {
            if ($this->request->get['firstname'] == '') {
                $error = $this->language->get('error_firstname');
            }
        }

        else if (isset($this->request->get['lastname'])) {
            if ($this->request->get['lastname'] == '') {
                $error = $this->language->get('error_lastname');
            }
        }
        
        else if (!$this->request->get['email'] || !filter_var($this->request->get['email'], FILTER_VALIDATE_EMAIL)) {
            $error = $this->language->get('error_email');
        }

        if (empty($this->session->data['newsletter_name_required'])) {
            $this->session->data['newsletter_name_required'] = 'optional';
        }
        
        $data = $this->request->get;

        if (is_null($error)) {
            $this->load->model('account/customer');
            $total = $this->model_account_newsletter->getTotalNewsletterByEmail($this->request->get['email']);

            if ($total && $this->request->get['subscribe'] && !$this->customer->isLogged()) { // subscribe
                $error = $this->language->get('error_exists');
            } elseif ($total && $this->request->get['subscribe'] && $this->customer->getEmail() != $this->request->get['email']) { // subscribe
                $error = $this->language->get('error_exists');
            } elseif (!$total && !$this->request->get['subscribe']) { // unsubscribe
                $error = $this->language->get('error_exists');
            }
        }

        if (is_null($error)) {
            if ($this->request->get['subscribe']) {
                if ($this->customer->isLogged() && !isset($this->request->get['listId'])) {
                    $this->model_account_newsletter->subscribe($this->request->get['email'], $data, 'account');
                } else {
                    $this->model_account_newsletter->subscribe($this->request->get['email'], $data);
                }
                if ($this->config->get('newsletter_mailchimp_enabled') && $this->config->get('newsletter_mailchimp_double_optin')) {
                    $success = $this->language->get('text_subscribed_optin');
                } else {
                    $success = $this->language->get('text_subscribed');
                }
            } else {
                $this->model_account_newsletter->unsubscribe($this->request->get['email']);
                $success = $this->language->get('text_unsubscribed');
            }
        }

        $success = sprintf($success, $this->request->get['email']);
        $error = sprintf($error, $this->request->get['email']);

        if (isset($this->request->get['ajax'])) {
            $ajax = array('success' => $success, 'error' => $error);
            $this->response->setOutput(json_encode($ajax), $this->config->get('config_compression'));
        } elseif ($error) {
            $this->response->setOutput($error, $this->config->get('config_compression'));
        } else {
            $this->response->setOutput($success, $this->config->get('config_compression'));
        }
    }
    
    public function signup() {
        
        $this->language->load('module/newsletter');
        
        $this->load->model('account/newsletter');
        
        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_newsletter_signup'),
            'href' => $this->url->link('module/newsletter/signup', '', 'SSL'),
            'separator' => $this->language->get('text_separator')
        );
        
        $this->data['heading_title'] = $this->language->get('heading_title');
        
        $this->data['text_my_newsletters'] = $this->language->get('text_my_newsletters');
        $this->data['text_choose_newsletter'] = $this->language->get('text_choose_newsletter');
        $this->data['text_choose_newsletter_womens'] = $this->language->get('text_choose_newsletter_womens');
        $this->data['text_choose_newsletter_mens'] = $this->language->get('text_choose_newsletter_mens');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');
        
        $this->data['entry_name'] = $this->language->get('entry_name');
        $this->data['entry_name2'] = $this->language->get('entry_name2');
        $this->data['entry_email'] = $this->language->get('entry_email');
        
        $this->data['button_back'] = $this->language->get('button_back');
        $this->data['button_subscribe'] = $this->language->get('button_subscribe');
        
        $this->data['action'] = $this->url->link('account/newsletter', '', 'SSL');
        $this->data['back'] = $this->url->link('common/home', '', 'SSL');
        
        $this->data['select_title'] = explode(',', $this->language->get('select_title'));
               
        if (count($this->data['breadcrumbs']) > 1)
            {
                $count = count($this->data['breadcrumbs']) - 2;
                $this->data['text_breadcrumb_back'] = sprintf($this->language->get('text_breadcrumb_back'), $this->data['breadcrumbs'][$count]['text']);
            } else {
                $this->data['text_breadcrumb_back'] = '';
            }
        
        if (isset($this->error['firstname'])) {
            $this->data['error_firstname'] = $this->error['firstname'];
        } else {
            $this->data['error_firstname'] = '';
        }

        if (isset($this->error['lastname'])) {
            $this->data['error_lastname'] = $this->error['lastname'];
        } else {
            $this->data['error_lastname'] = '';
        }

        if (isset($this->error['email'])) {
            $this->data['error_email'] = $this->error['email'];
        } else {
            $this->data['error_email'] = '';
        }
        
        $this->setTemplate('module/newsletter_signup.tpl');

        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/content_top',
            'common/content_bottom',
            'common/footer',
            'common/header'
        );

        $this->response->setOutput($this->render());
    }

}

?>