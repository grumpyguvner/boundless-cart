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
			'href'      => $this->url->link('common/home'),
			'text'      => $this->language->get('text_home'),
			'separator' => FALSE
		);
		
		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/store_locations'),
			'text'      => $this->language->get('heading_title'),
			'separator' => $this->language->get('text_separator')
		);
		
	   	$this->data['heading_title'] = $this->language->get('heading_title');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->data['store_loc_find_store'] = $this->language->get('store_loc_find_store');
                $this->data['store_loc_radius'] = $this->language->get('store_loc_radius');
		$this->data['store_loc_no_store'] = $this->language->get('store_loc_no_store');
		$this->data['store_loc_txt_add'] = $this->language->get('store_loc_txt_add');
		
		$this->data['actionURL'] = $this->url->link('common/store_locations');
		
		$MAP_OBJECT = new GoogleMapAPI();
		$MAP_OBJECT->width = $this->config->get('store_locations_mWidth') . 'px'; 
		$MAP_OBJECT->height = $this->config->get('store_locations_mHeight') . 'px';  		
		$MAP_OBJECT->_minify_js = FALSE;//isset($_REQUEST["min"])?FALSE:TRUE;
		if( $this->config->get('store_locations_image_icon') != "") {
			$MAP_OBJECT->setMarkerIcon($this->model_tool_image->resize( $this->config->get('store_locations_image_icon'),32,32));
		}

		$this->load->model('module/store_locations');
		$cords = array();
		
		
		//getting request when sepecific place is searched
		if (isset($this->request->get['address']) && strlen($this->request->get['address']) > 0  && isset($this->request->get['distance'])) {
			$cords = $MAP_OBJECT->getGeocode($this->request->get['address']);
			$Locations = $this->model_module_store_locations->getListNearBy(0,0, $cords, $this->request->get['distance']);
			$this->data['address'] = $this->request->get['address'];
			$this->data['distance'] = $this->request->get['distance'];
			$this->data['detectLoc'] = "";
		}
		// getting the request when auto detect location by browser
		else if( isset($this->request->get['lat']) && isset($this->request->get['lon']) && is_numeric($this->request->get['lat']) && is_numeric($this->request->get['lon']) ) {
			$latlong = $this->request->get['lat'] . ',' . $this->request->get['lon'];
			$cords['lat'] = $this->request->get['lat'];
			$cords['lon'] = $this->request->get['lon'];
			$Locations = $this->model_module_store_locations->getListNearBy(0,0, $cords, $this->request->get['distance']);
			$addr = $MAP_OBJECT->reverseGeoCode($latlong);
			$this->data['address'] = $addr['formatted_address'];
			$this->data['distance'] = $this->request->get['distance'];
			$this->data['detectLoc'] = "";

		}
		else {
			$Locations = $this->model_module_store_locations->getList(0,0);
			$this->data['address'] = '';
			$this->data['distance'] = '100';
			$this->data['detectLoc'] = "detectLocation();";
			
		}
		
		$total = 0;
		foreach($Locations as $Location) {
			//Adding Google map marker for all locations
			$locHtml = "<b><a href='" . $this->url->link('common/location_details&loc_id=' . $Location['ID']) . "'>" . $Location['Name'] . "</a></b><br /><br />" . $Location['Address'] . "<br />Phone: " . $Location['Phone'] . "<br />email: <a href='mailto:" . $Location['Email'] . "'>" . $Location['Email'] . "</a>" ;
			
			$locHtml = $locHtml . "<br /><br /><input type='text' id='stAddress' />&nbsp<input type='button' value='" . $this->language->get('store_loc_need_dir') . "' onclick='getAdd(\"" .  $this->url->link('common/location_details&loc_id=' . $Location['ID']) . "\");' />";
			
			$MAP_OBJECT->addMarkerByAddress($Location['Address'],$Location['Name'],$locHtml);
			$total++;
		}
		
		if(isset($this->request->get['pno']) ) {
			$pageNo = $this->request->get['pno'];
			$pageNo = $pageNo <= 0  ? 1 : $pageNo;	// checking if page no zero or less than one is supplied
		}
		else {
			$pageNo = 1;
		}
		
		$perPage = $this->config->get('store_locations_per_page');
		$ctrStart = $perPage * ($pageNo - 1);
		$ctrEnd = $ctrStart + $perPage;
		
		$ctrEnd = $ctrEnd <= $total ? $ctrEnd : $total;		//checking boundary condition if the calculated last record for current page increases the total no of records
		
		$noOfPages = $total / $perPage;
		$this->data['noOfPages'] = $noOfPages;
		$this->data['pageLink'] = $this->url->link('common/store_locations&address=' . $this->data['address'] . '&distance=' . $this->data['distance']);
		
		$this->data['Locations'] = array();
		
		if (count($cords) > 0) {
			$Locations = $this->model_module_store_locations->getListNearBy($ctrStart,$perPage, $cords,$this->data['distance']);
		}
		else {
			$Locations = $this->model_module_store_locations->getList($ctrStart,$perPage);
		}
		//$Locations = $this->model_module_store_locations->getList($ctrStart,$perPage);
		$counter = 0;
		foreach($Locations as $Location) {
			
			$Location['href'] = $this->url->link('common/location_details&loc_id=' . $Location['ID']);
			$images = $this->model_module_store_locations->getLocationImages($Location['ID']);
			if(isset($images[0])) {
				$Location['thumb'] = $this->model_tool_image->resize($images[0]['image'], $this->config->get('store_locations_iaWidth'), $this->config->get('store_locations_iaHeight'));
			} else {
				$Location['thumb'] = $this->model_tool_image->resize('no_image.jpg', 80, 80);
			}
			$this->data['Locations'][$counter] = $Location;
			$counter++;
		}
		
		
		//start - google map code
		$this->data['gmapHeaderJS'] = $MAP_OBJECT->getHeaderJS();
		$this->data['gmapJS'] = $MAP_OBJECT->getMapJS();
		$this->data['gmapJS'] = $this->data['gmapJS'] . "<!-- Generated for OpenCart using Store Locations module by Asif Mahmood (asif.mahmood@gmail.com) \r\n download your copy from http://www.opencart.com/index.php?route=extension/extension/info&extension_id=3151 -->";
		
		$this->data['gmaponLoad'] =$MAP_OBJECT->getOnLoad();
		$this->data['gmapHtml'] = $MAP_OBJECT->getMap();
		$this->data['gmapSideBar'] =$MAP_OBJECT->getSidebar();
     	//End - google map code
		
		
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
	
	
	
	private function validate() {
		

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}
}
?>