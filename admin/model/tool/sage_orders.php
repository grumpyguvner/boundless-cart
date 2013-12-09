<?php

class ModelToolSageOrders extends Model {

    private $languageId = 0;
    
    private $tax_codes = array();

    protected function getDefaultLanguageId() {
        $code = $this->config->get('config_language');
        $sql = "SELECT language_id FROM `" . DB_PREFIX . "language` WHERE code = '$code'";
        $result = $this->db->query($sql);
        $this->languageId = 1;
        if ($result->rows) {
            foreach ($result->rows as $row) {
                $this->languageId = $row['language_id'];
                break;
            }
        }
        return $this->languageId;
    }

    function runSchedulerOperation() {
        $this->import();
    }

    function import() {
        
        $debug = true;

        //Prevent php from timing out during import
        set_time_limit(0);
        
        // Initialise the tax codes array from Sage
        $this->fetchSageTaxCodes();

        $this->log->write("Begining export of order information to Sage");
        $this->languageId = $this->getDefaultLanguageId();
        
        // Load XML Feed to fetch detail
        $this->load->helper('fetchxml');
        $this->load->model('sale/order');
        $this->load->model('sale/customer');
        $this->load->model('catalog/product');
        $this->load->model('tool/sage_products');

        $order_id = 0;
        $error = false;
        // Check & update existing record cache
        $sql = "SELECT o.order_id 
            FROM `" . DB_PREFIX . "order` o 
                LEFT JOIN `" . DB_PREFIX . "sage_order` so ON (o.order_id = so.order_id) 
            WHERE so.order_id IS NULL 
            ORDER BY o.order_id";
        $result = $this->db->query($sql);
        if ($result->rows) {
            foreach ($result->rows as $row) {
                $errors = array();
                $order_info = $this->model_sale_order->getOrder($row['order_id']);
                if (!empty($order_info) && $this->readyToPost($row['order_id'])) {
                    $this->log->write("processing " . $order_info['order_id'] . ":" . $order_info['invoice_prefix'] . ":" . $order_info['customer_name']);

                    #set header
                    $order_xml =
                            '<order>' . "\n" .
                            '<gross_pricing>true</gross_pricing>' . "\n" .
                            '<document_date>' . $order_info['date_added'] . '</document_date>' . "\n" .
                            '<customer_ref>' . substr((defined('SITE_REGION') ? SITE_REGION : "") . str_pad($order_info['order_id'], 6, "0", STR_PAD_LEFT) . " " . $order_info['firstname']. " " . $order_info['lastname'] ,0,30) . '</customer_ref>' . "\n";
                    #set delivery address
                    $order_xml .=
                            '<delivery_address>' . "\n" .
                            ' <postal_name>' . str_replace("&", "and", $order_info['shipping_firstname'] . " " . $order_info['shipping_lastname']) . '</postal_name>' . "\n" .
                            ' <address1>' . str_replace("&", "and", $order_info['shipping_address_1']) . '</address1>' . "\n" .
                            ' <address2>' . str_replace("&", "and", $order_info['shipping_address_2']) . '</address2>' . "\n" .
                            ' <address3>' . str_replace("&", "and", $order_info['shipping_city']) . '</address3>' . "\n" .
                            ' <address4>' . str_replace("&", "and", $order_info['shipping_zone']) . '</address4>' . "\n" .
                            ' <city>' . str_replace("&", "and", $order_info['shipping_city']) . '</city>' . "\n" .
                            ' <county>' . str_replace("&", "and", $order_info['shipping_zone']) . '</county>' . "\n" .
                            ' <postcode>' . $order_info['shipping_postcode'] . '</postcode>' . "\n" .
                            ' <country>' . $order_info['shipping_country'] . '</country>' . "\n" .
                            '</delivery_address>' . "\n";

                    #set invoice address
                    $order_xml .=
                            '<invoice_address>' . "\n" .
                            ' <postal_name>' . str_replace("&", "and", $order_info['payment_firstname'] . " " . $order_info['payment_lastname']) . '</postal_name>' . "\n" .
                            ' <address1>' . str_replace("&", "and", $order_info['payment_address_1']) . '</address1>' . "\n" .
                            ' <address2>' . str_replace("&", "and", $order_info['payment_address_2']) . '</address2>' . "\n" .
                            ' <address3>' . str_replace("&", "and", $order_info['payment_city']) . '</address3>' . "\n" .
                            ' <address4>' . str_replace("&", "and", $order_info['payment_zone']) . '</address4>' . "\n" .
                            ' <city>' . str_replace("&", "and", $order_info['payment_city']) . '</city>' . "\n" .
                            ' <county>' . str_replace("&", "and", $order_info['payment_zone']) . '</county>' . "\n" .
                            ' <postcode>' . $order_info['payment_postcode'] . '</postcode>' . "\n" .
                            ' <country>' . $order_info['payment_country'] . '</country>' . "\n" .
                            '</invoice_address>' . "\n";

                    #loop through order items and set relevant fields
                    $order_products = $this->model_sale_order->getOrderProducts($row['order_id']);
                    foreach ($order_products as $order_product) {
                        
                        //Refresh product data from sage
//                        $this->model_tool_sage_products->import($order_product['model']);
                        $order_options = $this->model_sale_order->getOrderOptions($row['order_id'], $order_product['order_product_id']);
                        $this->log->write("checking product " . $order_product['model'] . " : " . $order_options[0]['value'] . " x " . $order_product['quantity']);
                        
                        $product_id = $order_product['product_id'];
                        $product_option_value_id = $order_options[0]['product_option_value_id'];
                        $product_option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$order_product['product_id'] . "' AND product_option_value_id = '" . (int)$order_options[0]['product_option_value_id'] . "'");
                        if ($product_option_value_query->row) {
                            //Make sure order quantity not greater than available quantity
                            //*****************************************************************
                            //*** This can only be done if we have refreshed the sage data ****
//                            if ($order_product['quantity'] > $product_option_value_query->row['quantity']) {
//                                $errors[] = "quantity ordered greater than stock: " . $order_product['model'] . " : " . $order_options[0]['value'] . " x " . $order_product['quantity'];
//                                $this->log->write("quantity ordered greater than stock, expect sage to throw error");
//                            } else {
//                                $this->log->write("product quantity ok, continuing");
//                            }
                            //*****************************************************************
                            $sage_info = $this->model_catalog_product->getSageProductInfo($product_id, $product_option_value_id);
                            if (!$sage_info) {
                                $errors[] = "product option doesn't match a sage sku: " . $order_product['model'] . " : " . $order_options[0]['value'] . " x " . $order_product['quantity'];
                            } else {
                                $product_info = $this->model_catalog_product->getProduct($product_id);
                                if (!$product_info) {
                                    $errors[] = "product not found: " . $order_product['model'] . " : " . $order_options[0]['value'] . " x " . $order_product['quantity'];
                                } else {

                                    $order_xml .=
                                            '<item>' . "\n" .
                                            ' <warehouse_id>' . $this->config->get('sage_warehouse') . '</warehouse_id>' . "\n" .
                                            ' <item_id>' . $sage_info['stock_item_id'] . '</item_id>' . "\n" .
                                            ' <tax_code_id>' . $this->getSageTaxId($product_info['tax_class_id']) . '</tax_code_id>' . "\n" .
                                            ' <quantity>' . $order_product['quantity'] . '</quantity>' . "\n" .
                                            ' <price>' . ($order_product['price']+$order_product['tax']) . '</price>' . "\n" .
                                            '</item>' . "\n";
                                }
                            }
                        } else {
                            $errors[] = "product option no longer exists: " . $order_product['model'] . " : " . $order_options[0]['value'] . " x " . $order_product['quantity'];
                            $this->log->write("product option no longer exists");
                        }
                    }#next product
                    
                    #set postage charge
                    $shipping = $this->model_sale_order->getOrderShippingTotal($row['order_id']);
                    if ($shipping > 5) {
                        $order_xml .=
                                '<item>' . "\n" .
                                ' <warehouse_id>' . $this->config->get('sage_warehouse') . '</warehouse_id>' . "\n" .
                                ' <item_id>8200429</item_id>' . "\n" .
                                ' <price>0</price>' . "\n" .
                                ' <tax_code_id>2</tax_code_id>' . "\n" .
                                ' <quantity>1</quantity>' . "\n" .
                                '</item>' . "\n";
                    }
                    $order_xml .= 
                            '<item>' . "\n" .
                            ' <warehouse_id>' . $this->config->get('sage_warehouse') . '</warehouse_id>' . "\n" .
                            ' <item_id>' . ( ( $shipping <= 5 ) ? 20816591 : 19318251 ) . '</item_id>' . "\n" .
                            ' <tax_code_id>2</tax_code_id>' . "\n" .
                            ' <price>' . ((float) $shipping <> 0 ? (float) $shipping  : 0) . '</price>' . "\n" .
                            ' <quantity>1</quantity>' . "\n" .
                            '</item>' . "\n";
                    $order_xml .= '<comment>Ship via:' . $order_info['shipping_method'] . '</comment>' . "\n";

                    #set order total
                    $order_xml .=
                            '<payment>' . "\n" .
                            ' <amount>' . $order_info['total'] . '</amount>' . "\n" .
                            ' <payment_method_id>19108621</payment_method_id>' . "\n" . // Need the method_id for sagepay from Andy
                            '</payment>' . "\n";

                    $order_xml .= '<comment>Payment made by: ' . $order_info['payment_method'] . '</comment>' . "\n";
                    switch ($order_info['payment_code']) {
                        case "worldpay":
                            #set WorldPay Transaction ID
                            // Need to store the sagepay / paypal transaction ids ...
                            $order_xml .= ( $order_info['worldpay_transaction_id'] <> '' ) ? '<comment>Worldpay Transaction ID: ' . $order_info['worldpay_transaction_id'] . '</comment>' . "\n" : '';
                            break;
                        default:
                            break;
                    }

                    $order_xml .=
                            '</order>' . "\n";

                    // post order to sage
                    $sage_customer_id = 10680255;
                    $ordersURL = "http://" . $this->config->get('sage_server') . ":" . $this->config->get('sage_port') . "/DMC_SOP/customers/" . $sage_customer_id . "/orders";
                    
                    if (!count($errors)) {
                        if ($debug) $this->log->write("posting to " . $ordersURL . ":\n" . $order_xml);
                        $response = send2Sage($ordersURL, $order_xml);
                        if ($debug) $this->log->write("response:\n" . serialize($response));
                        
                        $xml = simplexml_load_string($response);
                        $order_id = (string) $xml->order->id;
                        
                        $comment = "SAGE INTERFACE" . " [" . $this->request->server['REMOTE_ADDR'] . "]";
                        if ($order_id) {
//                            $status_id = $this->config->get('config_complete_status_id');
                            //We need to set the order status to Processing but do not have a conifg setting for this yet.
                            $status_id = 2;
                            $data = array(
                                'order_status_id' => $status_id,
                                'notify' => true,
                                'comment' => '',
                                'notes' => $comment
                            );
                            $this->model_sale_order->addOrderHistory($row['order_id'],$data);
                            $sql = "INSERT INTO `" . DB_PREFIX . "sage_order` SET 
                                                    sage_id = " . $order_id . ",
                                                    sage_reference = '" . $order_info['order_id'] . "',
                                                    sage_status = '" . $order_info['order_id'] . "',
                                                    data = '" . $this->db->escape(serialize($response)) . "',
                                                    order_id = '" . $order_info['order_id'] . "',
                                                    status = '" . $status_id . "',
                                                    date_added = NOW(),
                                                    date_modified = NOW(),
                                                    date_processed = NOW()
                                ";
                            $this->db->query($sql);
                        } else {
                            $subject = "SAGE ORDER ERROR: Unexpected response from sage  " . $order_info['order_id'];
                            $message = "The URL was:\n" . $ordersURL . "\n\n\nThe response was:\n" . $response . "\n\n\nThe data posted was:\n\n" . $order_xml . "\n";
                            $this->emailError($subject, $message);
                        }
                    } else {
                        $subject = "SAGE ORDER ERROR: Didn't try to send to sage  " . $order_info['order_id'];
                        $message = "Unable to send to sage because of the following errors:\n" . implode("\n", $errors) . "\n\nAfter resolving the errors the order will then be sent to sage.";
                        $message .= "\n\n\nThe URL was:\n" . $ordersURL . "\n\n\nThe response was:\n" . $response . "\n\n\nThe data posted was:\n\n" . $order_xml . "\n";
                        $this->emailError($subject, $message);
                    }
                    
                }
            }
        }
        // only delete old customers if no errors were encountered
        if ($error) {
            $this->log->write("Errors were encountered whilst exporting orders.");
            return false;
        }

