<?php

class ControllerModulePostcodeAnywhere extends Controller {

    public function postcode() {
        $this->language->load('module/postcode_anywhere');
        
        $json = array();
        $json['addresses'] = false;
        $json['error'] = false;
        $json['fail'] = false;
        
        $this->load->model('module/postcode_anywhere');
        if ($this->model_module_postcode_anywhere->isAvailable())
        {
            if (!empty($this->request->get['postcode']) && !empty($this->request->get['country_id'])) {
                $json['addresses'] = $this->model_module_postcode_anywhere->getAddressesByPostcode($this->request->get['postcode'], $this->request->get['country_id']);
                if (!$json['addresses'])
                {
                    $json['error'] = $this->language->get('error_postcode_lookup_noaddresses');
                }
            } else {
                $json['error'] = $this->language->get('error_postcode_lookup_empty');
            }
        } else {
            $json['error'] = $this->language->get('error_postcode_unavailable');
            $json['fail'] = true;
        }
        
        if (!$this->model_module_postcode_anywhere->isAvailable()) {
            $json['error'] = $this->language->get('error_postcode_unavailable');
            $json['fail'] = true;
        }

        $this->response->setOutput(json_encode($json));
    }

    public function address() {
        $this->language->load('module/postcode_anywhere');
        
        $json = array();
        $json['address'] = false;
        $json['error'] = false;
        $json['fail'] = false;
        
        $this->load->model('module/postcode_anywhere');
        if ($this->model_module_postcode_anywhere->isAvailable())
        {
            if (!empty($this->request->get['address']) && !empty($this->request->get['country_id'])) {
                $json['address'] = $this->model_module_postcode_anywhere->getAddressById($this->request->get['address'], $this->request->get['country_id']);
                if (!$json['address'])
                {
                    $json['error'] = $this->language->get('error_postcode_lookup_noaddresses');
                }
            } else {
                $json['error'] = $this->language->get('error_address_lookup_empty');
            }
        } else {
            $json['error'] = $this->language->get('error_postcode_unavailable');
            $json['fail'] = true;
        }
        
        if (!$this->model_module_postcode_anywhere->isAvailable()) {
            $json['error'] = $this->language->get('error_postcode_unavailable');
            $json['fail'] = true;
        }

        $this->response->setOutput(json_encode($json));
    }

}

?>