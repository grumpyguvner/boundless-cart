<?php  
class ControllerModuleBlocks extends Controller {
	protected function index($setting) {

		$this->data['content'] = html_entity_decode($setting['description'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
                
                $this->setTemplate('module/blocks.tpl');
		
		$this->render();

	}
}
?>