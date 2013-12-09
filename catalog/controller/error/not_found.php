<?php
class ControllerErrorNotFound extends Controller {
    public function index() {
        
        $this->language->load('error/not_found');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home'),
            'separator' => false
        );
        
        $route = '';

        if (isset($this->request->get['route'])) {
            $data = $this->request->get;

            unset($data['_route_']);

            $route = $data['route'];

            unset($data['route']);

            $url = '';

            if ($data) {
                $url = '&' . urldecode(http_build_query($data, '', '&'));
            }

            if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
                $connection = 'SSL';
            } else {
                $connection = 'NONSSL';
            }

            $this->data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link($route, $url, $connection),
                'separator' => $this->language->get('text_separator')
            );
        }

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_error'] = $this->language->get('text_error');

        $this->data['button_continue'] = $this->language->get('button_continue');
        $this->data['button_error_home'] = $this->language->get('button_error_home');
        $this->data['button_error_back'] = $this->language->get('button_error_back');
        $this->data['button_back'] = $this->language->get('button_back');
        
        if (count($this->data['breadcrumbs']) > 1)
            {
                $count = count($this->data['breadcrumbs']) - 2;
                $this->data['text_breadcrumb_back'] = sprintf($this->language->get('text_breadcrumb_back'), $this->data['breadcrumbs'][$count]['text']);
            } else {
                $this->data['text_breadcrumb_back'] = '';
            }

        $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . '/1.1 404 Not Found');

        $this->data['home'] = $this->url->link('common/home');
        $this->data['continue'] = $this->url->link('common/home');

        $this->setTemplate('error/not_found.tpl');

        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/content_top',
            'common/content_bottom',
            'common/footer',
            'common/header'
        );

       $this->request->get['route'] = 'error/not_found';
        
        $this->response->setOutput($this->render());
        
        if ($route)
        {
            $this->request->get['route'] = $route; 
        } else {
            unset($this->request->get['route']);
        }
        
    }

}

?>