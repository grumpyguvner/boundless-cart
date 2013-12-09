<?php

class ControllerReportRegisterYourProduct extends Controller {

    public function index() {
        $this->load->language('report/register_your_product');

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
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token']),
            'text' => $this->language->get('text_home'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'href' => $this->url->link('report/register_your_product', 'token=' . $this->session->data['token'] . $url),
            'text' => $this->language->get('heading_title'),
            'separator' => ' :: '
        );

        $this->load->model('report/customer');

        $this->data['customers'] = array();

        $data = array(
            'start' => ($page - 1) * 20,
            'limit' => 20
        );

        $customer_total = $this->model_report_customer->getTotalRegisterYourProduct($data);

        $results = $this->model_report_customer->getRegisterYourProduct($data);

        foreach ($results as $result) {

            $this->data['customers'][] = array(
                'name' => $result['name'],
                'email' => $result['email'],
                'location' => $result['location'],
                'barcode' => $result['barcode'],
                'date_purchased' => $result['date_purchased']
            );
        }

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_no_results'] = $this->language->get('text_no_results');

        $this->data['column_name'] = $this->language->get('column_name');
        $this->data['column_date_purchased'] = $this->language->get('column_date_purchased');
        $this->data['column_email'] = $this->language->get('column_email');
        $this->data['column_location'] = $this->language->get('column_location');
        $this->data['column_barcode'] = $this->language->get('column_barcode');

        $this->data['button_export'] = $this->language->get('button_export');
        $this->data['export'] = $this->url->link('report/register_your_product/download', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['token'] = $this->session->data['token'];

        $url = '';

        $pagination = new Pagination();
        $pagination->total = $customer_total;
        $pagination->page = $page;
        $pagination->limit = 20;
        $pagination->url = $this->url->link('report/register_your_product', 'token=' . $this->session->data['token'] . $url . '&page={page}');

        $this->data['pagination'] = $pagination->render();

        $this->template = 'report/register_your_product.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    public function download() {
        $this->load->language('report/register_your_product');

        // Get Model
        $this->load->model('report/customer');

        // build column headings
        $headings = array();

        $headings[] = $this->language->get('column_name');
        $headings[] = $this->language->get('column_email');
        $headings[] = $this->language->get('column_location');
        $headings[] = $this->language->get('column_barcode');
        $headings[] = $this->language->get('column_date_purchased');

        /// retrieve and build data for excel - taking in account for variable sizes that not all products have
        $results = $this->model_report_customer->getRegisterYourProduct();
        
        $data = array();

        foreach ($results as $rownum => $row) {
            $data[$rownum][] = $row['name'];
            $data[$rownum][] = $row['email'];
            $data[$rownum][] = $row['location'];
            $data[$rownum][] = $row['barcode'];
            $data[$rownum][] = $row['date_purchased'];
        }

        // create data formats per column
        $settings = array();

        $settings[] = 'text';
        $settings[] = 'text';
        $settings[] = 'text';
        $settings[] = 'text';
        $settings[] = 'text';

        // load excel model
        $this->load->model('report/export');
        // send to excel builder and return spreadsheet
        $this->model_report_export->download('report_register_your_product', 'Product Registration', $data, $headings, $settings);
    }

}

?>