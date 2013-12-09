<?php

class ModelToolSysproOrders extends Model {

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

        $this->log->write("Begining export of order information to Syspro");
        $this->languageId = $this->getDefaultLanguageId();
        
        $this->load->model('sale/order');
        $this->load->model('sale/customer');
        $this->load->model('catalog/product');
        $this->load->model('tool/syspro_products');

        $order_id = 0;
        $error = false;
        // Check & update existing record cache
        $sql = "SELECT o.order_id 
            FROM `" . DB_PREFIX . "order` o 
                LEFT JOIN `" . DB_PREFIX . "syspro_order` so ON (o.order_id = so.order_id) 
            WHERE so.order_id IS NULL 
              AND o.order_status_id = 1
            ORDER BY o.order_id";
        $result = $this->db->query($sql);
        if ($result->rows) {
            foreach ($result->rows as $row) {
                $errors = array();
                $order_info = $this->model_sale_order->getOrder($row['order_id']);
                if (!empty($order_info) && $this->readyToPost($row['order_id'])) {
                    $this->log->write("processing " . $order_info['order_id'] . ":" . $order_info['invoice_prefix'] . ":" . $order_info['customer_name']);

                    $syspro_customer_id = 10680255;
                    
                    #set header
                    $order_xml =
                            '<order>' . "\n" .
                            '<gross_pricing>true</gross_pricing>' . "\n" .
                            '<customer_id>' . $syspro_customer_id . '</customer_id>' . "\n" .
                            '<document_date>' . $order_info['date_added'] . '</document_date>' . "\n" .
                            '<customer_ref>' . substr((defined('SITE_REGION') ? SITE_REGION : "") . str_pad($order_info['order_id'], 6, "0", STR_PAD_LEFT) . " " . $order_info['firstname']. " " . $order_info['lastname'] ,0,30) . '</customer_ref>' . "\n";
                    #set delivery address
                    $order_xml .=
                            '<delivery_address>' . "\n" .
                            ' <email>' . $order_info['email'] . '</email>' . "\n" .
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
                        
                        //Refresh product data from syspro
//                        $this->model_tool_syspro_products->import($order_product['model']);
                        $order_options = $this->model_sale_order->getOrderOptions($row['order_id'], $order_product['order_product_id']);
                        $this->log->write("checking product " . $order_product['model'] . " : " . $order_options[0]['value'] . " x " . $order_product['quantity']);
                        
                        $product_id = $order_product['product_id'];
                        $product_option_value_id = $order_options[0]['product_option_value_id'];
                        $product_option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$order_product['product_id'] . "' AND product_option_value_id = '" . (int)$order_options[0]['product_option_value_id'] . "'");
                        if ($product_option_value_query->row) {
                            //Make sure order quantity not greater than available quantity
                            //*****************************************************************
                            //*** This can only be done if we have refreshed the syspro data ****
//                            if ($order_product['quantity'] > $product_option_value_query->row['quantity']) {
//                                $errors[] = "quantity ordered greater than stock: " . $order_product['model'] . " : " . $order_options[0]['value'] . " x " . $order_product['quantity'];
//                                $this->log->write("quantity ordered greater than stock, expect syspro to throw error");
//                            } else {
//                                $this->log->write("product quantity ok, continuing");
//                            }
                            //*****************************************************************
                            $syspro_info = $this->model_catalog_product->getSysproProductInfo($product_id, $product_option_value_id);
                            if (!$syspro_info) {
                                $errors[] = "product option doesn't match a syspro sku: " . $order_product['model'] . " : " . $order_options[0]['value'] . " x " . $order_product['quantity'];
                            } else {
                                $product_info = $this->model_catalog_product->getProduct($product_id);
                                if (!$product_info) {
                                    $errors[] = "product not found: " . $order_product['model'] . " : " . $order_options[0]['value'] . " x " . $order_product['quantity'];
                                } else {

                                    $order_xml .=
                                            '<item>' . "\n" .
                                            ' <warehouse_id>' . $this->config->get('syspro_warehouse') . '</warehouse_id>' . "\n" .
                                            ' <item_id>' . $syspro_info['stock_item_code'] . '</item_id>' . "\n" .
                                            ' <tax_code_id>' . $this->getSysproTaxId($product_info['tax_class_id']) . '</tax_code_id>' . "\n" .
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
                                ' <warehouse_id>' . $this->config->get('syspro_warehouse') . '</warehouse_id>' . "\n" .
                                ' <item_id>8200429</item_id>' . "\n" .
                                ' <price>0</price>' . "\n" .
                                ' <tax_code_id>A</tax_code_id>' . "\n" .
                                ' <quantity>1</quantity>' . "\n" .
                                '</item>' . "\n";
                    }
                    $order_xml .= 
                            '<item>' . "\n" .
                            ' <warehouse_id>' . $this->config->get('syspro_warehouse') . '</warehouse_id>' . "\n" .
                            ' <item_id>' . ( ( $shipping <= 5 ) ? 20816591 : 19318251 ) . '</item_id>' . "\n" .
                            ' <tax_code_id>A</tax_code_id>' . "\n" .
                            ' <price>' . ((float) $shipping <> 0 ? (float) $shipping  : 0) . '</price>' . "\n" .
                            ' <quantity>1</quantity>' . "\n" .
                            '</item>' . "\n";
                    $order_xml .= '<comment>Ship via:' . $order_info['shipping_method'] . '</comment>' . "\n";

                    switch ($order_info['payment_code']) {
                        case "sagepay":
                            $order_xml .=
                                    '<payment>' . "\n" .
                                    ' <amount>' . $order_info['total'] . '</amount>' . "\n" .
                                    ' <payment_method_id>09</payment_method_id>' . "\n" . 
                                    '</payment>' . "\n";
                            $order_xml .= '<comment>Payment made by: ' . $order_info['payment_method'] . '</comment>' . "\n";
                            $order_xml .= ( $order_info['payment_transaction_id'] <> '' ) ? '<comment>Payment Transaction ID: ' . $order_info['payment_transaction_id'] . '</comment>' . "\n" : '';
                            break;
                        case "pp_standard":
                            $order_xml .=
                                    '<payment>' . "\n" .
                                    ' <amount>' . $order_info['total'] . '</amount>' . "\n" .
                                    ' <payment_method_id>10</payment_method_id>' . "\n" . 
                                    '</payment>' . "\n";
                            $order_xml .= '<comment>Payment made by: ' . $order_info['payment_method'] . '</comment>' . "\n";
                            $order_xml .= ( $order_info['payment_transaction_id'] <> '' ) ? '<comment>Payment Transaction ID: ' . $order_info['payment_transaction_id'] . '</comment>' . "\n" : '';
                            break;
                        default:
                            $order_xml .=
                                    '<payment>' . "\n" .
                                    ' <amount>' . $order_info['total'] . '</amount>' . "\n" .
                                    ' <payment_method_id>19108621</payment_method_id>' . "\n" . // Need the method_id for sagepay from Andy
                                    '</payment>' . "\n";
                            $order_xml .= '<comment>Payment made by: ' . $order_info['payment_method'] . '</comment>' . "\n";
                            $order_xml .= ( $order_info['payment_transaction_id'] <> '' ) ? '<comment>Payment Transaction ID: ' . $order_info['payment_transaction_id'] . '</comment>' . "\n" : '';
                            break;
                    }

                    $order_xml .=
                            '</order>' . "\n";

                    if (!count($errors)) {
                        if ($debug) $this->log->write("posting to " . $ordersURL . ":\n" . $order_xml);
                        
                        $filename = $this->config->get('syspro_output_folder') . "/b2c-order_" . str_pad($order_info['order_id'], 11, "0", STR_PAD_LEFT) . ".xml";
                        $fp = fopen($filename, 'w');
                        fwrite($fp, $order_xml);
                        fclose($fp);
                            $sql = "INSERT INTO `" . DB_PREFIX . "syspro_order` SET 
                                                    order_id = '" . $order_info['order_id'] . "',
                                                    date_added = NOW(),
                                                    date_modified = NOW(),
                                                    date_processed = NOW()
                                ";
                            $this->db->query($sql);
                    } else {
                        $subject = "SAGE ORDER ERROR: Didn't try to send to syspro  " . $order_info['order_id'];
                        $message = "Unable to send to syspro because of the following errors:\n" . implode("\n", $errors) . "\n\nAfter resolving the errors the order will then be sent to syspro.";
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

    private function getSysproTaxId($tax_class_id) {
        
        $sql = "SELECT tax_code
                FROM `" . DB_PREFIX . "syspro_tax_code` WHERE tax_class_id = '" . (int)$tax_class_id . "'";
        $result = $this->db->query($sql);

        if ($result->num_rows)
            return $result->rows[0]['tax_code'];

        return "";
    }
    
}

?>
