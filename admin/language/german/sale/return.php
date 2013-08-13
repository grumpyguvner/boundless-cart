<?php
// Heading
$_['heading_title']       = 'Product Returns';

// Text
$_['text_opened']         = 'Opened';
$_['text_unopened']       = 'Unopened';
$_['text_success']        = 'Success: You have modified returns!';
$_['text_wait']           = 'Please Wait!';

// Text
$_['text_return_id']      = 'Return ID:';
$_['text_order_id']       = 'Order ID:';
$_['text_new_order_id']       = 'New Order ID:';
$_['text_date_ordered']   = 'Order Date:';
$_['text_customer']       = 'Customer:';
$_['text_email']          = 'E-Mail:';
$_['text_telephone']      = 'Telephone:';
$_['text_return_status']  = 'Return Status:';
$_['text_date_added']     = 'Date Added:';
$_['text_date_modified']  = 'Date Modified:';
$_['text_product']        = 'Product:';
$_['text_model']          = 'Model:';
$_['text_price']          = 'Price:';
$_['text_quantity']       = 'Quantity:';
$_['text_refund_amount']  = 'Refund Amount:';
$_['text_return_reason']  = 'Return Reason:';
$_['text_return_action']  = 'Return Action:';
$_['text_comment']        = 'Comment:';
$_['text_add_product']    = 'Add Product(s)';
$_['text_order']                              = 'Order Details';

// Column
$_['column_return_id']     = 'Return ID';
$_['column_order_id']      = 'Order ID';
$_['column_customer']      = 'Customer';
$_['column_total']                            = 'Total';
$_['column_product']       = 'Product';
$_['column_model']         = 'Model';
$_['column_status']        = 'Status';
$_['column_quantity']                         = 'Quantity';
$_['column_price']                            = 'Unit Price';
$_['column_date_added']    = 'Date Added';
$_['column_date_modified'] = 'Date Modified';
$_['column_comment']       = 'Comment';
$_['column_notify']        = 'Customer Notified';
$_['column_action']        = 'Action';

// Entry
$_['entry_customer']      = 'Customer:';
$_['entry_order_id']      = 'Order ID:';
$_['entry_date_ordered']  = 'Order Date:';
$_['entry_firstname']     = 'First Name:';
$_['entry_lastname']      = 'Last Name:';
$_['entry_email']         = 'E-Mail:';
$_['entry_telephone']     = 'Telephone:';
$_['entry_model']         = 'Model:';
$_['entry_price']         = 'Price:';
$_['entry_quantity']      = 'Quantity:';
$_['entry_reason']        = 'Return Reason:';
$_['entry_opened']        = 'Opened:';
$_['entry_comment']       = 'Comment:';
$_['entry_return_status'] = 'Return Status:';
$_['entry_notify']        = 'Notify Customer:';
$_['entry_action']        = 'Return Action:';
$_['entry_refund_amount'] = 'Refund Amount:';
$_['entry_shipping']                          = 'Shipping Method:';

$_['entry_product']                           = 'Choose Product:';
$_['entry_option']                            = 'Choose Option(s):';

// Error
$_['error_warning']       = 'Warning: Please check the form carefully for errors!';
$_['error_permission']    = 'Warning: You do not have permission to modify returns!';
$_['error_order_id']      = 'Order ID required!';
$_['error_firstname']     = 'First Name must be between 1 and 32 characters!';
$_['error_lastname']      = 'Last Name must be between 1 and 32 characters!';
$_['error_email']         = 'E-Mail Address does not appear to be valid!';
$_['error_telephone']     = 'Telephone must be between 3 and 32 characters!';
$_['error_product']       = 'Product Name must be greater than 3 and less than 255 characters!';
$_['error_model']         = 'Product Model must be greater than 3 and less than 64 characters!';

$_['error_refund_amount_title']   = 'Refund';
$_['error_refund_amount']         = 'Warning: Refund needed.<br><br>Refund Amount : %s<br><br>Please confirm you have done this via their payment method manually.';

$_['confirm_refund']              = 'Refund amount approved: %s (refund_id %s)';

$_['error_replacement_amount_title']   = 'Replacement';
$_['error_replacement_amount_refund']  = 'Warning: Replacement order created but the client also requires refund needed.<br><br>Returned products : %s<br>New Order Amount : %s<br>Refund Amount : %s<br>Please confirm you have done this via their payment method manually.';
$_['error_replacement_amount_underpay']= 'Warning: Replacement order created but the client has now under paid.<br><br>Returned products : %s<br>New Order Amount : %s<br>Underpay Amount : %s<br><br>Please confirm you have done this via their payment method manually.';

$_['confirm_replacement_refund']  = 'Replacement amount approved: Returned products: %s, Order Amount: %s, Refund Amount: %s (refund_id %s, order_id %s)';
$_['confirm_replacement_underpay']= 'Replacement amount approved: Returned products: %s, Order Amount: %s, Underpay Amount: %s (refund_id %s, order_id %s)';
?>