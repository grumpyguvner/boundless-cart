<?php
// Heading
$_['heading_title']                 = 'Import Orders';

// Text
$_['text_feed']                     = 'Amazon Market Place';
$_['text_success']                  = 'Success: You have modified Amazon Market Place!';

// Text
$_['button_back']                   = 'Back';

// Entry
$_['entry_title']                   = 'Import your orders from Amazon Market Place';

$_['entry_options']                 = 'Options :';

$_['entry_lookup_orders']         = 'Lookup Only (Do not import)';

$_['entry_last_import']              = 'Last Import : %s';
$_['entry_no_last_import']           = 'Orders were never imported';

$_['entry_import_from']             = 'From';
$_['entry_import_to']               = 'To';
$_['entry_status']                  = 'Status';
$_['entry_orders']                  = 'Orders';
$_['entry_legend']                  = 'Legend';

$_['entry_submit']                  = 'Import Now';
$_['entry_lookup']                  = 'Lookup now';
$_['entry_retrieve']                = 'Get Details for Selected Orders';
$_['entry_import']                  = 'Import Selected Orders';
$_['entry_delete_order']            = 'Are you sure to delete this order from this store ?';
$_['entry_order_deleted']           = 'Order %d was successfully deleted...';

$_['entry_add_stock_error']         = 'Not enough stock, but the product can be imported' ;
$_['entry_add_not_exists']          = 'Unidentified product in the store, but can be imported' ;
$_['entry_add_imported']            = 'Available and in stock' ;
$_['entry_add_unkwnown_error']      = 'Fatal Error !' ;

$_['entry_amazon_order']            = 'Order from Amazon Market Place :' ;
$_['entry_details_ok']              = 'Orders details from Amazon Market Place loaded...' ;
$_['entry_amazon_fetch_order']      = 'Orders from Amazon Market Place loaded...' ;
$_['entry_amazon_order_imported']   = 'Order %s from Amazon Market Place was successfully imported as order #%d : [&nbsp;<a href="%s" target="_blank" title="">Edit</a>&nbsp;]<br />' ;
$_['entry_amazon_no_order']         = 'No order from Amazon Market Place for the selected period and status...' ;

// Order Table
//
$_['entry_order_id']                = '<img src="view/image/amazon/delete.png" alt="Delete This Order" />' ;
$_['entry_order_name']              = 'Purchaser Name' ;
$_['entry_order_shipping']          = 'Shipping' ;
$_['entry_order_shipping_price']    = 'Ship.Price' ;
$_['entry_order_date']              = 'Order Date' ;
$_['entry_order_quantity']          = 'Qty' ;
$_['entry_order_amount']            = 'Amount' ;
$_['entry_order_currency']          = '&nbsp;&nbsp;$' ;
$_['entry_order_status']            = 'Status' ;

// Product Table
//
$_['entry_product_status']          = 'Status' ;
$_['entry_product_asin']            = 'ASIN' ;
$_['entry_product_sku']             = 'SKU' ;
$_['entry_product_quantity']        = 'Qty' ;
$_['entry_product_name']            = 'Name' ;
$_['entry_product_shipping']        = 'Shipping' ;
$_['entry_product_currency']        = '&nbsp;&nbsp;$' ;
$_['entry_product_price']           = 'Price' ;

// Order Total
//
$_['entry_sub_total']               = 'Sub-Total:' ;
$_['entry_total']                   = 'Total:' ;

// Import Messages
//
$_['entry_import_address_empty']    = 'Fatal Error : order->Address->Name is empty (%s)' ;
$_['entry_import_city_empty']       = 'Fatal Error : order->Address->City is empty (%s)' ;
$_['entry_import_items_empty']      = 'Fatal Error : no Items in this Order (%s)' ;
$_['entry_import_add_failed']       = 'Fatal Error : Failed to create order in database (%s)' ;
$_['entry_import_add_product_failed'] = 'Fatal Error : Failed to create product %s in database for order %s' ;
$_['entry_import_wrong_qty']        = 'Warning : Wrong Quantity for order %s item %s' ;

// Error
$_['error_permission']              = 'Warning: You do not have permission to modify Amazon Market Place!';
$_['error_login']                   = 'Error: Unable to connect to Amazon Market Place!';
$_['error_orders']                  = 'Warning: No order to retrieve from Amazon Market Place!';
$_['error_retrieve']                = 'Error: Unable to retrieve order id : %s';

$_['warning_nothing']               = 'Warning : nothing to import from Amazon Market Place!';

// Statuses
//
$_[ 'status_All' ]              = 'All - Retrieve all orders on the Market Place' ;
$_[ 'status_Pending' ]          = 'Pending - This order is pending on the Market Place' ;
$_[ 'status_Unshipped' ]        = 'Unshipped - This order wait to be shipped' ;
$_[ 'status_PartiallyShipped' ] = 'Partially Shipped - This order was Partially Shipped' ;
$_[ 'status_Shipped' ]          = 'Shipped - This order was Shipped' ;
$_[ 'status_Canceled' ]         = 'Canceled - This order was canceled' ;
?>