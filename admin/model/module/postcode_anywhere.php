<?php

require_once(DIR_SYSTEM . 'library/postcode_anywhere.php');

class ModelModulePostcodeAnywhere extends Model {

    private $pa;
    private $paError = array();
    private $available = null;

    public function __construct($registry) {
        parent::__construct($registry);

        $this->pa = new PostcodeAnywhere($this->config->get('postcode_anywhere_key'), $this->config->get('postcode_anywhere_account_code'), $this->config->get('postcode_anywhere_cache'), $this->config->get('postcode_anywhere_cache_expire'), $this->paError);
    }

    public function isAvailable() {
        
        if ($this->paError)
        {
            foreach ($this->paError as $error)
            {
                if ($error['code'] < 1000)
                {
                    return $this->available = false;
                }
            }
        }
        
        if (!is_null($this->available)) return $this->available;
        
        if ($this->config->get('postcode_anywhere_status'))
        {
            if ($this->config->get('postcode_anywhere_check_credit'))
            {
                $balance = $this->pa->getBalance();

                if ($balance && empty($this->paError))
                {
                    foreach ($balance->Items as $credit)
                    {
                        if ($credit->Percent > 5)
                        {
                            return $this->available = true;
                        }
                    }
                }
            } else {
                return $this->available = true;
            }
        }
        return $this->available = false;
    }
    
    public function getCountryFromIp($ipAddress) {
        
        if ($this->config->get('postcode_anywhere_geolocation') && $this->isAvailable())
        {
            $country_ip = $this->pa->getCountryFromIP($ipAddress);

            if ($country_ip)
            {
                $this->load->model('localisation/country');

                $data = array();

                $data['ip'] = $country_ip->Items[0]->IpAddress;
                $data['iso_code_2'] = $country_ip->Items[0]->Iso2;
                $data['iso_code_3'] = $country_ip->Items[0]->Iso3;

                $country = $this->model_localisation_country->getCountryByISO3($country_ip->Items[0]->Iso3);

                $data['country_id'] = ($country) ? $country['country_id'] : 0;

                return $data;
            }
        }

        return false;
    }

    public function getAddressesByPostcode($postcode, $country_id = false) {
        if (!$country_id) {
            $country_id = $this->config->get('config_country_id');
        }
        $this->load->model('localisation/country');
        $country = $this->model_localisation_country->getCountry($country_id);

        $addresses = $this->pa->getAddressesByPostcode($postcode, $country['iso_code_3']);
        
        if ($addresses)
        {
            $data = array();
            switch ($country['iso_code_3']) {
                case 'GBR':
                case 'USA':
                    foreach ($addresses->Items as $address_info)
                    {
                        $data[] = array('value' => $address_info->Id,
                                        'text'  => $address_info->StreetAddress . ', ' . $address_info->Place);
                    }
                    break;
                default:
                    $this->load->model('localisation/country');
                    $this->load->model('localisation/zone');
                    foreach ($addresses->Items as $address_info)
                    {
                        $address = array();
                        $country = $this->model_localisation_country->getCountryByISO3($address_info->CountryCode);
                        $address['country_id'] = ($country) ? $country['country_id'] : '';

                        $address['company'] = '';
                        $address['address_1'] = $address_info->Description;
                        $address['address_2'] = $address_info->District;
                        $address['postcode'] = $address_info->PostalCode;
                        $address['city'] = $address_info->City;

                        $zone = $this->model_localisation_zone->getZoneByName($address_info->State, $address['country_id']);

                        $address['zone_id'] = ($zone) ? $zone['zone_id'] : '';
                        
                        if (!$address['zone_id']) {
                           $zone_data = array('status' => 1, 'code' => $address_info->State, 'name' => $address_info->State, 'country_id' => $address['country_id']); 
                            
                           $address['zone_id'] = $this->model_localisation_zone->addZone($zone_data);
                        }
                    
                        $data[] = array('value' => json_encode($address),
                                        'text'  => $address_info->Description . ', ' . $address_info->City);
                    }
            }
            if ($data !== false) return $data;
        }

        return false;
    }

