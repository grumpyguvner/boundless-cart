<?php
require_once DIR_SYSTEM . 'vendor/composer/autoload_real.php';

return ComposerAutoloaderInit69c6ed8a4071781d5e74378df2dc7086::getLoader();

class ControllerPaymentPPExpress extends Controller {

    protected function index() {

        $this->data['button_confirm'] = $this->language->get('button_confirm');
        $this->data['text_wait'] = $this->language->get('text_wait');


        $this->data['action'] = $this->url->link('payment/pp_express/send', '', 'SSL');


        $this->setTemplate('payment/pp_express.tpl');

        $this->render();
    }

    public function send() {
        
        if (!defined('PP_CONFIG_PATH')) {
            if (!$this->config->get('pp_express_test'))
            {
                define('PP_CONFIG_PATH', DIR_SYSTEM . 'vendor/paypal/config_live/');
            } else {
                define('PP_CONFIG_PATH', DIR_SYSTEM . 'vendor/paypal/config_sandbox/');
            }
        }
        
        $audit = new Log(date("Y-m-d") . "-paypal.log");
        
        $this->load->model('checkout/order');
        $this->load->model('payment/pp_express');

        $order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);

        if ($order_info) {

            $returnUrl = $this->url->link('payment/pp_express/finish', '', 'SSL');
            $cancelUrl = $this->url->link('payment/pp_express/cancel', '', 'SSL');

            $currencyCode = $order_info['currency_code'];
//        $shippingTotal = new BasicAmountType($currencyCode, $_REQUEST['shippingTotal']);
//        $handlingTotal = new BasicAmountType($currencyCode, $_REQUEST['handlingTotal']);
//        $insuranceTotal = new BasicAmountType($currencyCode, $_REQUEST['insuranceTotal']);

            $address = new AddressType();
            $address->CityName = $order_info['shipping_city'];
            $address->Name = $order_info['shipping_firstname'] . ' ' . $order_info['shipping_lastname'];
            $address->Street1 = $order_info['shipping_address_1'];
            $address->Street2 = $order_info['shipping_address_2'];
            $address->StateOrProvince = $order_info['shipping_city'];
            $address->PostalCode = $order_info['shipping_postcode'];
            $address->Country = $order_info['shipping_iso_code_2'];

            $paymentDetails = new PaymentDetailsType();
            $itemTotalValue = 0;
            //$taxTotalValue = 0;

            $products = $this->cart->getProducts();
            foreach ($products as $product) {

                $itemAmount = new BasicAmountType($currencyCode, $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], true), $order_info['currency_code'], false, false));
                $itemTotalValue += $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], true), $order_info['currency_code'], false, false) * $product['quantity'];
                //$taxTotalValue += $this->currency->format($this->tax->getTax($product['price'], $product['tax_class_id']), $order_info['currency_code'], false, false) * $product['quantity'];
                $itemDetails = new PaymentDetailsItemType();
                $itemDetails->Name = $product['name'];
                $itemDetails->Amount = $itemAmount;
                $itemDetails->Quantity = $product['quantity'];
                //$itemDetails->Tax = new BasicAmountType($currencyCode,$this->currency->format($this->tax->getTax($product['price'], $product['tax_class_id']), $order_info['currency_code'], false, false));

                $paymentDetails->PaymentDetailsItem[] = $itemDetails;
            }

            //$orderTotalValue = $shippingTotal->value + $handlingTotal->value +
            //       $insuranceTotal->value +
            //       $itemTotalValue + $taxTotalValue;

            $paymentDetails->ShipToAddress = $address;
            $paymentDetails->ItemTotal = new BasicAmountType($currencyCode, $itemTotalValue);
            $paymentDetails->OrderTotal = new BasicAmountType($currencyCode, $this->currency->format($order_info['total'], $order_info['currency_code'], false, false));
            //$paymentDetails->TaxTotal = new BasicAmountType($currencyCode, $taxTotalValue);

            if ($this->config->get('pp_express_method')) {
                $paymentDetails->PaymentAction = "Sale";
            } else {
                $paymentDetails->PaymentAction = "Order";
            }

//        $paymentDetails->HandlingTotal = $handlingTotal;
//        $paymentDetails->InsuranceTotal = $insuranceTotal;
            $paymentDetails->ShippingTotal = $this->currency->format($order_info['total'], $order_info['currency_code'], false, false) - $itemTotalValue;
