<?php

class ControllerModuleWelcomePopup extends Controller {

    public function index() {
        if ($this->extensions->isInstalled('welcome_popup', 'module')) {
            if (isset($this->request->get['route'])) {
                    $route = $this->request->get['route'];
            } else {
                    $route = 'common/home';
            }

            $this->load->model('design/layout');
            $layout_id = $this->model_design_layout->getLayout($route);
            
            $welcome_popup = (array)$this->config->get('welcome_popup');
            
            $sort_order = array();
		  
            foreach ($welcome_popup as $key => $value) {
                    $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $welcome_popup);
                        
            foreach ($welcome_popup as $welcome)
            {
                if ($welcome['status'] == 1 && ($welcome['layout_id'] == 0 || $welcome['layout_id'] == $layout_id))
                {
                    if (empty($welcome['site_region']) || (defined('SITE_REGION') && $welcome['site_region'] == SITE_REGION))
                    {
                        if (!isset($_COOKIE['welcome_popup_' . $welcome['unqid']]) || $_COOKIE['welcome_popup_' . $welcome['unqid']] < $welcome['timestamp'])
                        {
                            $this->language->load('module/welcome_popup');

                            $this->data['heading_title'] = $this->language->get('heading_title');

                            $this->data['content'] = html_entity_decode($welcome['description'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');

                            if (defined('SITE_REGION')) {
                                setcookie('welcome_popup_' . $welcome['unqid'], $welcome['timestamp'], time() + 60 * 60 * 24 * 30, '/' . SITE_REGION . '/', $this->request->server['HTTP_HOST']);
                            } else {
                                setcookie('welcome_popup_' . $welcome['unqid'], $welcome['timestamp'], time() + 60 * 60 * 24 * 30, '/', $this->request->server['HTTP_HOST']);
                            }
                            
                            $this->setTemplate('module/welcome_popup.tpl');

                            $this->render();
                            
                            break;
                        }
                    }
                }
            }
        }
    }
}

?>
