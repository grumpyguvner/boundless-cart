<?php 
class ControllerProductCategory extends Controller {  
	public function index() { 
                $category_id = $this->category->getIdFromPath();

                $this->category->load($category_id);
                if ($this->category->getId() != $category_id || !$this->category->isAvailable()) {
                    $this->categoryNotFound();
                    return false;
                }
            
		$this->language->load('product/category');
		
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
					
                $this->data['breadcrumbs'] = $this->category->getBreadcrumbs();
                
		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}
		if (isset($this->request->get['option'])) {
			$option = $this->request->get['option'];
		} else {
			$option = '';
		}
		if (isset($this->request->get['product'])) {
			$product = $this->request->get['product'];
		} else {
			$product = '';
		}
                
                $path = $this->category->getPath();
		
                $sort = $this->category->getSort();
                $order = $this->category->getOrder();
                $page = $this->category->getPage();
                $limit = $this->category->getLimit();
	
                $this->document->setTitle($this->category->getMetaTitle() ? $this->category->getMetaTitle() : $this->category->getName());
                $this->document->setDescription($this->category->getMetaDescription());
                $this->document->setKeywords($this->category->getMetaKeyword());
			
                $this->data['heading_title'] = $this->category->getName();

                $this->data['text_refine'] = $this->language->get('text_refine');
                $this->data['text_empty'] = $this->language->get('text_empty');			
                $this->data['text_quantity'] = $this->language->get('text_quantity');
                $this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
                $this->data['text_model'] = $this->language->get('text_model');
                $this->data['text_price'] = $this->language->get('text_price');
                $this->data['text_tax'] = $this->language->get('text_tax');
                $this->data['text_points'] = $this->language->get('text_points');
                $this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
                $this->data['text_display'] = $this->language->get('text_display');
                $this->data['text_list'] = $this->language->get('text_list');
                $this->data['text_grid'] = $this->language->get('text_grid');
                $this->data['text_sort'] = $this->language->get('text_sort');
                $this->data['text_limit'] = $this->language->get('text_limit');
                $this->data['text_save'] = $this->language->get('text_limit');
                $this->data['text_rrp'] = $this->language->get('text_limit');
                $this->data['text_pay'] = $this->language->get('text_limit');
                $this->data['text_designed'] = $this->language->get('text_designed');
                $this->data['text_pview'] = $this->language->get('text_pview');
                $this->data['text_fourty_per_page'] = $this->language->get('text_fourty_per_page');
                $this->data['text_hundred_per_page'] = $this->language->get('text_hundred_per_page');

                $this->data['button_cart'] = $this->language->get('button_cart');
                $this->data['button_wishlist'] = $this->language->get('button_wishlist');
                $this->data['button_compare'] = $this->language->get('button_compare');
                $this->data['button_continue'] = $this->language->get('button_continue');
                
                if (count($this->data['breadcrumbs']) > 1)
                    {
                        $count = count($this->data['breadcrumbs']) - 2;
                        $this->data['text_breadcrumb_back'] = sprintf($this->language->get('text_breadcrumb_back'), $this->data['breadcrumbs'][$count]['text']);
                    } else {
                        $this->data['text_breadcrumb_back'] = '';
                    }

