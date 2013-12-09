<?php

require_once(DIR_SYSTEM . 'library/gmap/GoogleMap.php');
require_once(DIR_SYSTEM . 'library/gmap/JSMin.php');

class ControllerCommonStoreLocations extends Controller {

    private $error = array();

    public function index() {
        $this->language->load('common/store_locations');
        $this->load->model('tool/image');

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'href' => $this->url->link('common/home'),
            'text' => $this->language->get('text_home'),
            'separator' => FALSE
        );

        $this->data['breadcrumbs'][] = array(
            'href' => $this->url->link('common/store_locations'),
            'text' => $this->language->get('heading_title'),
            'separator' => $this->language->get('text_separator')
        );
        
        if (!isset($this->request->get['distance'])) $this->request->get['distance'] = 50;
        
        $limit = (int)$this->config->get('store_locations_per_page');

        if (isset($this->request->get['page'])) {
                $page = (int)$this->request->get['page'];
        } else { 
                $page = 1;
        }
        $start = ($page - 1) * $limit;

        $this->data['heading_title'] = $this->language->get('heading_title');
        $this->document->setTitle($this->language->get('heading_title'));
        $this->data['store_loc_find_store'] = $this->language->get('store_loc_find_store');
        $this->data['store_loc_radius'] = $this->language->get('store_loc_radius');
        $this->data['store_loc_no_store'] = $this->language->get('store_loc_no_store');
        $this->data['store_loc_txt_add'] = $this->language->get('store_loc_txt_add');
        $this->data['store_loc_text_miles'] = $this->language->get('store_loc_text_miles');

        $this->data['actionURL'] = $this->url->link('common/store_locations');

        $MAP_OBJECT = new GoogleMapAPI();

        $this->load->model('module/store_locations');
        $cords = array();
        
        //getting request when sepecific place is searched
        if (isset($this->request->get['lat']) && isset($this->request->get['lon']) && is_numeric($this->request->get['lat']) && is_numeric($this->request->get['lon'])) {
            
            $latlong = $this->request->get['lat'] . ',' . $this->request->get['lon'];
            $cords['lat'] = $this->request->get['lat'];
            $cords['lon'] = $this->request->get['lon'];
            $Locations = $this->model_module_store_locations->getListNearBy(0, 0, $cords, $this->request->get['distance']);
            if (isset($this->request->get['address']) && !empty($this->request->get['address']))
            {
                $this->data['address'] = $this->request->get['address'];
            } else {
                $addr = $MAP_OBJECT->reverseGeoCode($latlong);
                $this->data['address'] = $addr['formatted_address'];
            }
            $this->data['distance'] = $this->request->get['distance'];
            $this->data['detectLoc'] = "";
            
            $this->data['map_start_cords'] = $cords;
            $total_stores = count($Locations);
            
            $limit = false;
        } elseif (isset($this->request->get['address']) && strlen($this->request->get['address']) > 0) {
            $cords = $MAP_OBJECT->getGeocode($this->request->get['address']);
            $Locations = $this->model_module_store_locations->getListNearBy(0, 0, $cords, $this->request->get['distance']);
            $this->data['address'] = $this->request->get['address'];
            $this->data['distance'] = $this->request->get['distance'];
            $this->data['detectLoc'] = "";
            $total_stores = count($Locations);
            
            $this->data['map_start_cords'] = $cords;
            
            $limit = false;
        // getting the request when auto detect location by browser
        } else {
            $Locations = $this->model_module_store_locations->getList($start, $limit);
            $Map_pins = false;
            $this->data['address'] = '';
            $this->data['distance'] = $this->request->get['distance'];
            $this->data['detectLoc'] = "detectLocation();";
            $total_stores = $this->model_module_store_locations->getTotalList();
            
            $this->load->model('localisation/country');
            $country_info = $this->model_localisation_country->getCountry($this->config->get('config_country_id'));
            $this->data['map_start_address'] = $country_info['name'];
        }
        
        $url = array();
        
