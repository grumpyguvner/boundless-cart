<?php 
class ControllerSaleRedeemTheme extends Controller { 
	private $error = array();
   
  	public function index() {
		$this->load->language('sale/redeem_theme');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/redeem_theme');
		
    	$this->getList();
  	}
              
  	public function insert() {
		$this->load->language('sale/redeem_theme');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/redeem_theme');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
      		$this->model_sale_redeem_theme->addRedeemTheme($this->request->post);
		  	
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
      		$this->redirect($this->url->link('sale/redeem_theme', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
	
    	$this->getForm();
  	}

  	public function update() {
		$this->load->language('sale/redeem_theme');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/redeem_theme');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
	  		$this->model_sale_redeem_theme->editRedeemTheme($this->request->get['redeem_theme_id'], $this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('sale/redeem_theme', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
	
    	$this->getForm();
  	}

  	public function delete() {
		$this->load->language('sale/redeem_theme');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/redeem_theme');
		
    	if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $redeem_theme_id) {
				$this->model_sale_redeem_theme->deleteRedeemTheme($redeem_theme_id);
			}
			      		
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('sale/redeem_theme', 'token=' . $this->session->data['token'] . $url, 'SSL'));
   		}
	
    	$this->getList();
  	}
    
  	private function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'vtd.name';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
				
		$url = '';
			
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
			'href'      => $this->url->link('sale/redeem_theme', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
							
		$this->data['insert'] = $this->url->link('sale/redeem_theme/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('sale/redeem_theme/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	

		$this->data['redeem_themes'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
		
		$redeem_theme_total = $this->model_sale_redeem_theme->getTotalRedeemThemes();
	
		$results = $this->model_sale_redeem_theme->getRedeemThemes($data);
 
    	foreach ($results as $result) {
			$action = array();
			
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('sale/redeem_theme/update', 'token=' . $this->session->data['token'] . '&redeem_theme_id=' . $result['redeem_theme_id'] . $url, 'SSL')
			);
						
			$this->data['redeem_themes'][] = array(
				'redeem_theme_id' => $result['redeem_theme_id'],
				'name'             => $result['name'],
				'selected'         => isset($this->request->post['selected']) && in_array($result['redeem_theme_id'], $this->request->post['selected']),
				'action'           => $action
			);
		}	
	
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_name'] = $this->language->get('column_name');
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

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_name'] = $this->url->link('sale/redeem_theme', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $redeem_theme_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('sale/redeem_theme', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'sale/redeem_theme_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
  	}
  
  	private function getForm() {
     	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
 		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');			
   	
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_content'] = $this->language->get('entry_content');

    	$this->data['button_save'] = $this->language->get('button_save');
    	$this->data['button_cancel'] = $this->language->get('button_cancel');
    
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
		
 		if (isset($this->error['content'])) {
			$this->data['error_content'] = $this->error['content'];
		} else {
			$this->data['error_content'] = '';
		}
				
		$url = '';
			
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
			'href'      => $this->url->link('sale/redeem_theme', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
		
		if (!isset($this->request->get['redeem_theme_id'])) {
			$this->data['action'] = $this->url->link('sale/redeem_theme/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('sale/redeem_theme/update', 'token=' . $this->session->data['token'] . '&redeem_theme_id=' . $this->request->get['redeem_theme_id'] . $url, 'SSL');
		}
					
		$this->data['cancel'] = $this->url->link('sale/redeem_theme', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		if (isset($this->request->get['redeem_theme_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$redeem_theme_info = $this->model_sale_redeem_theme->getRedeemTheme($this->request->get['redeem_theme_id']);
    	}
		
		$this->data['token'] = $this->session->data['token'];
		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		
		if (isset($this->request->post['redeem_theme_description'])) {
			$this->data['redeem_theme_description'] = $this->request->post['redeem_theme_description'];
		} elseif (isset($this->request->get['redeem_theme_id'])) {
			$this->data['redeem_theme_description'] = $this->model_sale_redeem_theme->getRedeemThemeDescriptions($this->request->get['redeem_theme_id']);
		} else {
			$this->data['redeem_theme_description'] = array();
		}
		
		if (isset($this->request->post['content'])) {
			$this->data['content'] = $this->request->post['content'];
		} elseif (!empty($redeem_theme_info)) {
			$this->data['content'] = $redeem_theme_info['content'];
		} else {
			$this->data['content'] = '';
		}
				
		$this->template = 'sale/redeem_theme_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());	
  	}
  	
	private function validateForm() {
    	if (!$this->user->hasPermission('modify', 'sale/redeem_theme')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
	
    	foreach ($this->request->post['redeem_theme_description'] as $language_id => $value) {
      		if ((utf8_strlen($value['name']) < 3) || (utf8_strlen($value['name']) > 32)) {
        		$this->error['name'][$language_id] = $this->language->get('error_name');
      		}
    	}
		
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}

  	private function validateDelete() {
		if (!$this->user->hasPermission('modify', 'sale/redeem_theme')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
		
		$this->load->model('sale/redeem');
		
		foreach ($this->request->post['selected'] as $redeem_theme_id) {
			$redeem_total = $this->model_sale_redeem->getTotalRedeemsByRedeemThemeId($redeem_theme_id);
		
			if ($redeem_total) {
	  			$this->error['warning'] = sprintf($this->language->get('error_redeem'), $redeem_total);	
			}  
	  	}
		
		if (!$this->error) { 
	  		return true;
		} else {
	  		return false;
		}
  	}	  
}
?>