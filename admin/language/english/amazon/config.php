<?php
// Heading
$_['heading_title']    = 'Configuration';

// Text
$_['text_amazon']      = 'Amazon Market Place';
$_['text_success']     = 'Success: You have modified Amazon Market Place !';

$_['entry_marketplace']  = 'Marketplace' ;
$_['entry_amazon_ca']    = 'Canada' ;
$_['entry_amazon_fr']    = 'France' ;
$_['entry_amazon_de']    = 'Germany' ;
$_['entry_amazon_it']    = 'Italy' ;
$_['entry_amazon_jp']    = 'Japan' ;
$_['entry_amazon_es']    = 'Spain' ;
$_['entry_amazon_uk']    = 'United Kingdom' ;
$_['entry_amazon_us']    = 'United States' ;

// Entry
$_['entry_currency']        = 'Currency' ;
$_['entry_status']          = 'Status:';
$_['entry_merchant_id']     = 'Merchant ID';
$_['entry_marketplace_id']  = 'Market Place ID';
$_['entry_aws_key_id']      = 'AWS Key Id';
$_['entry_aws_secret_id']   = 'AWS Secret Key';

$_['entry_adv_key']         = 'Advertising Key ID';
$_['entry_adv_secret_key']  = 'Advertising Secret Key';

$_['entry_out_of_stock']    = 'Out of Stock' ;
$_['entry_price_formula']   = 'Price Formula' ;
$_['entry_price_callback']  = 'Price CallBack' ;
$_['entry_shipping_method'] = 'Shipping Method' ;
$_['entry_payment_method']  = 'Payment Methods' ;
$_['entry_debug_mode']      = 'Debug Mode' ;

// Entry
$_['required_merchant_id']     = 'Merchant ID';
$_['required_marketplace_id']  = 'Market Place ID';
$_['required_aws_key_id']      = 'AWS Key Id';
$_['required_aws_secret_id']   = 'AWS Secret Key';
$_['required_price_formula']   = 'Price Formula' ;
$_['required_price_callback']  = 'Price CallBack' ;
$_['required_shipping_method'] = 'Shipping Method' ;
$_['required_payment_method']  = 'Payment Method' ;

// Help
//
$_['help_keypairs']         = 'These informations are provided by The Amazon Market Place please go to the following url to subscribe to these services : <a href="https://sellercentral.amazon.com">https://sellercentral.amazon.com</a>';
$_['help_advapi']           = 'These informations are provided by The Amazon Advertising API please go to the following url to subscribe to these services : <a href="https://affiliate-program.amazon.com/gp/advertising/api/detail/main.html">https://affiliate-program.amazon.com/</a>';

$_['help_out_of_stock']     = 'Minimum of quantity in stock to export the product ';
$_['help_price_formula']    = 'Formula to be applied on all the exported products prices (multiply, divide, addition, subtraction, percentages)<br />' .
                                'Use the @ symbol as price reference (eg: @ + 10% mean you\'ll add 10% to the initial price, @ alone to keep your price intact)' ;
$_['help_price_callback']   = 'PHP Code to be applied to the price (for rounding, formating etc...) ' .
                                'Use the @ symbol as price reference (eg: round(@, 2) mean you\'ll round to 2 decimals...)' ;

$_['help_shipping_method']  = 'The shipping method name which appear on the order';
$_['help_payment_method']   = 'The payment method name which appear on the order';
$_['help_debug_mode']       = 'Set the debug mode to active, should no be set in normal operation mode !' ;

// Error
$_['error_permission'] = 'Warning: You do not have permission to modify Amazon Market Place!';
$_['error_required'] = 'Warning: the field %s is required for %s !';
?>