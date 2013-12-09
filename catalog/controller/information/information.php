<?php

class ControllerInformationInformation extends Controller {

    public function index() {
        $this->language->load('information/information');

        $this->load->model('catalog/information');

        $this->data['breadcrumbs'] = array();

        $this->load->model('tool/image');


        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home'),
            'separator' => false
        );

        if (isset($this->request->get['information_id'])) {
            $information_id = (int) $this->request->get['information_id'];
        } else {
            $information_id = 0;
        }

        $information_info = $this->model_catalog_information->getInformation($information_id);

        if ($information_info) {
            $this->document->setTitle($information_info['meta_title'] ? $information_info['meta_title'] : $information_info['title']);
            $this->document->setDescription($information_info['meta_description']);
            $this->document->setKeywords($information_info['meta_keyword']);
            $this->document->addLink($this->url->link('information/information', 'information_id=' . $information_id), 'canonical');


            $this->data['seoClass'] = preg_replace('%[^a-z0-9]%i', '', ucwords(strtolower($this->request->get['_route_'])));
            $this->data['catClass'] = preg_replace('%[^a-z0-9]%i', '', ucwords(strtolower($information_info['category'])));
            ;

            $this->data['breadcrumbs'][] = array(
                'text' => $information_info['title'],
                'href' => $this->url->link('information/information', 'information_id=' . $information_id),
                'separator' => $this->language->get('text_separator')
            );


            $this->data['heading_title'] = $information_info['title'];
            $this->data['button_continue'] = $this->language->get('button_continue');
            $this->data['text_designed'] = $this->language->get('text_designed');

            if (count($this->data['breadcrumbs']) > 1) {
                $count = count($this->data['breadcrumbs']) - 2;
                $this->data['text_breadcrumb_back'] = sprintf($this->language->get('text_breadcrumb_back'), $this->data['breadcrumbs'][$count]['text']);
            } else {
                $this->data['text_breadcrumb_back'] = '';
            }

            /*             * ************************ Added Antonio 05/02/2013 ********************* */
            if ($information_info['image']) {
                $this->data['thumb'] = $this->model_tool_image->resize($information_info['image'], $this->config->get('config_image_information_width'), $this->config->get('config_image_information_height'));
            } else {
                $this->data['thumb'] = '';
            }

            /*             * ************************ End Added Antonio 05/02/2013 ********************* */
            

            $this->data['description'] = html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');


            $this->data['continue'] = $this->url->link('common/home');

            $this->setTemplate('information/information.tpl');

            $this->children = array(
                'common/column_left',
                'common/column_right',
                'common/content_top',
                'common/content_bottom',
                'common/footer',
                'common/header'
            );

            $this->response->setOutput($this->render());
        } else {
            $this->data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_error'),
                'href' => $this->url->link('information/information', 'information_id=' . $information_id),
                'separator' => $this->language->get('text_separator')
            );

            $this->document->setTitle($this->language->get('text_error'));

            $this->data['heading_title'] = $this->language->get('text_error');

            $this->data['text_error'] = $this->language->get('text_error');

            $this->data['button_continue'] = $this->language->get('button_continue');

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

            $this->response->setOutput($this->render());
        }
    }

    public function info() {
        $this->load->model('catalog/information');

        if (isset($this->request->get['information_id'])) {
            $information_id = (int) $this->request->get['information_id'];
        } else {
            $information_id = 0;
        }

        $information_info = $this->model_catalog_information->getInformation($information_id);

        if ($information_info) {
            $output = '<html dir="ltr" lang="en">' . "\n";
            $output .= '<head>' . "\n";
            $output .= '  <title>' . $information_info['title'] . '</title>' . "\n";
            $output .= '  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">' . "\n";
            $output .= '  <meta name="robots" content="noindex">' . "\n";
            $output .= '</head>' . "\n";
            $output .= '<body>' . "\n";
            $output .= html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8') . "\n";
            $output .= '  </body>' . "\n";
            $output .= '</html>' . "\n";

            $this->response->setOutput($output);
        }
    }

}

?>
