<?php

class ControllerToolWMS extends Controller {

    private $error = array();

    function install() {
        
    }

    public function index() {
        $this->load->language('tool/wms');
        $this->document->setTitle($this->language->get('heading_title'));
        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

            $this->model_setting_setting->editSetting('wms', $this->request->post);
            $this->config->set('wms_host', $this->request->post['wms_host']);
            $this->config->set('wms_user', $this->request->post['wms_user']);
            $this->config->set('wms_password', $this->request->post['wms_password']);
            $this->config->set('wms_name', $this->request->post['wms_name']);
            $this->config->set('wms_products', $this->request->post['wms_products']);
            $this->config->set('wms_products_truncate', $this->request->post['wms_products_truncate']);
            $this->config->set('wms_products_debug', $this->request->post['wms_products_debug']);
            $this->config->set('wms_products_store', $this->request->post['wms_products_store']);

            if ($this->request->post['wms_products_truncate']) {
                $this->load->model('tool/wms_product');
                $this->model_tool_wms_product->truncate();
            }

            if ($this->request->post['wms_products']) {
                $this->load->model('tool/wms_product');
                $this->model_tool_wms_product->import();
                $this->session->data['success'] = $this->language->get('text_success');
            }
        }

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_import'] = $this->language->get('button_import');
        $this->data['button_cancel'] = $this->language->get('button_cancel');

        $this->data['tab_general'] = $this->language->get('tab_general');

        $this->data['text_default'] = $this->language->get('text_default');

        $this->data['entry_wms_host'] = $this->language->get('entry_wms_host');
        $this->data['entry_wms_user'] = $this->language->get('entry_wms_user');
        $this->data['entry_wms_password'] = $this->language->get('entry_wms_password');
        $this->data['entry_wms_name'] = $this->language->get('entry_wms_name');
        $this->data['entry_wms_products'] = $this->language->get('entry_wms_products');
        $this->data['entry_wms_products_truncate'] = $this->language->get('entry_wms_products_truncate');
        $this->data['entry_wms_products_debug'] = $this->language->get('entry_wms_products_debug');
        $this->data['entry_wms_products_store'] = $this->language->get('entry_wms_products_store');

        if (isset($this->request->post['wms_host'])) {
            $this->data['wms_host'] = $this->request->post['wms_host'];
        } else {
            $this->data['wms_host'] = $this->config->get('wms_host');
        }

        if (isset($this->request->post['wms_user'])) {
            $this->data['wms_user'] = $this->request->post['wms_user'];
        } else {
            $this->data['wms_user'] = $this->config->get('wms_user');
        }

        if (isset($this->request->post['wms_password'])) {
            $this->data['wms_password'] = $this->request->post['wms_password'];
        } else {
            $this->data['wms_password'] = $this->config->get('wms_password');
        }

        if (isset($this->request->post['wms_name'])) {
            $this->data['wms_name'] = $this->request->post['wms_name'];
        } else {
            $this->data['wms_name'] = $this->config->get('wms_name');
        }

        if (isset($this->request->post['wms_products'])) {
            $this->data['wms_products'] = $this->request->post['wms_products'];
        } else {
            $this->data['wms_products'] = $this->config->get('wms_products');
        }

        if (isset($this->request->post['wms_products_truncate'])) {
            $this->data['wms_products_truncate'] = $this->request->post['wms_products_truncate'];
        } else {
            $this->data['wms_products_truncate'] = $this->config->get('wms_products_truncate');
        }

        if (isset($this->request->post['wms_products_debug'])) {
            $this->data['wms_products_debug'] = $this->request->post['wms_products_debug'];
        } else {
            $this->data['wms_products_debug'] = $this->config->get('wms_products_debug');
        }

        $this->load->model('setting/store');

        $this->data['stores'] = $this->model_setting_store->getStores();

        if (isset($this->request->post['wms_products_store'])) {
            $this->data['wms_products_store'] = $this->request->post['wms_products_store'];
        } elseif (is_array($this->config->get('wms_products_store'))) {
            $this->data['wms_products_store'] = $this->config->get('wms_products_store');
        } else {
            $this->data['wms_products_store'] = array(0);
        }


        if (isset($this->error['wms_host'])) {
            $this->data['error_wms_host'] = $this->error['wms_host'];
        } else {
            $this->data['error_wms_host'] = '';
        }

        if (isset($this->error['wms_user'])) {
            $this->data['error_wms_user'] = $this->error['wms_user'];
        } else {
            $this->data['error_wms_user'] = '';
        }

        if (isset($this->error['wms_password'])) {
            $this->data['error_wms_password'] = $this->error['wms_password'];
        } else {
            $this->data['error_wms_password'] = '';
        }

        if (isset($this->error['wms_name'])) {
            $this->data['error_wms_name'] = $this->error['wms_name'];
        } else {
            $this->data['error_wms_name'] = '';
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
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => FALSE
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('tool/wms', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['action'] = $this->url->link('tool/wms', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['import'] = $this->url->link('tool/wms/import', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['cancel'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');

        $this->template = 'tool/wms.tpl';
        $this->children = array(
            'common/header',
            'common/footer',
        );
        $this->response->setOutput($this->render());
    }

    public function import($stylenumber = "") {
        
        if($stylenumber=="")
            $stylenumber = (isset($this->request->get['stylenumber']) ? $this->request->get['stylenumber'] : "");

        if ($this->validate()) {
            // send the categories, products and options from WMS
            $this->load->model('tool/wms_product');
            $this->model_tool_wms_product->import($stylenumber);
        } else {

            // return a permission error page
            return $this->forward('error/permission');
        }
    }

    public function importAllLive() {
        if ($this->validate()) {
            $query = $this->db->query("SELECT model from " . DB_PREFIX . "product where status or quantity");
            if ($query->num_rows)
            {
                foreach ($query->rows as $result)
                {
                    $model = preg_replace('%^(\d*)-.*%', '\\1', $result['model']);
                    $this->import($model);
                }
            }
        } else {

            // return a permission error page
            return $this->forward('error/permission');
        }
    }

    private function validate() {
        if (!$this->user->hasPermission('modify', 'tool/wms')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return TRUE;
        } else {
            return FALSE;
        }
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