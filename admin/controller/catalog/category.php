<?php 
class ControllerCatalogCategory extends Controller { 
	private $error = array();
 
	public function index() {
		$this->load->language('catalog/category');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/category');
		 
		$this->getList();
	}

	public function insert() {
		$this->load->language('catalog/category');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/category');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$new_id = $this->model_catalog_category->addCategory($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');
	  
			$url = '';
                        
                        //2012-06 MH Added new_id to url so that api calls can fetch id
                        $url .= '&new_id=' . $new_id;
			
			$this->redirect($this->url->link('catalog/category', 'token=' . $this->session->data['token'] . $url, 'SSL')); 
		}

		$this->getForm();
	}

	public function update() {
		$this->load->language('catalog/category');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/category');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_category->editCategory($this->request->get['category_id'], $this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->redirect($this->url->link('catalog/category', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('catalog/category');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/category');
		
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $category_id) {
				$this->model_catalog_category->deleteCategory($category_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('catalog/category', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->getList();
	}
	
	private function getList() {
   		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/category', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
									
		$this->data['insert'] = $this->url->link('catalog/category/insert', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['delete'] = $this->url->link('catalog/category/delete', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['categories'] = array();
		
		$results = $this->model_catalog_category->getCategories(0);

		foreach ($results as $result) {
			$action = array();
			
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('catalog/category/update', 'token=' . $this->session->data['token'] . '&category_id=' . $result['category_id'], 'SSL')
			);
					
			$this->data['categories'][] = array(
				'category_id' => $result['category_id'],
				'name'        => $result['name'],
				'sort_order'  => $result['sort_order'],
				'selected'    => isset($this->request->post['selected']) && in_array($result['category_id'], $this->request->post['selected']),
				'action'      => $action
			);
		}
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
		$this->data['column_action'] = $this->language->get('column_action');

		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
 
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
		
		$this->template = 'catalog/category_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	private function getForm() {
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');		
		$this->data['text_enabled'] = $this->language->get('text_enabled');
                $this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_percent'] = $this->language->get('text_percent');
		$this->data['text_amount'] = $this->language->get('text_amount');
                $this->data['text_select_all'] = $this->language->get('text_select_all');
                $this->data['text_unselect_all'] = $this->language->get('text_unselect_all');
				
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_meta_title'] = $this->language->get('entry_meta_title');
		$this->data['entry_meta_keyword'] = $this->language->get('entry_meta_keyword');
		$this->data['entry_meta_description'] = $this->language->get('entry_meta_description');
		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_keyword'] = $this->language->get('entry_keyword');
		$this->data['entry_filter'] = $this->language->get('entry_filter');
		$this->data['entry_parent'] = $this->language->get('entry_parent');
		$this->data['entry_googlebase_text'] = $this->language->get('entry_googlebase_text');
		$this->data['entry_googlebase_xml'] = $this->language->get('entry_googlebase_xml');
		$this->data['entry_is_filter'] = $this->language->get('entry_is_filter');
		$this->data['entry_members_only'] = $this->language->get('entry_members_only');
		$this->data['entry_date_start'] = $this->language->get('entry_date_start');
		$this->data['entry_date_end'] = $this->language->get('entry_date_end');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_top'] = $this->language->get('entry_top');
		$this->data['entry_column'] = $this->language->get('entry_column');		
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

                $this->data['tab_general'] = $this->language->get('tab_general');
                $this->data['tab_data'] = $this->language->get('tab_data');
		$this->data['tab_design'] = $this->language->get('tab_design');
		$this->data['tab_merchandising'] = $this->language->get('tab_merchandising');
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
	
 		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = array();
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/category', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		if (!isset($this->request->get['category_id'])) {
			$this->data['action'] = $this->url->link('catalog/category/insert', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$this->data['action'] = $this->url->link('catalog/category/update', 'token=' . $this->session->data['token'] . '&category_id=' . $this->request->get['category_id'], 'SSL');
		}
		
		$this->data['cancel'] = $this->url->link('catalog/category', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['token'] = $this->session->data['token'];

		if (isset($this->request->get['category_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
                        $category_info = $this->model_catalog_category->getCategory($this->request->get['category_id']);
                }
		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['category_description'])) {
			$this->data['category_description'] = $this->request->post['category_description'];
		} elseif (isset($this->request->get['category_id'])) {
			$this->data['category_description'] = $this->model_catalog_category->getCategoryDescriptions($this->request->get['category_id']);
		} else {
			$this->data['category_description'] = array();
		}

		$categories = $this->model_catalog_category->getCategories(0);

		// Remove own id from list
		if (!empty($category_info)) {
			foreach ($categories as $key => $category) {
				if ($category['category_id'] == $category_info['category_id']) {
					unset($categories[$key]);
				}
			}
		}

		$this->data['categories'] = $categories;

		if (isset($this->request->post['parent_id'])) {
			$this->data['parent_id'] = $this->request->post['parent_id'];
		} elseif (!empty($category_info)) {
			$this->data['parent_id'] = $category_info['parent_id'];
		} else {
			$this->data['parent_id'] = 0;
		}
                
                // Filters
		$this->load->model('catalog/filter');
                
                $this->data['has_filters'] = $this->model_catalog_filter->getTotalFilterGroups();
                $filters = $this->model_catalog_filter->getFilters(); 
                
                if (isset($this->request->post['category_filter'])) {
                    $this->data['category_filter_selected'] = $this->request->post['category_filter'];
                } elseif (isset($this->request->get['category_id'])) {
                    $this->data['category_filter_selected'] = $this->model_catalog_category->getCategoryFilters($this->request->get['category_id']);
                } else {
                    $this->data['category_filter_selected'] = array();
                }
			
		$this->data['category_filters'] = array();
		
                foreach ($filters as $filter_info) {
                        $this->data['category_filters'][] = array(
                                'filter_id' => $filter_info['filter_id'],
                                'name'      => $filter_info['group'] . ' &gt; ' . $filter_info['name']
                        );
                }
		
		if (isset($this->request->post['googlebase_text'])) {
			$this->data['googlebase_text'] = $this->request->post['googlebase_text'];
		} elseif (!empty($category_info)) {
			$this->data['googlebase_text'] = $category_info['googlebase_text'];
		} else {
			$this->data['googlebase_text'] = '';
		}

		if (isset($this->request->post['googlebase_xml'])) {
			$this->data['googlebase_xml'] = $this->request->post['googlebase_xml'];
		} elseif (!empty($category_info)) {
			$this->data['googlebase_xml'] = $category_info['googlebase_xml'];
		} else {
			$this->data['googlebase_xml'] = '';
		}
						
		$this->load->model('setting/store');
		
		$this->data['stores'] = $this->model_setting_store->getStores();
		
		if (isset($this->request->post['category_store'])) {
			$this->data['category_store'] = $this->request->post['category_store'];
		} elseif (isset($this->request->get['category_id'])) {
			$this->data['category_store'] = $this->model_catalog_category->getCategoryStores($this->request->get['category_id']);
		} else {
			$this->data['category_store'] = array(0);
		}			
		
		if (isset($this->request->post['keyword'])) {
			$this->data['keyword'] = $this->request->post['keyword'];
		} elseif (!empty($category_info)) {
			$this->data['keyword'] = $category_info['keyword'];
		} else {
			$this->data['keyword'] = '';
		}

		if (isset($this->request->post['image'])) {
			$this->data['image'] = $this->request->post['image'];
		} elseif (!empty($category_info)) {
			$this->data['image'] = $category_info['image'];
		} else {
			$this->data['image'] = '';
		}
		
		$this->load->model('tool/image');

		if (isset($this->request->post['image']) && file_exists(DIR_IMAGE . $this->request->post['image'])) {
			$this->data['thumb'] = $this->model_tool_image->resize($this->request->post['image'], 100, 100);
		} elseif (!empty($category_info) && $category_info['image'] && file_exists(DIR_IMAGE . $category_info['image'])) {
			$this->data['thumb'] = $this->model_tool_image->resize($category_info['image'], 100, 100);
		} else {
			$this->data['thumb'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}
		
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		
		if (isset($this->request->post['top'])) {
			$this->data['top'] = $this->request->post['top'];
		} elseif (!empty($category_info)) {
			$this->data['top'] = $category_info['top'];
		} else {
			$this->data['top'] = 0;
		}
		
		if (isset($this->request->post['column'])) {
			$this->data['column'] = $this->request->post['column'];
		} elseif (!empty($category_info)) {
			$this->data['column'] = $category_info['column'];
		} else {
			$this->data['column'] = 1;
		}
				
		if (isset($this->request->post['sort_order'])) {
			$this->data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($category_info)) {
			$this->data['sort_order'] = $category_info['sort_order'];
		} else {
			$this->data['sort_order'] = 0;
		}

		if (isset($this->request->post['members_only'])) {
			$this->data['members_only'] = $this->request->post['members_only'];
		} elseif (!empty($category_info)) {
			$this->data['members_only'] = $category_info['members_only'];
		} else {
			$this->data['members_only'] = 0;
		}

                if (isset($this->request->post['date_start_date'])) {
                    $this->data['date_start_date'] = $this->request->post['date_start_date'];
                    $this->data['date_start_time'] = $this->request->post['date_start_time'];
                } elseif (!empty($category_info) && strtotime($category_info['date_start'])) {
                    $this->data['date_start_date'] = date('Y-m-d', strtotime($category_info['date_start']));
                    $this->data['date_start_time'] = date('H:i', strtotime($category_info['date_start']));
                } else {
                    $this->data['date_start_date'] = '';
                    $this->data['date_start_time'] = '';
                }

                if (isset($this->request->post['date_end_date'])) {
                    $this->data['date_end_date'] = $this->request->post['date_end_date'];
                    $this->data['date_end_time'] = $this->request->post['date_end_time'];
                } elseif (!empty($category_info) && strtotime($category_info['date_end'])) {
                    $this->data['date_end_date'] = date('Y-m-d', strtotime($category_info['date_end']));
                    $this->data['date_end_time'] = date('H:i', strtotime($category_info['date_end']));
                } else {
                    $this->data['date_end_date'] = '';
                    $this->data['date_end_time'] = '';
                }
		
		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (!empty($category_info)) {
			$this->data['status'] = $category_info['status'];
		} else {
			$this->data['status'] = 1;
		}
				
		if (isset($this->request->post['category_layout'])) {
			$this->data['category_layout'] = $this->request->post['category_layout'];
		} elseif (isset($this->request->get['category_id'])) {
			$this->data['category_layout'] = $this->model_catalog_category->getCategoryLayouts($this->request->get['category_id']);
		} else {
			$this->data['category_layout'] = array();
		}

		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
                
                $this->data['merchandising'] = ($this->extensions->isInstalled('merchandising', 'module') && isset($this->request->get['category_id'])) ? true : false;
                
                if ($this->data['merchandising'])
                {
                    $this->load->language('catalog/product');
                    
                    $this->data['column_sort_order'] = $this->language->get('column_sort_order');
                    $this->data['column_image'] = $this->language->get('column_image');
                    $this->data['column_name'] = $this->language->get('column_name');
                    $this->data['column_model'] = $this->language->get('column_model');
                    $this->data['column_price'] = $this->language->get('column_price');
                    $this->data['column_quantity'] = $this->language->get('column_quantity');
                    $this->data['column_status'] = $this->language->get('column_status');
                    $this->data['column_action'] = $this->language->get('column_action');
                    
                    $this->load->model('catalog/product');
                    
                    $this->data['products'] = array();

                    $data = array('filter_category_id' => $this->request->get['category_id']);

                    $this->load->model('tool/image');

                    $results = $this->model_catalog_product->getProducts($data);

                    foreach ($results as $result) {
                        $action = array();

                        $action[] = array(
                            'text' => $this->language->get('text_edit'),
                            'href' => $this->url->link('catalog/product/update', 'token=' . $this->session->data['token'] . '&product_id=' . $result['product_id'], 'SSL')
                        );

                        if ($result['image'] && file_exists(DIR_IMAGE . $result['image'])) {
                            $image = $this->model_tool_image->resize($result['image'], 40, 40);
                        } else {
                            $image = $this->model_tool_image->resize('no_image.jpg', 40, 40);
                        }

                        $special = false;

                        $product_specials = $this->model_catalog_product->getProductSpecials($result['product_id']);

                        foreach ($product_specials as $product_special) {
                            if (($product_special['date_start'] == '0000-00-00' || $product_special['date_start'] < date('Y-m-d')) && ($product_special['date_end'] == '0000-00-00' || $product_special['date_end'] > date('Y-m-d'))) {
                                $special = $product_special['price'];

                                break;
                            }
                        }

                        $this->data['products'][] = array(
                            'product_id' => $result['product_id'],
                            'name' => $result['name'],
                            'model' => $result['model'],
                            'price' => $result['price'],
                            'special' => $special,
                            'image' => $image,
                            'quantity' => $result['quantity'],
                            'status' => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
                            'selected' => isset($this->request->post['selected']) && in_array($result['product_id'], $this->request->post['selected']),
                            'action' => $action
                        );
                    }
                }
						
		$this->template = 'catalog/category_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/category')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['category_description'] as $language_id => $value) {
			if ((utf8_strlen($value['name']) < 2) || (utf8_strlen($value['name']) > 255)) {
				$this->error['name'][$language_id] = $this->language->get('error_name');
			}
		}
		
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
					
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/category')) {
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