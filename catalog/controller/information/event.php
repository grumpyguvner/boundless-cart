<?php 
class ControllerInformationEvent extends Controller {
	public function index() {  
    	$this->language->load('information/event');
		
		$this->load->model('catalog/event');
		$this->load->model('tool/image'); 
		$this->data['breadcrumbs'] = array();
		
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);
		
		if (isset($this->request->get['event_id'])) {
			$event_id = $this->request->get['event_id'];
		} else {
			$event_id = 0;
		}
		
		$event_info = $this->model_catalog_event->getEvent($event_id);
   		
		if ($event_info) {
	  		$this->document->setTitle($event_info['title']); 

      		$this->data['breadcrumbs'][] = array(
        		'text'      => $event_info['title'],
				'href'      => $this->url->link('information/event', 'event_id=' .  $event_id),      		
        		'separator' => $this->language->get('text_separator')
      		);		
						
      		$this->data['heading_title'] = $event_info['title'];
      		
      		$this->data['button_continue'] = $this->language->get('button_continue');
			
			$this->data['description'] = html_entity_decode($event_info['description'], ENT_QUOTES, 'UTF-8');
			
			$this->data['event_date'] = date('M d, Y',strtotime($event_info['event_date']));
			
			$this->data['event_id'] = $event_info['event_id'];
			$this->data['allow_subscribe'] = $event_info['allow_subscribe'];
			$this->data['button_sub'] = $this->language->get('button_sub');
                        $this->data['button_back'] = $this->language->get('button_back');
      		
			$this->data['continue'] = $this->url->link('common/home');
			$this->data['no_of_sub'] = $event_info['no_of_sub'];
			$this->data['entry_products'] = $this->language->get('entry_products');
                        
                        if (count($this->data['breadcrumbs']) > 1) {
                            $count = count($this->data['breadcrumbs']) - 2;
                            $this->data['text_breadcrumb_back'] = sprintf($this->language->get('text_breadcrumb_back'), $this->data['breadcrumbs'][$count]['text']);
                        } else {
                            $this->data['text_breadcrumb_back'] = '';
                        }
			
			if ($event_info['image']) {
				$this->data['thumb'] = $this->model_tool_image->resize($event_info['image'],150, 150);
			} else {
				$this->data['thumb'] = '';
			}
			$q_no_sub = "select null from ".DB_PREFIX."event_subscribers where event_id='".$event_info['event_id']."'";
			$query_no_sub = $this->db->query($q_no_sub);
			$results_no_sub = $query_no_sub->rows;
			$this->data['no_sub'] = count($query_no_sub->rows);
			
			# events
			$this->data['products'] = array();
			if($event_info['product_related']!=''){
				$this->load->model('catalog/product');
				$product_related = unserialize($event_info['product_related']);
				foreach ($product_related as $pid) {
					$pinfo = $this->model_catalog_product->getProduct($pid);
                                        $this->data['products'][$pid]['thumb'] = $this->model_tool_image->resize($pinfo['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
					$this->data['products'][$pid]['name'] = $pinfo['name'];
					$this->data['products'][$pid]['href'] = $this->url->link('product/product', 'product_id=' . $pid);
                                        $this->data['products'][$pid]['price'] = $this->currency->format($this->tax->calculate($pinfo['price'], $pinfo['tax_class_id'], $this->config->get('config_tax')));
                                        $this->data['products'][$pid]['special'] = $this->currency->format($this->tax->calculate($pinfo['special'], $pinfo['tax_class_id'], $this->config->get('config_tax')));
                                        $this->data['products'][$pid]['saving_percent'] = $pinfo['saving_percent'];
                                        $this->data['products'][$pid]['new'] = $pinfo['new'];
				}
			}
			
			
			$this->setTemplate('information/event.tpl');
			
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
      		$this->data['breadcrumbs'][] = array(
        		'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('information/event', 'event_id=' . $event_id),
        		'separator' => $this->language->get('text_separator')
      		);
				
	  		$this->document->setTitle($this->language->get('text_error'));
			
      		$this->data['heading_title'] = $this->language->get('text_error');

      		$this->data['text_error'] = $this->language->get('text_error');

      		$this->data['button_continue'] = $this->language->get('button_continue');

      		$this->data['continue'] = $this->url->link('common/home');
                
                if (count($this->data['breadcrumbs']) > 1) {
                    $count = count($this->data['breadcrumbs']) - 2;
                    $this->data['text_breadcrumb_back'] = sprintf($this->language->get('text_breadcrumb_back'), $this->data['breadcrumbs'][$count]['text']);
                } else {
                    $this->data['text_breadcrumb_back'] = '';
                }
                

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
	
	
	public function events(){
		$this->language->load('information/event');
		$this->load->model('catalog/event');
		$this->load->model('tool/image'); 
		$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);
		
		$this->data['breadcrumbs'][] = array(
        	'text'      =>  $this->language->get('heading_title'),
			'href'      =>  $this->url->link('information/event/events'),
        	'separator' => $this->language->get('text_separator')
      	);
		
		$this->document->setTitle($this->language->get('heading_title')); 
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['button_sub'] = $this->language->get('button_sub');
		$this->data['entry_products'] = $this->language->get('entry_products');
		
                if (count($this->data['breadcrumbs']) > 1) {
                    $count = count($this->data['breadcrumbs']) - 2;
                    $this->data['text_breadcrumb_back'] = sprintf($this->language->get('text_breadcrumb_back'), $this->data['breadcrumbs'][$count]['text']);
                } else {
                    $this->data['text_breadcrumb_back'] = '';
                }
                
		$wh = '';
		if(isset($this->request->get['date'])){
			$wh =" AND DATE_FORMAT(i.event_date,'%Y-%m-%d')='".$this->request->get['date']."'";
		}
		$this->data['available_events'] = array();
		$this->load->model('catalog/product');
		if($this->model_catalog_event->getEvents($wh)){
			$available_events = $this->model_catalog_event->getevents($wh);
			foreach($available_events as $k=>$v){
				$this->data['available_events'][$k] = $v;
				//if($k == 'product_related'){
					if($v['product_related']!=''){
						$product_related = unserialize($v['product_related']);
						foreach ($product_related as $pid) {
							$pinfo = $this->model_catalog_product->getProduct($pid);
							$this->data['available_events'][$k]['products'][$pid]['name'] = $pinfo['name'];
							$this->data['available_events'][$k]['products'][$pid]['href'] = $this->url->link('product/product', 'product_id=' . $pid);
						}
					}
				//}
			}
		}
		
		//echo '<pre>';print_r($this->data['available_events']);echo '</pre>';
		
		$this->setTemplate('information/events.tpl');
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);
		
		$this->data['text_error'] = $this->language->get('text_error');
      	$this->data['button_continue'] = $this->language->get('button_continue');
		$this->data['continue'] =$this->url->link('common/home');
	
		$this->response->setOutput($this->render());
	}
	public function subscribe(){
		$this->language->load('information/event');
		$this->load->model('catalog/event');
		
		$this->data['button_sub'] = $this->language->get('button_sub');
		$this->data['button_submit'] = $this->language->get('button_submit');
		
		$this->data['text_message'] = '';
                $this->data['text_save'] = $this->language->get('text_save');
                $this->data['text_rrp'] = $this->language->get('text_rrp');
                $this->data['text_pay'] = $this->language->get('text_pay');
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			$this->db->query("
			insert into ".DB_PREFIX."event_subscribers set
			event_id = '".$this->request->get['event_id']."',
			fname = '".$this->request->post['fname']."',
			lname = '".$this->request->post['lname']."',
			phone = '".$this->request->post['phone']."',
			email = '".$this->request->post['email']."',
			comments = '".$this->request->post['comments']."',
			dtadd = NOW()
			");
			$this->data['text_message'] = '<div class="success">'.$this->language->get('text_message')."</div>";
		}
		
		if (isset($this->request->get['event_id'])) {
			$event_id = $this->request->get['event_id'];
			$event_info = $this->model_catalog_event->getEvent($event_id);
		}
		$this->data['heading_title'] = $this->language->get('button_sub')."(".$event_info['title'].")";
		
		
		$this->data['entry_fname'] = $this->language->get('entry_fname');
		$this->data['entry_lname'] = $this->language->get('entry_lname');
		$this->data['entry_phone'] = $this->language->get('entry_phone');
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_comments'] = $this->language->get('entry_comments');
		
		
		
		$this->setTemplate('information/event_sub.tpl');
		
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