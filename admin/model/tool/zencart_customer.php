<?php
include_once('zencart_core.php');

class ModelToolZencartCustomer extends ModelToolZencart {

    function import() {
        $this->debugMode = $this->config->get('zencart_orders_debug');
        
        $this->truncate();

        if (!$this->cacheZencartData())
            return false;

        $this->debug("Import Complete");
        return true;
    }

    function truncate() {
        if ($this->config->get('zencart_orders_truncate')) {
            
            $this->debug("truncating tables");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "address`");
            
            $this->db->query("TRUNCATE `" . DB_PREFIX . "customer`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "customer_ip`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "customer_ip_blacklist`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "customer_online`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "customer_reward`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "customer_transaction`");
            
            $this->db->query("TRUNCATE `" . DB_PREFIX . "order`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "order_download`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "order_fraud`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "order_history`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "order_option`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "order_product`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "order_total`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "order_voucher`");
            
            $this->db->query("TRUNCATE `" . DB_PREFIX . "review`");
            
        }
    }

    function cacheZencartData($forceRefresh = false) {

        $this->debug("fetching customers from zencart");
        $sql = 'SELECT * FROM customers LEFT JOIN customers_info ON (customers.customers_id = customers_info.customers_info_id) ORDER BY customers.customers_id';
        if ($this->config->get('zencart_orders_limit')) $sql .= ' LIMIT ' . (int)$this->config->get('zencart_orders_limit');
        $aCustomer = $this->dbQF->Execute($sql);
        
        $myModel = "";
        $customer_id = 0;
        $new_customer_id = 0;
        $myCustomerIds = array();
        $error = false;

        if ($aCustomer->RecordCount() > 0) {
            while (!$aCustomer->EOF) {
                $this->debug("=================================================================================================");
                $this->debug("processing customer ".$aCustomer->fields['customers_firstname']." ".$aCustomer->fields['customers_lastname']."");
                
                $customer_id = $aCustomer->fields['customers_id'];
                
                $this->debug("fetching addresses for ".$aCustomer->fields['customers_firstname']." ".$aCustomer->fields['customers_lastname']." from zencart");
                $aAddress = $this->dbQF->Execute('SELECT * FROM address_book LEFT JOIN countries ON (address_book.entry_country_id = countries.countries_id) LEFT JOIN zones ON (address_book.entry_zone_id = zones.zone_id) WHERE customers_id = ' . (int)$aCustomer->fields['customers_id'] . ' ORDER BY address_book_id');
                
                $addresses = array();
                if ($aAddress->RecordCount() > 0) {
                    while (!$aAddress->EOF) {
                        
                        $country_id = $this->tableLookUp(DB_PREFIX . "country", 'country_id', array('iso_code_3' => $aAddress->fields['countries_iso_code_3']));
                        $zone_id = $this->tableLookUp(DB_PREFIX . "zone", 'zone_id', array('country_id' => $country_id, 'code' => $aAddress->fields['zone_code']));
                        
                        $address = array();
                        $address['firstname'] = $aAddress->fields['entry_firstname'];
                        $address['lastname'] = $aAddress->fields['entry_lastname'];
                        $address['company'] = $aAddress->fields['entry_company'];
                        $address['company_id'] = '';
                        $address['tax_id'] = '';
                        $address['address_1'] = $aAddress->fields['entry_street_address'];
                        $address['address_2'] = $aAddress->fields['entry_suburb'];
                        $address['city'] = $aAddress->fields['entry_city'];
                        $address['postcode'] = $aAddress->fields['entry_postcode'];
                        $address['country_id'] = $country_id;
                        $address['zone_id'] = $zone_id;
                        if ($aCustomer->fields['customers_default_address_id'] == $aAddress->fields['address_book_id'])
                        {
                            $address['default'] = true;
                        }
                        $addresses[] = $address;
                        $aAddress->MoveNext();
                    }
                }

                $customer = array('firstname' => $aCustomer->fields['customers_firstname'],
                                  'lastname' => $aCustomer->fields['customers_lastname'],
                                  'email' => $aCustomer->fields['customers_email_address'],
                                  'telephone' => $aCustomer->fields['customers_telephone'],
                                  'fax' => $aCustomer->fields['customers_fax'],
                                  'newsletter' => $aCustomer->fields['customers_newsletter'],
                                  'customer_group_id' => 1,
                                  'status' => $aCustomer->fields['customers_authorization'] != 4 ? 1 : 0,
                                  'password' => md5(dechex(rand(0,9999999))),
                                  'address' => $addresses);
                
                $this->load->model('sale/customer');
                $customer['customer_id'] = $this->model_sale_customer->addCustomer($customer);
                
                $password = $stack = explode(':', $aCustomer->fields['customers_password']);
                
                $this->db->query("UPDATE " . DB_PREFIX . "customer SET password = '" . $this->db->escape($password[0]) . "', salt = '" . $this->db->escape($password[1]) . "', approved = 1, date_added = '" . $this->db->escape($aCustomer->fields['customers_info_date_account_created']) . "' WHERE customer_id = '" . (int)$customer['customer_id'] . "'");
                
                $this->processReviews($customer_id, $customer);
                
                if ($this->config->get('zencart_orders'))
                {
                    $this->processOrders($customer_id, $customer);
                }
                
                $aCustomer->MoveNext();
            }
        }

        return true;
    }
    
    function processReviews ($customer_id, $customer)
    {
        $this->debug("=================================================================================================");
        $this->debug("processing reviews for  ".$customer['firstname']." ".$customer['lastname']."");
        
        $aReview = $this->dbQF->Execute('SELECT r.*, rd.*, p.products_model FROM reviews r LEFT JOIN reviews_description rd ON rd.reviews_id = r.reviews_id LEFT JOIN products p ON p.products_id = r.products_id WHERE r.customers_id = ' . (int)$customer_id . ' ORDER BY r.reviews_id');
        
        if ($aReview->RecordCount() > 0) {
            while (!$aReview->EOF) {
                $this->debug("processing review for  ".$aReview->fields['products_model']);
        
                $data = array();
                
                $data['author'] = 0;
                
                $data['product_id'] = $this->tableLookUp(DB_PREFIX . "product", 'product_id', array('model' => $aReview->fields['products_model']));
                $data['text'] = $aReview->fields['reviews_text'];
                $data['rating'] = $aReview->fields['reviews_rating'];
                $data['status'] = $aReview->fields['status'];
                $data['customer_id'] = $customer['customer_id'];
                $data['author'] = $customer['firstname'] . ' ' . $customer['lastname'];
                $data['date_added'] = $aReview->fields['date_added'];
                
                $this->db->query("INSERT INTO " . DB_PREFIX . "review SET author = '" . $this->db->escape($data['author']) . "', customer_id = '" . (int)$data['customer_id'] . "', product_id = '" . (int)$data['product_id'] . "', text = '" . $this->db->escape($data['text']) . "', rating = '" . (int)$data['rating'] . "', status = '" . (int)$data['status'] . "', date_added = '" . $this->db->escape($data['date_added']) . "'");
                
                $aReview->MoveNext();
            }
        }
        
    }
    
    function processOrders ($customer_id, $customer)
    {
        $this->debug("=================================================================================================");
        $this->debug("processing orders for  ".$customer['firstname']." ".$customer['lastname']."");
        
        $aOrder = $this->dbQF->Execute('SELECT * FROM orders WHERE customers_id = ' . (int)$customer_id . ' ORDER BY orders_id');
        
        if ($aOrder->RecordCount() > 0) {
            while (!$aOrder->EOF) {
                $this->debug("processing orders for  ".$aOrder->fields['orders_id']);
                
                $this->debug("<pre>" . print_r($customer, true) . "</pre>");
                $this->debug("<pre>" . print_r($aOrder, true) . "</pre>");
        
                $data = array();
                
                $data['store_id'] = 0;
                
                $data['shipping_country_id'] = $this->tableLookUp(DB_PREFIX . "country", 'country_id', array('name' => $aOrder->fields['delivery_country']));
                $data['shipping_zone_id'] = $this->tableLookUp(DB_PREFIX . "zone", 'zone_id', array('country_id' => $data['shipping_country_id'], 'name' => $aOrder->fields['delivery_state']));;
                $data['payment_country_id'] = $this->tableLookUp(DB_PREFIX . "country", 'country_id', array('name' => $aOrder->fields['billing_country']));
                $data['payment_zone_id'] = $this->tableLookUp(DB_PREFIX . "zone", 'zone_id', array('country_id' => $data['payment_country_id'], 'name' => $aOrder->fields['billing_state']));;
                $data['customer_id'] = $customer['customer_id'];
                $data['customer_group_id'] = $customer['customer_group_id'];
                
                $name = self::guessName($aOrder->fields['customers_name']);
                $data['firstname'] = $name[0];
                $data['lastname'] = $name[1];
                $data['email'] = $aOrder->fields['customers_email_address'];
                $data['telephone'] = $aOrder->fields['customers_telephone'];
                $data['fax'] = '';
                
                $name = self::guessName($aOrder->fields['billing_name']);
                $data['payment_firstname'] = $name[0];
                $data['payment_lastname'] = $name[1];
                $data['payment_company'] = $aOrder->fields['billing_company'];
                $data['payment_company_id'] = '';
                $data['payment_tax_id'] = '';
                $data['payment_address_1'] = $aOrder->fields['billing_street_address'];
                $data['payment_address_2'] = $aOrder->fields['billing_suburb'];
                $data['payment_city'] = $aOrder->fields['billing_city'];
                $data['payment_postcode'] = $aOrder->fields['billing_postcode'];
                $data['payment_method'] = $aOrder->fields['payment_method'];
                $data['payment_code'] = $aOrder->fields['payment_module_code'];
                
                $name = self::guessName($aOrder->fields['delivery_name']);
                $data['shipping_firstname'] = $name[0];
                $data['shipping_lastname'] = $name[1];
                $data['shipping_company'] = $aOrder->fields['delivery_company'];
                $data['shipping_address_1'] = $aOrder->fields['delivery_street_address'];
                $data['shipping_address_2'] = $aOrder->fields['delivery_suburb'];
                $data['shipping_city'] = $aOrder->fields['delivery_city'];
                $data['shipping_postcode'] = $aOrder->fields['delivery_postcode'];
                $data['shipping_method'] = $aOrder->fields['shipping_method'];
                $data['shipping_code'] = $aOrder->fields['shipping_module_code'];
                
                $data['comment'] = '';
                $data['order_status_id'] = (int)self::getOrderStatus($aOrder->fields['orders_status']);
                $data['affiliate_id'] = '';
                
                $this->config->set('config_currency', $aOrder->fields['currency']);
                $data['order_product'] = array();
                
                $aOrdersProducts = $this->dbQF->Execute('SELECT p.* FROM orders_products p WHERE orders_id = ' . (int)$aOrder->fields['orders_id'] . ' ORDER BY p.orders_products_id');
                if ($aOrdersProducts->RecordCount() > 0) {
                    while (!$aOrdersProducts->EOF) {
                        $temp = array();
                        $temp['product_id'] = $this->tableLookUp(DB_PREFIX . "product", 'product_id', array('model' => $aOrdersProducts->fields['products_model']));
                        $temp['name'] = $aOrdersProducts->fields['products_name'];
                        $temp['model'] = $aOrdersProducts->fields['products_model'];
                        $temp['quantity'] = $aOrdersProducts->fields['products_quantity'];
                        $temp['price'] = ($aOrdersProducts->fields['final_price']/$aOrdersProducts->fields['products_quantity']);
                        $temp['total'] = $aOrdersProducts->fields['final_price'];
                        $temp['tax'] = ($aOrdersProducts->fields['products_tax'] ? (($aOrdersProducts->fields['final_price']/100)*$aOrdersProducts->fields['products_tax']) : 0);
                        $temp['reward'] = '';
                        $temp['order_option'] = array();

                        $aOrdersProductsAttributes = $this->dbQF->Execute('SELECT * FROM orders_products_attributes WHERE orders_products_id = ' . (int)$aOrdersProducts->fields['orders_products_id'] . ' ORDER BY orders_products_attributes_id');
                        if ($aOrdersProductsAttributes->RecordCount() > 0) {
                            while (!$aOrdersProductsAttributes->EOF) {
                                $temp2 = array();
                                $temp2['product_option_id'] = '';
                                $temp2['product_option_value_id'] = '';
                                $temp2['name'] = $aOrdersProductsAttributes->fields['products_options'];
                                $temp2['value'] = $aOrdersProductsAttributes->fields['products_options_values'];
                                $temp2['type'] = 'select';

                                $temp['order_option'][] = $temp2;
                                $aOrdersProductsAttributes->MoveNext();
                            }
                        }

                        $data['order_product'][] = $temp;
                        $aOrdersProducts->MoveNext();
                    }
                }
                
                $data['order_total'] = array();
                $aOrdersTotal = $this->dbQF->Execute('SELECT * FROM orders_total WHERE orders_id = ' . (int)$aOrder->fields['orders_id'] . ' ORDER BY orders_id');
                if ($aOrdersTotal->RecordCount() > 0) {
                    while (!$aOrdersTotal->EOF) {
                        $temp2 = array();
                        $temp2['code'] = $aOrdersTotal->fields['class'];
                        $temp2['title'] = str_replace(':','',$aOrdersTotal->fields['title']);
                        $temp2['text'] = html_entity_decode($aOrdersTotal->fields['text'], ENT_QUOTES, 'UTF-8');
                        $temp2['value'] = $aOrdersTotal->fields['value'];
                        $temp2['sort_order'] = $aOrdersTotal->fields['sort_order'];

                        $data['order_total'][] = $temp2;
                        $aOrdersTotal->MoveNext();
                    }
                }
                $this->debug("<pre>" . print_r($data, true) . "</pre>");
                
                $this->load->model('sale/order');
                $order_id = $this->model_sale_order->addOrder($data);
                
                $ip = explode(' - ', $aOrder->fields['ip_address']);
                if (!isset($ip[1])) $ip[1] = '';
                
                $this->db->query("UPDATE `" . DB_PREFIX . "order` SET ip = '" . $this->db->escape($ip[0]) . "', forwarded_ip = '" . $this->db->escape($ip[1]) . "', currency_value = '" . $aOrder->fields['currency_value'] . "', total = '" . $aOrder->fields['order_total'] . "', date_added = '" . $aOrder->fields['date_purchased'] . "', date_modified = '" . $aOrder->fields['last_modified'] . "' WHERE order_id = '" . (int)$order_id . "'");
                
                $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order` WHERE order_id = '" . (int)$order_id . "'");
                $this->debug("<pre>" . print_r($query->row, true) . "</pre>");
                
                $aOrdersStatus = $this->dbQF->Execute('SELECT * FROM orders_status_history WHERE orders_id = ' . (int)$aOrder->fields['orders_id'] . ' ORDER BY orders_id');
                if ($aOrdersStatus->RecordCount() > 0) {
                    while (!$aOrdersStatus->EOF) {
                        $sql = "INSERT INTO `" . DB_PREFIX . "order_history` "
                             . "SET order_id = '" . (int)$order_id . "', "
                             . "order_status_id = '" . (int)self::getOrderStatus($aOrdersStatus->fields['orders_status_id']) . "', "
                             . "notify = '" . ($aOrdersStatus->fields['customer_notified'] > 0 ? 1 : 0) . "', "
                             . "comment = '" . $this->db->escape($aOrdersStatus->fields['comments']) . "', "
                             . "date_added = '" . $aOrdersStatus->fields['date_added'] . "' ";
                        $this->db->query($sql);
                        
                        $aOrdersStatus->MoveNext();
                    }
                }
                $sql = "INSERT INTO `" . DB_PREFIX . "order_history` "
                    . "SET order_id = '" . (int)$order_id . "', "
                    . "order_status_id = '" . (int)self::getOrderStatus($aOrder->fields['orders_status']) . "', "
                    . "notify = '" . ($aOrdersStatus->fields['customer_notified'] > 0 ? 1 : 0) . "', "
                    . "comment = 'Order moved from legacy online system (orders_id: " . $aOrder->fields['orders_id'] . ")', "
                    . "date_added = NOW() ";
                $this->db->query($sql);
                
                $this->debug("=================================================================================================");
                $aOrder->MoveNext();
            }
        }
        
    }
    
    static function guessName ($name) {
        $name = explode(' ', $name);
        
        $guessedName = array($name, '');
        
        if (count($name) > 1)
        {
            $guessedName[0] = array_shift($name);
            $guessedName[1] = implode(' ', $name);
        }
        
        return $guessedName;
    }
    
    static function getOrderStatus ($order_status_id) {
        
        $order_status = array(0 => 17,
                              1 => 1,
                              2 => 2,
                              3 => 3,
                              4 => 17);
        
        return $order_status[$order_status_id];
    }
}
