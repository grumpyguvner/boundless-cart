<?php

class PostcodeAnywhere {

    private $key; //The key to use to authenticate to the service.
    private $account; //Not sure this is used anymore
    private $max = 150; // max return
    private $timeout = 8; // timeout set on the calll to the endpoint
    private $error = array(); // error

    public function __construct($key, $account = null, $cache = false, $cache_expire = 3600, &$error = null) {
        $this->key = $key;
        $this->account = $account;
        if (!is_null($error)) {
            $this->error = &$error;
        }

        if ($cache) {
            $this->cache = new Cache($cache_expire);
        }
    }

    public function getBalance() {

        $endpoint = 'http://services.postcodeanywhere.co.uk/Management/Balance/List/v1.10/json3.ws?';
        $endpoint .= 'Key=' . urlencode($this->key);

        return $this->getData($endpoint);
    }
    
    public function getLists() {

        $endpoint = 'http://services.postcodeanywhere.co.uk/Management/Keys/List/v1.00/json3.ws?';
        $endpoint .= 'Key=' . urlencode($this->key);

        return $this->getData($endpoint);
    }
    
    public function getCountryFromIP($IpAddress) {

        $endpoint = 'http://services.postcodeanywhere.co.uk/Extras/Web/Ip2Country/v1.00/json3.ws?';
        $endpoint .= 'Key=' . urlencode($this->key);
        $endpoint .= '&IpAddress=' . $IpAddress;

        return $this->getData($endpoint);
    }

    public function getAddressesByPostcode($postcode, $iso3 = 'GBR', $building = null) {
        switch ($iso3) {
            case 'GBR':
                $data = $this->getAddressesByPostcodeUK($postcode);
                break;
            case 'USA':
                $data = $this->getAddressesByPostcodeUS($postcode);
                break;
            default:
                $data = $this->getAddressesByPostcodeInternational($postcode, $iso3, $building);
        }

        return $data;
    }

    public function getAddressesByPostcodeUK($postcode) {

        $endpoint = 'http://services.postcodeanywhere.co.uk/PostcodeAnywhere/Interactive/FindByPostcode/v1.00/json3.ws?';
        $endpoint .= 'Key=' . urlencode($this->key) . '&';
        $endpoint .= 'Postcode=' . urlencode($postcode);
        $endpoint .= '&$Top=' . $this->max;

        $cache = 'postcodeUK.' . $postcode;

        return $this->getData($endpoint, $cache);
    }

    public function getAddressesByPostcodeUS($postcode) {
        if (preg_match('%\d{5}-\d{4}%', $postcode)) {
            $endpoint = 'http://services.postcodeanywhere.co.uk/PostcodeAnywhereInternational/InteractiveUSA/FindByZip4/v1.00/json3.ws?';
            $endpoint .= 'Key=' . urlencode($this->key) . '&';
            $endpoint .= 'Zip4=' . urlencode($postcode);
        } else {
            $endpoint = 'http://services.postcodeanywhere.co.uk/PostcodeAnywhereInternational/InteractiveUSA/FindByZip/v1.00/json3.ws?';
            $endpoint .= 'Key=' . urlencode($this->key);
            $endpoint .= '&Zip=' . urlencode($postcode);
            $endpoint .= '&$Top=' . $this->max;
        }

        $cache = 'postcodeUS.' . $postcode;

        return $this->getData($endpoint, $cache);
    }

    public function getAddressesByPostcodeInternational($postcode, $iso3, $building = null) {
        $endpoint = 'http://services.postcodeanywhere.co.uk/PostcodeAnywhereInternational/Interactive/RetrieveByPostalCode/v2.20/json3.ws?';
        $endpoint .= 'Key=' . urlencode($this->key) . '&';
        $endpoint .= '&PostalCode=' . urlencode($postcode);
        $endpoint .= '&Country=' . urlencode($iso3);
        if ($building)
            $endpoint .= '&Building=' . urlencode($building);
        $endpoint .= '&$Top=' . $this->max;

        $cache = 'postcodeIntern.' . $postcode . '.' . $iso3 . '.' . $building;

        return $this->getData($endpoint, $cache);
    }

    public function getAddressById($id, $iso3 = 'GBR') {

        switch ($iso3) {
            case 'GBR':
                $data = $this->getAddressByIdUK($id);
                break;
            case 'USA':
                $data = $this->getAddressByIdUS($id);
                break;
            default:
                $data = false;
        }

        return $data;
    }

    public function getAddressByIdUK($id) {
        $endpoint = 'http://services.postcodeanywhere.co.uk/PostcodeAnywhere/Interactive/RetrieveById/v1.30/json3.ws?';
        $endpoint .= 'Key=' . urlencode($this->key) . '&';
        $endpoint .= 'Id=' . urlencode($id);

        $cache = 'addressUK.' . $id;

        return $this->getData($endpoint, $cache);
    }

    public function getAddressByIdUS($id) {
        $endpoint = 'http://services.postcodeanywhere.co.uk/PostcodeAnywhereInternational/InteractiveUSA/RetrieveById/v1.00/json3.ws?';
        $endpoint .= 'Key=' . urlencode($this->key) . '&';
        $endpoint .= 'Id=' . urlencode($id);

        $cache = 'addressUS.' . $id;

        return $this->getData($endpoint, $cache);
    }

    private function getData($endpoint, $cache = false) {

        if ($cache && isset($this->cache)) {
            $data = $this->cache->get('postcode_anywhere.' . $cache);

            if ($data)
                return $data;
        }

        $ctx = stream_context_create(array('http' => array('timeout' => $this->timeout)));

        $json = @file_get_contents($endpoint, 0, $ctx);

        if ($json) {
            $data = json_decode($json);

            if (json_last_error() == JSON_ERROR_NONE) {
                if (isset($data->Items[0]->Error)) {
                    $this->setError($data->Items[0]->Error, $data->Items[0]->Description);
                    return false;
                }

                if ($cache && isset($this->cache))
                    $this->cache->set('postcode_anywhere.' . $cache, $data);

                return $data;
            } else {
                switch (json_last_error()) {
                    case JSON_ERROR_DEPTH:
                        $this->setError(json_last_error(), 'Maximum stack depth exceeded');
                        break;
                    case JSON_ERROR_STATE_MISMATCH:
                        $this->setError(json_last_error(), 'Underflow or the modes mismatch');
                        break;
                    case JSON_ERROR_CTRL_CHAR:
                        $this->setError(json_last_error(), 'Unexpected control character found');
                        break;
                    case JSON_ERROR_SYNTAX:
                        $this->setError(json_last_error(), 'Syntax error, malformed JSON');
                        break;
                    case JSON_ERROR_UTF8:
                        $this->setError(json_last_error(), 'Malformed UTF-8 characters, possibly incorrectly encoded');
                        break;
                    default:
                        $this->setError(json_last_error(), 'Unknown error');
                        break;
                }
            }
            return false;
        }
    }

    private function setError($error, $description) {

        $this->error[] = array('code' => $error,
            'description' => $description);
        
    }

}