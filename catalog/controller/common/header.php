<?php

class ControllerCommonHeader extends Controller {

    protected function index() {
        $this->data['title'] = $this->document->getTitle();

        if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
            $this->data['base'] = $this->config->get('config_ssl');
        } else {
            $this->data['base'] = $this->config->get('config_url');
        }

        $this->data['description'] = $this->document->getDescription();
        $this->data['keywords'] = $this->document->getKeywords();
        $this->data['links'] = $this->document->getLinks();
        $this->data['styles'] = $this->document->getStyles();
        $this->data['scripts'] = $this->document->getScripts();
        $this->data['lang'] = $this->language->get('code');
        $this->data['direction'] = $this->language->get('direction');
        
        $this->data['google_analytics'] = html_entity_decode($this->config->get('config_google_analytics'), ENT_QUOTES, 'UTF-8');

        // Whos Online
        if ($this->config->get('config_customer_online')) {
            $this->load->model('tool/online');

            if (isset($this->request->server['REMOTE_ADDR'])) {
                $ip = $this->request->server['REMOTE_ADDR'];
            } else {
                $ip = '';
            }

            if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
                $url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
            } else {
                $url = '';
            }

            if (isset($this->request->server['HTTP_REFERER'])) {
                $referer = $this->request->server['HTTP_REFERER'];
            } else {
                $referer = '';
            }

