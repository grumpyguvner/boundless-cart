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
class ControllerAmazonSynchronize extends Controller {
	private $error = array();
    private $name = 'amazon' ;
    private $amazon_url = 'mws.amazonservices.' ;
    private $_cr = "<br />\n" ;
    private $debug = false ;

    const CREATE = 1 ;
    const UPDATE = 2 ;

	public function index() {
        $cr = $this->_cr ;

		$this->load->language('amazon/synchronize');

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

		$languages = $this->model_localisation_language->getLanguages();
        $this->data['languages'] = array() ;

        foreach($languages as $language)
        {
            $code = $language['code'] ;

            if ( $this->config->get('status_' . $code) && $this->config->get('merchant_id_' . $code) )
            {
                if ( $this->config->get('debug_mode_' . $code) )
                    $this->debug = true ;

                $this->data['languages'][] = $language ;
                $this->data['marketplace_' . $code] = str_replace('_', '.', $this->config->get('marketplace_' . $code)) ;
                $this->data['marketplace_url_' . $code] = str_replace('_', '.', $this->amazon_url . $this->config->get('marketplace_' . $code));

                $last_synch = $this->config->get('last_synch_' . $code) ;

                if ( $last_synch )
                {
                    $this->data['last_synch_' . $code] = $last_synch ;
                    $this->data['synch_range1_' . $code] = sprintf($this->language->get('entry_synch_range_1'), $last_synch) ;
                    $this->data['synch_range2_' . $code] = $this->language->get('entry_synch_range_2') ;
                    $this->data['synch_range_' . $code] = $this->language->get('entry_synch_range') ;
                }
                else
                {

                    $this->data['last_synch_' . $code] = null ;
                    $this->data['last_synch_never_' . $code] = $this->language->get('entry_no_last_synch');
                    $this->data['synch_range1_' . $code] = sprintf($this->language->get('entry_synch_range_1'), $last_synch) ;
                    $this->data['synch_range2_' . $code] = null ;
                    $this->data['synch_range_' . $code] = $this->language->get('entry_synch_range') ;
                }
            }
        }

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');

		$this->data['entry_title'] = $this->language->get('entry_title');

		$this->data['entry_lookup_products'] = $this->language->get('entry_lookup_products');
		$this->data['entry_product_created'] = $this->language->get('entry_product_created');
		$this->data['entry_product_updated'] = $this->language->get('entry_product_updated');
		$this->data['entry_product_deleted'] = $this->language->get('entry_product_deleted');
		$this->data['entry_product_ignored'] = $this->language->get('entry_product_ignored');

		$this->data['entry_options'] = $this->language->get('entry_options');
		$this->data['entry_synchronized'] = $this->language->get('entry_synchronized');

		$this->data['entry_submit'] = $this->language->get('entry_submit');
		$this->data['entry_lookup'] = $this->language->get('entry_lookup');

        $this->data['synchronize'] = $this->url->link('amazon/synchronize/synchronize', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['css'] = HTTP_SERVER . 'view/stylesheet/' . $this->name . '/' ;  ;
        $this->data['js'] = HTTP_SERVER . 'view/javascript/' . $this->name . '/' ;

		$this->data['button_back'] = $this->language->get('button_back');


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
			'href'      => $this->url->link('amazon/synchronize', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['cancel'] = $this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL');

		$this->template = 'amazon/synchronize.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());
	}

    public function synchronize()
    {
        $cr = $this->_cr ;
        $pass = true ;
        ob_start() ;

        $productsCreate = array() ;
        $productsUpdate = array() ;
        $productsDelete = array() ;
        $amazonProducts = array() ;
        $productsIgnore = array() ;
        $c = $u = $d = $i = 0 ;

        require_once(dirname(__FILE__) . '/functions/amazon.webservice.class.php') ;
        require_once(dirname(__FILE__) . '/functions/amazon.tools.class.php') ;

  		$this->load->model('amazon/synchronize');
        $this->load->model('amazon/categories');

        $this->load->language('amazon/synchronize');

        // Settings
        $startDate      = $this->request->post['synch-date'] ;

        // Language
        //
        $language       = $code = $this->request->post['language'] ;
        $language_id    = $this->request->post['language_id'] ;

        // MarketPlace
        $marketplace        = str_replace('_', '.', $this->config->get('marketplace_' . $code)) ;
        $marketplace_url    = str_replace('_', '.', $this->amazon_url . $this->config->get('marketplace_' . $code));

        if ( $this->config->get('debug_mode_' . $code) )
            $this->debug = true ;

        // Parameters
        //
        $out_of_stock       = $this->config->get('out_of_stock_' . $code) ;
        $price_callback     = $this->config->get('price_callback_' . $code);
        $price_formula      = $this->config->get('price_formula_' . $code);

        // Amazon Auth
        //
        $auth = array(
             'MerchantID'     => $this->config->get('merchant_id_' . $code),
             'MarketplaceID'  => $this->config->get('marketplace_id_' . $code),
             'AWSAccessKeyID' => $this->config->get('aws_key_id_' . $code),
             'SecretKey'      => $this->config->get('aws_secret_id_' . $code)
        ) ;

        // Currencies
        //
        $marketplace_currency = $this->config->get('currency_' . $code) ;

        $this->load->model('localisation/currency');

		$currencies = $this->model_localisation_currency->getCurrencies();
        $target_currency        = $currencies[$marketplace_currency]['currency_id'] ;
        $target_currency_code   = $currencies[$marketplace_currency]['code'] ;

        $source_currency_code   = $this->config->get('config_currency') ;
        $source_currency        = $currencies[$source_currency_code]['currency_id'] ;

        // Currency Class
        //
        $currency = new Currency($this->registry) ;

        // Amazon Locales
        //
        $marketPlace =
          array(
          'Region'         => $marketplace,
          'Currency'       => $target_currency_code
           ) ;

        // Initializing Amazon API
        //
        if ( ! ($amazonApi = new Service($auth, $marketPlace, $this->debug)) )
        {
          echo $this->l('Unable to login') ;
          $pass = false ;
        }
        if ( $this->debug )
            printf("DEBUG: %s(%d) - Data is %s%s", basename(__FILE__), __LINE__, nl2br(print_r($amazonApi, true)), $cr) ;


        // Fetch Amazon Categories
        //
        $categories = $this->model_amazon_categories->getCategoryList() ;

        if ( $this->debug )
            printf("DEBUG: %s(%d) - Data is %s%s", basename(__FILE__), __LINE__, nl2br(print_r($categories, true)), $cr) ;


        // Fetch Product List
        //
        $products = $this->model_amazon_synchronize->getAmazonCatalog($startDate, $out_of_stock, $language_id, $categories) ;

        if ( $this->debug )
            printf("DEBUG: %s(%d) - Data is %s%s", basename(__FILE__), __LINE__, nl2br(print_r($products, true)), $cr) ;


        if ( ! count($products) )
            if ( $this->debug )
                printf("DEBUG: %s(%d) - Data is %s%s", basename(__FILE__), __LINE__, 'No Products to export', $cr) ;

        // Main Loop
        //
        foreach($products as $product)
        {
            // Select the main Product ID
            //
            foreach( array('ean', 'upc', 'isbn', 'asin') as $kind )
            {
                if ( $product[$kind] )
                {
                  $type = strtoupper($kind);
                  $value = $kind == 'ean' ? sprintf('%013s', $product[$kind]) : $product[$kind] ;

                  if ( $this->debug )
                      printf("DEBUG: %s(%d) - Data is %s%s", basename(__FILE__), __LINE__, $type, $cr) ;
                  break ;
                }
            }

            $productPrice   = floatval($product['price']) ;
            
            $productQty     = intval($product['quantity']);
            
            if ($product['sku'])
            {
                $productSKU = $product['sku'];
            } else {
                $productSKU = $product['product_id'];
                if ($product['product_option_value_id']) {
                    $productSKU += '-' . $product['product_option_value_id'];
                }
            }

            // Convert from/to currency
            //
            $newPrice = $currency->convert($productPrice, $source_currency_code, $target_currency_code) ;

            // Price Formula
            //
            $newPrice =  Amazon_Tools::Formula($newPrice, $price_formula) ;

            // Price CallBack (see Admin > Module > Fnac)
            //
            $newPrice =  Amazon_Tools::CallBack($newPrice, $price_callback) ;
            
            // Test : is the product already exported to amazon ?
            //
            if ( ! $this->model_amazon_synchronize->isOnAmazon($productSKU, $product['language_id']) )
            {
                $amazonProducts[] = $productSKU;
                $action = self::CREATE ;
            }
            else
                $action = self::UPDATE ;

            if ( $this->debug )
                printf("DEBUG: %s(%d) - Data is %s%s", basename(__FILE__), __LINE__, "newPrice: $newPrice", $cr) ;

            // Apply Tax
            //
            if ( $product['tax_class_id'] )
            {
                $tax = $this->model_amazon_synchronize->getTaxByClassId($product['tax_class_id']) ;

                if ( isset($tax['rate']) && $tax['rate'] )
                {
                  $product_tax  = $newPrice * ($tax['rate'] / 100) ;
                  $newPrice     = $newPrice + $product_tax ;

                  if ( $this->debug )
                      printf("DEBUG: %s(%d) - Data is %s%s", basename(__FILE__), __LINE__, nl2br(print_r($tax, true)), $cr) ;
                }
            }

            //
            //  Prepare arrays to send to amazon
            //
            if ( $action == self::CREATE && $productQty >= $out_of_stock)
            {
                $productsCreate[$c]['SKU'] = $productSKU ;
                $productsCreate[$c]['ProductIDType'] = $type ;
                $productsCreate[$c]['ProductIDCode'] = $value ;
                $productsCreate[$c]['ConditionType'] = 'New';
                $productsCreate[$c]['ConditionNote'] = '' ; // Created by WS/API on ' . $currentDate;
                $productsCreate[$c]['Quantity'] = $productQty;
                $productsCreate[$c]['Price'] = $newPrice;

                if ( $this->debug )
                    printf("DEBUG: %s(%d) - Data is %s%s", basename(__FILE__), __LINE__, nl2br(print_r($productsCreate[$c], true)), $cr) ;

                $c++ ;
            }
            elseif ( $action == self::UPDATE && $productQty >= $out_of_stock)
            {
                $productsUpdate[$u]['SKU'] = $productSKU ;
                $productsUpdate[$u]['ProductIDType'] = $type ;
                $productsUpdate[$u]['ProductIDCode'] = $value ;
                $productsUpdate[$u]['ConditionType'] = 'New';
                $productsUpdate[$u]['ConditionNote'] = '' ; // Updated by WS/API on ' . $currentDate;
                $productsUpdate[$u]['Quantity'] = $productQty;
                $productsUpdate[$u]['Price'] = $newPrice;

                if ( $this->debug )
                    printf("DEBUG: %s(%d) - Data is %s%s", basename(__FILE__), __LINE__, nl2br(print_r($productsUpdate[$u], true)), $cr) ;

                $u++ ;
            }
            elseif ( $action == self::UPDATE && $productQty < $out_of_stock)
            {
                $productsUpdate[$u]['SKU'] = $productSKU ;
                $productsUpdate[$u]['ProductIDType'] = $type ;
                $productsUpdate[$u]['ProductIDCode'] = $value ;
                $productsUpdate[$u]['ConditionType'] = 'New';
                $productsUpdate[$u]['ConditionNote'] = '' ; // Updated by WS/API on ' . $currentDate;
                $productsUpdate[$u]['Quantity'] = 0 ;
                $productsUpdate[$u]['Price'] = $newPrice;

                if ( $this->debug )
                    printf("DEBUG: %s(%d) - Data is %s%s", basename(__FILE__), __LINE__, nl2br(print_r($productsUpdate[$u], true)), $cr) ;

                $u++ ;
            }
            elseif ( $action == self::CREATE && $productQty < $out_of_stock )
            {
                $productsDelete[$d]['SKU'] = $productSKU ;
                $productsDelete[$d]['ProductIDType'] = $type ;
                $productsDelete[$d]['ProductIDCode'] = $value ;

                if ( $this->debug )
                    printf("DEBUG: %s(%d) - Data is %s%s", basename(__FILE__), __LINE__, nl2br(print_r($productsDelete[$d], true)), $cr) ;

                $c++ ;
            }
            else
            {
                $productsIgnore[$i]['SKU'] = $productSKU ;
                $productsIgnore[$i]['ProductIDType'] = $type ;
                $productsIgnore[$i]['ProductIDCode'] = $value ;
                $productsIgnore[$i]['ConditionType'] = 'New';
                $productsIgnore[$i]['ConditionNote'] = '' ; // Updated by WS/API on ' . $currentDate;
                $productsIgnore[$i]['Quantity'] = 0 ;
                $productsIgnore[$i]['Price'] = $newPrice;

                if ( $this->debug )
                    printf("DEBUG: %s(%d) - Data is %s%s", basename(__FILE__), __LINE__, nl2br(print_r($productsIgnore[$i], true)), $cr) ;

                $i++ ;
            }

            echo "Product id: " . $product['product_id'] . " $type $value \n<br>";

        }
        // Synchronizing with Amazon
        //
        if ( ! isset($this->request->post['lookup']) )
        {
          if ( count($productsCreate) )
          {
            if ( ! $datas = $amazonApi->addProducts($productsCreate) )
            {
                printf('Error : query failed (%s)', nl2br(print_r($datas)) ) ;
                $pass = false ;
            }
            else
            foreach($amazonProducts as $product)
                $query = $this->db->query('INSERT INTO `'.DB_PREFIX.'amazon_products` values ( "' . $this->db->escape($product) . '",' . intval($language_id) . ')') ;
          }

          if ( count($productsUpdate) )
          {
            if ( ! $datas = $amazonApi->updateProducts($productsUpdate) )
            {
                printf('Error : query failed (%s)', nl2br(print_r($datas)) ) ;
                $pass = false ;
            }

          }

          if ( count($productsDelete) )
          {
            if ( ! $datas = $amazonApi->deleteProducts($productsDelete) )
            {
                printf( $this->l('Error : query failed (%s)'), nl2br(print_r($datas)) ) ;
                $pass = false ;
            }
          }

          // Update Synch Date
          //
          $this->load->model('setting/setting');
          $data = $this->model_setting_setting->getSetting($this->name) ;

          $data['last_synch_' . $language] = date('Y-m-d H:i:s') ;

          $this->model_setting_setting->editSetting($this->name, $data) ;
        }

        // Output JSON
        //
        $content = ob_get_clean();
        $items = array('created' => $productsCreate, 'updated' => $productsUpdate, 'deleted' => $productsDelete, 'ignored' => $productsIgnore) ;
        $count = array('created' => count($productsCreate), 'updated' => count($productsUpdate), 'deleted' => count($productsDelete), 'ignored' => count($productsIgnore)) ;
        $json  = json_encode( array('items' => $items, 'count' => $count, 'error' => ! $pass, 'some' => $content, 'debug' => $this->debug) ) ;
        $callback = isset($this->request->get['callback']) ? strval($this->request->get['callback']) : 'jsonp_' . time() ;
        echo strval($callback) . '(' . $json . ')';
        exit ;
    }

}
?>