//        if(isset($_REQUEST['notifyURL']))
//        {
//                $paymentDetails->NotifyURL = $_REQUEST['notifyURL'];
//        }

            $setECReqDetails = new SetExpressCheckoutRequestDetailsType();
            $setECReqDetails->PaymentDetails[0] = $paymentDetails;
            $setECReqDetails->CancelURL = $cancelUrl;
            $setECReqDetails->ReturnURL = $returnUrl;

            // Shipping details
            $setECReqDetails->NoShipping = 0;
            $setECReqDetails->AddressOverride = 0;
            //$setECReqDetails->ReqConfirmShipping = 0;
            // Billing agreement
//        $billingAgreementDetails = new BillingAgreementDetailsType($_REQUEST['billingType']);
//        $billingAgreementDetails->BillingAgreementDescription = $_REQUEST['billingAgreementText'];
//        $setECReqDetails->BillingAgreementDetails = array($billingAgreementDetails);
            // Display options
//        $setECReqDetails->cppheaderimage = $_REQUEST['cppheaderimage'];
//        $setECReqDetails->cppheaderbordercolor = $_REQUEST['cppheaderbordercolor'];
//        $setECReqDetails->cppheaderbackcolor = $_REQUEST['cppheaderbackcolor'];
//        $setECReqDetails->cpppayflowcolor = $_REQUEST['cpppayflowcolor'];
//        $setECReqDetails->cppcartbordercolor = $_REQUEST['cppcartbordercolor'];
//        $setECReqDetails->cpplogoimage = $_REQUEST['cpplogoimage'];
//        $setECReqDetails->PageStyle = $_REQUEST['pageStyle'];
//        $setECReqDetails->BrandName = $_REQUEST['brandName'];
            // Advanced options
            $setECReqDetails->AllowNote = 0;

            $setECReqDetails->Custom = $this->session->data['order_id'];

            $setECReqType = new SetExpressCheckoutRequestType();
            $setECReqType->SetExpressCheckoutRequestDetails = $setECReqDetails;
            $setECReq = new SetExpressCheckoutReq();
            $setECReq->SetExpressCheckoutRequest = $setECReqType;
            
            $paypalService = new PayPalAPIInterfaceServiceService();
            
            $paypalAPICredentials = new PPSignatureCredential($this->config->get('pp_express_username'), $this->config->get('pp_express_password'), $this->config->get('pp_express_signature'));
            
            try {
                /* wrap API method calls on the service object with a try catch */
                $setECResponse = $paypalService->SetExpressCheckout($setECReq, $paypalAPICredentials);
                
                $audit->write(serialize($setECResponse));
            } catch (Exception $ex) {
                $this->response->redirect($this->url->link('payment/pp_express/error', '', 'SSL'));
           }

            if (isset($setECResponse)) {
                if ($setECResponse->Ack == 'Success') {
                    $token = $setECResponse->Token;

                    if (!$this->config->get('pp_express_test')) {
                            $payPalURL = 'https://www.paypal.com/webscr';
                    } else {
                            $payPalURL = 'https://www.sandbox.paypal.com/webscr';
                    }
                    $payPalURL .= '?cmd=_express-checkout&token=' . $token;

                    $this->response->redirect($payPalURL);
                } else {
                    $this->response->redirect($this->url->link('payment/pp_express/error', '', 'SSL'));
                }
            }

            $this->render();
        }
    }

    public function finish() {
        $audit = new Log(date("Y-m-d") . "-paypal.log");
        
        if (!defined('PP_CONFIG_PATH')) {
            if (!$this->config->get('pp_standard_test'))
            {
                define('PP_CONFIG_PATH', DIR_SYSTEM . 'vendor/paypal/config_live/');
            } else {
                define('PP_CONFIG_PATH', DIR_SYSTEM . 'vendor/paypal/config_sandbox/');
            }
        }
        
        $this->load->model('checkout/order');
        $this->load->model('payment/pp_express');

        $order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);

        $token = urlencode($this->request->get['token']);
        $payerId = urlencode($this->request->get['PayerID']);
        
        $audit->write(serialize($this->request->get));

        if ($this->config->get('pp_express_method')) {
            $paymentAction = "Sale";
        } else {
            $paymentAction = "Order";
        }

// ------------------------------------------------------------------
// this section is optional if parameters required for DoExpressCheckout is retrieved from your database
        $getExpressCheckoutDetailsRequest = new GetExpressCheckoutDetailsRequestType($token);
        $getExpressCheckoutReq = new GetExpressCheckoutDetailsReq();
        $getExpressCheckoutReq->GetExpressCheckoutDetailsRequest = $getExpressCheckoutDetailsRequest;

        $paypalService = new PayPalAPIInterfaceServiceService();
        
        $paypalAPICredentials = new PPSignatureCredential($this->config->get('pp_express_username'), $this->config->get('pp_express_password'), $this->config->get('pp_express_signature'));
        try {
            /* wrap API method calls on the service object with a try catch */
            $getECResponse = $paypalService->GetExpressCheckoutDetails($getExpressCheckoutReq, $paypalAPICredentials);
            
            $audit->write(serialize($getECResponse));
        } catch (Exception $ex) {
            $this->response->redirect($this->url->link('payment/pp_express/error', '', 'SSL'));
        }
