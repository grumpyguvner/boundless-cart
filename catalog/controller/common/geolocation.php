<?php

class ControllerCommonGeolocation extends Controller {

    public function index() {

        if ($this->extensions->isInstalled('geolocation', 'module') && $this->config->get('geolocation_status') && count($this->config->get('geolocation_countries'))) {

            $timeout = 72;

            if (!isset($this->session->data['geolocation'])) {
                $this->session->data['geolocation'] = array();
            }
            
            if (defined('SITE_REGION'))
            {
                $country_iso_code = SITE_REGION;
            } else {
                $user_ip = (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) ? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['REMOTE_ADDR'];

                if (!array_key_exists($user_ip, $this->session->data['geolocation']) || $this->session->data['geolocation'][$user_ip]['timeadded'] < strtotime("-" . $timeout . " hour")) {
                    $this->load->model('localisation/country');
                    $country_ip = $this->model_localisation_country->getCountryByIp($user_ip, $timeout);

                    if (!$country_ip) {
                        $this->load->model('module/postcode_anywhere');
                        $country_ip_pa = $this->model_module_postcode_anywhere->getCountryFromIP($user_ip);

                        if ($country_ip_pa) {
                            $this->model_localisation_country->insertCountryByIp($country_ip_pa);
                            $country_ip = $country_ip_pa;
                        }
                    }

                    if ($country_ip) {
                        $this->session->data['geolocation'][$user_ip] = $country_ip;
                    }
                    $this->session->data['geolocation'][$user_ip]['timeadded'] = strtotime("now");
                }
                
                if (array_key_exists('iso_code_2', $this->session->data['geolocation'][$user_ip]))
                {
                    $country_iso_code = $this->session->data['geolocation'][$user_ip]['iso_code_2'];
                }
            }

            if (isset($country_iso_code)) {
                foreach ($this->config->get('geolocation_countries') as $country) {
                    if ($country['iso_code_2'] == $country_iso_code) {
                        if ((bool) $country['catalog_mode']) {
                            $this->config->set('config_block_buy', true);
                        }

                        if ($this->currency->is_default() && !empty($country['currency_code']) && $this->currency->has($country['currency_code'])) {
                            $this->currency->set($country['currency_code']);
                        }

                        if ($this->request->data['default_language'] && !empty($country['language_code']) && $this->session->data['language'] != $country['language_code']) {
                            $languages = array();
                            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "language WHERE status = '1'");

                            foreach ($query->rows as $result) {
                                $languages[$result['code']] = $result;
                            }

                            if (array_key_exists($country['language_code'], $languages) && $languages[$country['language_code']]['status']) {
                                $language = $languages[$country['language_code']];

                                $this->session->data['language'] = $language['code'];

                                if (defined('SITE_REGION')) {
                                    setcookie('language', $language['code'], time() + 60 * 60 * 24 * 30, '/' . SITE_REGION . '/', $this->request->server['HTTP_HOST']);
                                } else {
                                    setcookie('language', $language['code'], time() + 60 * 60 * 24 * 30, '/', $this->request->server['HTTP_HOST']);
                                }

                                $this->config->set('config_language_id', $language['language_id']);
                                $this->config->set('config_language', $language['code']);

                                // Language	
                                $objLanguage = new Language($language['directory'], $this->registry);
                                $objLanguage->load($language['filename']);
                                $this->registry->set('language', $objLanguage);
                            }
                        }
                    }
                }
            }
        }
    }
}
?>