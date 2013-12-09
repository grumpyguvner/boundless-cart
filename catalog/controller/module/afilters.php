<?php

class ControllerModuleAFilters extends Controller {

    protected function index() {

        $this->language->load('module/afilters');

        $this->data['heading_title'] = $this->language->get('heading_title');
        $this->data['text_type'] = $this->language->get('text_type');
        $this->data['text_termal_rating'] = $this->language->get('text_termal_rating');
        $this->data['text_gender'] = $this->language->get('text_gender');
        $this->data['text_activity'] = $this->language->get('text_activity');

        $this->data['text_range'] = $this->language->get('text_range');
        $this->data['text_low'] = $this->language->get('text_low');
        $this->data['text_max'] = $this->language->get('text_max');
        $this->data['text_sale_item'] = $this->language->get('text_sale_item');
        $this->data['text_new_item'] = $this->language->get('text_new_item');
        
        $this->load->model('catalog/category');

        $this->load->model('catalog/product');

        $path = $this->category->getPath();
		
        $sort = $this->category->getSort();
        $order = $this->category->getOrder();
        $page = $this->category->getPage();
        $limit = $this->category->getLimit();

        $data['filter_category_id'] = $this->category->getId();
        $data['filters'] = $this->category->getFilterData();

        $data['sort'] = $sort;

        $data['order'] = $order;
        $data['limit'] = $limit;	
        $data['start'] = ($page - 1) * $limit;

        $this->data['attributes'] = $this->model_catalog_product->getAvailableAttributeFilters($data);

        $url = $this->category->getUrlQuery();
        $this->data['href_no_filters'] = $this->url->link('product/category', 'path=' . $path . $this->category->getUrlQuery(array('att_filters','cat_filters')));

        //--------------------------------------------------------------------------------------------------
        //-------------------------------- Categories Sealskinz ------------------------------------//
        $this->data['categories'] = array();

        $categories = $this->model_catalog_category->getCategories(0);

        foreach ($categories as $category) {
            if ($category['top']) {
                $children_data = array();

                $children = $this->model_catalog_category->getCategories($category['category_id']);

                foreach ($children as $child) {
                    $children_data[] = array(
                        'category_id' => $child['category_id'],
                        'name' => $child['name'],
                        'href' => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
                    );
                }

                $this->data['categories'][] = array(
                    'category_id' => $category['category_id'],
                    'name' => $category['name'],
                    'children' => $children_data,
                    'href' => $this->url->link('product/category', 'path=' . $category['category_id'])
                );
            }
        }
        $this->data['cat_id'] = $this->category->getId();

        //-------------------------------- End Categories Sealskinz --------------------------------//       

        $this->data['href'] = $this->url->link('product/category', 'path=' . $path . $url);

        //        if (isset($big_array2)) {
        //            $this->data['attributes'] = $big_array2;
//        $filters = $this->model_catalog_category->getCategoryAttributes($this->category->getId());
//        if (isset($filters)) {
//            $this->data['attributes'] = $filters;
//        } else {
//            $this->data['attributes'] = "";
//        }

        $this->data['filters'] = $this->category->getFilterData();
                        
        $this->data['sort'] = $sort;
        $this->data['order'] = $order;
        $this->data['page'] = $order;
        $this->data['limit'] = $limit;


        $this->setTemplate('module/afilters.tpl');



        $this->render();
    }

}

?>