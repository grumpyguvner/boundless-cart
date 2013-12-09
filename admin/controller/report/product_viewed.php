<?php
class ControllerReportProductViewed extends Controller {
	public function index() {     
		$this->load->language('report/product_viewed');

		$this->document->setTitle($this->language->get('heading_title'));
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';
				
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
			'href'      => $this->url->link('report/product_viewed', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);		
		
		$this->load->model('report/product');
		
		$data = array(
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
				
		$product_viewed_total = $this->model_report_product->getTotalProductsViewed($data); 
		
		$product_views_total = $this->model_report_product->getTotalProductViews(); 
		
		$this->data['products'] = array();
		
		$results = $this->model_report_product->getProductsViewed($data);
		
		foreach ($results as $result) {
			if ($result['viewed']) {
				$percent = round($result['viewed'] / $product_views_total * 100, 2);
			} else {
				$percent = 0;
			}
					
			$this->data['products'][] = array(
				'name'    => $result['name'],
				'model'   => $result['model'],
				'viewed'  => $result['viewed'],
				'percent' => $percent . '%'			
			);
		}
 		
		$this->data['heading_title'] = $this->language->get('heading_title');
		 
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		
		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_model'] = $this->language->get('column_model');
		$this->data['column_viewed'] = $this->language->get('column_viewed');
		$this->data['column_percent'] = $this->language->get('column_percent');
		
		$this->data['button_reset'] = $this->language->get('button_reset');
        
		$this->data['button_export'] = $this->language->get('Export');
		$this->data['export'] = $this->url->link('report/product_viewed/download', 'token=' . $this->session->data['token'], 'SSL');

		$url = '';		
				
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
				
		$this->data['reset'] = $this->url->link('report/product_viewed/reset', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
						
		$pagination = new Pagination();
		$pagination->total = $product_viewed_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('report/product_viewed', 'token=' . $this->session->data['token'] . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();
				 
		$this->template = 'report/product_viewed.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	public function reset() {
		$this->load->language('report/product_viewed');
		
		$this->load->model('report/product');
		
		$this->model_report_product->reset();
		
		$this->session->data['success'] = $this->language->get('text_success');
		
		$this->redirect($this->url->link('report/product_viewed', 'token=' . $this->session->data['token'], 'SSL'));
	}
    
	public function download() {
		$this->load->language('report/product_viewed');
        
        // Get Model
		$this->load->model('report/product');
        
        // build column headings
        $headings = array();
        
        $headings[] = $this->language->get('column_model');
        $headings[] = $this->language->get('column_name');
        $headings[] = $this->language->get('column_viewed');
        $headings[] = $this->language->get('column_percent');
        
        /// retrieve and build data for excel - taking in account for variable sizes that not all products have
        $product_viewed_total = $this->model_report_product->getTotalProductsViewed(); 
		
		$product_views_total = $this->model_report_product->getTotalProductViews(); 
        
        $results = $this->model_report_product->getProductsViewed();
        
		$data = array();
		foreach ($results as $rownum => $result) {
			if ($result['viewed']) {
				$percent = round($result['viewed'] / $product_views_total * 100, 2);
			} else {
				$percent = 0;
			}
					
			$data[$rownum][] = $result['name'];
			$data[$rownum][] = $result['model'];
			$data[$rownum][] = $result['viewed'];
			$data[$rownum][] = $percent . '%';
		}
        
        // create data formats per column
        $settings = array();
        
        $settings[] = 'text';
        $settings[] = 'text';
        $settings[] = 'text';
        $settings[] = 'text';
        
        // load excel model
		$this->load->model('report/export');
        // send to excel builder and return spreadsheet
        $this->model_report_export->download('report_product_viewed', 'Products Viewed Report', $data, $headings, $settings);
        
		exit;
	}
}
?>