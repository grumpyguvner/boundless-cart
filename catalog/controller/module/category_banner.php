<?php  
class ControllerModuleCategoryBanner extends Controller {
	protected function index($setting) {
		static $module = 0;
                
                $category_id = $this->category->getIdFromPath();
                
                if (!empty($category_id) && $category_id == $setting['category_id'])
                {
		
                    $this->load->model('design/banner');
                    $this->load->model('tool/image');

                    $this->document->addScript('catalog/view/javascript/jquery/jquery.cycle.js');

                    $this->data['banners'] = array();

                    $results = $this->model_design_banner->getBanner($setting['banner_id']);

                    foreach ($results as $result) {
                            if (file_exists(DIR_IMAGE . $result['image'])) {
                                    $this->data['banners'][] = array(
                                            'title' => $result['title'],
                                            'description' => $result['description'],
                                            'link'  => $result['link'],
                                            'image' => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height'])
                                    );
                            }
                    }

                    $this->data['module'] = $module++;

                    $this->setTemplate('module/category_banner.tpl');

                    $this->render();
                    
                    
                }
	}
}
?>