    public function getAddressById($id, $country_id = false) {
        $this->load->model('localisation/country');
        $this->load->model('localisation/zone');

        // $id my be json if international address
        $json = json_decode(html_entity_decode($id));
        if (json_last_error() == JSON_ERROR_NONE && is_object($json)) {
            $data = array();
            
            $data['company'] = isset($json->company) ? $json->company : '';
            $data['address_1'] = isset($json->address_1) ? $json->address_1 : '';
            $data['address_2'] = isset($json->address_2) ? $json->address_2 : '';
            $data['postcode'] = isset($json->postcode) ? $json->postcode : '';
            $data['city'] = isset($json->city) ? $json->city : '';
            $data['country_id'] = isset($json->country_id) ? $json->country_id : '';
            $data['zone_id'] = isset($json->zone_id) ? $json->zone_id : '';
            
            return $data;
        } else {
            if (!$country_id) {
                $country_id = $this->config->get('config_country_id');
            }
            $country = $this->model_localisation_country->getCountry($country_id);

            $address = $this->pa->getAddressById($id, $country['iso_code_3']);

            if ($address) {

                $data = array();

                switch ($country['iso_code_3']) {
                    case 'GBR':

                        $country = $this->model_localisation_country->getCountryByISO3($address->Items[0]->CountryISO3);
                        $data['country_id'] = ($country) ? $country['country_id'] : '';
                        
                        if (!$data['country_id']) {
                           $country_data = array('status' => 1, 'name' => $address->Items[0]->CountryName, 'iso_code_2' => $address->Items[0]->CountryISO2, 'iso_code_3' => $address->Items[0]->CountryISO3, 'address_format' => '', 'postcode_required' => 1);
                           
                           $data['country_id'] = $this->model_localisation_country->addCountry($country_data);
                        }

                        $data['company'] = $address->Items[0]->Company;
                        $data['address_1'] = $address->Items[0]->Line1;
                        $data['address_2'] = array($address->Items[0]->Line2);
                        if ($address->Items[0]->Line3)
                            $data['address_2'][] = $address->Items[0]->Line3;
                        if ($address->Items[0]->Line4)
                            $data['address_2'][] = $address->Items[0]->Line4;
                        if ($address->Items[0]->Line5)
                            $data['address_2'][] = $address->Items[0]->Line5;
                        $data['address_2'] = implode(', ', $data['address_2']);
                        $data['postcode'] = $address->Items[0]->Postcode;
                        $data['city'] = $address->Items[0]->PostTown;

                        $zone = $this->model_localisation_zone->getZoneByName($address->Items[0]->County, $data['country_id']);

                        $data['zone_id'] = ($zone) ? $zone['zone_id'] : '';
                        
                        if (!$data['zone_id']) {
                           $zone = $this->model_localisation_zone->getZoneByCode($address->Items[0]->County, $data['country_id']);

                           $data['zone_id'] = ($zone) ? $zone['zone_id'] : ''; 
                        }
                        
                        if (!$data['zone_id']) {
                           
                           $county = ($address->Items[0]->County) ? $address->Items[0]->County : $address->Items[0]->PostTown;
                            
                           $zone_data = array('status' => 1, 'code' => '', 'name' => $county, 'country_id' => $data['country_id']); 
                            
                           $data['zone_id'] = $this->model_localisation_zone->addZone($zone_data);
                        }

                        break;
                    case 'USA':
                        $country = $this->model_localisation_country->getCountryByISO3($address->Items[0]->CountryIso3);
                        $data['country_id'] = ($country) ? $country['country_id'] : '';
                        
                        if (!$data['country_id']) {
                           $country_data = array('status' => 1, 'name' => $address->Items[0]->CountryName, 'iso_code_2' => $address->Items[0]->CountryISO2, 'iso_code_3' => $address->Items[0]->CountryISO3, 'address_format' => '', 'postcode_required' => 1);
                           
                           $data['country_id'] = $this->model_localisation_country->addCountry($country_data);
                        }

                        $data['company'] = $address->Items[0]->Company;
                        $data['address_1'] = $address->Items[0]->Line1;
                        $data['address_2'] = $address->Items[0]->Line2;
                        $data['postcode'] = $address->Items[0]->Zip;
                        $data['city'] = $address->Items[0]->City;

                        $zone = $this->model_localisation_zone->getZoneByName($address->Items[0]->StateName, $data['country_id']);

                        $data['zone_id'] = ($zone) ? $zone['zone_id'] : '';
                        
                        if (!$data['zone_id']) {
                           $zone = $this->model_localisation_zone->getZoneByCode($address->Items[0]->StateCode, $data['country_id']);

                           $data['zone_id'] = ($zone) ? $zone['zone_id'] : ''; 
                        }
                        
                        if (!$data['zone_id']) {
                            
                           $zone_data = array('status' => 1, 'code' => $address->Items[0]->StateCode, 'name' => $address->Items[0]->StateName, 'country_id' => $data['country_id']); 
                            
                           $data['zone_id'] = $this->model_localisation_zone->addZone($zone_data);
                        }
                        
                        break;
                }
                if ($data) return $data;
            }
        }
        return false;
    }

}

?>