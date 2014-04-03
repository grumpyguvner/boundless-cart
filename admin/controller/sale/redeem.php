<?php  
class ControllerSaleRedeem extends Controller {
	private $error = array();
     
  	public function index() {
		$this->load->language('sale/redeem');
    	
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/redeem');
		
		$this->getList();
  	}
  
  	public function insert() {
    	$this->load->language('sale/redeem');

    	$this->document->setTitle($this->language->get('heading_title'));
		
	$this->load->model('sale/redeem');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_sale_redeem->addRedeem($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
                
                if (isset($this->request->get['filter_redeem_id'])) {
                    $url .= '&filter_redeem_id=' . $this->request->get['filter_redeem_id'];
                }
                
                if (isset($this->request->get['filter_product_id'])) {
                    $url .= '&filter_product_id=' . $this->request->get['filter_product_id'];
                }
                
                if (isset($this->request->get['filter_order_id'])) {
                    $url .= '&filter_order_id=' . $this->request->get['filter_order_id'];
                }
                
                if (isset($this->request->get['filter_code'])) {
                    $url .= '&filter_code=' . $this->request->get['filter_code'];
                }

                if (isset($this->request->get['filter_status'])) {
                    $url .= '&filter_status=' . $this->request->get['filter_status'];
                }

                if (isset($this->request->get['filter_redeem'])) {
                    $url .= '&filter_redeem=' . $this->request->get['filter_redeem'];
                }

                if (isset($this->request->get['filter_date_added'])) {
                    $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
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
			
			$this->redirect($this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
    
    	$this->getForm();
  	}

  	public function update() {
    	$this->load->language('sale/redeem');

    	$this->document->setTitle($this->language->get('heading_title'));
		
	$this->load->model('sale/redeem');
				
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_sale_redeem->editRedeem($this->request->get['redeem_id'], $this->request->post);
      		
			$this->session->data['success'] = $this->language->get('text_success');
	  
			$url = '';
                
                if (isset($this->request->get['filter_redeem_id'])) {
                    $url .= '&filter_redeem_id=' . $this->request->get['filter_redeem_id'];
                }
                
                if (isset($this->request->get['filter_product_id'])) {
                    $url .= '&filter_product_id=' . $this->request->get['filter_product_id'];
                }
                
                if (isset($this->request->get['filter_order_id'])) {
                    $url .= '&filter_order_id=' . $this->request->get['filter_order_id'];
                }
                
                if (isset($this->request->get['filter_code'])) {
                    $url .= '&filter_code=' . $this->request->get['filter_code'];
                }

                if (isset($this->request->get['filter_status'])) {
                    $url .= '&filter_status=' . $this->request->get['filter_status'];
                }

                if (isset($this->request->get['filter_redeem'])) {
                    $url .= '&filter_redeem=' . $this->request->get['filter_redeem'];
                }

                if (isset($this->request->get['filter_date_added'])) {
                    $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
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
			
			$this->redirect($this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    
    	$this->getForm();
  	}

  	public function delete() {
    	$this->load->language('sale/redeem');

    	$this->document->setTitle($this->language->get('heading_title'));
		
	$this->load->model('sale/redeem');
		
    	if (isset($this->request->post['selected']) && $this->validateDelete()) { 
			foreach ($this->request->post['selected'] as $redeem_id) {
				$this->model_sale_redeem->deleteRedeem($redeem_id);
			}
      		
			$this->session->data['success'] = $this->language->get('text_success');
	  
			$url = '';
                
                if (isset($this->request->get['filter_redeem_id'])) {
                    $url .= '&filter_redeem_id=' . $this->request->get['filter_redeem_id'];
                }
                
                if (isset($this->request->get['filter_product_id'])) {
                    $url .= '&filter_product_id=' . $this->request->get['filter_product_id'];
                }
                
                if (isset($this->request->get['filter_order_id'])) {
                    $url .= '&filter_order_id=' . $this->request->get['filter_order_id'];
                }
                
                if (isset($this->request->get['filter_code'])) {
                    $url .= '&filter_code=' . $this->request->get['filter_code'];
                }

                if (isset($this->request->get['filter_status'])) {
                    $url .= '&filter_status=' . $this->request->get['filter_status'];
                }

                if (isset($this->request->get['filter_redeem'])) {
                    $url .= '&filter_redeem=' . $this->request->get['filter_redeem'];
                }

                if (isset($this->request->get['filter_date_added'])) {
                    $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
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
			
			$this->redirect($this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
	
    	$this->getList();
  	}
        
        public function redeem() {
            $this->load->language('sale/redeem');
            $this->load->model('sale/redeem');
            
            if (isset($this->request->post['selected'])) {
                if (isset($this->request->post['selected']))
                {
                    foreach ($this->request->post['selected'] as $redeem_id) {
                            $this->model_sale_redeem->redeemRedeem($redeem_id);
                    }
                }

                $this->session->data['success'] = $this->language->get('text_success');

                $url = '';
                
                if (isset($this->request->get['filter_redeem_id'])) {
                    $url .= '&filter_redeem_id=' . $this->request->get['filter_redeem_id'];
                }
                
                if (isset($this->request->get['filter_product_id'])) {
                    $url .= '&filter_product_id=' . $this->request->get['filter_product_id'];
                }
                
                if (isset($this->request->get['filter_order_id'])) {
                    $url .= '&filter_order_id=' . $this->request->get['filter_order_id'];
                }
                
                if (isset($this->request->get['filter_code'])) {
                    $url .= '&filter_code=' . $this->request->get['filter_code'];
                }

                if (isset($this->request->get['filter_status'])) {
                    $url .= '&filter_status=' . $this->request->get['filter_status'];
                }

                if (isset($this->request->get['filter_redeem'])) {
                    $url .= '&filter_redeem=' . $this->request->get['filter_redeem'];
                }

                if (isset($this->request->get['filter_date_added'])) {
                    $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
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

                $this->redirect($this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . $url, 'SSL'));
            }
        }

  	private function getList() {
                $this->data['text_enabled'] = $this->language->get('text_enabled');
                $this->data['text_disabled'] = $this->language->get('text_disabled');
                $this->data['text_yes'] = $this->language->get('text_yes');
                $this->data['text_no'] = $this->language->get('text_no');
                
                if (isset($this->request->get['filter_redeem_id'])) {
                    $filter_redeem_id = $this->request->get['filter_redeem_id'];
                } else {
                    $filter_redeem_id = null;
                }
                
                if (isset($this->request->get['filter_product_id'])) {
                    $filter_product_id = $this->request->get['filter_product_id'];
                } else {
                    $filter_product_id = null;
                }
                
                if (isset($this->request->get['filter_order_id'])) {
                    $filter_order_id = $this->request->get['filter_order_id'];
                } else {
                    $filter_order_id = null;
                }

                if (isset($this->request->get['filter_code'])) {
                    $filter_code = $this->request->get['filter_code'];
                } else {
                    $filter_code = null;
                }

                if (isset($this->request->get['filter_status'])) {
                    $filter_status = $this->request->get['filter_status'];
                } else {
                    $filter_status = null;
                }
                
                if (isset($this->request->get['filter_redeem'])) {
                    $filter_redeem = $this->request->get['filter_redeem'];
                } else {
                    $filter_redeem = null;
                }

                if (isset($this->request->get['filter_date_added'])) {
                    $filter_date_added = $this->request->get['filter_date_added'];
                } else {
                    $filter_date_added = null;
                }
            
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'v.date_added';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
				
		$url = ''; 
                
                if (isset($this->request->get['filter_redeem_id'])) {
                    $url .= '&filter_redeem_id=' . $this->request->get['filter_redeem_id'];
                }
                
                if (isset($this->request->get['filter_product_id'])) {
                    $url .= '&filter_product_id=' . $this->request->get['filter_product_id'];
                }
                
                if (isset($this->request->get['filter_order_id'])) {
                    $url .= '&filter_order_id=' . $this->request->get['filter_order_id'];
                }
                
                if (isset($this->request->get['filter_code'])) {
                    $url .= '&filter_code=' . $this->request->get['filter_code'];
                }

                if (isset($this->request->get['filter_status'])) {
                    $url .= '&filter_status=' . $this->request->get['filter_status'];
                }

                if (isset($this->request->get['filter_redeem'])) {
                    $url .= '&filter_redeem=' . $this->request->get['filter_redeem'];
                }

                if (isset($this->request->get['filter_date_added'])) {
                    $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
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

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
							
		$this->data['insert'] = $this->url->link('sale/redeem/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('sale/redeem/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
                $this->data['redeemCode'] = $this->url->link('sale/redeem/redeem', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		$this->data['redeems'] = array();

		$data = array(
                        'filter_redeem_id' => $filter_redeem_id,
                        'filter_product_id' => $filter_product_id,
                        'filter_order_id' => $filter_order_id,
                        'filter_code' => $filter_code,
                        'filter_status' => $filter_status,
                        'filter_redeem' => $filter_redeem,
                        'filter_date_added' => $filter_date_added,
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
		
		$redeem_total = $this->model_sale_redeem->getTotalRedeems($data);
	
		$results = $this->model_sale_redeem->getRedeems($data);
 
    	foreach ($results as $result) {
			$action = array();
									
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('sale/redeem/update', 'token=' . $this->session->data['token'] . '&redeem_id=' . $result['redeem_id'] . $url, 'SSL')
			);

                $this->load->model('catalog/product');
                $product_info = $this->model_catalog_product->getProduct($result['product_id']);
						
			$this->data['redeems'][] = array(
				'redeem_id'  => $result['redeem_id'],
				'product_id'       => $result['product_id'],
				'order_id'       => $result['order_id'],
				'code'         => $result['code'],
				'status'      => $result['status'],
				'redeem'     => $result['redeem'],
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
                                'action'     => $action,
                                'product_link' => $this->url->link('catalog/product/update', 'token=' . $this->session->data['token'] . '&product_id=' . $result['product_id'] . $url, 'SSL'),
                                'order_link'  => $this->url->link('sale/order/info', 'token=' . $this->session->data['token'] . '&order_id=' . $result['order_id'] . $url, 'SSL'),
                                'product_model' => $product_info['name']
			);
		}
									
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_send'] = $this->language->get('text_send');
		$this->data['text_wait'] = $this->language->get('text_wait');
		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_redeem_id'] = $this->language->get('column_redeem_id');
		$this->data['column_product_id'] = $this->language->get('column_product_id');
		$this->data['column_order_id'] = $this->language->get('column_order_id');
		$this->data['column_code'] = $this->language->get('column_code');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_redeem'] = $this->language->get('column_redeem');
                $this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_action'] = $this->language->get('column_action');		
		
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
 
 		$this->data['token'] = $this->session->data['token'];
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$url = '';
                
                if (isset($this->request->get['filter_redeem_id'])) {
                    $url .= '&filter_redeem_id=' . $this->request->get['filter_redeem_id'];
                }
                
                if (isset($this->request->get['filter_product_id'])) {
                    $url .= '&filter_product_id=' . $this->request->get['filter_product_id'];
                }
                
                if (isset($this->request->get['filter_order_id'])) {
                    $url .= '&filter_order_id=' . $this->request->get['filter_order_id'];
                }
                
                if (isset($this->request->get['filter_code'])) {
                    $url .= '&filter_code=' . $this->request->get['filter_code'];
                }

                if (isset($this->request->get['filter_status'])) {
                    $url .= '&filter_status=' . $this->request->get['filter_status'];
                }

                if (isset($this->request->get['filter_redeem'])) {
                    $url .= '&filter_redeem=' . $this->request->get['filter_redeem'];
                }

                if (isset($this->request->get['filter_date_added'])) {
                    $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
                }

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_code'] = $this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . '&sort=v.code' . $url, 'SSL');
		$this->data['sort_from'] = $this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . '&sort=v.from_name' . $url, 'SSL');
		$this->data['sort_to'] = $this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . '&sort=v.to_name' . $url, 'SSL');
		$this->data['sort_theme'] = $this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . '&sort=theme' . $url, 'SSL');
		$this->data['sort_amount'] = $this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . '&sort=v.amount' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . '&sort=v.date_end' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . '&sort=v.date_added' . $url, 'SSL');
				
		$url = '';
                
                if (isset($this->request->get['filter_redeem_id'])) {
                    $url .= '&filter_redeem_id=' . $this->request->get['filter_redeem_id'];
                }
                
                if (isset($this->request->get['filter_product_id'])) {
                    $url .= '&filter_product_id=' . $this->request->get['filter_product_id'];
                }
                
                if (isset($this->request->get['filter_order_id'])) {
                    $url .= '&filter_order_id=' . $this->request->get['filter_order_id'];
                }
                
                if (isset($this->request->get['filter_code'])) {
                    $url .= '&filter_code=' . $this->request->get['filter_code'];
                }

                if (isset($this->request->get['filter_status'])) {
                    $url .= '&filter_status=' . $this->request->get['filter_status'];
                }

                if (isset($this->request->get['filter_redeem'])) {
                    $url .= '&filter_redeem=' . $this->request->get['filter_redeem'];
                }

                if (isset($this->request->get['filter_date_added'])) {
                    $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
                }

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $redeem_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();
                
                
                $this->data['filter_redeem_id'] = $filter_redeem_id;
                $this->data['filter_product_id'] = $filter_product_id;
                $this->data['filter_order_id'] = $filter_order_id;
                $this->data['filter_code'] = $filter_code;
                $this->data['filter_status'] = $filter_status;
                $this->data['filter_redeem'] = $filter_redeem;
                $this->data['filter_date_added'] = $filter_date_added;

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'sale/redeem_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
  	}

  	private function getForm() {
    	$this->data['heading_title'] = $this->language->get('heading_title');
        
        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');
        
    	$this->data['entry_redeem_id'] = $this->language->get('entry_redeem_id');
        $this->data['entry_product_id'] = $this->language->get('entry_product_id');
        $this->data['entry_order_id'] = $this->language->get('entry_order_id');
        $this->data['entry_code'] = $this->language->get('entry_code');
        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_redeem'] = $this->language->get('entry_redeem');
        $this->data['entry_date_added'] = $this->language->get('entry_date_added');

    	$this->data['button_save'] = $this->language->get('button_save');
    	$this->data['button_cancel'] = $this->language->get('button_cancel');
        $this->data['button_redeem'] = $this->language->get('button_redeem');

		
		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['tab_redeem_history'] = $this->language->get('tab_redeem_history');
		
		if (isset($this->request->get['redeem_id'])) {
			$this->data['redeem_id'] = $this->request->get['redeem_id'];
		} else {
			$this->data['redeem_id'] = 0;
		}
		 		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['code'])) {
			$this->data['error_code'] = $this->error['code'];
		} else {
			$this->data['error_code'] = '';
		}		
		
		if (isset($this->error['from_name'])) {
			$this->data['error_from_name'] = $this->error['from_name'];
		} else {
			$this->data['error_from_name'] = '';
		}	
		
		if (isset($this->error['from_email'])) {
			$this->data['error_from_email'] = $this->error['from_email'];
		} else {
			$this->data['error_from_email'] = '';
		}	
		
		if (isset($this->error['to_name'])) {
			$this->data['error_to_name'] = $this->error['to_name'];
		} else {
			$this->data['error_to_name'] = '';
		}	
		
		if (isset($this->error['to_email'])) {
			$this->data['error_to_email'] = $this->error['to_email'];
		} else {
			$this->data['error_to_email'] = '';
		}	
		
		if (isset($this->error['amount'])) {
			$this->data['error_amount'] = $this->error['amount'];
		} else {
			$this->data['error_amount'] = '';
		}
				
		$url = '';
                
                if (isset($this->request->get['filter_redeem_id'])) {
                    $url .= '&filter_redeem_id=' . $this->request->get['filter_redeem_id'];
                }
                
                if (isset($this->request->get['filter_product_id'])) {
                    $url .= '&filter_product_id=' . $this->request->get['filter_product_id'];
                }
                
                if (isset($this->request->get['filter_order_id'])) {
                    $url .= '&filter_order_id=' . $this->request->get['filter_order_id'];
                }
                
                if (isset($this->request->get['filter_code'])) {
                    $url .= '&filter_code=' . $this->request->get['filter_code'];
                }

                if (isset($this->request->get['filter_status'])) {
                    $url .= '&filter_status=' . $this->request->get['filter_status'];
                }

                if (isset($this->request->get['filter_redeem'])) {
                    $url .= '&filter_redeem=' . $this->request->get['filter_redeem'];
                }

                if (isset($this->request->get['filter_date_added'])) {
                    $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
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

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
									
		if (!isset($this->request->get['redeem_id'])) {
			$this->data['action'] = $this->url->link('sale/redeem/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('sale/redeem/update', 'token=' . $this->session->data['token'] . '&redeem_id=' . $this->request->get['redeem_id'] . $url, 'SSL');
		}
		
		$this->data['cancel'] = $this->url->link('sale/redeem', 'token=' . $this->session->data['token'] . $url, 'SSL');
  		
		if (isset($this->request->get['redeem_id']) && (!$this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$redeem_info = $this->model_sale_redeem->getRedeem($this->request->get['redeem_id']);
    	}
		
		$this->data['token'] = $this->session->data['token'];

        if (isset($this->request->post['product_id'])) {
      		$this->data['product_id'] = $this->request->post['product_id'];
    	} elseif (!empty($redeem_info)) {
			$this->data['product_id'] = $redeem_info['product_id'];
		} else {
      		$this->data['product_id'] = '';
    	}
        
        if (isset($this->request->post['order_id'])) {
      		$this->data['order_id'] = $this->request->post['order_id'];
    	} elseif (!empty($redeem_info)) {
			$this->data['order_id'] = $redeem_info['order_id'];
		} else {
      		$this->data['order_id'] = '';
    	}
        
    	if (isset($this->request->post['code'])) {
      		$this->data['code'] = $this->request->post['code'];
    	} elseif (!empty($redeem_info)) {
			$this->data['code'] = $redeem_info['code'];
		} else {
      		$this->data['code'] = '';
    	}
        
        if (isset($this->request->post['status'])) {
      		$this->data['status'] = $this->request->post['status'];
    	} elseif (!empty($redeem_info)) {
			$this->data['status'] = $redeem_info['status'];
		} else {
      		$this->data['status'] = '';
    	}
        
        if (isset($this->request->post['redeem'])) {
      		$this->data['redeem'] = $this->request->post['redeem'];
    	} elseif (!empty($redeem_info)) {
			$this->data['redeem'] = $redeem_info['redeem'];
		} else {
      		$this->data['redeem'] = '';
    	}
        
        $this->data['product_link'] = $this->url->link('catalog/product/update', 'token=' . $this->session->data['token'] . '&product_id=' . $this->data['product_id'] . $url, 'SSL');
        
        $this->data['order_link'] = $this->url->link('sale/order/info', 'token=' . $this->session->data['token'] . '&order_id=' . $this->data['order_id'] . $url, 'SSL');

        $this->load->model('catalog/product');
	$product_info = $this->model_catalog_product->getProduct($this->data['product_id']);
        $this->data['product_model'] = $product_info['name'];
        
		$this->template = 'sale/redeem_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());		
  	}
	
  	private function validateForm() {
    	if (!$this->user->hasPermission('modify', 'sale/redeem')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
	
        $redeem_info = $this->model_sale_redeem->getRedeemByCode($this->request->post['code']);

        if ($redeem_info) {
                if (!isset($this->request->get['redeem_id'])) {
                        $this->error['warning'] = $this->language->get('error_exists');
                } elseif ($redeem_info['redeem_id'] != $this->request->get['redeem_id'])  {
                        $this->error['warning'] = $this->language->get('error_exists');
                }
        }  	

    	if (!$this->error) {
      		return true;
    	} else {
      		return false;
    	}
  	}

  	private function validateDelete() {
    	if (!$this->user->hasPermission('modify', 'sale/redeem')) {
      		$this->error['warning'] = $this->language->get('error_permission');  
    	}
		
		$this->load->model('sale/order');
		
		foreach ($this->request->post['selected'] as $redeem_id) {
			$order_redeem_info = $this->model_sale_order->getOrderRedeemByRedeemId($redeem_id);
			
		}
		
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}	
	
	public function send() {
    	$this->language->load('sale/redeem');
		
		$json = array();
    	
     	if (!$this->user->hasPermission('modify', 'sale/redeem')) {
      		$json['error'] = $this->language->get('error_permission'); 
    	} elseif (isset($this->request->get['redeem_id'])) {
			$this->load->model('sale/redeem');
			
			$this->model_sale_redeem->sendRedeem($this->request->get['redeem_id']);
			
			$json['success'] = $this->language->get('text_sent');
		}	
		
		$this->response->setOutput(json_encode($json));			
  	}	
}
?>