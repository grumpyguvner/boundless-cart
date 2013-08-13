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

 class ControllerAmazonShipping extends Controller {
	private $error = array();
    private $name = 'amazon' ;
    private $amazon_url = 'mws.amazonservices.' ;

	public function index() {
		$this->load->language('amazon/shipping');

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
                $this->data['shipping_default_' . $code] = $this->config->get('shipping_method_' . $code) ;
            }
        }

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');

		$this->data['entry_title'] = $this->language->get('entry_title');

		$this->data['entry_lookup_shipping'] = $this->language->get('entry_lookup_shipping');

        // Actions
        //
		$this->data['entry_submit']             = $this->language->get('entry_submit');
		$this->data['entry_lookup']             = $this->language->get('entry_lookup');

        // Selector
        //
		$this->data['entry_options'] = $this->language->get('entry_options');
		$this->data['entry_import_from']    = $this->language->get('entry_import_from');
		$this->data['entry_import_to']      = $this->language->get('entry_import_to');
		$this->data['entry_status']         = $this->language->get('entry_status');
		$this->data['entry_shipping']         = $this->language->get('entry_shipping');

        // Order Table
        //
		$this->data['entry_orders']                 = $this->language->get('entry_orders');
		$this->data['entry_order_name']             = $this->language->get('entry_order_name');
		$this->data['entry_order_shipping']         = $this->language->get('entry_order_shipping');
		$this->data['entry_order_shipping_price']   = $this->language->get('entry_order_shipping_price');
		$this->data['entry_order_date']             = $this->language->get('entry_order_date');
		$this->data['entry_order_status']           = $this->language->get('entry_order_status');
		$this->data['entry_shipping_status']        = $this->language->get('entry_shipping_status');
		$this->data['entry_shipping_name']          = $this->language->get('entry_shipping_name');
		$this->data['entry_shipping_id']            = $this->language->get('entry_shipping_id');

        $statuses = array('All', 'Pending', 'Unshipped', 'PartiallyShipped', 'Shipped', 'Canceled') ;
        $states = array() ;

        foreach($statuses as $status)
            $states[$status] = $this->language->get('status_' . $status) ;

        $this->data['statuses'] = $states ;

        $this->data['shipping'] = $this->url->link('amazon/shipping/shipping', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['update'] = $this->url->link('amazon/shipping/update', 'token=' . $this->session->data['token'], 'SSL');

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
			'href'      => $this->url->link('amazon/shipping', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['cancel'] = $this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL');

		$this->template = 'amazon/shipping.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());
	}

    public function shipping()
    {
        ob_start() ;
        $pass = true ;
        $errors = array() ;

        require_once(dirname(__FILE__) . '/functions/amazon.webservice.class.php') ;
        require_once(dirname(__FILE__) . '/functions/amazon.tools.class.php') ;

  		$this->load->model('amazon/shipping');

        $this->load->language('amazon/shipping');

        // Settings
        $startDate      = $this->request->post['import-from'] ;
        $endDate        = $this->request->post['import-to'] ;

        // Today - 5 minutes de temps de latence afin d'יviter les erreur de synchro dus a l'heure systeme
        //
        if ( ! $startDate )
                $date1 = date('c', strtotime('today midnight')) ;
        else    $date1 = date('c', strtotime($startDate)) ;

        if ( date('Ymd', strtotime($endDate)) == date('Ymd') || empty($endDate) )
                $date2 = date('c', strtotime('now - 5 min')) ;
        else    $date2 = date('c', strtotime($endDate)) ;

        // Language
        //
        $language       = $code = $this->request->post['language'] ;
        $language_id    = $this->request->post['language_id'] ;

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
/*
        if ( ! $amazonOrders = $amazonApi->GetUnshippedOrderList($date1, $date2, $this->request->post['status']) )
        {
          $pass = false ;
          $errors[] = $this->language->get('error_shipping') ;
        }
//        file_put_contents('amazonshipping.bin', serialize($amazonOrders));
*/

//         $amazonOrders = unserialize(file_get_contents('amazonorders.bin')) ;
        if ( ! $amazonOrders = $amazonApi->GetUnshippedOrdersList($date1, $date2, $this->request->post['status']) )
        {
          $pass = false ;
          $errors[] = $this->language->get('error_shipping') ;
        }


        $count = 0 ;

        if ( ! $amazonOrders || ! count($amazonOrders) )
        {
              $pass = false ;
              $errors[] = "Warning : nothing to import" ;
        }
        else
        {
          foreach($amazonOrders as $key => $order)
          {
            $count ++ ;
            // Order Exists
            //
           $amazonOrders[$key]->OrderId = $this->model_amazon_shipping->orderExists($order->AmazonOrderId) ;
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
        echo strval($this->request->get['callback']) . '(' . $json . ')';
        exit ;


        exit ;
    }


    public function update()
    {
        ob_start() ;
        $pass = true ;
        $errors = array() ;

        require_once(dirname(__FILE__) . '/functions/amazon.webservice.class.php') ;
        require_once(dirname(__FILE__) . '/functions/amazon.tools.class.php') ;

  		$this->load->model('amazon/shipping');

        $this->load->language('amazon/shipping');

        $order_id = $this->request->post['order_id'] ;

        // Language
        //
        $language       = $code = $this->request->post['language'] ;
        $language_id    = $this->request->post['language_id'] ;

        // Currencies
        //
        $marketplace_currency = $this->config->get('currency_' . $code) ;

        $this->load->model('localisation/currency');

        $currencies = $this->model_localisation_currency->getCurrencies();
        $target_currency        = $currencies[$marketplace_currency]['currency_id'] ;
        $target_currency_code   = $currencies[$marketplace_currency]['code'] ;

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


        if ( $amazonApi->confirmOrder($this->request->post['order_id'], $this->request->post['shipping_name'], '', $this->request->post['shipping_id']) )
        {
            printf($this->language->get('entry_update_ok'), $this->request->post['order_id']) ;
            $pass = true ;
        }
        else
        {
            printf($this->language->get('entry_update_failed'), $this->request->post['order_id']) ;
            $pass = false ;
        }

        // Output JSON
        //
        $content = ob_get_clean();
        $json  = json_encode( array('error' => ! $pass, 'errors' => $errors, 'output' => $content) ) ;
        echo strval($this->request->get['callback']) . '(' . $json . ')';
        exit ;
  }

}
?>