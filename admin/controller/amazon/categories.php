<?php
/* NOTICE OF LICENSE
 *
 * This source file is subject to a commercial license from SARL SMC
 * Use, copy, modification or distribution of this source file without written
 * license agreement from the SARL SMC is strictly forbidden.
 * In order to obtain a license, please contact us: olivier@common-services.com
 * ...........................................................................
 * INFORMATION SUR LA LICENCE D'UTILISATION
 *
 * L'utilisation de ce fichier source est soumise a une licence commerciale
 * concedee par la societe SMC
 * Toute utilisation, reproduction, modification ou distribution du present
 * fichier source sans contrat de licence ecrit de la part de la SARL SMC est
 * expressement interdite.
 * Pour obtenir une licence, veuillez contacter la SARL SMC a l'adresse: olivier@common-services.com
 * ...........................................................................
 * @package    Amazon Market Place
 * @copyright  Copyright (c) 2011-2011 S.A.R.L SMC (http://www.common-services.com)
 * @copyright  Copyright (c) 2011-2011 Olivier B.
 * @author     Olivier B.
 * @license    Commercial license
 * Support by mail  :  olivier@common-services.com
 * Support on forum :  delete
 * Skype : delete13_fr
 * Phone : +33.970465505
 */
class ControllerAmazonCategories extends Controller {
	private $error = array();
    private $name = 'amazon' ;
    private $amazon_url = 'mws.amazonservices.' ;

	public function index() {
		$this->load->language('amazon/categories');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('amazon', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL'));
		}

        $this->create_table() ;

        /*
        For Multi Store - not implemented yet

        $this->load->model('setting/store');

        $stores = $this->model_setting_store->getStores() ;
        */
        $this->load->model('catalog/category');

        $this->data['categories'] = array();
        $this->data['selected'] = array();

		$results = $this->model_catalog_category->getCategories(0);

        $selected_categories = array() ;

        $sql = 'SELECT category_id FROM `'.DB_PREFIX.'amazon_categories`' ;
        $query = $this->db->query($sql) ;

        foreach($query->rows as $category)
         $selected_categories[] = $category['category_id'] ;

		foreach ($results as $result) {
            if ( in_array($result['category_id'], $selected_categories) )  continue ;
			$this->data['categories'][] = array(
				'id' => $result['category_id'],
				'name'        => $result['name'],
			);
		}
		foreach ($results as $result) {
            if ( ! in_array($result['category_id'], $selected_categories) )  continue ;
			$this->data['selected'][] = array(
				'id' => $result['category_id'],
				'name'        => $result['name'],
			);
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');

		$this->data['entry_title'] = $this->language->get('entry_title');

		$this->data['entry_available_categories'] = $this->language->get('entry_available_categories');
		$this->data['entry_selected_categories'] = $this->language->get('entry_selected_categories');


        $this->data['css'] = HTTP_SERVER . 'view/stylesheet/' . $this->name . '/' ;  ;
        $this->data['js'] = HTTP_SERVER . 'view/javascript/' . $this->name . '/' ;

		$this->data['button_back'] = $this->language->get('button_back');
		$this->data['button_save'] = $this->language->get('button_save');

        $this->data['validation'] = $this->url->link('amazon/categories/validation', 'token=' . $this->session->data['token'], 'SSL');


 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_feed'),
			'href'      => $this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('amazon/categories', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['cancel'] = $this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['google_sitemap_status'])) {
			$this->data['google_sitemap_status'] = $this->request->post['google_sitemap_status'];
		} else {
			$this->data['google_sitemap_status'] = $this->config->get('google_sitemap_status');
		}

		$this->data['data_feed'] = HTTP_CATALOG . 'index.php?route=amazon/categories';

		$this->template = 'amazon/categories.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());
	}

	public function validation() {
	    $pass = true ;

		$this->load->language('amazon/categories');

		if (!$this->user->hasPermission('modify', 'amazon/categories')) {
			$this->error['warning'] = $this->language->get('error_permission');
            $pass = false ;
        }

       $pass = $this->create_table() && $pass ;

        if ( isset($this->request->post['available-categories']) )
         $available_categories = $this->request->post['available-categories'] ;
        else
         $available_categories = null ;

        if ( is_array($available_categories) )
        {
            $categories_ids = implode(',', $available_categories) ;
            $sql = 'DELETE FROM `'.DB_PREFIX.'amazon_categories` WHERE `category_id` IN (' . $categories_ids .')'  ;
            $pass =	$query = $this->db->query($sql) && $pass ;
        }
        if ( isset($this->request->post['selected-categories']) )
            $selected_categories = $this->request->post['selected-categories'] ;
        else
            $selected_categories = null ;

        if ( is_array($selected_categories) && count($selected_categories) )
        {
            foreach($selected_categories as $id_category)
            {
                if ( ! $id_category )   continue ;
                $sql = 'REPLACE INTO `'.DB_PREFIX.'amazon_categories` VALUES(' . intval($id_category) . ');' ;
                $pass = $query = $this->db->query($sql) && $pass ;
            }
        }
        if ( $pass )
          echo $this->language->get('save');
        else
          echo $this->language->get('error_save');
        exit;
	}

    private function create_table()
    {
       $sql = 'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'amazon_categories` (
                `category_id` INT NOT NULL ,
                PRIMARY KEY (  `category_id` )
                ) ' ;
       return($query = $this->db->query($sql)) ;
    }
}
?>