            $this->model_tool_online->whosonline($ip, $this->customer->getId(), $url, $referer);
        }

        $this->language->load('common/header');

        if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
            $server = HTTPS_IMAGE;
        } else {
            $server = HTTP_IMAGE;
        }

        if ($this->config->get('config_icon') && file_exists(DIR_IMAGE . $this->config->get('config_icon'))) {
            $this->data['icon'] = $server . $this->config->get('config_icon');
        } else {
            $this->data['icon'] = '';
        }

        $this->data['name'] = $this->config->get('config_name');

        if ($this->config->get('config_logo') && file_exists(DIR_IMAGE . $this->config->get('config_logo'))) {
            $this->data['logo'] = $server . $this->config->get('config_logo');
        } else {
            $this->data['logo'] = '';
        }

        if (ENVIRONMENT_WARNING) {
            $this->data['error_environment'] = 'Warning: You are currently in the <strong>' . strtoupper(APPLICATION_ENV) . '</strong> environment!';
        } else {
            $this->data['error_environment'] = '';
        }

        $this->data['text_home'] = $this->language->get('text_home');
        $this->data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
        $this->data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
        $this->data['text_search'] = $this->language->get('text_search');
        $this->data['text_welcome'] = sprintf($this->language->get('text_welcome'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
        $this->data['text_login'] = $this->language->get('text_login');
        $this->data['text_register'] = $this->language->get('text_register');
        $this->data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $this->customer->getFirstName(), $this->url->link('account/logout', '', 'SSL'));
        $this->data['text_account'] = $this->language->get('text_account');
        $this->data['text_checkout'] = $this->language->get('text_checkout');
        $this->data['text_stockist'] = $this->language->get('text_stockist');
        $this->data['text_activity'] = $this->language->get('text_activity');
        $this->data['text_activities'] = $this->language->get('text_activities');
        $this->data['text_free_delivery'] = $this->language->get('text_free_delivery');
        $this->data['text_free_returns'] = $this->language->get('text_free_returns');
        $this->data['text_blog'] = $this->language->get('text_blog');
        $this->data['text_product_registration'] = $this->language->get('text_product_registration');
        $this->data['text_follow_us'] = $this->language->get('text_follow_us');
        $this->data['text_uk'] = $this->language->get('text_uk');
        $this->data['text_us'] = $this->language->get('text_us');
        $this->data['text_brand_story'] = $this->language->get('text_brand_story');

        $this->data['home'] = $this->url->link('common/home');
        $this->data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
        $this->data['logged'] = $this->customer->isLogged();
        $this->data['account'] = $this->url->link('account/account', '', 'SSL');
        $this->data['shopping_cart'] = $this->url->link('checkout/cart');
        $this->data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');
        $this->data['login'] = $this->url->link('account/login', '', 'SSL');
        $this->data['register'] = $this->url->link('account/register', '', 'SSL');
        $this->data['stockist'] = $this->url->link('common/store_locations', '', 'SSL');
        $this->data['fb'] = $this->language->get('fb');
        $this->data['tw'] = $this->language->get('tw');
        $this->data['yb'] = $this->language->get('yb');
        $this->data['pt'] = $this->language->get('pt');
        $this->data['gp'] = $this->language->get('gp');

        if (isset($this->request->get['filter_name'])) {
            $this->data['filter_name'] = $this->request->get['filter_name'];
        } else {
            $this->data['filter_name'] = '';
        }

        // Menu
        $this->load->model('catalog/category');

        $this->load->model('catalog/product');

        $this->data['categories'] = array();

        $categories = $this->model_catalog_category->getCategories(0);

        foreach ($categories as $category) {
            if ($category['top']) {
                $children_data = array();
                $children_html = "";

                $children = $this->model_catalog_category->getCategories($category['category_id']);

                foreach ($children as $child) {
                    $data = array(
                        'filter_category_id' => $child['category_id'],
                        'filter_sub_category' => true
                    );

                    $product_total = $this->model_catalog_product->getTotalProducts($data);

                    $children_data[] = array(
//						'name'  => $child['name'] . ' (' . $product_total . ')',
                        'name' => $child['name'],
                        'href' => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
                    );
//                                        $children_html .= '<li><a href="' . $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id']) . '">'. $child['name'] . ' (' . $product_total . ')' . '</a></li>';
                    $children_html .= '<li><a href="' . $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id']) . '">' . $child['name'] . '</a></li>';
                }

                if (!$children_html == "")
                    $children_html = "<div style='min-width: 130px; padding: 5px;'><div style='float: left; text-align: left;'><ul>" . $children_html . "</ul></div></div>";

                else {
                    //If no sub categories then add attribute filter
                    $groups = $this->model_catalog_category->getCategoryAttributes($category['category_id']);
                    $children_html = "";

                    foreach ($groups as $group) {
                        if (array_key_exists('attribute_types', $group)) {
                            //TODO: Amend attribute groups to have a "Display on menu" flag
                            /*  if ($group['name']=="Menu Filters"){ */
                            $children_html = "";
                            foreach ($group['attribute_types'] as $type) {
                                $children_html .= "<div style='float: left; text-align: left;'>";
                                $children_html .= '<h3 style="margin: 4px 0px; border-bottom: 1px solid #7C217D;">' . $type['type_name'] . '</h3>';
                                $children_html .= "<ul>";
                                foreach ($type['types'] as $value) {
                                    $children = explode(",", $value);
                                    foreach ($children as $child) {
                                        $children_html .= '<li><a href="' . $this->url->link('product/category', 'path=' . $category['category_id'] . '&att_filters[' . $type['type_id'] . ']=' . urlencode(trim($child))) . '">' . trim($child) . '</a></li>';
                                    }
                                }
                                $children_html .= "</ul>";
                                $children_html .= "</div>";
                            }
                            /* } */
                        }
                    }
                    if (!$children_html == "")
                        $children_html = "<div style='min-width: 260px; padding: 5px;'>" . $children_html . "</div>";
                }
                // Level 1
                $this->data['categories'][] = array(
                    'name' => $category['name'],
                    'children' => $children_data,
                    'children_html' => $children_html,
                    'column' => $category['column'] ? $category['column'] : 1,
                    'href' => $this->url->link('product/category', 'path=' . $category['category_id'])
                );
            }
        }
        
        /**************************** MODULE CONTENT BLOCK *******************************/
        $language = $this->config->get('config_language_id');                
        
        $module_data = array();
        
        $this->load->model('setting/setting');
        
        $settings_blocks = $this->model_setting_setting->getSetting('blocks');
        if ($settings_blocks) {
            foreach ($settings_blocks as $key => $setting_blocks) {
                if ($key == 'blocks_module_header') {
                    foreach ($setting_blocks as $blocks) {
                    
                        if ($blocks['status']) {
                            $module_data[] = array(
                                    'description'   => html_entity_decode($blocks['description'][$language], ENT_QUOTES, 'UTF-8'),
                                    'sort_order'    => $blocks['sort_order']
                            );
                        }
                    }
                }
            }
        }    
        $sort_order = array(); 
	  
        foreach ($module_data as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }

        array_multisort($sort_order, SORT_ASC, $module_data);
        
        $this->data['blocks'] = array();
        
        foreach ($module_data as $module) {
            if ($module) {
                    $this->data['blocks'][] = $module;
            }
        }
        
        /**************************** END MODULE CONTENT BLOCK *******************************/

        $this->children = array(
            'module/localisation',
            'module/language',
            'module/currency',
            'module/cart',
            'common/content_banner',
            'module/megamenu'
        );

        $this->setTemplate('common/header.tpl');

        $this->render();
    }

}

?>
