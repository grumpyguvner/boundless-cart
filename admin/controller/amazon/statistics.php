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
 
class ControllerAmazonStatistics extends Controller {
	private $error = array();
    private $name = 'amazon' ;

	public function index() {
		$this->load->language('amazon/statistics');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('amazon', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL'));
		}

        /*
        For Multi Store - not implemented yet

        $this->load->model('setting/store');

        $stores = $this->model_setting_store->getStores() ;
        */
        // Languages
        //
		$this->load->model('localisation/language');

		$this->data['languages'] = $languages = $this->model_localisation_language->getLanguages();

        // Check if the module is setted up
        //
        $pass = false ;
        foreach($languages as $language)
            if ( $this->config->get('status_' . $language['code']) && $this->config->get('merchant_id_' . $language['code']) )
                  $pass = true ;

        if ( ! $pass )
        {
			$this->session->data['error'] = $this->language->get('error_not_configured');
			$this->redirect($this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL'));
        }

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');

		$this->data['entry_title'] = $this->language->get('entry_title');

		$this->data['entry_language'] = $this->language->get('entry_language');
		$this->data['entry_all'] = $this->language->get('entry_all');

		$this->data['entry_active_products'] = $this->language->get('entry_active_products');
		$this->data['entry_instock_products'] = $this->language->get('entry_instock_products');
		$this->data['entry_options'] = $this->language->get('entry_options');
		$this->data['entry_submit'] = $this->language->get('entry_submit');

        $this->data['statistics'] = $this->url->link('amazon/statistics/statistics', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['statisticsd'] = $this->url->link('amazon/statistics/statisticsd', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['css'] = HTTP_SERVER . 'view/stylesheet/' . $this->name . '/' ;  ;
        $this->data['js'] = HTTP_SERVER . 'view/javascript/' . $this->name . '/' ;

		$this->data['button_back'] = $this->language->get('button_back');


		$this->data['tab_general'] = $this->language->get('tab_general');

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
			'href'      => $this->url->link('amazon/statistics', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['cancel'] = $this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['google_sitemap_status'])) {
			$this->data['google_sitemap_status'] = $this->request->post['google_sitemap_status'];
		} else {
			$this->data['google_sitemap_status'] = $this->config->get('google_sitemap_status');
		}

		$this->data['data_feed'] = HTTP_CATALOG . 'index.php?route=amazon/statistics';

		$this->template = 'amazon/statistics.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());
	}

    public function statistics()
    {
  		$this->load->model('amazon/statistics');
        $this->load->language('amazon/statistics');

        $options = $this->request->post ;

        $this->data['entry_description'] = $this->language->get('entry_description');
        $this->data['entry_value_qty'] = $this->language->get('entry_value_qty');
        $this->data['entry_percent'] = $this->language->get('entry_percent');
        $this->data['entry_download'] = $this->language->get('entry_download');

        // Products
        //
        $result = $this->model_amazon_statistics->getCatalogProductsQuantity($options);

        $this->data['result_value'] = $products = intval($result['total']) ;
        $this->data['entry_products'] = $this->language->get('entry_products');

        // Products without SKU
        //
        $result = $this->model_amazon_statistics->getCatalogProductsWithoutSKU($options);

        $this->data['functions'] = $this->url->link('amazon/statistics/statistics', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['products_without_sku'] = $val = $result['total'] ;

        if ( $this->data['products_without_sku'] )
                $this->data['products_without_sku_action'] = 'getCatalogProductsWithoutSKU_Download' ;
        else    $this->data['products_without_sku_action'] = '' ;

        $percent = $products > $val ? $val / $products : $products / $val ;
        $percent *= 100 ;

        $this->data['products_without_sku_percent'] = sprintf('%.02f %%', $percent) ;
        $this->data['entry_products_without_sku'] = $this->language->get('entry_products_without_sku');

        // Products without SKU/UPC
        //
        $result = $this->model_amazon_statistics->getCatalogProductsWithoutSKU_UPC($options);

        $this->data['products_without_sku_upc'] = $val = $result['total'] ;

        $percent = $products > $val ? $val / $products : $products / $val ;
        $percent *= 100 ;

        if ( $this->data['products_without_sku_upc'] )
                $this->data['products_without_sku_upc_action'] = 'getCatalogProductsWithoutSKU_UPC_Download' ;
        else    $this->data['products_without_sku_upc_action'] = '' ;

        $this->data['products_without_sku_upc_percent'] = sprintf('%.02f %%', $percent) ;
        $this->data['entry_products_without_sku_upc'] = $this->language->get('entry_products_without_sku_upc');

        // Products with Duplicate SKY
        //
        $result = $this->model_amazon_statistics->getCatalogProductsDuplicateSKU($options);

        $this->data['products_duplicate_sku'] = $val = $result['total'] ;

        $percent = $products > $val ? $val / $products : $products / $val ;
        $percent *= 100 ;

        $this->data['products_duplicate_sku_percent'] = sprintf('%.02f %%', $percent) ;
        $this->data['entry_products_duplicate_sku'] = $this->language->get('entry_products_duplicate_sku');

        if ( $this->data['products_duplicate_sku'] )
                $this->data['products_duplicate_sku_action'] = 'getCatalogProductsDuplicateSKU_Download' ;
        else    $this->data['products_duplicate_sku_action'] = '' ;

		$this->template = 'amazon/catalog_statistics.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());

    }

    //
    // Export CSV
    //
    public function statisticsd()
    {
      $options = $this->request->post ;
      $action = $this->request->post['action'] ;

      $this->load->model('amazon/statistics');
      $this->load->language('amazon/statistics');

      $contents = $this->model_amazon_statistics->$action($options);

      $fieldheader = array_keys($contents[0]) ;

      array_unshift($contents, $fieldheader);

      $tmpfile = tempnam(dirname(__FILE__), 'exportcsv');
      $fp = fopen($tmpfile, 'w');
      foreach ($contents as $item) {
        fputcsv($fp, $item, ',', '"');
      }
      fclose($fp);
      $buf = file_get_contents($tmpfile);
      @unlink($tmpfile);
      ob_clean() ;

      echo base64_encode($buf);
      die;
    }

	private function validate() {
		if (!$this->user->hasPermission('modify', 'amazon/statistics')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>