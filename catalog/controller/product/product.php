<?php  
class ControllerProductProduct extends Controller {
	private $error = array(); 
	
	public function index() { 
		$this->language->load('product/product');
	
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),			
			'separator' => false
		);
		
		$this->load->model('catalog/category');	
		
		if (isset($this->request->get['path'])) {
			$path = '';
				
			foreach (explode('_', $this->request->get['path']) as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}
				
				$category_info = $this->model_catalog_category->getCategory($path_id);
				
				if ($category_info) {
					$this->data['breadcrumbs'][] = array(
						'text'      => $category_info['name'],
						'href'      => $this->url->link('product/category', 'path=' . $path),
						'separator' => $this->language->get('text_separator')
					);
				}
			}
		}
		
		$this->load->model('catalog/manufacturer');	
		
		if (isset($this->request->get['manufacturer_id'])) {
			$this->data['breadcrumbs'][] = array( 
				'text'      => $this->language->get('text_brand'),
				'href'      => $this->url->link('product/manufacturer'),
				'separator' => $this->language->get('text_separator')
			);	
				
			$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);

			if ($manufacturer_info) {	
				$this->data['breadcrumbs'][] = array(
					'text'	    => $manufacturer_info['name'],
					'href'	    => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id']),					
					'separator' => $this->language->get('text_separator')
				);
			}
		}
		
		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_tag'])) {
			$url = '';
			
			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
						
			if (isset($this->request->get['filter_tag'])) {
				$url .= '&filter_tag=' . $this->request->get['filter_tag'];
			}
						
			if (isset($this->request->get['filter_description'])) {
				$url .= '&filter_description=' . $this->request->get['filter_description'];
			}
			
			if (isset($this->request->get['filter_category_id'])) {
				$url .= '&filter_category_id=' . $this->request->get['filter_category_id'];
			}	
						
			$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_search'),
				'href'      => $this->url->link('product/search', $url),
				'separator' => $this->language->get('text_separator')
			); 	
		}
		
		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			$product_id = 0;
		}
		
		$this->load->model('catalog/product');
		
		$product_info = $this->model_catalog_product->getProduct($product_id);
		
		if ($product_info) {
			$url = '';
			
			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}
			
			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}			

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
						
			if (isset($this->request->get['filter_tag'])) {
				$url .= '&filter_tag=' . $this->request->get['filter_tag'];
			}
			
			if (isset($this->request->get['filter_description'])) {
				$url .= '&filter_description=' . $this->request->get['filter_description'];
			}	
						
			if (isset($this->request->get['filter_category_id'])) {
				$url .= '&filter_category_id=' . $this->request->get['filter_category_id'];
			}
												
			$this->data['breadcrumbs'][] = array(
				'text'      => $product_info['name'],
				'href'      => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id']),
				'separator' => $this->language->get('text_separator')
			);			
			
			$this->document->setTitle($product_info['meta_title'] ? $product_info['meta_title'] : $product_info['name']);
			$this->document->setDescription($product_info['meta_description']);
			$this->document->setKeywords($product_info['meta_keyword']);
			$this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');
			
			$this->data['heading_title'] = $product_info['name'];
			
			$this->data['text_select'] = $this->language->get('text_select');
			$this->data['text_select_option'] = $this->language->get('text_select_option');
			$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$this->data['text_model'] = $this->language->get('text_model');
			$this->data['text_reward'] = $this->language->get('text_reward');
			$this->data['text_points'] = $this->language->get('text_points');	
			$this->data['text_discount'] = $this->language->get('text_discount');
			$this->data['text_stock'] = $this->language->get('text_stock');
			$this->data['text_price'] = $this->language->get('text_price');
                        $this->data['text_special_price'] = $this->language->get('text_special_price');
			$this->data['text_tax'] = $this->language->get('text_tax');
			$this->data['text_discount'] = $this->language->get('text_discount');
			$this->data['text_option'] = $this->language->get('text_option');
			$this->data['text_qty'] = $this->language->get('text_qty');
			$this->data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
			$this->data['text_or'] = $this->language->get('text_or');
			$this->data['text_write'] = $this->language->get('text_write');
			$this->data['text_note'] = $this->language->get('text_note');
			$this->data['text_share'] = $this->language->get('text_share');
			$this->data['text_wait'] = $this->language->get('text_wait');
			$this->data['text_tags'] = $this->language->get('text_tags');
                        $this->data['text_zoom'] = $this->language->get('text_zoom');
                        $this->data['text_save'] = $this->language->get('text_save');
                        $this->data['text_rrp'] = $this->language->get('text_rrp');
                        $this->data['text_pay'] = $this->language->get('text_pay');
                        $this->data['text_expert'] = $this->language->get('text_expert');
                        $this->data['text_question'] = $this->language->get('text_question');
                        $this->data['text_ask'] = $this->language->get('text_ask');
                        $this->data['text_rating1'] = $this->language->get('text_rating1');
                        $this->data['text_rating2'] = $this->language->get('text_rating2');
                        $this->data['text_rating3'] = $this->language->get('text_rating3');
                        $this->data['text_rating4'] = $this->language->get('text_rating4');
                        $this->data['text_rating5'] = $this->language->get('text_rating5');
                        $this->data['text_termal_rating'] = $this->language->get('text_termal_rating');
                        $this->data['text_gender'] = $this->language->get('text_gender');
                        $this->data['text_activity'] = $this->language->get('text_activity');
                        $this->data['text_filter'] = $this->language->get('text_filter');
                        $this->data['text_option_details'] = $this->language->get('text_option_details');
                        $this->data['text_write_review'] = $this->language->get('text_write_review');
			$this->data['text_buy'] = $this->language->get('text_buy');
                        $this->data['text_press'] = $this->language->get('text_press');
                        $this->data['text_view_product_info'] = $this->language->get('text_view_product_info');
                        $this->data['text_out_of_stock'] = $this->language->get('text_out_of_stock');
                        
                        if (count($this->data['breadcrumbs']) > 1)
                        {
                            $count = count($this->data['breadcrumbs']) - 2;
                            $this->data['text_breadcrumb_back'] = sprintf($this->language->get('text_breadcrumb_back'), $this->data['breadcrumbs'][$count]['text']);
                        } else {
                            $this->data['text_breadcrumb_back'] = '';
                        }
                        
			$this->data['entry_name'] = $this->language->get('entry_name');
			$this->data['entry_review'] = $this->language->get('entry_review');
			$this->data['entry_rating'] = $this->language->get('entry_rating');
			$this->data['entry_good'] = $this->language->get('entry_good');
			$this->data['entry_bad'] = $this->language->get('entry_bad');
			$this->data['entry_captcha'] = $this->language->get('entry_captcha');
			
			$this->data['button_cart'] = $this->language->get('button_cart');
                        $this->data['button_cart_pavillon'] = $this->language->get('button_cart_pavillon');
                        $this->data['button_checkout'] = $this->language->get('button_checkout');
                        $this->data['button_shopping'] = $this->language->get('button_shopping');
                        $this->data['button_checkout'] = $this->language->get('button_checkout');
			$this->data['button_wishlist'] = $this->language->get('button_wishlist');
			$this->data['button_compare'] = $this->language->get('button_compare');			
			$this->data['button_upload'] = $this->language->get('button_upload');
			$this->data['button_continue'] = $this->language->get('button_continue');
			
			$this->load->model('catalog/review');
                        
			$this->data['login'] = $this->url->link('account/login', '');

			$this->data['tab_description'] = $this->language->get('tab_description');
			$this->data['tab_attribute'] = $this->language->get('tab_attribute');
                        $this->data['tab_attribute_size'] = $this->language->get('tab_attribute_size');
                        $this->data['tab_attribute_fabric'] = $this->language->get('tab_attribute_fabric');
			$this->data['tab_review'] = sprintf($this->language->get('tab_review'), $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']));
			$this->data['tab_related'] = $this->language->get('tab_related');
                        $this->data['tab_category_items'] = $this->language->get('tab_category_items');
                        $this->data['tab_also_bought'] = $this->language->get('tab_also_bought');
                        $this->data['tab_best_selling'] = $this->language->get('tab_best_selling');
			
			$this->data['product_id'] = $this->request->get['product_id'];
			$this->data['manufacturer'] = $product_info['manufacturer'];
			$this->data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
			$this->data['model'] = $product_info['model'];
			$this->data['reward'] = $product_info['reward'];
			$this->data['points'] = $product_info['points'];
                        $this->data['stock_quantity'] = $product_info['quantity'];
			$this->data['logged'] = $this->customer->isLogged();
			if ($product_info['quantity'] <= 0) {
				$this->data['stock'] = $product_info['stock_status'];
			} elseif ($this->config->get('config_stock_display')) {
				$this->data['stock'] = $product_info['quantity'];
			} else {
				$this->data['stock'] = $this->language->get('text_instock');
			}
			
			$this->load->model('tool/image');
                        
                        if ($product_info['image']) {
                            $this->data['popup'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
                            $this->data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
                            $this->data['additional'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'));
                            
			} else {
				$this->data['popup'] = '';
				$this->data['thumb'] = '';
				$this->data['additional'] = '';
			}
                        
                        $this->data['additionalHeight'] = $this->config->get('config_image_additional_height');
                        $this->data['additionalWidth'] = $this->config->get('config_image_additional_width');
                        
			
			$this->data['images'] = array();
			
			$results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);
			
			foreach ($results as $result) {
				$this->data['images'][] = array(
					'popup' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
                                        'video' => $result['video'],
					'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),
                                        'main' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'))
				);
			}	
						
			if (!$this->config->get('config_block_buy') && (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price'))) {
				$this->data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$this->data['price'] = false;
			}
						
			if ((float)$product_info['special']) {
				$this->data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				$this->data['saving_percent'] = $product_info['saving_percent'];
			} else {
				$this->data['special'] = false;
				$this->data['saving_percent'] = false;
			}
			
			if ($this->config->get('config_tax')) {
				$this->data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price']);
			} else {
				$this->data['tax'] = false;
			}
			
			$discounts = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);
			
			$this->data['discounts'] = array(); 
			
			foreach ($discounts as $discount) {
				$this->data['discounts'][] = array(
					'quantity' => $discount['quantity'],
					'price'    => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')))
				);
			}
			
			$this->data['options'] = array();
                        
                        if (!$this->config->get('config_block_buy'))
                        {
			
                            foreach ($this->model_catalog_product->getProductOptions($this->request->get['product_id']) as $option) { 
                                    if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') { 
                                            $option_value_data = array();

                                            foreach ($option['option_value'] as $option_value) {
                                                    if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
                                                            if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
                                                                    $price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                                                            } else {
                                                                    $price = false;
                                                            }

                                                            $option_value_data[] = array(
                                                                    'product_option_value_id' => $option_value['product_option_value_id'],
                                                                    'option_value_id'         => $option_value['option_value_id'],
                                                                    'name'                    => $option_value['name'],
                                                                    'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
                                                                    'price'                   => $price,
                                                                    'price_prefix'            => $option_value['price_prefix']
                                                            );
                                                    }
                                            }

                                            $this->data['options'][] = array(
                                                    'product_option_id' => $option['product_option_id'],
                                                    'option_id'         => $option['option_id'],
                                                    'name'              => $option['name'],
                                                    'type'              => $option['type'],
                                                    'option_value'      => $option_value_data,
                                                    'required'          => $option['required']
                                            );					
                                    } elseif ($option['type'] == 'text' || $option['type'] == 'textarea' || $option['type'] == 'file' || $option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {
                                            $this->data['options'][] = array(
                                                    'product_option_id' => $option['product_option_id'],
                                                    'option_id'         => $option['option_id'],
                                                    'name'              => $option['name'],
                                                    'type'              => $option['type'],
                                                    'option_value'      => $option['option_value'],
                                                    'required'          => $option['required']
                                            );						
                                    }
                            }
                        }
							
			if ($product_info['minimum']) {
				$this->data['minimum'] = $product_info['minimum'];
			} else {
				$this->data['minimum'] = 1;
			}
			
			$this->data['review_status'] = $this->config->get('config_review_status');
                        $this->data['review_anonymous_status'] = $this->config->get('config_anonymous_review_status');
			$this->data['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);
			$this->data['rating'] = (int)$product_info['rating'];
			$this->data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');
                        $this->data['brief_summary'] = html_entity_decode($product_info['brief_summary'], ENT_QUOTES, 'UTF-8');
			$attGroups = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);
                        $this->data['attribute_groups'] = array();
                        $this->data['product_tabs'] = array();
                        foreach ($attGroups as $attGroup){
                            switch ($attGroup['name']){
                                case "Product Tabs":
                                    foreach ($attGroup['attribute'] as $tab)
                                    {
                                        $text = $tab['text'];
                                        if (preg_match('%^information_id=(\d+)%', $tab['text'])) {
                                            $this->load->model('catalog/information');
                                            $information_id = preg_replace('%^information_id=(\d+)%', '\\1', $tab['text']);
                                            $information_data = $this->model_catalog_information->getInformation($information_id);
                                            $text = $information_data['description'];
                                        }
                                        $this->data['product_tabs'][] = array('name'=>$tab['name'],'text'=>html_entity_decode($text));
                                    }
                                    break;
                                default:
                                    $this->data['attribute_groups'][$attGroup['name']][] = $attGroup;
                            }
                        }
			
			$this->data['products'] = array();
			
			$results = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);
			
			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
				} else {
					$image = false;
				}
				
				if (!$this->config->get('config_block_buy') && (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price'))) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}
						
				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}
				
				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}
                                
                                $idcategory = $this ->model_catalog_product->getCategories($product_info['product_id']);
                                
                                foreach ($idcategory as $categoryid) {
                                    if ($categoryid['category_id']) {
                                        $idcat = $categoryid['category_id'];
                                    }
                                }
                                
                                
				$this->data['products'][] = array(
					'product_id' => $result['product_id'],
					'thumb'   	 => $image,
					'name'    	 => $result['name'],
					'price'   	 => $price,
					'special' 	 => $special,
                                        'saving_percent' => $result['saving_percent'],
                                        'sale'           => $result['sale'],
                                        'new'            => $result['new'],
					'rating'     => $rating,
					'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
					'href'    	 => $this->url->link('product/product', 'path=' . $idcat . '&product_id=' . $result['product_id']),
				);
			}	
			
                        /* Customers also bought */
			$this->data['alsoBought'] = array();
			$results = $this->model_catalog_product->getProductCustomersAlsoBought($this->request->get['product_id']);
			
			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
				} else {
					$image = false;
				}
				
				if (!$this->config->get('config_block_buy') && (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price'))) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}
						
				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}
				
				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}
				                                
				$this->data['alsoBought'][] = array(
					'product_id' => $result['product_id'],
					'thumb'   	 => $image,
					'name'    	 => $result['name'],
					'price'   	 => $price,
					'special' 	 => $special,
                                        'saving_percent' => $result['saving_percent'],
                                        'new'            => $result['new'],
                                        'sale'            => $result['sale'],
					'rating'     => $rating,
					'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
					'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
				);
			}
			/* End Customers also bought */
                        
                        /* Other products in the category */
                        if (isset($this->request->get['path'])) {
                            $path = '';

                            foreach (explode('_', $this->request->get['path']) as $path_id) {
                                    if (!$path) {
                                            $path = $path_id;
                                    } else {
                                            $path .= '_' . $path_id;
                                    }

                                    $category_info = $this->model_catalog_category->getCategory($path_id);
                            }
                            
                            $this->data['alsoCategory'] = array();
                            $data = array(
                                'start'   	 => 0,
                                'limit'   	 => 6,
                                'filter_category_id' => $category_info['category_id']
                            );
                            $results = $this->model_catalog_product->getProducts($data);
                        
			foreach ($results as $result) {
				if ($result['product_id'] != $product_id) {
                                    if ($result['image']) {
                                            $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
                                    } else {
                                            $image = false;
                                    }

                                    if (!$this->config->get('config_block_buy') && (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price'))) {
                                            $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                                    } else {
                                            $price = false;
                                    }

                                    if ((float)$result['special']) {
                                            $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                                    } else {
                                            $special = false;
                                    }

                                    if ($this->config->get('config_review_status')) {
                                            $rating = (int)$result['rating'];
                                    } else {
                                            $rating = false;
                                    }

                                    $this->data['alsoCategory'][] = array(
                                            'product_id' => $result['product_id'],
                                            'thumb'   	 => $image,
                                            'name'    	 => $result['name'],
                                            'price'   	 => $price,
                                            'special' 	 => $special,
                                            'saving_percent' => $result['saving_percent'],
                                            'new'            => $result['new'],
                                            'sale'            => $result['sale'],
                                            'rating'     => $rating,
                                            'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
                                            'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
                                    );
                                }
                            }
                        }
                        
			/* End Other products in category */
                        
                        /* Top selling products */
                        $this->data['bestSelling'] = array();
                        $results = $this->model_catalog_product->getBestSellerProducts(5);

                        foreach ($results as $result) {
                            if ($result['product_id'] != $product_id) {
                                if ($result['image']) {
                                        $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
                                } else {
                                        $image = false;
                                }

                                if (!$this->config->get('config_block_buy') && (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price'))) {
                                        $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                                } else {
                                        $price = false;
                                }

                                if ((float)$result['special']) {
                                        $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                                } else {
                                        $special = false;
                                }

                                if ($this->config->get('config_review_status')) {
                                        $rating = (int)$result['rating'];
                                } else {
                                        $rating = false;
                                }

                                $this->data['bestSelling'][] = array(
                                        'product_id' => $result['product_id'],
                                        'thumb'   	 => $image,
                                        'name'    	 => $result['name'],
                                        'price'   	 => $price,
                                        'special' 	 => $special,
                                        'saving_percent' => $result['saving_percent'],
                                        'new'            => $result['new'],
                                        'sale'            => $result['sale'],
                                        'rating'     => $rating,
                                        'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
                                        'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
                                );
                            }
                        }
                        
			/* End Top selling products */
                        
                        /***************************** News press **********************************************/
                        $this->data['news'] = array();

                        $news = $this->model_catalog_product->getInfoPress($this->request->get['product_id']);
                        if (!empty($news)) {
                            foreach ($news as $nproduct) {
                                    if ($nproduct['image'] && $nproduct['status'] == '1') {
                                                    $image = $this->model_tool_image->resize($nproduct['image'], 203, 217);
                                            } else {
                                                    $image = 'no_press_img.jpg';
                                            }
                            $this->data['news'][] = array(
                                            'title'              => $nproduct['title'],
                                            'acom'               => $nproduct['acom'],
                                            'thumb'              => $image,
                                            'short_description'  => substr(strip_tags(html_entity_decode($nproduct['description'])),0,140),
                                            'short_description2' => substr(strip_tags(html_entity_decode($nproduct['description'])),0,350),
                                            'href'               => $this->url->link('news/article', 'ncat=' . $nproduct['ncategory_id'] . '&news_id=' . $nproduct['news_id']),
                                            'status'             => $nproduct['status']

                            );
                            }
                        }
                        $this->data['no_press_img'] = $this->model_tool_image->resize('no_press_img.jpg', 203, 217);
                        /******************************** End News press ***********************************************/

                                                
			$this->data['tags'] = array();
					
			$tags = explode(',', $product_info['tag']);
			
			foreach ($tags as $tag) {
				$this->data['tags'][] = array(
					'tag'  => trim($tag),
					'href' => $this->url->link('product/search', 'filter_tag=' . trim($tag))
				);
			}
			
			$this->model_catalog_product->updateViewed($this->request->get['product_id']);
			
			$this->setTemplate('product/product.tpl');
			
			$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);
						
			$this->response->setOutput($this->render());
		} else {
			$url = '';
			
			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}
			
			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}			

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}	
					
			if (isset($this->request->get['filter_tag'])) {
				$url .= '&filter_tag=' . $this->request->get['filter_tag'];
			}
							
			if (isset($this->request->get['filter_description'])) {
				$url .= '&filter_description=' . $this->request->get['filter_description'];
			}
					
			if (isset($this->request->get['filter_category_id'])) {
				$url .= '&filter_category_id=' . $this->request->get['filter_category_id'];
			}
								
      		$this->data['breadcrumbs'][] = array(
        		'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('product/product', $url . '&product_id=' . $product_id),
        		'separator' => $this->language->get('text_separator')
      		);			
		
      		$this->document->setTitle($this->language->get('text_error'));

      		$this->data['heading_title'] = $this->language->get('text_error');

      		$this->data['text_error'] = $this->language->get('text_error');

      		$this->data['button_continue'] = $this->language->get('button_continue');

      		$this->data['continue'] = $this->url->link('common/home');
                
                
			$this->setTemplate('error/not_found.tpl');
			
			$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);
						
			$this->response->setOutput($this->render());
    	}
  	}
	
	public function review() {
    	$this->language->load('product/product');
		
		$this->load->model('catalog/review');

		$this->data['text_on'] = $this->language->get('text_on');
		$this->data['text_no_reviews'] = $this->language->get('text_no_reviews');
                $this->data['text_says'] = $this->language->get('text_says');
                

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}  
		
		$this->data['reviews'] = array();
		
		$review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);
			
		$results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * 5, 5);
      		
		foreach ($results as $result) {
        	$this->data['reviews'][] = array(
        		'author'     => $result['author'],
                        'text'       => $result['text'],
                        'rating'     => (int)$result['rating'],
                        'reply'      => $result['reply'],
        		'reviews'    => sprintf($this->language->get('text_reviews'), (int)$review_total),
        		'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
        	);
      	}			
			
		$pagination = new Pagination();
		$pagination->total = $review_total;
		$pagination->page = $page;
		$pagination->limit = 5; 
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');
			
		$this->data['pagination'] = $pagination->render();
                        
                        if ($pagination->getPrevLink())
                        {
                            $this->document->addLink($pagination->getPrevLink(), 'prev');
                        }
                        if ($pagination->getNextLink())
                        {
                            $this->document->addLink($pagination->getNextLink(), 'next');
                        }
		
		$this->setTemplate('product/review.tpl');
		
		$this->response->setOutput($this->render());
	}
	
	public function write() {
		$this->language->load('product/product');
		
		$this->load->model('catalog/review');
		
		$json = array();
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
				$json['error'] = $this->language->get('error_name');
			}
			
			if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error'] = $this->language->get('error_text');
			}
	
			if (empty($this->request->post['rating'])) {
				$json['error'] = $this->language->get('error_rating');
			}
	
			if (empty($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
				$json['error'] = $this->language->get('error_captcha');
			}
				
			if (!isset($json['error'])) {
				$this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);
				
				$json['success'] = $this->language->get('text_success');
			}
		}
		
		$this->response->setOutput(json_encode($json));
	}
	
	public function captcha() {
		$this->load->library('captcha');
		
		$captcha = new Captcha();
		
		$this->session->data['captcha'] = $captcha->getCode();
		
		$captcha->showImage();
	}
	
	public function upload() {
		$this->language->load('product/product');
		
		$json = array();
		
		if (!empty($this->request->files['file']['name'])) {
			$filename = basename(preg_replace('/[^a-zA-Z0-9\.\-\s+]/', '', html_entity_decode($this->request->files['file']['name'], ENT_QUOTES, 'UTF-8')));
			
			if ((utf8_strlen($filename) < 3) || (utf8_strlen($filename) > 64)) {
        		$json['error'] = $this->language->get('error_filename');
	  		}	  	
			
			$allowed = array();
			
			$filetypes = explode(',', $this->config->get('config_upload_allowed'));
			
			foreach ($filetypes as $filetype) {
				$allowed[] = trim($filetype);
			}
			
			if (!in_array(substr(strrchr($filename, '.'), 1), $allowed)) {
				$json['error'] = $this->language->get('error_filetype');
       		}	
						
			if ($this->request->files['file']['error'] != UPLOAD_ERR_OK) {
				$json['error'] = $this->language->get('error_upload_' . $this->request->files['file']['error']);
			}
		} else {
			$json['error'] = $this->language->get('error_upload');
		}
		
		if (!$json) {
			if (is_uploaded_file($this->request->files['file']['tmp_name']) && file_exists($this->request->files['file']['tmp_name'])) {
				$file = basename($filename) . '.' . md5(mt_rand());
				
				// Hide the uploaded file name so people can not link to it directly.
				$json['file'] = $this->encryption->encrypt($file);
				
				move_uploaded_file($this->request->files['file']['tmp_name'], DIR_DOWNLOAD . $file);
			}
						
			$json['success'] = $this->language->get('text_upload');
		}	
		
		$this->response->setOutput(json_encode($json));		
	}
       
}
?>