        if (isset($this->request->get['lat']) && is_numeric($this->request->get['lat']))
        {
            $url[] = 'lat=' . $this->request->get['lat'];
        }
        if (isset($this->request->get['lat']) && is_numeric($this->request->get['lat']))
        {
            $url[] .= 'lon=' . $this->request->get['lon'];
        }
        if (isset($this->request->get['distance']) && is_numeric($this->request->get['distance']))
        {
            $url[] .= 'distance=' . $this->request->get['distance'];
        }
        if (isset($this->request->get['address']) && !empty($this->request->get['address']))
        {
            $url[] .= 'address=' . urlencode($this->request->get['address']);
        }
        
        $this->data['ajax_url'] = $this->url->link('common/store_locations/store_locations',implode('&', $url));

        if ($limit)
        {
            $pagination = new Pagination();
            $pagination->total = $total_stores;
            $pagination->page = $page;
            $pagination->limit = $limit;
            $pagination->url = $this->url->link('common/store_locations','page={page}&' . implode('&', $url));
            $this->data['pagination'] = $pagination->render();
                        
                        if ($pagination->getPrevLink())
                        {
                            $this->document->addLink($pagination->getPrevLink(), 'prev');
                        }
                        if ($pagination->getNextLink())
                        {
                            $this->document->addLink($pagination->getNextLink(), 'next');
                        }
        } else {
            $this->data['pagination'] = '';
        }

        $this->data['Locations'] = array();
        
        foreach ($Locations as $Location) {

            $Location['href'] = $this->url->link('common/location_details&loc_id=' . $Location['ID']);
            $images = $this->model_module_store_locations->getLocationImages($Location['ID']);
            if (isset($images[0])) {
                $Location['thumb'] = $this->model_tool_image->resize($images[0]['image'], $this->config->get('store_locations_iaWidth'), $this->config->get('store_locations_iaHeight'));
            } else {
                $Location['thumb'] = $this->model_tool_image->resize('no_image.jpg', 80, 80);
            }
            $this->data['Locations'][] = $Location;
        }
        
        $this->setTemplate('common/store_locations.tpl');

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
    
    public function store_locations () {
        $this->load->model('module/store_locations');
        
        if (!isset($this->request->get['distance'])) $this->request->get['distance'] = 50;

        //getting request when sepecific place is searched
        if (isset($this->request->get['lat']) && isset($this->request->get['lon']) && is_numeric($this->request->get['lat']) && is_numeric($this->request->get['lon'])) {
            $cords['lat'] = $this->request->get['lat'];
            $cords['lon'] = $this->request->get['lon'];
            $Locations = $this->model_module_store_locations->getListNearBy(0, 0, $cords, $this->request->get['distance']);
        } elseif (isset($this->request->get['address']) && strlen($this->request->get['address']) > 0) {
            $MAP_OBJECT = new GoogleMapAPI();
            $cords = $MAP_OBJECT->getGeocode($this->request->get['address']);
            $Locations = $this->model_module_store_locations->getListNearBy(0, 0, $cords, $this->request->get['distance']); 
        } else {
            $Locations = $this->model_module_store_locations->getList(0, 0);
        }
        
        $stores = array();
        if ($Locations)
        {
            foreach ($Locations as $Location) {
                $temp = array();
                
                $temp['ID'] = $Location['ID'];
                $temp['lat'] = $Location['lat'];
                $temp['lon'] = $Location['lon'];
                $temp['html'] = '<strong>'.$Location['Name'].'</strong>';
                $address = explode(",", $Location['Address']);
                $temp['html'] .= '<br />' . implode('<br>', $address);
                if (!empty($Location['Phone'])) {
                     $temp['html'] .= '<br >'. $Location['Phone'];
                }
                if (!empty($Location['Email'])) {
                     $temp['html'] .= '<br ><a href="mailto:' . $Location['Email'] . '">' . $Location['Email'] . '</a>';
                }
                if (!empty($Location['Website'])) {
                     $temp['html'] .= '<br ><a href="http://' . $Location['Website'] . '" target="_blank">' . $Location['Website'] . '</a>';
                }
                
                $stores[] = $temp;
            }
        }

        $this->response->setOutput(json_encode($stores));
    }

    private function validate() {
        if (!$this->error) {
            return TRUE;
        } else {
            return FALSE;
        }
    }

}

?>