        $this->log->write("Export Complete");
    }

    function emailError($subject, $message) {
        $mail = new Mail();
        $mail->protocol = $this->config->get('config_mail_protocol');
        $mail->hostname = $this->config->get('config_smtp_host');
        $mail->username = $this->config->get('config_smtp_username');
        $mail->password = $this->config->get('config_smtp_password');
        $mail->port = $this->config->get('config_smtp_port');
        $mail->timeout = $this->config->get('config_smtp_timeout');							
        $mail->setTo($this->config->get('config_email'));
        $mail->setFrom($this->config->get('config_email'));
        $mail->setSender($this->config->get('config_name'));
        $mail->setSubject($subject);
        $mail->setText($message);
        $mail->send();
				
        // Send to additional alert emails
        $emails = explode(',', $this->config->get('config_alert_emails'));

        foreach ($emails as $email) {
                if ($email && preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $email)) {
                        $mail->setTo($email);
                        $mail->send();
                }
        }				
    }
    
    function readyToPost($order_id) {

        $sql = "SELECT order_status_id
            FROM `" . DB_PREFIX . "order` o 
            WHERE o.order_id = '" . $order_id ."'";
        $result = $this->db->query($sql);
        //TODO: Add "Ready to Post" to order status i/o hard coding
        if ($result->rows) {
            switch ($result->rows[0]['order_status_id']) {
                case 1: //Order Status Pending needs separate module config
//                case $this->config->get('config_customer_order_status_id'):
                    return true;
                    break;
                default:
                    $this->log->write('ignoring order ' . $order_id . ' status [' . $result->rows[0]['order_status_id'] .']');
            }
        }
        
        return false;
    }

    private function fetchSageTaxCodes() {

        $this->tax_codes = array();
        $this->load->model('localisation/tax_rate');
        
        // Load XML Feed to fetch detail
        $this->load->helper('fetchxml');

        $xml = new fetchXml();
        //Unable to use $xml->get_array method because pricebands uses attributes which are lost
        $response = $xml->get("http://" . $this->config->get('sage_server') . ":" . $this->config->get('sage_port') . "/DMC_SOP/tax_codes");
        if (!$response == 0) {
            $xml = new SimpleXMLElement($response);

            //Convert the XML into a useable array
            foreach ($xml->children() as $second_gen) {
                switch (strtolower((string) $second_gen->getName())) {
                    case "debug":
                        //Ignore
                        break;
                    case "tax_codes":
                        foreach ($second_gen->children() as $third_gen) {
                            if ($third_gen->count() > 0) {
                                $tax_code_id = 0;
                                $tax_code = array();
                                foreach ($third_gen->children() as $fourth_gen) {
                                    switch (strtolower((string) $fourth_gen->getName())) {
                                        case "id":
                                            $tax_code_id = (int) $fourth_gen;
                                            break;
                                        case "vat_return":
                                            $tax_code[strtolower((string) $fourth_gen->getName())] = (boolean) $fourth_gen;
                                            break;
                                        case "rate":
                                            $tax_code[strtolower((string) $fourth_gen->getName())] = (float) $fourth_gen;
                                            break;
                                        default:
                                            $tax_code[strtolower((string) $fourth_gen->getName())] = (string) $fourth_gen;
                                    }
                                }
                                if (!$tax_code_id == 0)
                                    $this->tax_codes[$tax_code_id] = $tax_code;
                            }
                        }
                }

            }
        }

    }
    
    private function getSageTaxId($tax_class_id) {
        
        $this->load->model('localisation/tax_class');
        
        $tax_class = $this->model_localisation_tax_class->getTaxClass($tax_class_id);
        
        if ($tax_class)
        {
            foreach ($this->tax_codes as $key => $tax_code) {
                if ($tax_code['name'] == $tax_class['title'])
                {
                    return $key;
                }
            }
        }
        
        foreach ($this->tax_codes as $key => $tax_code) {
            if ((float)$tax_code['rate'] == 0)
            {
                return $key;
            }
        }
        
        return 0;
    }
    
    private function getShippingTaxClassId($shipping_code) {
        
        $this->load->model('setting/setting');
        
        $shipping_code = explode('.', $shipping_code);
        
        $shipping_setting = $this->model_setting_setting->getSetting($shipping_code[0]);
        
        if (array_key_exists($shipping_code[0] . '_tax_class_id', $shipping_setting))
        {
            return $shipping_setting[$shipping_code[0] . '_tax_class_id'];
        } else {
            return 0;
        }
    }
}


function send2Sage($ordersURL, $xml) {

    $headers = array(
        "Content-type: text/xml;charset=\"utf-8\"",
        "Accept: text/xml",
        "Cache-Control: no-cache",
        "Pragma: no-cache",
        "Content-length: " . strlen($xml)
    );

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $ordersURL);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_TIMEOUT, 120);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    #curl_setopt($ch, CURLOPT_USERAGENT, $defined_vars['HTTP_USER_AGENT']);
    // Apply the XML to our curl call
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $xml);

    $data = curl_exec($ch);

    if (curl_errno($ch)) {
        #print "POST URL: " . $ordersURL . "<br />";
        #print "Error: " . curl_error($ch);
        $response = "Error: " . curl_error($ch);
    } else {
        // Show me the result
        #print "POST URL: " . $ordersURL . "<br />";
        #var_dump($data);
        $response = $data;
        curl_close($ch);
    }

    return $response;
}

?>
