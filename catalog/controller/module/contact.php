<?php  
class ControllerModuleContact extends Controller {
	protected function index() {
		
		
                $this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_contact'] = $this->language->get('text_contact');
                $this->data['text_sitemap'] = $this->language->get('text_sitemap');
                		
                $this->load->model('catalog/information');
		
		$this->data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
      		$this->data['informations'][] = array(
        		'title'      => $result['title'],
                        'sort_order' => $result['sort_order'],
	    		'href'       => $this->url->link('information/information', 'information_id=' . $result['information_id'])
      		);
    	}
		$this->data['contact'] = $this->url->link('information/contact');
                
		
		$this->setTemplate('module/contact.tpl');
		
		$this->render();
	}
}
?>