//----------------------------------------------------------------------------

        $orderTotal = new BasicAmountType();
        $orderTotal->currencyID = $order_info['currency_code'];
        $orderTotal->value = $this->currency->format($order_info['total'], $order_info['currency_code'], false, false);

        $paymentDetails = new PaymentDetailsType();
        $paymentDetails->OrderTotal = $orderTotal;
//        if (isset($_REQUEST['notifyURL'])) {
//            $paymentDetails->NotifyURL = $_REQUEST['notifyURL'];
//        }

        $DoECRequestDetails = new DoExpressCheckoutPaymentRequestDetailsType();
        $DoECRequestDetails->PayerID = $payerId;
        $DoECRequestDetails->Token = $token;
        $DoECRequestDetails->PaymentAction = $paymentAction;
        $DoECRequestDetails->PaymentDetails[0] = $paymentDetails;

        $DoECRequest = new DoExpressCheckoutPaymentRequestType();
        $DoECRequest->DoExpressCheckoutPaymentRequestDetails = $DoECRequestDetails;


        $DoECReq = new DoExpressCheckoutPaymentReq();
        $DoECReq->DoExpressCheckoutPaymentRequest = $DoECRequest;

        try {
            /* wrap API method calls on the service object with a try catch */
            $DoECResponse = $paypalService->DoExpressCheckoutPayment($DoECReq, $paypalAPICredentials);
            
            $audit->write(serialize($DoECResponse));
        } catch (Exception $ex) {
            $this->response->redirect($this->url->link('payment/pp_express/error', '', 'SSL'));
        }
        
        if (isset($DoECResponse)) {

            if ($DoECResponse->Ack == 'Success' && isset($DoECResponse->DoExpressCheckoutPaymentResponseDetails->PaymentInfo)) {
                
                $transaction = $DoECResponse->DoExpressCheckoutPaymentResponseDetails->PaymentInfo[0];
                $payment = $getECResponse->GetExpressCheckoutDetailsResponseDetails;
            
		if (isset($payment->Custom)) {
			$order_id = $payment->Custom;
		} else {
			$order_id = 0;
		}		
		
		$this->load->model('checkout/order');
				
		$order_info = $this->model_checkout_order->getOrder($order_id);
                
                $order_status_id = $this->config->get('pp_express_order_status_id');
                            
                if (!$order_info['order_status_id']) {
                        $this->model_checkout_order->confirm($order_id, $order_status_id, '', false, $this->getMessage($comment, $transaction));
                } else {
                        $this->model_checkout_order->update($order_id, $order_status_id, '', false, $this->getMessage($comment, $transaction));
                }
                
                $this->response->redirect($this->url->link('checkout/success', '', 'SSL'));
            } else {
                $this->response->redirect($this->url->link('payment/pp_express/error', '', 'SSL'));
            }
            

//            echo "<table>";
//            echo "<tr><td>Ack :</td><td><div id='Ack'>$DoECResponse->Ack</div> </td></tr>";
//            if (isset($DoECResponse->DoExpressCheckoutPaymentResponseDetails->PaymentInfo)) {
//                echo "<tr><td>TransactionID :</td><td><div id='TransactionID'>" . $DoECResponse->DoExpressCheckoutPaymentResponseDetails->PaymentInfo[0]->TransactionID . "</div> </td></tr>";
//            }
//            echo "</table>";
//            echo "<pre>";
//            print_r($DoECResponse);
//            echo "</pre>";
        }

        $this->render();
    }

    public function error() {

        $this->data['continue'] = $this->url->link('checkout/cart');

        $this->setTemplate('payment/pp_express_failure.tpl');

        $this->response->setOutput($this->render());
        
        exit();
    }
    
    private function getMessage($comment, $transaction)
    {
        $comment = 'PayPal Express Callback' . "\n" . $comment;

        foreach ($transaction as $key => $value)
        {
            switch ($key) {
                case 'TransactionID':
                case 'TransactionType':
                case 'PaymentStatus':
                    $comment .= $key . ' {' . $value . '}' . "\n";
                    break;
            }
        }

        return trim($comment);
    }

}

?>