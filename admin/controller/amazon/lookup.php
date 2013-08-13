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

class ControllerAmazonLookup extends Controller {
	private $error = array();
    private $name = 'amazon' ;
    private $amazon_url = 'mws.amazonservices.' ;

	public function index() {
		$this->load->language('amazon/lookup');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

        /*
        For Multi Store - not implemented yet

        $this->load->model('setting/store');

        $stores = $this->model_setting_store->getStores() ;
        */
        $this->load->model('catalog/category');

		$this->data['entry_categories'] = $this->language->get('entry_categories');

        $this->data['categories'] = array();
        $this->data['selected'] = array();

		$results = $this->model_catalog_category->getCategories(0);

		foreach ($results as $result) {
			$this->data['categories'][] = array(
				'id' => $result['category_id'],
				'name'        => $result['name'],
			);
		}

        // Languages
        //
		$this->load->model('localisation/language');

		$languages = $this->model_localisation_language->getLanguages();
        $this->data['languages'] = array() ;
        $pass = false ;

        foreach($languages as $language)
        {
            $code = $language['code'] ;

            if ( $this->config->get('status_' . $code) && $this->config->get('merchant_id_' . $code) )
            {
                $this->data['languages'][] = $language ;

                $this->data['marketplace_' . $code] = str_replace('_', '.', $this->config->get('marketplace_' . $code));
                $this->data['marketplace_url_' . $code] = str_replace('_', '.', $this->amazon_url . $this->config->get('marketplace_' . $code));

                $this->data['adv_key_' . $code] =$this->config->get('adv_key_' . $code);
                $this->data['adv_secret_key_' . $code] = $this->config->get('adv_secret_key_' . $code);

                if ( $this->config->get('adv_key_' . $code) )   $pass = true ;
            }
        }

        if ( ! $pass )
        {
			$this->session->data['error'] = $this->language->get('error_not_configured');
			$this->redirect($this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');

		$this->data['entry_title'] = $this->language->get('entry_title');

		$this->data['entry_types'] = $this->language->get('entry_types');
		$this->data['entry_value'] = $this->language->get('entry_value');
		$this->data['entry_type_ean'] = $this->language->get('entry_type_ean');
		$this->data['entry_type_upc'] = $this->language->get('entry_type_upc');
		$this->data['entry_type_isbn'] = $this->language->get('entry_type_isbn');
		$this->data['entry_type_asin'] = $this->language->get('entry_type_asin');

		$this->data['entry_choose_category'] = $this->language->get('entry_choose_category');

		$this->data['entry_submit'] = $this->language->get('entry_submit');

        $this->data['lookup'] = $this->url->link('amazon/lookup/lookup', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['create'] = $this->url->link('amazon/lookup/create', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['css'] = HTTP_SERVER . 'view/stylesheet/' . $this->name . '/' ;  ;
        $this->data['js'] = HTTP_SERVER . 'view/javascript/' . $this->name . '/' ;

		$this->data['button_back'] = $this->language->get('button_back');
		$this->data['button_lookup'] = $this->language->get('button_lookup');
		$this->data['button_create'] = $this->language->get('button_create');

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
			'href'      => $this->url->link('amazon/lookup', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['cancel'] = $this->url->link('extension/amazon', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['google_sitemap_status'])) {
			$this->data['google_sitemap_status'] = $this->request->post['google_sitemap_status'];
		} else {
			$this->data['google_sitemap_status'] = $this->config->get('google_sitemap_status');
		}

		$this->data['data_feed'] = HTTP_CATALOG . 'index.php?route=amazon/lookup';

		$this->template = 'amazon/lookup.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());
	}

    public function lookup()
    {
        ob_start() ;

        require_once(dirname(__FILE__) . '/functions/lookup.php') ;

        $amazonApi = new Amazon_Fetch($this->request->post['marketplace'],  $this->request->post['adv_key'], $this->request->post['adv_secret_key']) ;

        switch($type = $this->request->post['type'])
        {
            case 'EAN' :
                $value = sprintf('%013s', $this->request->post['value']) ;
                break ;
            case 'UPC' :
                $value = intval($this->request->post['value']) ;
                break ;
            case 'ISBN' :
            case 'ASIN' :
                $value = strval($this->request->post['value']) ;
                break ;
            default :
                echo "The type must be set" ;
                die;
        }

        if ( $data = $amazonApi->fetch($type, $value) )
        {
            $category = '' ;

            if ( isset($data['Title']) )
            {

              echo '<h1>' . $data['Title'] . '</h1><br /><br /><br /><br /><br /><br /><br />' ;
              $image = '';
              $paragraphs = '';
              foreach($data as $key=>$val){

                if ( $key == 'nodes') continue ;
                if ( $key == 'review_short') continue ;

                echo "<li><b>".$key.": </b> \n";

                if ( $key == 'review' )
                {
                  $items = explode("\n", str_replace('. ', ". \n", $val));
                  for ($i = 0; $i < count ($items); $i++)
                  $paragraphs .= "<p>" . $items[$i] . "</p>\n";

                  echo $paragraphs ;

                  continue ;
                }
                $images = '' ;
                if(is_array($val)){
                    echo "<ul>\n";
                    foreach($val as $key2=>$val2){

                        if(is_array($val2))
                        {
                          foreach($val2 as $key => $item)
                          if ( $key == 'URL' )
                          {
                                $images .= '<img src="'.$item.'" class="image" />';
                          }
                        }
                        else
                        {
                            echo "<li>".$key2.": \n";
                            echo $val2;
                            echo "</li>\n";
                        }

                    }
                    echo "</ul>\n";
                } else {
                    echo $val;
                }
                echo "</li>\n";
              }
              echo '<br /><br />' . $images ;

                $error = false ;
            }
            else
            {
                $error = true ;
            }
            $html = ob_get_clean() ;

            $json = json_encode(array('html' => $html, 'data' => $data, 'error' => false)) ;

            echo strval($this->request->get['callback']) . '(' . $json . ')';

        }
        else
        {
            $html = ob_get_clean() ;

            $json = json_encode(array('html' => '', 'data' => '', 'error' => $html)) ;

            echo strval($this->request->get['callback']) . '(' . $json . ')';
        }


        exit ;
    }

	public function create() {
        $this->load->model('catalog/product');
  		$this->load->language('amazon/lookup');
		$this->load->model('localisation/language');

        ob_start() ;

		$languages = $this->model_localisation_language->getLanguages();

    	$store_id = 0 ; // mono store at this time
        $imagesDir = DIR_IMAGE . 'amazon/' ;

        if ( ! is_dir($imagesDir) ) mkdir($imagesDir) ;

        if ( isset($this->request->post['Manufacturer']) )
        {
          $manufacturer_id = $this->_setManufacturer($this->request->post['Manufacturer']) ;
        }
        elseif ( isset($this->request->post['Brand']) )
        {
          $manufacturer_id = $this->_setManufacturer($this->request->post['Brand']) ;
        }

        // Lookup for existing product
        //
        if ( isset($this->request->post['ASIN']) && ! empty($this->request->post['ASIN']) )
        {
            $value  = $this->request->post['ASIN'] ;
            $code   = 'asin' ;
        }
        elseif ( isset($this->request->post['EAN']) && ! empty($this->request->post['EAN']) )
        {
            $value  = $this->request->post['EAN'] ;
            $code   = 'ean' ;
        }
        elseif ( isset($this->request->post['UPC']) && ! empty($this->request->post['UPC']) )
        {
            $value  = $this->request->post['UPC'] ;
            $code   = 'upc' ;
        }
        elseif ( isset($this->request->post['ISBN']) && ! empty($this->request->post['ISBN']) )
        {
            $value  = $this->request->post['ISBN'] ;
            $code   = 'isbn' ;
        }
        if ( $exists = $this->_productLookup($code, $value) )
        {
            $product_id = $exists['product_id'] ;
        }

        $language_id = intval($this->request->get['language']) ;
        $category_id = intval($this->request->get['categories']) ;
        $product_name = isset($this->request->post['Title']) ? $this->request->post['Title'] : '' ;

        $asin   = isset($this->request->post['ASIN']) ? $this->request->post['ASIN'] : '' ;
        $ean    = isset($this->request->post['EAN'])  ? $this->request->post['EAN'] : '' ;
        $upc    = isset($this->request->post['UPC'])  ? $this->request->post['UPC'] : '' ;
        $isbn   = isset($this->request->post['ISBN']) ? $this->request->post['ISBN'] : '' ;

        // Copy Image
        //
        $pictures = $this->request->post['pictures'] ;

        if ( is_array($pictures) )
        {
            $pic = 0 ;
            $additionnalPictures = array() ;

            foreach($pictures as $picture)
            {
              $originName = basename($picture['URL']) ;
              $path_parts = pathinfo($originName) ;

              // Friendly URL : Path amazon/{asin}-product-name.ext
              //
              if ( ! isset($path_parts['extension']) )
                 continue ;

              $file = strtolower($asin) . '-' . self::getFriendlyUrl($product_name) . '-' . $pic . '.' . $path_parts['extension'] ;
              $outputFile = $imagesDir . $file ;

              if ( ! file_exists($outputFile) )
                  copy($picture['URL'], $outputFile) ;

              if ( $pic == 0 )
              {
                // First Picture
                //
                $mainPicture = 'amazon/' . $file ;
              }
              else
              {
                // Additionnal Pictures
                //
                $additionnalPictures[] = 'amazon/' . $file ;
              }

              $pic ++ ;
            }
        }

        // Selling References
        //
        $ean    = isset($this->request->post['EAN']) ? $this->request->post['EAN'] : '' ;
        $upc    = isset($this->request->post['UPC']) ? $this->request->post['UPC'] : '' ;
        $isbn   = isset($this->request->post['ISBN']) ? $this->request->post['ISBN'] : '' ;
        $asin   = isset($this->request->post['ASIN']) ? $this->request->post['ASIN'] : '' ;
        $mpn    = isset($this->request->post['MPN'])  ? $this->request->post['MPN'] : '' ;
        $model  = isset($this->request->post['Model']) ? $this->request->post['Model'] : '' ;

        // Package
        //
        if ( isset($this->request->post['PackageDimensions']) )
        {
            $width   = $this->request->post['PackageDimensions']['Width'] ;
            $height  = $this->request->post['PackageDimensions']['Height'] ;
            $length  = $this->request->post['PackageDimensions']['Length'] ;
            $weight  = $this->request->post['PackageDimensions']['Weight'] ;

            self::_unset('PackageDimensions') ;
        }

        // ListPrice with the Shop Currency
        //
        $currency = new Currency($this->registry) ;

        $target_price = 0 ;
        if ( isset($this->request->post['ListPrice']) && isset($this->request->post['ListPrice']['Amount']) )
            $target_price = floatval($this->request->post['ListPrice']['Amount'] / 100) ;

        $target_currency = '' ;
        if ( isset($this->request->post['ListPrice']) && isset($this->request->post['ListPrice']['CurrencyCode']) )
            $target_currency = $this->request->post['ListPrice']['CurrencyCode'] ;
        $source_currency = $this->config->get('config_currency') ;

        if ( $target_currency )
        $price = round($currency->convert($target_price, $target_currency, $source_currency), 1) ;

        self::_unset('ListPrice') ;

        // Description
        //
        $paragraphs = '' ;

        // Main Features
        //
        if ( isset($this->request->post['Feature']) &&  is_array($this->request->post['Feature']) )
        {
            $paragraphs = '<ul>' ;
            foreach($this->request->post['Feature'] as $feature)
                $paragraphs .= '<li>' . $feature . '</li>' ;
            $paragraphs .= '</ul>' ;
        }
        self::_unset('Feature') ;

        // Full description
        //
        $items = explode("\n", str_replace('. ', ". \n", $this->request->post['review']));
        for ($i = 0; $i < count ($items); $i++)
            $paragraphs .= "<p>" . $items[$i] . "</p>\n";

        // Porduct Name
        //
        $product_name = $this->request->post['Title'] ;

        // Unset unused
        //
        self::_unset('Brand,Manufacturer,Label,Publisher,Binding,ItemDimensions,IsMemorabilia,IsAutographed,ASIN,EAN,UPC,ISBN,MPN,SKU,Model,pictures') ;
        self::_unset('review,review_short,ReleaseDate,ProductTypeName,ProductTypeSubcategory,nodes,review_short,ProductGroup,Studio,PackageQuantity,Title') ;

        $specifications = '' ;
/* uninteresting
        // All the other items as Specifications
        //
        $specifications = '<ul>' ;

        foreach($this->request->post as $key=>$val){

          $specifications .=  "<li><b>".$key.": </b> ";

          if ( is_array($val) )
          {
              $specifications .=  "<ul>\n";
              foreach($val as $key2=>$val2){

                      $specifications .=  "<li>".$key2.": ";
                      $specifications .=  $val2;
                      $specifications .=  "</li>\n";

              }
              $specifications .=  "</ul>\n";
          } else {
              $specifications .=  $val;
          }
          $specifications .=  "</li>\n";
        }

        $specifications .= '</ul>' ;
*/
        $product_description = $paragraphs . "\n"  . '<br /><br />' . $specifications . "\n" ;
    // asin ipad B00365F6EG
        if ( ! $exists )
        {

    		$this->db->query("INSERT INTO " . DB_PREFIX . "product SET
              model = '" . $this->db->escape($model) . "', ean = '" . $this->db->escape($ean) . "', upc = '" . $this->db->escape($upc) . "', isbn = '" . $this->db->escape($isbn) . "', asin = '" . $this->db->escape($asin) . "',
              quantity = '0', subtract = '1', date_available = '" . date('Y-m-d') . "', manufacturer_id = '" . (int)$manufacturer_id . "', price = '" . (float)$price . "',
              weight = '" . (float)$weight . "', weight_class_id = '2', length = '" . (float)$length . "', width = '" . (float)$width . "', height = '" . (float)$height . "', length_class_id = '2',
              status = '0', date_added = now(), image='" . $mainPicture . "'") ;

    		$product_id = $this->db->getLastId();

    		$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "'");

            $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '" . (int)$category_id . "'");

            // Additionnal Pictures
            //
    		if ( count($additionnalPictures) ) {
    			foreach ($additionnalPictures as $image) {
    				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape($image) . "'");
    			}
    		}

            // SEO / Friendly URL
            //
            $friendlyUrl = strtolower($asin) . '-' . self::getFriendlyUrl($product_name) ;

            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', keyword = '" . $this->db->escape($friendlyUrl) . "'");

            // Create for all languages except description
            //
            foreach($languages as $language)
            {
                if ( $language_id == $language['language_id'] )
                     $description = $product_description ;
                else $description = '' ;

       			$this->db->query("INSERT INTO " . DB_PREFIX . "product_description SET product_id = '" . (int)$product_id . "', language_id = '" . (int)$language['language_id']. "',
                                name = '" . $this->db->escape($product_name) . "', description = '" . $this->db->escape($description) . "'");
            }
			$message = $this->language->get('entry_created_success');
			$url = $this->url->link('catalog/product/update', 'product_id=' . $product_id . '&token=' . $this->session->data['token'], 'SSL') ;

            $edit_message = sprintf($this->language->get('entry_created_link'), $url, $url) ;

            $html = ob_get_clean() ;

            $json = json_encode(array('message' => $message, 'edit_message' => $edit_message, 'some_data' => $html)) ;

            echo strval($this->request->get['callback']) . '(' . $json . ')';
        }
        else // Update
        {
			$message = $this->language->get('entry_updated_success');
            $error = 0 ;
			$url = $this->url->link('catalog/product/update', 'product_id=' . $product_id . '&token=' . $this->session->data['token'], 'SSL') ;

            $edit_message = sprintf($this->language->get('entry_updated_link'), $url, $url) ;

            // Update for the selected language
            //
   			$result = $this->db->query("REPLACE INTO " . DB_PREFIX . "product_description SET product_id = '" . (int)$product_id . "', language_id = '" . (int)$language_id . "',
                                name = '" . $this->db->escape($product_name) . "', description = '" . $this->db->escape($product_description) . "'" );

            $html = ob_get_clean() ;

            if ( ! $result )
            {
                $message = $this->language->get('entry_updated_error');
                $error = 1 ;
            }
            $json = json_encode(array('message' => $message, 'edit_message' => $edit_message, 'some_data' => $html)) ;

            echo strval($this->request->get['callback']) . '(' . $json . ')';

        }

    }
    private function _unset($item)
    {
        $items = explode(',', $item) ;
        foreach($items as $item)
        if ( isset($this->request->post[$item]) ) unset($this->request->post[$item]) ;

    }
    private function _productLookup($code, $value)
    {
		$query = $this->db->query("SELECT DISTINCT product_id from " . DB_PREFIX . "product WHERE " . $code . " = '" . strval($value) . "'") ;

		return $query->row;
	}
    private function _setManufacturer($manufacturer) {
        $this->load->model('catalog/manufacturer');

        $results = $this->model_catalog_manufacturer->getManufacturers();

        foreach($results as $item)
        {
          if ( strtoupper($item['name']) == strtoupper($manufacturer))
            return($item['manufacturer_id']) ;
        }

        $this->model_catalog_manufacturer->addManufacturer(array('name' => $manufacturer)) ;

        return( $this->db->getLastId() ) ;
	}
    private static function getFriendlyUrl($text)
    {
      $text = mb_convert_encoding($text,'HTML-ENTITIES','UTF-8');
      $text = preg_replace( array('/&szlig;/','/&(..)lig;/','/&([aouAOU])uml;/','/&(.)[^;]*;/'),array('ss',"$1","$1".'e',"$1"),  $text);
      $text = preg_replace('/[\x00-\x1F\x21-\x2B\x3A-\x3F\x5B-\x60\x7B-\x7F]/', '', $text); // remove non printable
      $text = preg_replace('/[ \t]+/', '-', $text) ;
      $text = str_replace(array('_', ',', '.', '/', '+', '?', '&', '='), '-', $text) ;
      $text = preg_replace('/\-+/', '-', $text) ;
      return strtolower(trim($text));
    }


}
?>