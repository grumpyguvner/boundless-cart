<?php

class ControllerCommonFooter extends Controller {

    protected function index() {
        $this->language->load('common/footer');

        $this->data['text_categories'] = $this->language->get('text_categories'); /* Added for Sailskinz */
        $this->data['text_information'] = $this->language->get('text_information');
        $this->data['text_sizeguide'] = $this->language->get('text_sizeguide');
        $this->data['text_customerservice'] = $this->language->get('text_customerservice');
        $this->data['text_moreinformation'] = $this->language->get('text_moreinformation');
        $this->data['text_connect'] = $this->language->get('text_connect');
        $this->data['text_service'] = $this->language->get('text_service');
        $this->data['text_extra'] = $this->language->get('text_extra');
        $this->data['text_contact'] = $this->language->get('text_contact');
        $this->data['text_return'] = $this->language->get('text_return');
        $this->data['text_sitemap'] = $this->language->get('text_sitemap');
        $this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
        $this->data['text_voucher'] = $this->language->get('text_voucher');
        $this->data['text_affiliate'] = $this->language->get('text_affiliate');
        $this->data['text_special'] = $this->language->get('text_special');
        $this->data['text_account'] = $this->language->get('text_account');
        $this->data['text_order'] = $this->language->get('text_order');
        $this->data['text_wishlist'] = $this->language->get('text_wishlist');
        $this->data['text_newsletter'] = $this->language->get('text_newsletter');
        $this->data['text_description_newsletter'] = $this->language->get('text_description_newsletter');
        $this->data['text_about_us'] = $this->language->get('text_about_us');
        $this->data['text_term_conditions'] = $this->language->get('text_term_conditions');
        $this->data['text_delivery'] = $this->language->get('text_delivery');
        $this->data['text_returns'] = $this->language->get('text_returns');
        $this->data['text_privacy_policy'] = $this->language->get('text_privacy_policy');
        $this->data['text_faqs'] = $this->language->get('text_faqs');
        $this->data['text_how_works'] = $this->language->get('text_how_works');
        $this->data['text_product_care'] = $this->language->get('text_product_care');
        $this->data['text_testimonials'] = $this->language->get('text_testimonials');
        $this->data['text_stockist'] = $this->language->get('text_stockist');
        $this->data['text_international'] = $this->language->get('text_international');
        $this->data['text_ltd'] = $this->language->get('text_ltd');
        $this->data['text_nation'] = $this->language->get('text_nation');
        $this->data['store'] = $this->config->get('config_name');
        $this->data['address'] = nl2br($this->config->get('config_address'));
        $this->data['text_socks'] = $this->language->get('text_socks');
        $this->data['text_gloves'] = $this->language->get('text_gloves');
        $this->data['text_hats'] = $this->language->get('text_hats');

        /* Added for Sailskinz */

        $this->load->model('catalog/category');

        $this->data['categories'] = array();

        $categories = $this->model_catalog_category->getCategories(0);

        foreach ($categories as $category) {
            if ($category['top']) {
                $children_data = array();

                $children = $this->model_catalog_category->getCategories($category['category_id']);

                foreach ($children as $child) {
                    $children_data[] = array(
                        'name' => $child['name'],
                        'href' => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
                    );
                }

                $this->data['categories'][] = array(
                    'name' => $category['name'],
                    'children' => $children_data,
                    'href' => $this->url->link('product/category', 'path=' . $category['category_id'])
                );
            }
        }
        
        $this->load->model('catalog/ncategory');

        $this->data['ncategories'] = array();
        
        $ncategories = $this->model_catalog_ncategory->getncategories();

        foreach ($ncategories as $ncat) {

            $this->data['ncategories'][] = array(
                'ncat_id'   => $ncat['ncategory_id'],
                'name'      => $ncat['name'],
                'href'      => $this->url->link('news/ncategory', 'ncat=' . $ncat['ncategory_id'])
            );
        }
        
        /* End added for Sailskinz */

        $this->load->model('catalog/information');

        $this->data['informations'] = array();

        foreach ($this->model_catalog_information->getInformations() as $result) {
            if ($result['bottom']) {
                $this->data['informations'][] = array(
                    'title' => $result['title'],
                    'href' => $this->url->link('information/information', 'information_id=' . $result['information_id'])
                );
            }
        }

        $this->data['contact'] = $this->url->link('information/contact');
        $this->data['return'] = $this->url->link('account/return/insert', '', 'SSL');
        $this->data['sitemap'] = $this->url->link('information/sitemap');
        $this->data['manufacturer'] = $this->url->link('product/manufacturer');
        $this->data['voucher'] = $this->url->link('account/voucher', '', 'SSL');
        $this->data['allow_affiliate'] = $this->config->get('config_allow_affiliate') ? 1 : 0;
        $this->data['affiliate'] = $this->url->link('affiliate/account', '', 'SSL');
        $this->data['special'] = $this->url->link('product/special');
        $this->data['account'] = $this->url->link('account/account', '', 'SSL');
        $this->data['order'] = $this->url->link('account/order', '', 'SSL');
        $this->data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
        $this->data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');
        $this->data['stockist'] = $this->url->link('common/store_locations', '', 'SSL');

        if (ENVIRONMENT_WARNING) {
            $this->data['error_environment'] = 'Warning: You are currently in the <strong>' . strtoupper(APPLICATION_ENV) . '</strong> environment!';
        } else {
            $this->data['error_environment'] = '';
        }

        $this->data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));

        $this->setTemplate('common/footer.tpl');

        $this->render();
    }

}

?>