                if ($this->category->getImage()) {
                        $this->data['thumb'] = $this->model_tool_image->resize($this->category->getImage(), $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
                        $this->data['thumbW'] = $this->config->get('config_image_category_width');
                        $this->data['thumbH'] = $this->config->get('config_image_category_height');
                } else {
                        $this->data['thumb'] = '';
                        $this->data['thumbW'] = 0;
                        $this->data['thumbH'] = 0;
                }
									
                $this->data['description'] = html_entity_decode($this->category->getDescription(), ENT_QUOTES, 'UTF-8');
                $this->data['compare'] = $this->url->link('product/compare');

                $urlQuery = $this->category->getUrlQuery();
                $filterData = $this->category->getFilterData();

                //Conventional Category Navigation:
                $this->data['categories'] = array();
                $sub_categories = $this->category->getChildren();
                foreach ($sub_categories as $sub_category) {
                        $data = array(
                                'filter_category_id'  => $sub_category['category_id'],
                                'filter_sub_category' => true
                        );

                        $product_total = $this->model_catalog_product->getTotalProducts($data);				

                        $this->data['categories'][] = array(
                                'name'  => $sub_category['name'] . ($this->config->get('config_product_count') ? ' (' . $product_total . ')' : ''),
                                'href'  => $this->url->link('product/category', 'path=' . $path . '_' . $sub_category['category_id'] . $urlQuery)
                        );
                }
                
                $this->data['products'] = array();
	
                $data = array(
                        'filter_category_id' => $category_id,
                        'filter_filter'      => $filter, 
                        'filter_option'      => $option,
                        'sort'               => $sort,
                        'order'              => $order,
                        'start'              => ($page - 1) * $limit,
                        'limit'              => $limit
                );
                                
                if (!empty($product))
                {
                    $product = explode(',', $product);
                    foreach ($product as $p)
                    {
                        if (preg_match('%range:\d+:\d+%', $p))
                        {
                            $price_range = explode(':', $p);
                            $data['filter_product_min_price'] = $this->currency->convert($price_range[1], $this->currency->getCode(), $this->config->get('config_currency'));
                            $data['filter_product_max_price'] = $this->currency->convert($price_range[2], $this->currency->getCode(), $this->config->get('config_currency'));
                        } 
                        elseif ($p == 'new')
                        {
                            $data['filter_new'] = true;
                        }
                        elseif ($p == 'sale')
                        {
                            $data['filter_sale'] = true;
                        }
                    }
                }   
                
                if ($this->extensions->isInstalled('afilters'))
                {
                    
                    $data['filters'] = $this->category->getFilterData();
                    
                    $product_total = $this->model_catalog_product->getTotalProductsAFiltered($data); 
                    $this->data['total'] = $product_total;
                    $results = $this->model_catalog_product->getProductsAFiltered($data);
                } else {
                    $product_total = $this->model_catalog_product->getTotalProducts($data); 
                    $this->data['total'] = $product_total;
                    $results = $this->model_catalog_product->getProducts($data);
                }
				
	
                foreach ($results as $result) {
                        if ($result['image']) {
                                $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
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

                        if ($this->config->get('config_tax')) {
                                $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
                        } else {
                                $tax = false;
                        }				

                        if ($this->config->get('config_review_status')) {
                                $rating = (int)$result['rating'];
                        } else {
                                $rating = false;
                        }
                        
                        $this->data['products'][] = array(
                                'product_id'  => $result['product_id'],
                                'thumb'       => $image,
                                'name'        => $result['name'],
                                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
                                'price'       => $price,
                                'special'     => $special,
                                'saving_percent'        => $result['saving_percent'],
                                'sale'      => $result['sale'],
                                'new'         => $result['new'],
                                'tax'         => $tax,
                                'rating'      => $result['rating'],
                                'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
                                'href'        => $this->url->link('product/product', 'path=' . $path . '&product_id=' . $result['product_id'])
                        );
                }
                
                    $this->data['login_required'] = (!$this->customer->isLogged() && $this->category->isMembersOnly()) ? true : false;
                    $this->data['login_modal'] = $this->url->link('module/login');
                    $this->data['date_end'] = $this->category->getDateEnd();

                        $urlSort = $this->category->getUrlQuery('sort');
			$this->data['sorts'] = array();
			
			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $path . '&sort=p.sort_order&order=ASC' . $urlSort)
			);
			
			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $path . '&sort=pd.name&order=ASC' . $urlSort)
			);

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $path . '&sort=pd.name&order=DESC' . $urlSort)
			);

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $path . '&sort=p.price&order=ASC' . $urlSort)
			); 

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $path . '&sort=p.price&order=DESC' . $urlSort)
			); 
			
			if ($this->config->get('config_review_status')) {
				$this->data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->url->link('product/category', 'path=' . $path . '&sort=rating&order=DESC' . $urlSort)
				); 
				
				$this->data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->url->link('product/category', 'path=' . $path . '&sort=rating&order=ASC' . $urlSort)
				);
			}
			
			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $path . '&sort=p.model&order=ASC' . $urlSort)
			);

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $path . '&sort=p.model&order=DESC' . $urlSort)
			);
			
                        $urlLimit = $this->category->getUrlQuery('limit');
			$this->data['limits'] = array();
			
			$this->data['limits'][] = array(
				'text'  => $this->config->get('config_catalog_limit'),
				'value' => $this->config->get('config_catalog_limit'),
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&limit=' . $this->config->get('config_catalog_limit') . $urlLimit)
			);
						
			$this->data['limits'][] = array(
				'text'  => 25,
				'value' => 25,
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&limit=25' . $urlLimit)
			);
			
			$this->data['limits'][] = array(
				'text'  => 50,
				'value' => 50,
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&limit=50' . $urlLimit)
			);

			$this->data['limits'][] = array(
				'text'  => 75,
				'value' => 75,
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&limit=75' . $urlLimit)
			);
			
			$this->data['limits'][] = array(
				'text'  => 100,
				'value' => 100,
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&limit=100' . $urlLimit)
			);
						
			$urlPage = $this->category->getUrlQuery('page');
			$pagination = new Pagination();
                        $pagination->total = $product_total;
                        $pagination->page = $page;
                        $pagination->limit = $limit;
                        $pagination->text_first = $this->language->get('text_first');
                        $pagination->text_prev = $this->language->get('text_prev');
                        $pagination->text_next = $this->language->get('text_next');
                        $pagination->text_last = $this->language->get('text_last');
                        $pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&page={page}' . $urlPage);
                        $this->data['pagination'] = $pagination->render();
                        
                        if ($pagination->getPrevLink())
                        {
                            $this->document->addLink($pagination->getPrevLink(), 'prev');
                        }
                        if ($pagination->getNextLink())
                        {
                            $this->document->addLink($pagination->getNextLink(), 'next');
                        }
                        if ($page == 1)
                        {
                            $this->document->addLink($this->url->link('product/category', 'path=' . $this->request->get['path'] . $urlPage), 'canonical');
                        }
                       
                        $pagination2 = new Pagination();
                        $pagination2->total = $product_total;
                        $pagination2->page = $page;
                        $pagination2->limit = $limit;
                        $pagination2->text = $this->language->get('text_pagination');
                        
           
                        $this->data['pagination2'] = $pagination2->text();
                        
			$this->data['sort'] = $sort;
			$this->data['order'] = $order;
			$this->data['limit'] = $limit;
		
			$this->data['continue'] = $this->url->link('common/home');

			$this->setTemplate('product/category.tpl');
			
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
        
          private function categoryNotFound() {
			$url = '';
                        foreach ($afilterURL as $key=>$val) {
				foreach ($val as $val2) {
				$url .= '&att_filters['.$key.'][]=' . urlencode($val2);
				}
				}
			
			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}
									
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
				
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
						
			$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('product/category', $url),
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
?>