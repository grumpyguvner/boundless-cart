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

class ControllerAmazonOrders extends Controller {
	private $error = array();
    private $name = 'amazon' ;
    private $amazon_url = 'mws.amazonservices.' ;

    // Cron
    //
    private $_order_id ;
    private $_language ;
    private $_order ;
    private $_import_date_1 ;
    private $_import_date_2 ;

	public function index() {
		$this->load->language('amazon/orders');

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
                $this->data['languages'][] = $language ;
                $this->data['marketplace_' . $code] = str_replace('_', '.', $this->config->get('marketplace_' . $code)) ;
                $this->data['marketplace_url_' . $code] = str_replace('_', '.', $this->amazon_url . $this->config->get('marketplace_' . $code));

                if ( $last_import = $this->config->get('last_import_' . $code) )
                        $this->data['last_import_' . $code] = sprintf($this->language->get('entry_last_import'), $last_import) ;
                else    $this->data['last_import_' . $code] = $this->language->get('entry_no_last_import');


            }
        }

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');

		$this->data['entry_title'] = $this->language->get('entry_title');

		$this->data['entry_lookup_orders'] = $this->language->get('entry_lookup_orders');

        // Actions
        //
		$this->data['entry_submit']             = $this->language->get('entry_submit');
		$this->data['entry_lookup']             = $this->language->get('entry_lookup');
		$this->data['entry_retrieve']           = $this->language->get('entry_retrieve');
		$this->data['entry_import']             = $this->language->get('entry_import');
		$this->data['entry_delete_order']       = $this->language->get('entry_delete_order');


        // Selector
        //
		$this->data['entry_options'] = $this->language->get('entry_options');
		$this->data['entry_import_from']    = $this->language->get('entry_import_from');
		$this->data['entry_import_to']      = $this->language->get('entry_import_to');
		$this->data['entry_status']         = $this->language->get('entry_status');
		$this->data['entry_orders']         = $this->language->get('entry_orders');
		$this->data['entry_legend']         = $this->language->get('entry_legend');

        // Order Table
        //
		$this->data['entry_order_id']               = $this->language->get('entry_order_id');
		$this->data['entry_order_name']             = $this->language->get('entry_order_name');
		$this->data['entry_order_shipping']         = $this->language->get('entry_order_shipping');
		$this->data['entry_order_shipping_price']   = $this->language->get('entry_order_shipping_price');
		$this->data['entry_order_date']             = $this->language->get('entry_order_date');
		$this->data['entry_order_quantity']         = $this->language->get('entry_order_quantity');
		$this->data['entry_order_amount']           = $this->language->get('entry_order_amount');
		$this->data['entry_order_currency']         = $this->language->get('entry_order_currency');
		$this->data['entry_order_status']           = $this->language->get('entry_order_status');

        // Imported Products
        //
		$this->data['entry_product_status']         = $this->language->get('entry_product_status');
		$this->data['entry_product_asin']           = $this->language->get('entry_product_asin');
		$this->data['entry_product_sku']            = $this->language->get('entry_product_sku');
		$this->data['entry_product_quantity']       = $this->language->get('entry_product_quantity');
		$this->data['entry_product_name']           = $this->language->get('entry_product_name');
		$this->data['entry_product_shipping']       = $this->language->get('entry_product_shipping');
		$this->data['entry_product_currency']       = $this->language->get('entry_product_currency');
		$this->data['entry_product_price']          = $this->language->get('entry_product_price');

		$this->data['entry_add_stock_error'] = $this->language->get('entry_add_stock_error');
		$this->data['entry_add_not_exists']  = $this->language->get('entry_add_not_exists');
		$this->data['entry_add_imported']    = $this->language->get('entry_add_imported');
		$this->data['entry_add_unkwnown_error'] = $this->language->get('entry_add_unkwnown_error');

        $statuses = array('All', 'Pending', 'Unshipped', 'PartiallyShipped', 'Shipped', 'Canceled') ;
        $states = array() ;

        foreach($statuses as $status)
            $states[$status] = $this->language->get('status_' . $status) ;

        $this->data['statuses'] = $states ;

        $this->data['orders'] = $this->url->link('amazon/orders/orders', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['retrieve'] = $this->url->link('amazon/orders/retrieve', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['import'] = $this->url->link('amazon/orders/import', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['delete'] = $this->url->link('amazon/orders/delete', 'token=' . $this->session->data['token'], 'SSL');

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
			'href'      => $this->url->link('amazon/orders', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['cancel'] = $this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL');

		$this->template = 'amazon/orders.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());
	}

   public function cron()
    {
        $json_outputs = array() ;

        ob_clean() ;
        ob_start() ;

        if ( isset($this->request->post['language']) )
            $this->_language = $this->request->post['language'] ;
        else
            $this->_language = 'de' ;

        if ( isset($this->request->post['date_start']) && isset($this->request->post['date_end']) )
        {
          $this->_import_date_1 = date('c', strtotime(str_replace('-', '/', $this->request->post['date_start']))) ;
          $this->_import_date_2 = date('c', strtotime(str_replace('-', '/', $this->request->post['date_end']))) ;

          $this->_import_date_2 = str_replace('00:00:', '23:59:', $this->_import_date_2) ;
        }

        printf('Importing orders from %s to %s ' . "<br />\n", $this->_import_date_1, $this->_import_date_2) ;

        echo ob_get_clean() ;

        ob_start() ;

        $this->orders() ;

        $orders = ob_get_clean() ;

       # $json = json_decode(html_entity_decode($orders)) ;
         $json = json_decode($orders) ;
        if ( isset($this->request->get['callback']) ) unset($this->request->get['callback']) ;

        $count = 0 ;

         if ( ! $json )
         {
            echo  $json_outputs ;
            echo "no orders" ;
             exit ;
         }

         foreach($json->orders as $order)
         {
            if ( $order->OrderStatus == 'Pending' )  continue ;
            if ( $order->OrderStatus == 'Canceled' )  continue ;

            // Exists, skiping
            //
            if ( $order->OrderId )
                continue ;

            $count++ ;

            $this->_order_id = $order->AmazonOrderId ;

            ob_start() ;

            $this->retrieve() ;

            if ( ! ($output = ob_get_clean()) ) continue ;

            $products_json = json_decode($output) ;


            if ( ! isset($products_json->orders) || ! $products_json->orders )  continue ;
            if ( ! isset($products_json->orders->Items) || ! $products_json->orders->Items )  continue ;

            foreach($products_json->orders->Items as $key => $product)
            {
                $order->Items[$key] = $product ;
            }

            $this->_order = array() ;
            $this->_order[] = $order ;

            ob_start() ;
            $this->import() ;

            $json_outputs[] = ob_get_clean() ;
         }
         sleep(60) ;
         die ;
    }


    public function orders()
    {
        require_once(dirname(__FILE__) . '/functions/amazon.webservice.class.php') ;
        require_once(dirname(__FILE__) . '/functions/amazon.tools.class.php') ;

  		$this->load->model('localisation/language');
        $this->load->model('localisation/currency');

  		$this->load->model('amazon/orders');
        $this->load->language('amazon/orders');

        ob_start() ;

        $pass = true ;
        $errors = array() ;

        $languages = $this->model_localisation_language->getLanguages() ;

        // Settings
        $startDate      = isset($this->request->post['import-from']) ? $this->request->post['import-from'] : false ;
        $endDate        = isset($this->request->post['import-to']) ? $this->request->post['import-to'] : false ;

        // Today - 15 minutes de temps de latence afin d'éviter les erreur de synchro dus a l'heure systeme
        //
        if ( ! $startDate )
                $date1 = date('c', strtotime('yesterday midnight')) ;
        else    $date1 = date('c', strtotime($startDate . ' midnight + 1 minute')) ;

        if ( date('Ymd', strtotime($endDate)) == date('Ymd') || empty($endDate) )
                $date2 = date('c', strtotime('now - 15 min')) ;
        else    $date2 = date('c', strtotime($endDate . ' midnight + 1 day - 1 minute')) ;

        // Cron override
        //
        if ( $this->_import_date_1 && $this->_import_date_2 )
        {
          $date1 = $this->_import_date_1 ;
          $date2 = $this->_import_date_2 ;
        }

        // Language
        //
        $language = isset($this->request->post['language']) ? $this->request->post['language'] : $this->_language ;
        $language_id = isset($this->request->post['language_id']) ? isset($this->request->post['language_id']) : $languages[$language] ;
        $code = $language ;

        // MarketPlace
        $marketplace        = str_replace('_', '.', $this->config->get('marketplace_' . $code)) ;
        $marketplace_url    = str_replace('_', '.', $this->amazon_url . $this->config->get('marketplace_' . $code));

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
        if ( ! ($amazonApi = new Service($auth, $marketPlace, false)) )
        {
          $pass = false ;
          $errors[] = $this->language->get('error_login') ;
        }

//        $status = isset($this->request->post['status']) ? $this->request->post['status'] : 'Unshipped' ;
        $status = isset($this->request->post['status']) ? $this->request->post['status'] : 'All' ;

        if ( ! $amazonOrders = $amazonApi->GetUnshippedOrdersList($date1, $date2, $status) )
        {
          $pass = false ;
          $errors[] = $this->language->get('error_orders') ;
        }

        $count = 0 ;

        if ( ! $amazonOrders )
        {
              $pass = false ;
              $errors[] = $this->language->get('warning_nothing') ;
        }
        else
        {
          foreach($amazonOrders as $key => $order)
          {
            if ( ! $order->AmazonOrderId )  continue ;
            $count ++ ;
            // Order Exists
            //
           $amazonOrders[$key]->OrderId = $this->model_amazon_orders->orderExists($order->AmazonOrderId) ;
          }
        }
        if ( $count )
            echo $this->language->get('entry_amazon_fetch_order') ;
        else
            echo $this->language->get('entry_amazon_no_order') ;

        // Output JSON
        //
        $content = ob_get_clean();
        $json  = json_encode( array('orders' => $amazonOrders, 'count' => $count, 'error' => ! $pass, 'errors' => $errors, 'output' => $content) ) ;

        // jQuery Output or PHP Output
        //
        $callback = isset($this->request->get['callback']) ? $this->request->get['callback'] : false ;

        if ( $callback ) // jquery
        {
            echo strval($callback) . '(' . $json . ')';
            die ;
        }
        else // internal
        {
            echo $json ;
            return ;
        }
    }


    public function retrieve()
    {
  		$this->load->model('localisation/language');
        $this->load->model('localisation/currency');

  		$this->load->model('amazon/orders');
        $this->load->language('amazon/orders');

        ob_start() ;

        $pass = true ;
        $errors = array() ;

        require_once(dirname(__FILE__) . '/functions/amazon.webservice.class.php') ;
        require_once(dirname(__FILE__) . '/functions/amazon.tools.class.php') ;

        $languages = $this->model_localisation_language->getLanguages() ;

        if ( isset($this->request->post['order_id']) )
            $order_id = $this->request->post['order_id'] ;
        elseif ( intval($this->_order_id) )
            $order_id = $this->_order_id ;
        else
        {
          $pass = false ;
          $errors[] = "Error : nothing to import" ;
        }

        // Language
        //
        $language = isset($this->request->post['language']) ? $this->request->post['language'] : $this->_language ;
        $language_id = isset($this->request->post['language_id']) ? isset($this->request->post['language_id']) : $languages[$language] ;
        $code = $language ;

        // MarketPlace
        $marketplace        = str_replace('_', '.', $this->config->get('marketplace_' . $code)) ;
        $marketplace_url    = str_replace('_', '.', $this->amazon_url . $this->config->get('marketplace_' . $code));

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

		$currencies = $this->model_localisation_currency->getCurrencies();

        $target_currency        = $currencies[$marketplace_currency]['currency_id'] ;
        $target_currency_code   = $currencies[$marketplace_currency]['code'] ;

        $source_currency_code   = $this->config->get('config_currency') ;
        $source_currency        = $currencies[$source_currency_code]['currency_id'] ;

        // Amazon Locales
        //
        $marketPlace =
          array(
          'Region'         => $marketplace,
          'Currency'       => $target_currency_code
           ) ;
        // Initializing Amazon API
        //
        if ( ! ($amazonApi = new Service($auth, $marketPlace, false)) )
        {
          $pass = false ;
          $errors[] = $this->language->get('error_login') ;
        }
        if ( ! $orders = $amazonApi->getOrderById($order_id) )
        {
          $pass = false ;
          $errors[] = sprintf($this->language->get('error_retrieve'), $order_id) ;
        }

        if ( ! $orders || ! count($orders) )
        {
              $pass = false ;
              $errors[] = "Warning : nothing to import" ;
        }
        else
        // Product Exists / Available
        //
        foreach($orders->Items as $key => $product)
        {
            $product_info = $this->model_amazon_orders->isProductAvailable($product->SKU, $product->ASIN) ;

            // Not exists
            //
            if ( $product_info == false )
               $orders->Items[$key]->Status = 2 ;

            elseif ( $product_info['quantity'] < $product->QuantityOrdered )    // not enough in stock
               $orders->Items[$key]->Status = 1 ;

            elseif ( $product_info['quantity'] >= $product->QuantityOrdered ) // enough
               $orders->Items[$key]->Status = 3 ;

            else // unknown error
               $orders->Items[$key]->Status = 4 ;

            switch( $orders->Items[$key]->Status )
            {
                case 1 :
                case 3 :
                case 4 :
                $orders->Items[$key]->ProductId = $product_info['product_id'] ;
                $orders->Items[$key]->ProductModel = $product_info['model'] ;
                break ;
            }
        }
        echo $this->language->get('entry_details_ok') ;

        // Output JSON
        //
        $content = ob_get_clean();
        $json  = json_encode( array('orders' => $orders, 'error' => ! $pass, 'errors' => $errors, 'output' => $content) ) ;

        // jQuery Output or PHP Output
        //
        $callback = isset($this->request->get['callback']) ? $this->request->get['callback'] : false ;

        if ( $callback ) // jquery
        {
            echo strval($callback) . '(' . $json . ')';
            die ;
        }
        else // internal
        {
            echo $json ;
            return ;
        }
  }

  public function import()
  {
      require_once(dirname(__FILE__) . '/functions/amazon.tools.class.php') ;

      ob_start() ;

      $pass = true ;
      $errors = array() ;
      $order_data = array() ;
      $count = 0 ;

	  $this->load->model('amazon/orders');
	  $this->load->model('localisation/zone');
  	  $this->load->model('localisation/geo_zone');

      $this->load->language('amazon/orders');

      $this->load->model('localisation/language');


      $languages = $this->model_localisation_language->getLanguages() ;

      // Language
      //
      $language = isset($this->request->post['language']) ? $this->request->post['language'] : $this->_language ;
      $language_id = isset($this->request->post['language_id']) ? isset($this->request->post['language_id']) : $languages[$language]['language_id'] ;
      $code = $language ;

      // Countries
      //
      $this->load->model('localisation/country');
      $countries = $this->model_localisation_country->getCountries();

      // Currencies
      //
      $this->load->model('localisation/currency');

      $currencies = $this->model_localisation_currency->getCurrencies();

      // Attach to store (unimplemented yet)
      //
      $this->load->model('setting/store');

      $store_info = $this->model_setting_store->getStore(0);

      if ($store_info) {
      	$order_data['store_name'] = $store_info['name'];
      	$order_data['store_url'] = $store_info['url'];
      } else {
      	$order_data['store_name'] = $this->config->get('config_name');
      	$order_data['store_url'] = HTTP_CATALOG;
      }

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
      $this->session->data['currency'] = $source_currency_code ;
      $this->request->cookie['currency']  = $source_currency_code ;
      $currency = new Currency($this->registry) ;

      // Fakemail
      //
      $var = explode('@', $this->config->get('config_email')) ;
      $order_data['email'] = 'no-reply-' . rand(1000, 10000000) . '@' . $var[1] ;

      // Get JSON datas
      //
      if ( ! $this->_order_id )
      {
        $json = $this->request->post['data'];
        $json = json_decode(html_entity_decode($json)) ;
      }
      else
      {
        $json = $this->_order ;
      }

      if ( ! count($json) )
      {
            $pass = false ;
            $errors[] = $this->language->get('warning_nothing') ;
      }
      elseif ( ! $this->_order_id && ((!isset($this->request->post['orders']) || ! count($this->request->post['orders'])) || ! isset($this->request->post['products'])) )
      {
            $pass = false ;
            $errors[] = $this->language->get('warning_nothing') ;
      }
      else
      // Order Loop
      //
      foreach($json as $key => $order)
      {
        if ( ! isset($this->request->post['orders']) && ! $this->_order_id )  continue;

        if ( ! isset($order->AmazonOrderId) )  continue ;

        if ( $order->OrderStatus == 'Pending' )  continue ;
        if ( $order->OrderStatus == 'Canceled' )  continue ;

        // Skipping unselected orders
        //
        if ( isset($this->request->post['orders']) )
            if ( ! in_array($order->AmazonOrderId, $this->request->post['orders']) )    continue ;

        if ( empty($order->Address->Name) )
        {
            $pass = false ;
            $errors[] = sprintf($this->language->get('entry_import_address_empty'), $order->AmazonOrderId) ;
            continue ;
        }
        if ( empty($order->Address->City) )
        {
            $pass = false ;
            $errors[] = sprintf($this->language->get('entry_import_city_empty'), $order->AmazonOrderId) ;
            continue ;
        }
        if ( ! count($order->Items) )
        {
            $pass = false ;
            $errors[] = sprintf($this->language->get('entry_import_items_empty'), $order->AmazonOrderId) ;
            continue ;
        }

        // Filter & Split Into Firstname / Lastname
        //
        $var = Amazon_Tools::address_filter($order->Address->Name) ;
        //
        $var = trim($var) ;
        $var = substr($var, 0, 31) ;
        $var1 =  explode(' ', $var) ;
        $sz = sizeof($var1) - 1 ;
        $lastname = $var1[$sz] ;
        unset($var1[$sz]) ;
        $firstname = implode(' ', $var1) ;

        foreach($countries as $country)
            if ($country['iso_code_2'] == strtoupper(Amazon_Tools::address_filter($order->Address->CountryCode)))
                break ;

        $zone = $this->model_amazon_orders->getZoneToGeoZoneByCountryId($country['country_id']) ;

        if ( isset($zone['geo_zone_id']) && intval($zone['geo_zone_id']) )
                $tax = $this->model_amazon_orders->getTaxByGeoZoneId($zone['geo_zone_id']) ;
        else    $tax = false ;

        $invoice_prefix = $this->config->get('config_invoice_prefix') ;

		$query = $this->db->query("SELECT MAX(invoice_no) AS invoice_no FROM `" . DB_PREFIX . "order` WHERE invoice_prefix = '" . $this->db->escape($invoice_prefix) . "'");

        if ($query->row['invoice_no']) {
            $invoice_no = (int)$query->row['invoice_no'] + 1;
        } else {
            $invoice_no = 1;
        }

        $order_data['firstname']              = $firstname ;
        $order_data['lastname']               = $lastname ;
        $order_data['telephone']              = Amazon_Tools::address_filter($order->Address->Phone) ;

        $order_data['shipping_firstname']     = $firstname ;
        $order_data['shipping_lastname']      = $lastname ;
        $order_data['shipping_address_1']     = Amazon_Tools::address_filter($order->Address->AddressLine1) ;
        $order_data['shipping_address_2']     = Amazon_Tools::address_filter($order->Address->AddressLine2) ;
        $order_data['shipping_city']          = Amazon_Tools::address_filter($order->Address->City) ;
        $order_data['shipping_postcode']      = strval($order->Address->PostalCode) ;
        $order_data['shipping_country']       = $country['name'] ;
        $order_data['shipping_country_id']    = $country['country_id'] ;
        $order_data['shipping_zone']          = Amazon_Tools::address_filter($order->Address->StateOrRegion) ;
        $order_data['shipping_method']        = $this->config->get('shipping_method_' . $language) ;

        $order_data['payment_firstname']      = $order_data['shipping_firstname'] ;
        $order_data['payment_lastname']       = $order_data['shipping_lastname'] ;
        $order_data['payment_address_1']      = $order_data['shipping_address_1'] ;
        $order_data['payment_address_2']      = $order_data['shipping_address_2'] ;
        $order_data['payment_city']           = $order_data['shipping_city'] ;
        $order_data['payment_postcode']       = $order_data['shipping_postcode'] ;
        $order_data['payment_country']        = $order_data['shipping_country'] ;
        $order_data['payment_country_id']     = $order_data['shipping_country_id'] ;
        $order_data['payment_zone']           = $order_data['shipping_zone'] ;
        $order_data['payment_method']         = $this->config->get('payment_method_' . $language) ;

        $order_data['amazon_order_id']        = strval($order->AmazonOrderId) ;
        $order_data['invoice_no']             = $invoice_no ;
        $order_data['invoice_prefix']         = $invoice_prefix ;

        $order_data['total']                  = floatval($order->OrderTotalAmount) ;
        $order_data['order_status_id']        = $this->config->get('config_order_status_id') ;
        $order_data['language_id']            = $language_id ;
        $order_data['currency_id']            = $currencies[ strval($order->OrderTotalCurrency) ]['currency_id'] ;
        $order_data['currency_code']          = $currencies[ strval($order->OrderTotalCurrency) ]['code'] ;
        $order_data['currency_value']         = $currencies[ strval($order->OrderTotalCurrency) ]['value'] ;
        $order_data['date_added']             = date('Y-m-d H:i:s', strtotime(strval($order->PurchaseDate))) ;
        $order_data['date_modified']          = $order_data['date_added'] ;
        $order_data['comment']                =
            sprintf('%s<br /><b>%s</b>: %s<br /><b>%s</b>: %s<br /><b>%s</b>: %s<br /><b>%s</b>: %d<br />', $this->language->get('entry_amazon_order'),
                'AmazonOrderId', strval($order->AmazonOrderId),
                'OrderStatus', strval($order->OrderStatus),
                'ShipServiceLevel', strval($order->ShipServiceLevel),
                'NumberOfItemsUnshipped', intval($order->NumberOfItemsUnshipped)) ;

        $product_taxes = 0 ;
        $shipping_price = 0 ;
        $product_prices = 0 ;

        if ( ! ($order_id = $this->model_amazon_orders->addOrder($order_data)) )
        {
            $pass = false ;
            $errors[] = sprintf($this->language->get('entry_import_add_failed'), $order->AmazonOrderId) ;
            continue ;
        }
        $json[$key]->OrderId = $order_id ;

        // Add products to order
        //
        foreach($order->Items as $product)
        {
            if ( ! $this->_order_id )
                if ( ! in_array($order->AmazonOrderId . '_' . $product->ASIN, $this->request->post['products']) )    continue ;

            if ( ! intval($product->QuantityOrdered) )
            {
                $pass = false ;
                $errors[] = sprintf($this->language->get('entry_import_wrong_qty'), $order->AmazonOrderId, $product->ASIN) ;
                continue ;
            }
            $order_product = array() ;
            $order_product['order_id']  = intval($order_id) ;
            $order_product['asin']      = strval($product->ASIN) ;
            $order_product['sku']       = strval($product->SKU) ;
            $order_product['name']      = strval($product->Title) ;
            $order_product['quantity']  = intval($product->QuantityOrdered) ;
            $product_price = floatval($product->ItemPriceAmount) / intval($product->QuantityOrdered) ;
            $product_tax = 0 ;

            if ( $tax )
            {
                $product_tax    = $product_price * ($tax['rate'] / 100) ;
                $product_price  = $product_price - $product_tax ;
                $product_taxes += $product_tax ;
            }

            $order_product['price']     = $product_price ;
            $order_product['total']     = $product_price * $order_product['quantity'] ;
            $product_prices            += $product_price * $order_product['quantity'] ;
            $shipping_price            += floatval($product->ShippingPriceAmount) ;

            if ( isset($product->ProductId) )
                $order_product['product_id'] = intval($product->ProductId) ;

            if ( isset($product->ProductModel) )
                $order_product['model'] = strval($product->ProductModel) ;

            if ( ! $this->model_amazon_orders->addProduct($order_product) )
            {
                $pass = false ;
                $errors[] = sprintf($this->language->get('entry_import_add_product_failed'), $order->AmazonOrderId, $product->ASIN) ;
                continue ;
            }

            if ( isset($order_product['product_id']) && intval($order_product['product_id']) )
                $this->model_amazon_orders->decreaseQuantity($order_product['product_id'], intval($product->QuantityOrdered)) ;

            $count ++ ;
        }
        //
        // Order Total - Taxes
        //
        if ( $product_taxes )
        {
          $taxes = array() ;
          //$taxes['text']          = $currency->format(round($product_taxes, 2), $target_currency_code) ;
          $taxes['text']          = $currency->format(round($product_taxes, 2)) ;
          $taxes['value']         = round(floatval($product_taxes), 2) ;
          if ( isset($tax['name']) )
            $taxes['title']       = $tax['name'] ;
          else
            $taxes['title']       = $tax['description'] ;
          $taxes['code']          = 'tax' ;
          $taxes['order_id']      = $order_id ;
          $taxes['sort_order']    = $this->config->get('tax_sort_order')  ;

          if ( ! $this->model_amazon_orders->addSubTotal($taxes) )
          {
              $pass = false ;
              $errors[] = sprintf($this->language->get('entry_import_add_product_failed'), $order->AmazonOrderId, $product->ASIN) ;
              continue ;
          }
        }
        //
        // Order Total - Subtotal
        //
        $subtotal = array() ;
        $subtotal['text']          = $currency->format(floatval($product_prices + $shipping_price)) ;
        //$subtotal['text']          = $currency->format(floatval($product_prices + $shipping_price), $target_currency_code) ;
        $subtotal['value']         = floatval($product_prices + $shipping_price);
        $subtotal['code']          = 'sub_total' ;
        $subtotal['title']         = $this->language->get('entry_sub_total') ;
        $subtotal['order_id']      = $order_id ;
        $subtotal['sort_order']    = $this->config->get('sub_total_sort_order');

        if ( ! $this->model_amazon_orders->addSubTotal($subtotal) )
        {
            $pass = false ;
            $errors[] = sprintf($this->language->get('entry_import_add_product_failed'), $order->AmazonOrderId, $product->ASIN) ;
            continue ;
        }
        //
        // Order Total - Shipping
        //
        $shipping = array() ;
        //$shipping['text']          = $currency->format(floatval($shipping_price), $target_currency_code) ;
        $shipping['text']          = $currency->format(floatval($shipping_price)) ;
        $shipping['value']         = floatval($shipping_price);
        $shipping['code']          = 'shipping' ;
        $shipping['title']         = sprintf('%s (%s):', $this->config->get('shipping_method_' . $code), strval($order->ShipServiceLevel)) ;
        $shipping['order_id']      = $order_id ;
        $shipping['sort_order']    = $this->config->get('shipping_sort_order');

        if ( ! $this->model_amazon_orders->addSubTotal($shipping) )
        {
            $pass = false ;
            $errors[] = sprintf($this->language->get('entry_import_add_product_failed'), $order->AmazonOrderId, $product->ASIN) ;
            continue ;
        }

        //
        // Order Total - Total
        //
        $total = array() ;
        //$total['text']          = $currency->format(floatval($shipping_price + $product_prices + $product_taxes), $target_currency_code) ;
        $total['text']          = $currency->format(floatval($shipping_price + $product_prices + $product_taxes)) ;
        $total['value']         = floatval($shipping_price + $product_prices + $product_taxes);
        $total['code']          = 'total' ;
        $total['title']         = $this->language->get('entry_total') ;
        $total['order_id']      = $order_id ;
        $total['sort_order']    = $this->config->get('total_sort_order');

        if ( ! $this->model_amazon_orders->addSubTotal($total) )
        {
            $pass = false ;
            $errors[] = sprintf($this->language->get('entry_import_add_product_failed'), $order->AmazonOrderId, $product->ASIN) ;
            continue ;
        }

        // Order History
        //
        $history = array() ;
        $history['date_added'] = date('Y-m-d H:i:s', strtotime(strval($order->PurchaseDate))) ;
        $history['order_status_id'] = $order_data['order_status_id'] ;
        $history['order_id'] = $order_id ;
        $history['comment'] = $order_data['comment'] ;

        if ( ! $this->model_amazon_orders->addOrderHistory($history) )
        {
            $pass = false ;
            $errors[] = sprintf($this->language->get('entry_import_add_product_failed'), $order->AmazonOrderId, $product->ASIN) ;
            continue ;
        }

        // Link To Order
        //
        $link = $this->url->link('sale/order/info', 'token=' . $this->session->data['token'] . '&order_id=' . $order_id, 'SSL');

        printf($this->language->get('entry_amazon_order_imported'), strval($order->AmazonOrderId), $order_id, $link) ;
      }
      $orders = $json ;

      // Update Last Import Date
      //
      $this->load->model('setting/setting');
      $data = $this->model_setting_setting->getSetting($this->name) ;

      $date = date('Y-m-d H:i:s') ;
      $data['last_import_' . $language] = $date ;

      $import = sprintf($this->language->get('entry_last_import'), $date) ;

      $this->model_setting_setting->editSetting($this->name, $data) ;

      // Ouput JSON
      //
      $content = ob_get_clean();
      $json  = json_encode( array('order' => $orders, 'count' => $count, 'error' => ! $pass, 'errors' => $errors, 'output' => $content, 'date_import' => $import) ) ;

      // jQuery Output or PHP Output
      //
      $callback = isset($this->request->get['callback']) ? $this->request->get['callback'] : false ;

      if ( $callback ) // jquery
      {
          echo strval($callback) . '(' . $json . ')';
          die ;
      }
      else // internal
      {
          echo $json ;
          return ;
      }
  }


  public function delete()
  {
      $order_id = $this->request->post['order_id'] ;

	  $this->load->model('amazon/orders');
	  $this->load->language('amazon/orders');

      $this->model_amazon_orders->removeOrder($order_id) ;

      printf($this->language->get('entry_order_deleted'), $order_id) ;
      die;
  }
}
?>