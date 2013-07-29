<?php


class ModelPaymentPPExpress extends Model {

    public function getMethod($address, $total) {
        $this->load->language('payment/pp_express');

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int) $this->config->get('pp_express_geo_zone_id') . "' AND country_id = '" . (int) $address['country_id'] . "' AND (zone_id = '" . (int) $address['zone_id'] . "' OR zone_id = '0')");

        if ($this->config->get('pp_express_total') > $total) {
            $status = false;
        } elseif (!$this->config->get('pp_express_geo_zone_id')) {
            $status = true;
        } elseif ($query->num_rows) {
            $status = true;
        } else {
            $status = false;
        }

        $method_data = array();

        if ($status) {
            $method_data = array(
                'code' => 'pp_express',
                'title' => $this->language->get('text_title'),
                'sort_order' => $this->config->get('pp_express_sort_order')
            );
        }

        return $method_data;
    }

    public function isRefundable() {
        return false;
    }

    private function getApiContext() {
        $apiContext = new ApiContext(new OAuthTokenCredential(
                                'ATkZABBJgahfQUzRYKwjM0vqp_zKvRbofFk0NadXg0z1B1uHEAmNXDav-wpo',
                                'EO422dn3gQLgDbuwqTjzrFgFtaRLRR5BdHEESmha49TM'
                ));

        // Define the location of the sdk_config.ini file 
        define("PP_CONFIG_PATH", dirname(__DIR__));

        // Alternatively pass in the configuration via a hashmap.
        // The hashmap can contain any key that is allowed in
        // sdk_config.ini	
        /*
          $apiContext->setConfig(array(
          'http.ConnectionTimeOut' => 30,
          'http.Retry' => 1,
          'mode' => 'sandbox',
          'log.LogEnabled' => true,
          'log.FileName' => '../PayPal.log',
          'log.LogLevel' => 'INFO'
          ));
         */
        return $apiContext;
    }

    public function makePaymentUsingPayPal($order_info, $returnUrl, $cancelUrl) {

        $payer = new Payer();
        $payer->setPayment_method("paypal");

        // Specify the payment amount.
        $amount = new Amount();
        $amount->setCurrency($currency);
        $amount->setTotal($total);

        // ###Transaction
        // A transaction defines the contract of a
        // payment - what is the payment for and who
        // is fulfilling it. Transaction is created with
        // a `Payee` and `Amount` types
        $transaction = new Transaction();
        $transaction->setAmount($amount);
        $transaction->setDescription($payment_desc);

        $redirectUrls = new RedirectUrls();
        $redirectUrls->setReturn_url($returnUrl);
        $redirectUrls->setCancel_url($cancelUrl);

        $payment = new Payment();
        $payment->setRedirect_urls($redirectUrls);
        $payment->setIntent("sale");
        $payment->setPayer($payer);
        $payment->setTransactions(array($transaction));

        $payment->create(getApiContext());
        return $payment;
    }

    public function setEC($order_info, $returnUrl, $cancelUrl, $callbackUrl) {

        //$logger = new PPLoggingManager('SetExpressCheckout');

        $setExpressCheckoutRequestDetails = new SetExpressCheckoutRequestDetailsType();

        $setExpressCheckoutRequestDetails->ReturnURL = $returnUrl;

        $setExpressCheckoutRequestDetails->CancelURL = $cancelUrl;

        $paymentDetailsArray = array();

        // information about the first payment
        $paymentDetails1 = new PaymentDetailsType();

        $orderTotal1 = new BasicAmountType($order_info['currency_code'], $this->currency->format($order_info['total'], $order_info['currency_code'], false, false));
        $paymentDetails1->OrderTotal = $orderTotal1;

        if ($this->config->get('pp_express_method')) {
            $paymentDetails1->PaymentAction = "Sale";
        } else {
            $paymentDetails1->PaymentAction = "Order";
        }


        // Unique identifier for the merchant. For parallel payments, this field
        // is required and must contain the Payer Id or the email address of the
        // merchant.
        $sellerDetails1 = new SellerDetailsType();
        $sellerDetails1->PayPalAccountID = "paypalsandbox@totallyboundless.com";
        $paymentDetails1->SellerDetails = $sellerDetails1;


        // `Address` to which the order is shipped, which takes mandatory params:
        //
		// * `Street Name`
        // * `City`
        // * `State`
        // * `Country`
        // * `Postal Code`
        $shipToAddress1 = new AddressType();
        $shipToAddress1->Street1 = "Ape Way";
        $shipToAddress1->CityName = "Austin";
        $shipToAddress1->StateOrProvince = "TX";
        $shipToAddress1->Country = "US";
        $shipToAddress1->PostalCode = "78750";

        // Your URL for receiving Instant Payment Notification (IPN) about this transaction. If you do not specify this value in the request, the notification URL from your Merchant Profile is used, if one exists.
        $paymentDetails1->NotifyURL = $callbackUrl;

        $paymentDetails1->ShipToAddress = $shipToAddress1;

        $paymentDetailsArray[0] = $paymentDetails1;

        $setExpressCheckoutRequestDetails->PaymentDetails = $paymentDetailsArray;
        $setExpressCheckoutRequestDetails->Custom = $order_info['order_id'];

        $setExpressCheckoutReq = new SetExpressCheckoutReq();
        $setExpressCheckoutRequest = new SetExpressCheckoutRequestType($setExpressCheckoutRequestDetails);

        $setExpressCheckoutReq->SetExpressCheckoutRequest = $setExpressCheckoutRequest;



        // ## Creating service wrapper object
        // Creating service wrapper object to make API call and loading
        // configuration file for your credentials and endpoint
        $service = new PayPalAPIInterfaceServiceService();

        try {
            // ## Making API call
            // Invoke the appropriate method corresponding to API in service
            // wrapper object
            $response = $service->SetExpressCheckout($setExpressCheckoutReq);
        } catch (Exception $ex) {
            //$logger->error("Error Message : " + $ex->getMessage());
        }

        // ## Accessing response parameters
        // You can access the response parameters using variables in
        // response object as shown below
        // ### Success values
        if ($response->Ack == "Success") {

            // ### Redirecting to PayPal for authorization
            // Once you get the "Success" response, needs to authorise the
            // transaction by making buyer to login into PayPal. For that,
            // need to construct redirect url using EC token from response.
            // For example,
            // `redirectURL="https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=". $response->Token();`
            // Express Checkout Token
            //$logger->log("EC Token:" . $response->Token);
        }
        // ### Error Values
        // Access error values from error list using getter methods
        else {
            //$logger->error("API Error Message : ". $response->Errors[0]->LongMessage);
        }
        return $response;
    }

    public function getEC() {

        $getExpressCheckoutDetailsRequest = new GetExpressCheckoutDetailsRequestType($this->request->get['token']);

        $getExpressCheckoutReq = new GetExpressCheckoutDetailsReq();
        $getExpressCheckoutReq->GetExpressCheckoutDetailsRequest = $getExpressCheckoutDetailsRequest;

        $paypalService = new PayPalAPIInterfaceServiceService();
        try {
            /* wrap API method calls on the service object with a try catch */
            $getECResponse = $paypalService->GetExpressCheckoutDetails($getExpressCheckoutReq);
        } catch (Exception $ex) {
            include_once("../Error.php");
            exit;
        }
        if (isset($getECResponse)) {
            echo "<table>";
            echo "<tr><td>Ack :</td><td><div id='Ack'>" . $getECResponse->Ack . "</div> </td></tr>";
            echo "<tr><td>Token :</td><td><div id='Token'>" . $getECResponse->GetExpressCheckoutDetailsResponseDetails->Token . "</div></td></tr>";
            echo "<tr><td>PayerID :</td><td><div id='PayerID'>" . $getECResponse->GetExpressCheckoutDetailsResponseDetails->PayerInfo->PayerID . "</div></td></tr>";
            echo "<tr><td>PayerStatus :</td><td><div id='PayerStatus'>" . $getECResponse->GetExpressCheckoutDetailsResponseDetails->PayerInfo->PayerStatus . "</div></td></tr>";
            echo "</table>";
            echo '<pre>';
            print_r($getECResponse);
            echo '</pre>';
        }
    }

}

?>