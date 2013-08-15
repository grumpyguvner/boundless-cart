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

class ControllerAmazonConfig extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('amazon/config');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('amazon', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL'));
		}

        // Currencies
        //
        $this->load->model('localisation/currency');

		$this->data['currencies'] = $this->model_localisation_currency->getCurrencies();

        // Languages
        //
		$this->load->model('localisation/language');

		$languages = $this->model_localisation_language->getLanguages();

        $this->data['languages'] = $languages ;

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');

		$this->data['entry_status'] = $this->language->get('entry_status');

		$this->data['entry_marketplace'] = $this->language->get('entry_marketplace');
		$this->data['entry_amazon_ca'] = $this->language->get('entry_amazon_ca');
		$this->data['entry_amazon_fr'] = $this->language->get('entry_amazon_fr');
		$this->data['entry_amazon_de'] = $this->language->get('entry_amazon_de');
		$this->data['entry_amazon_it'] = $this->language->get('entry_amazon_it');
		$this->data['entry_amazon_jp'] = $this->language->get('entry_amazon_jp');
		$this->data['entry_amazon_es'] = $this->language->get('entry_amazon_es');
		$this->data['entry_amazon_us'] = $this->language->get('entry_amazon_us');
		$this->data['entry_amazon_uk'] = $this->language->get('entry_amazon_uk');

		$this->data['entry_currency'] = $this->language->get('entry_currency');

		$this->data['entry_merchant_id'] = $this->language->get('entry_merchant_id');

		$this->data['entry_merchant_id'] = $this->language->get('entry_merchant_id');
		$this->data['entry_marketplace_id'] = $this->language->get('entry_marketplace_id');
		$this->data['entry_aws_key_id'] = $this->language->get('entry_aws_key_id');
		$this->data['entry_aws_secret_id'] = $this->language->get('entry_aws_secret_id');

		$this->data['entry_adv_key'] = $this->language->get('entry_adv_key');
		$this->data['entry_adv_secret_key'] = $this->language->get('entry_adv_secret_key');

		$this->data['entry_out_of_stock'] = $this->language->get('entry_out_of_stock');
		$this->data['entry_price_formula'] = $this->language->get('entry_price_formula');
		$this->data['entry_price_callback'] = $this->language->get('entry_price_callback');
		$this->data['entry_shipping_method'] = $this->language->get('entry_shipping_method');
		$this->data['entry_payment_method'] = $this->language->get('entry_payment_method');
		$this->data['entry_debug_mode'] = $this->language->get('entry_debug_mode');

		$this->data['help_out_of_stock'] = $this->language->get('help_out_of_stock');

		$this->data['help_keypairs'] = $this->language->get('help_keypairs');
		$this->data['help_advapi'] = $this->language->get('help_advapi');

		$this->data['help_price_formula'] = $this->language->get('help_price_formula');
		$this->data['help_price_callback'] = $this->language->get('help_price_callback');
		$this->data['help_shipping_method'] = $this->language->get('help_shipping_method');
		$this->data['help_payment_method'] = $this->language->get('help_payment_method');
		$this->data['help_debug_mode'] = $this->language->get('help_debug_mode');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

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
       		'text'      => $this->language->get('text_amazon'),
			'href'      => $this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('amazon/config', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['action'] = $this->url->link('amazon/config', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL');

        foreach($languages as $language)
        {
            $code = $language['code'] ;

    		if (isset($this->request->post['status_' . $code])) {
    			$this->data['status_' . $code] = $this->request->post['status_' . $code];
    		} else {
    			$this->data['status_' . $code] = $this->config->get('status_' . $code);
    		}

    		if (isset($this->request->post['marketplace_' . $code])) {
    			$this->data['marketplace_' . $code] = $this->request->post['marketplace_' . $code];
    		} else {
    			$this->data['marketplace_' . $code] = $this->config->get('marketplace_' . $code);
    		}

            switch( $this->data['marketplace_' . $code] )
            {
              case 'com' :
                $this->data['marketplace_country_' . $code] = 'us' ;
                break ;
              case 'co_uk' :
                $this->data['marketplace_country_' . $code] = 'uk' ;
                break ;
              default :
                $this->data['marketplace_country_' . $code] = $this->data['marketplace_' . $code] ;
                break ;
            }

    		if (isset($this->request->post['currency_' . $code])) {
    			$this->data['currency_' . $code] = $this->request->post['currency_' . $code];
    		} else {
    			$this->data['currency_' . $code] = $this->config->get('currency_' . $code);
    		}

    		if (isset($this->request->post['merchant_id_' . $code])) {
    			$this->data['merchant_id_' . $code] = $this->request->post['merchant_id_' . $code];
    		} else {
    			$this->data['merchant_id_' . $code] = $this->config->get('merchant_id_' . $code);
    		}

    		if (isset($this->request->post['marketplace_id_' . $code])) {
    			$this->data['marketplace_id_' . $code] = $this->request->post['marketplace_id_' . $code];
    		} else {
    			$this->data['marketplace_id_' . $code] = $this->config->get('marketplace_id_' . $code);
    		}

    		if (isset($this->request->post['aws_key_id_' . $code])) {
    			$this->data['aws_key_id_' . $code] = $this->request->post['aws_key_id_' . $code];
    		} else {
    			$this->data['aws_key_id_' . $code] = $this->config->get('aws_key_id_' . $code);
    		}

    		if (isset($this->request->post['aws_secret_id_' . $code])) {
    			$this->data['aws_secret_id_' . $code] = $this->request->post['aws_secret_id_' . $code];
    		} else {
    			$this->data['aws_secret_id_' . $code] = $this->config->get('aws_secret_id_' . $code);
    		}

    		if (isset($this->request->post['adv_key_' . $code])) {
    			$this->data['adv_key_' . $code] = $this->request->post['adv_key_' . $code];
    		} else {
    			$this->data['adv_key_' . $code] = $this->config->get('adv_key_' . $code);
    		}

    		if (isset($this->request->post['adv_secret_key_' . $code])) {
    			$this->data['adv_secret_key_' . $code] = $this->request->post['adv_secret_key_' . $code];
    		} else {
    			$this->data['adv_secret_key_' . $code] = $this->config->get('adv_secret_key_' . $code);
    		}

    		if (isset($this->request->post['out_of_stock_' . $code])) {
    			$this->data['out_of_stock_' . $code] = $this->request->post['out_of_stock_' . $code];
    		} else {
    			$this->data['out_of_stock_' . $code] = $this->config->get('out_of_stock_' . $code);
    		}

    		if (isset($this->request->post['price_formula_' . $code])) {
    			$this->data['price_formula_' . $code] = $this->request->post['price_formula_' . $code];
    		} elseif ( ! ($value = $this->config->get('price_formula_' . $code)) ) {
    			$this->data['price_formula_' . $code] = '@ + 10%' ;
    		} else {
    			$this->data['price_formula_' . $code] = $value ;
    		}

    		if (isset($this->request->post['price_callback_' . $code])) {
    			$this->data['price_callback_' . $code] = $this->request->post['price_callback_' . $code];
    		} elseif ( ! ($value = $this->config->get('price_callback_' . $code)) ) {
    			$this->data['price_callback_' . $code] = 'number_format(round(@,1), 2, \'.\',  \'\'); ' ;
    		} else {
    			$this->data['price_callback_' . $code] = $value;
    		}

    		if (isset($this->request->post['shipping_method_' . $code])) {
    			$this->data['shipping_method_' . $code] = $this->request->post['shipping_method_' . $code];
    		} elseif ( ! ($value = $this->config->get('shipping_method_' . $code)) ) {
                $this->data['shipping_method_' . $code] = 'Amazon' ;
            }
            else {
    			$this->data['shipping_method_' . $code] = $value ;
    		}

    		if (isset($this->request->post['payment_method_' . $code])) {
    			$this->data['payment_method_' . $code] = $this->request->post['payment_method_' . $code];
            }
            elseif ( ! ($value = $this->config->get('payment_method_' . $code)) ) {
    			$this->data['payment_method_' . $code] = 'Amazon' ;
    		}
    		else {
    			$this->data['payment_method_' . $code] = $value ;
    		}

    		if (isset($this->request->post['debug_mode_' . $code])) {
    			$this->data['debug_mode_' . $code] = $this->request->post['debug_mode_' . $code];
            }
    		else {
    			$this->data['debug_mode_' . $code] = $this->config->get('debug_mode_' . $code);
    		}

        }

		$this->template = 'amazon/config.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'amazon/config')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
        $warning = '';

		$this->load->model('localisation/language');
        $languages = $this->model_localisation_language->getLanguages();

        foreach($languages as $language)
        {
           $code = $language['code'] ;
           foreach($this->request->post as $key => $val)
           {
              if  ( ! preg_match('/_' . $code . '$/', $key ) ) continue ;

              $required = 'required_' . preg_replace('/_[a-z]*$/', '', $key) ;

              $message  = $this->language->get($required) ;
              $error_required = $this->language->get('error_required') ;

              if ( $message != $required && empty($val) && $this->request->post['status_' . $code] )
                $warning .= sprintf($error_required, $message, $language['name']) . '<br />' ;
            }
        }
        $this->error['warning'] = $warning ;

        // Adding Marketplace fields - product
        //
        $fields = array() ;
        $query  = $this->db->query('show columns from `' . DB_PREFIX . 'product`') ;
        foreach($query->rows as $row)
            $fields[ $row['Field'] ] = 1 ;

        if ( !isset($fields['ean']) )
            $this->db->query('ALTER TABLE  `' . DB_PREFIX . 'product` ADD  `ean` VARCHAR( 13 ) NULL AFTER  `sku` , ADD INDEX (`ean` )') ;

        if ( !isset($fields['upc'] ) )
            $this->db->query('ALTER TABLE  `' . DB_PREFIX . 'product` ADD  `upc` VARCHAR( 12 ) NULL AFTER  `sku` , ADD INDEX (`upc` )') ;

        if ( !isset($fields['asin'] ) )
            $this->db->query('ALTER TABLE  `' . DB_PREFIX . 'product` ADD  `asin` VARCHAR( 13 ) NULL AFTER  `sku` , ADD INDEX (`asin` )') ;

        if ( !isset($fields['isbn'] ) )
            $this->db->query('ALTER TABLE  `' . DB_PREFIX . 'product` ADD  `isbn` VARCHAR( 13 ) NULL AFTER  `sku` , ADD INDEX (`isbn` )') ;

        // Adding Marketplace fields - order product
        //
        $fields = array() ;
        $query  = $this->db->query('show columns from `' . DB_PREFIX . 'order_product`') ;
        foreach($query->rows as $row)
            $fields[ $row['Field'] ] = 1 ;

        if ( !isset($fields['asin'] ) )
            $this->db->query('ALTER TABLE  `' . DB_PREFIX . 'order_product` ADD  `asin` VARCHAR( 13 ) NULL AFTER  `product_id` , ADD INDEX (`asin` )') ;

        if ( !isset($fields['sku'] ) )
            $this->db->query('ALTER TABLE  `' . DB_PREFIX . 'order_product` ADD  `sku` VARCHAR( 13 ) NULL AFTER  `asin` , ADD INDEX (`sku` )') ;

        // Adding Marketplace fields - order
        //
        $fields = array() ;
        $query  = $this->db->query('show columns from `' . DB_PREFIX . 'order`') ;
        foreach($query->rows as $row)
            $fields[ $row['Field'] ] = 1 ;

        if ( !isset($fields['amazon_order_id'] ) )
            $this->db->query('ALTER TABLE  `' . DB_PREFIX . 'order` ADD  `amazon_order_id` VARCHAR( 24 ) NULL AFTER  `payment_method` , ADD INDEX (`amazon_order_id` )') ;

        // Adding Marketplace tables
        //
        $tables = array();
        $query  = $this->db->query('show tables') ;
        foreach($query->rows as $rows)
            foreach($rows as $table)
                $tables[$table] = 1 ;

        if ( !isset($tables[DB_PREFIX .'amazon_products'] ) )
            $this->db->query("
            CREATE TABLE `" . DB_PREFIX . "amazon_products` (
              `product_id` int(11) NOT NULL,
              `language_id` int(11) NOT NULL,
              PRIMARY KEY (`product_id`,`language_id`)
            ) ;") ;


    	if ( empty($warning) ) {
			return true;
		} else {
			return false;
		}
    }
}
?>