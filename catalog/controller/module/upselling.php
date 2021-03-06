<?php

class ControllerModuleUpselling extends Controller {

    protected function index($setting) {
        $this->language->load('module/upselling');

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['button_cart'] = $this->language->get('button_cart');

        $this->load->model('catalog/product');

        $this->load->model('tool/image');

        $this->load->model('module/upselling');

        $this->data['products'] = array();

        $upselling_products = $this->model_module_upselling->getUpsellingProducts();

        foreach ($upselling_products as $result) {
            if ($result['image']) {
                if ($this->config->get('config_image_related_adjustment') == 'crop') {
                    $image = $this->model_tool_image->cropsize($result['image'], $setting['image_width'], $setting['image_height']);
                } else {
                    $image = $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height']);
                }
            } else {
                $image = false;
            }

            if (!$this->config->get('config_block_buy') && (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price'))) {
                $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $price = false;
            }

            if ((float) $result['special']) {
                $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $special = false;
            }

            if ($this->config->get('config_review_status')) {
                $rating = (int) $result['rating'];
            } else {
                $rating = false;
            }

            $this->data['products'][] = array(
                'product_id' => $result['product_id'],
                'thumb' => $image,
                'name' => $result['name'],
                'price' => $price,
                'special' => $special,
                'saving_percent' => $result['saving_percent'],
                'new' => $result['new'],
                'sale' => $result['sale'],
                'rating' => $rating,
                'reviews' => sprintf($this->language->get('text_reviews'), (int) $result['reviews']),
                'href' => $this->url->link('product/product', 'product_id=' . $result['product_id']),
            );
        }

        $this->setTemplate('module/upselling.tpl');

        $this->render();
    }

}

?>