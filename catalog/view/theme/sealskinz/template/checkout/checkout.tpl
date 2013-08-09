<?php echo $header; ?>
<div id="breadcrumb">
    <div class="container">
        <?php
        foreach ($breadcrumbs as $breadcrumb) {
            echo $breadcrumb['separator'] . '<a href="' . $breadcrumb['href'] . '">' . $breadcrumb['text'] . '</a>';
        }
        ?>
    </div>
</div>
<div id="notification">
    <?php if (isset($success) && $success) { ?>
        <div class="success"><?php echo $success; ?></div>
        <?php
    }
    if (isset($error_warning) && $error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php }
    ?>
</div>
<div id="mainContainer" class="container"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content">
        <?php echo $content_top; ?>
        <h1><?php echo $heading_title; ?></h1>
        <div class="checkout">
            <div id="checkout">
                <div class="checkout-heading"><?php echo $text_checkout_option; ?></div>
                <div class="checkout-content"></div>
            </div>
            <?php if (!$logged) { ?>
                <div id="payment-address">
                    <div class="checkout-heading"><span><?php echo $text_checkout_account; ?></span></div>
                    <div class="checkout-content"></div>
                </div>
            <?php } else { ?>
                <div id="payment-address">
                    <div class="checkout-heading"><span><?php echo $text_checkout_payment_address; ?></span></div>
                    <div class="checkout-content"></div>
                </div>
            <?php } ?>
            <?php if ($shipping_required) { ?>
                <div id="shipping-address">
                    <div class="checkout-heading"><?php echo $text_checkout_shipping_address; ?></div>
                    <div class="checkout-content"></div>
                </div>
                <div id="shipping-method">
                    <div class="checkout-heading"><?php echo $text_checkout_shipping_method; ?></div>
                    <div class="checkout-content"></div>
                </div>
            <?php } ?>
            <div id="payment-method">
                <div class="checkout-heading"><?php echo $text_checkout_confirm; ?></div>
                <div class="checkout-content" style="padding-bottom: 0"></div>
            </div>
            <div id="confirm">
                <div class="checkout-content"></div>
            </div>
        </div>



        <?php echo $content_bottom; ?>    
    </div></div>
<script type="text/javascript"><!--
    $('#checkout .checkout-content input[name=\'account\']').live('change', function() {
        if ($(this).attr('value') == 'register') {
            $('#payment-address .checkout-heading span').html('<?php echo $text_checkout_account; ?>');
        } else {
            $('#payment-address .checkout-heading span').html('<?php echo $text_checkout_payment_address; ?>');
        }
    });

    $('.checkout-heading a').live('click', function() {
        $('.checkout-content').slideUp('slow');
	
        $(this).parent().parent().find('.checkout-content').slideDown('slow');
    });
<?php if (!$logged) { ?> 
        $(document).ready(function() {
            $.ajax({
                url: 'index.php?route=checkout/login',
                dataType: 'html',
                success: function(html) {
                    $('#checkout .checkout-content').html(html);
            				
                    $('#checkout .checkout-content').slideDown('slow');
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });	
        });		
<?php } else { ?>
        $.ajax({
            url: 'index.php?route=checkout/payment_address',
            dataType: 'html',
            success: function(html) {
                $('#shipping-address .checkout-content').html(html);
                <?php if ($shipping_required) { ?>
                $.ajax({
                    url: 'index.php?route=checkout/shipping_address',
                    dataType: 'html',
                    success: function(html) {
                        $('#shipping-address .checkout-content').append(html);

                        $('#shipping-address .checkout-content').slideDown('slow');
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
                <?php } else { ?>
                $('#shipping-address .checkout-content').append(html);
                <?php } // end if ?>
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
<?php } ?>

    // Checkout
    $('#button-account').live('click', function() {
        $.ajax({
            url: 'index.php?route=checkout/' + $('input[name=\'account\']:checked').attr('value'),
            dataType: 'html',
            beforeSend: function() {
                $('#button-account').attr('disabled', true);
                $('#button-account').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },		
            complete: function() {
                $('#button-account').attr('disabled', false);
                $('.wait').remove();
            },			
            success: function(html) {
                $('.warning, .error').remove();
			
                $('#payment-address .checkout-content').html(html);
				
                $('#checkout .checkout-content').slideUp('slow');
				
                $('#payment-address .checkout-content').slideDown('slow');
				
                $('.checkout-heading a').remove();
				
                $('#checkout .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    // Login
    $('#button-login').live('click', function() {
        $.ajax({
            url: 'index.php?route=checkout/login/validate',
            type: 'post',
            data: $('#checkout #login :input'),
            dataType: 'json',
            beforeSend: function() {
                $('#button-login').attr('disabled', true);
                $('#button-login').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },	
            complete: function() {
                $('#button-login').attr('disabled', false);
                $('.wait').remove();
            },				
            success: function(json) {
                $('.warning, .error').remove();
			
                if (json['redirect']) {
                    location = json['redirect'];
                } else if (json['error']) {
                    $('#checkout .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
				
                    $('.warning').fadeIn('slow');
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });	
    });

    // Register
    $('#button-register').live('click', function() {
        $.ajax({
            url: 'index.php?route=checkout/register/validate',
            type: 'post',
            data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'password\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address input[type=\'hidden\'], #payment-address select'),
            dataType: 'json',
            beforeSend: function() {
                $('#button-register').attr('disabled', true);
                $('#button-register').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },	
            complete: function() {
                $('#button-register').attr('disabled', false); 
                $('.wait').remove();
            },			
            success: function(json) {
                $('.warning, .error').remove();
						
                if (json['redirect']) {
                    location = json['redirect'];				
                } else if (json['error']) {
                    if (json['error']['warning']) {
                        $('#payment-address .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
                        $('.warning').fadeIn('slow');
                    }
				
                    if (json['error']['firstname']) {
                        $('#payment-address input[name=\'firstname\'] + br').after('<span class="error">' + json['error']['firstname'] + '</span>');
                    }
				
                    if (json['error']['lastname']) {
                        $('#payment-address input[name=\'lastname\'] + br').after('<span class="error">' + json['error']['lastname'] + '</span>');
                    }	
				
                    if (json['error']['email']) {
                        $('#payment-address input[name=\'email\'] + br').after('<span class="error">' + json['error']['email'] + '</span>');
                    }
				
                    if (json['error']['telephone']) {
                        $('#payment-address input[name=\'telephone\'] + br').after('<span class="error">' + json['error']['telephone'] + '</span>');
                    }	
					
                    if (json['error']['company_id']) {
                        $('#payment-address input[name=\'company_id\'] + br').after('<span class="error">' + json['error']['company_id'] + '</span>');
                    }	
				
                    if (json['error']['tax_id']) {
                        $('#payment-address input[name=\'tax_id\'] + br').after('<span class="error">' + json['error']['tax_id'] + '</span>');
                    }	
																		
                    if (json['error']['address_1']) {
                        $('#payment-address input[name=\'address_1\'] + br').after('<span class="error">' + json['error']['address_1'] + '</span>');
                    }	
				
                    if (json['error']['city']) {
                        $('#payment-address input[name=\'city\'] + br').after('<span class="error">' + json['error']['city'] + '</span>');
                    }	
				
                    if (json['error']['postcode']) {
                        $('#payment-address input[name=\'postcode\'] + br').after('<span class="error">' + json['error']['postcode'] + '</span>');
                    }	
				
                    if (json['error']['country']) {
                        $('#payment-address select[name=\'country_id\'] + br').after('<span class="error">' + json['error']['country'] + '</span>');
                    }	
				
                    if (json['error']['zone']) {
                        $('#payment-address select[name=\'zone_id\'] + br').after('<span class="error">' + json['error']['zone'] + '</span>');
                    }
				
                    if (json['error']['password']) {
                        $('#payment-address input[name=\'password\'] + br').after('<span class="error">' + json['error']['password'] + '</span>');
                    }	
				
                    if (json['error']['confirm']) {
                        $('#payment-address input[name=\'confirm\'] + br').after('<span class="error">' + json['error']['confirm'] + '</span>');
                    }
                } else {
                    window.location = 'index.php?route=checkout/checkout';
                }	 
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });	
    });

    // Payment Address	
    $('#button-payment-address').live('click', function() {
        	
    });

    // Shipping Address			
    $('#button-shipping-address').live('click', function() {
        
        $.ajax({
            url: 'index.php?route=checkout/payment_address/validate',
            type: 'post',
            data: $('#paymentPostcodeAnywhere input[type=\'text\'], #paymentPostcodeAnywhere input[type=\'password\'], #paymentPostcodeAnywhere input[type=\'checkbox\']:checked, #paymentPostcodeAnywhere input[type=\'radio\']:checked, #paymentPostcodeAnywhere input[type=\'hidden\'], #paymentPostcodeAnywhere select'),
            dataType: 'json',
            beforeSend: function() {
                $('#button-shipping-address').attr('disabled', true);
                $('#button-shipping-address').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },	
            complete: function() {
                $('#button-shipping-address').attr('disabled', false);
                $('.wait').remove();
            },			
            success: function(json) {
                $('.warning, .error').remove();
			
                if (json['redirect']) {
                    location = json['redirect'];
                } else if (json['error']) {
                    if (json['error']['warning']) {
                        $('#shipping-address .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
                        $('.warning').fadeIn('slow');
                    }
								
                    if (json['error']['firstname']) {
                        $('#paymentPostcodeAnywhere input[name=\'firstname\']').after('<div class="error">' + json['error']['firstname'] + '</div>');
                    }
				
                    if (json['error']['lastname']) {
                        $('#paymentPostcodeAnywhere input[name=\'lastname\']').after('<div class="error">' + json['error']['lastname'] + '</div>');
                    }	
				
                    if (json['error']['telephone']) {
                        $('#paymentPostcodeAnywhere input[name=\'telephone\']').after('<div class="error">' + json['error']['telephone'] + '</div>');
                    }		
				
                    if (json['error']['company_id']) {
                        $('#paymentPostcodeAnywhere input[name=\'company_id\']').after('<div class="error">' + json['error']['company_id'] + '</div>');
                    }	
				
                    if (json['error']['tax_id']) {
                        $('#paymentPostcodeAnywhere input[name=\'tax_id\']').after('<div class="error">' + json['error']['tax_id'] + '</div>');
                    }	
														
                    if (json['error']['address_1']) {
                        $('#paymentPostcodeAnywhere input[name=\'address_1\']').after('<div class="error">' + json['error']['address_1'] + '</div>');
                    }	
				
                    if (json['error']['city']) {
                        $('#paymentPostcodeAnywhere input[name=\'city\']').after('<div class="error">' + json['error']['city'] + '</div>');
                    }	
				
                    if (json['error']['postcode']) {
                        $('#paymentPostcodeAnywhere input[name=\'postcode\']').after('<div class="error">' + json['error']['postcode'] + '</div>');
                    }	
				
                    if (json['error']['country']) {
                        $('#paymentPostcodeAnywhere select[name=\'country_id\']').after('<div class="error">' + json['error']['country'] + '</div>');
                    }	
				
                    if (json['error']['zone']) {
                        $('#paymentPostcodeAnywhere select[name=\'zone_id\']').after('<div class="error">' + json['error']['zone'] + '</div>');
                    }
                } else {
                    <?php if ($shipping_required) { ?>
                        $.ajax({
                            url: 'index.php?route=checkout/shipping_address/validate',
                            type: 'post',
                            data: $('#shippingPostcodeAnywhere input[type=\'text\'], #shippingPostcodeAnywhere input[type=\'hidden\'], #shippingPostcodeAnywhere input[type=\'password\'], #shippingPostcodeAnywhere input[type=\'checkbox\']:checked, #shippingPostcodeAnywhere input[type=\'radio\']:checked, #shippingPostcodeAnywhere select'),
                            dataType: 'json',
                            beforeSend: function() {
                                $('#button-shipping-address').attr('disabled', true);
                                $('#button-shipping-address').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                            },	
                            complete: function() {
                                $('#button-shipping-address').attr('disabled', false);
                                $('.wait').remove();
                            },			
                            success: function(json) {
                                $('.warning, .error').remove();
    			
                                if (json['redirect']) {
                                    location = json['redirect'];
                                } else if (json['error']) {
                                    if (json['error']['warning']) {
                                        $('#shippingPostcodeAnywhere .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
    					
                                        $('.warning').fadeIn('slow');
                                    }
    								
                                    if (json['error']['firstname']) {
                                        $('#shippingPostcodeAnywhere input[name=\'firstname\']').after('<span class="error">' + json['error']['firstname'] + '</span>');
                                    }
    				
                                    if (json['error']['lastname']) {
                                        $('#shippingPostcodeAnywhere input[name=\'lastname\']').after('<span class="error">' + json['error']['lastname'] + '</span>');
                                    }	
    				
                                    if (json['error']['email']) {
                                        $('#shippingPostcodeAnywhere input[name=\'email\']').after('<span class="error">' + json['error']['email'] + '</span>');
                                    }
    				
                                    if (json['error']['telephone']) {
                                        $('#shippingPostcodeAnywhere input[name=\'telephone\']').after('<span class="error">' + json['error']['telephone'] + '</span>');
                                    }		
    										
                                    if (json['error']['address_1']) {
                                        $('#shippingPostcodeAnywhere input[name=\'address_1\']').after('<span class="error">' + json['error']['address_1'] + '</span>');
                                    }	
    				
                                    if (json['error']['city']) {
                                        $('#shippingPostcodeAnywhere input[name=\'city\']').after('<span class="error">' + json['error']['city'] + '</span>');
                                    }	
    				
                                    if (json['error']['postcode']) {
                                        $('#shippingPostcodeAnywhere input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
                                    }	
    				
                                    if (json['error']['country']) {
                                        $('#shippingPostcodeAnywhere select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
                                    }	
    				
                                    if (json['error']['zone']) {
                                        $('#shippingPostcodeAnywhere select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
                                    }
                                } else {
                                    $.ajax({
                                        url: 'index.php?route=checkout/shipping_method',
                                        dataType: 'html',
                                        success: function(html) {
                                            $('#shipping-method .checkout-content').html(html);
    						
                                            $('#shipping-address .checkout-content').slideUp('slow');
    						
                                            $('#shipping-method .checkout-content').slideDown('slow');
    						
                                            $('#shipping-address .checkout-heading a').remove();
                                            $('#shipping-method .checkout-heading a').remove();
                                            $('#payment-method .checkout-heading a').remove();
    						
                                            $('#shipping-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
                                        },
                                        error: function(xhr, ajaxOptions, thrownError) {
                                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                        }
                                    });	
                                }  
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });
                <?php } else { ?>
                        $.ajax({
                            url: 'index.php?route=checkout/payment_method',
                            dataType: 'html',
                            success: function(html) {
                                $('#payment-method .checkout-content').html(html);
            					
                                $('#shipping-address .checkout-content').slideUp('slow');
            						
                                $('#payment-method .checkout-content').slideDown('slow');
            						
                                $('#shipping-address .checkout-heading a').remove();
                                $('#payment-method .checkout-heading a').remove();
            													
                                $('#shipping-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });	
                <?php } ?>	
                   $.ajax({
                        url: 'index.php?route=checkout/payment_address',
                        dataType: 'html',
                        success: function(html) {
                            $('#shipping-address .checkout-content').html(html);
                            <?php if ($shipping_required) { ?>
                            $.ajax({
                                url: 'index.php?route=checkout/shipping_address',
                                dataType: 'html',
                                success: function(html) {
                                    $('#shipping-address .checkout-content').append(html);
                                },
                                error: function(xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });
                            <?php } // end if ?>
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });			
                }	  
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    // Guest
    $('#button-guest').live('click', function() {
        $.ajax({
            url: 'index.php?route=checkout/guest/validate',
            type: 'post',
            data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'checkbox\']:checked, #payment-address select'),
            dataType: 'json',
            beforeSend: function() {
                $('#button-guest').attr('disabled', true);
                $('#button-guest').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },	
            complete: function() {
                $('#button-guest').attr('disabled', false); 
                $('.wait').remove();
            },			
            success: function(json) {
                $('.warning, .error').remove();
			
                if (json['redirect']) {
                    location = json['redirect'];
                } else if (json['error']) {
                    if (json['error']['warning']) {
                        $('#payment-address .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
                        $('.warning').fadeIn('slow');
                    }
								
                    if (json['error']['firstname']) {
                        $('#payment-address input[name=\'firstname\']').after('<div class="error">' + json['error']['firstname'] + '</div>');
                    }
				
                    if (json['error']['lastname']) {
                        $('#payment-address input[name=\'lastname\']').after('<div class="error">' + json['error']['lastname'] + '</div>');
                    }	
				
                    if (json['error']['email']) {
                        $('#payment-address input[name=\'email\']').after('<div class="error">' + json['error']['email'] + '</div>');
                    }
				
                    if (json['error']['telephone']) {
                        $('#payment-address input[name=\'telephone\']').after('<div class="error">' + json['error']['telephone'] + '</div>');
                    }	
					
                    if (json['error']['company_id']) {
                        $('#payment-address input[name=\'company_id\']').after('<div class="error">' + json['error']['company_id'] + '</div>');
                    }	
				
                    if (json['error']['tax_id']) {
                        $('#payment-address input[name=\'tax_id\']').after('<div class="error">' + json['error']['tax_id'] + '</div>');
                    }	
																		
                    if (json['error']['address_1']) {
                        $('#payment-address input[name=\'address_1\']').after('<div class="error">' + json['error']['address_1'] + '</div>');
                    }	
				
                    if (json['error']['city']) {
                        $('#payment-address input[name=\'city\']').after('<div class="error">' + json['error']['city'] + '</div>');
                    }	
				
                    if (json['error']['postcode']) {
                        $('#payment-address input[name=\'postcode\']').after('<div class="error">' + json['error']['postcode'] + '</div>');
                    }	
				
                    if (json['error']['country']) {
                        $('#payment-address select[name=\'country_id\']').after('<div class="error">' + json['error']['country'] + '</div>');
                    }	
				
                    if (json['error']['zone']) {
                        $('#payment-address select[name=\'zone_id\']').after('<div class="error">' + json['error']['zone'] + '</div>');
                    }
                } else {
                    $.ajax({
                        url: 'index.php?route=checkout/guest_shipping',
                        dataType: 'html',
                        success: function(html) {
                            $('#shipping-address .checkout-content').html(html);

                            $('#payment-address .checkout-content').slideUp('slow');

                            $('#shipping-address .checkout-content').slideDown('slow');

                            $('#payment-address .checkout-heading a').remove();
                            $('#shipping-address .checkout-heading a').remove();
                            $('#shipping-method .checkout-heading a').remove();
                            $('#payment-method .checkout-heading a').remove();

                            $('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
                }	 
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });	
    });

    // Guest Shipping
    $('#button-guest-shipping').live('click', function() {
                                    
        $.ajax({
            url: 'index.php?route=checkout/guest/validate',
            type: 'post',
            data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'checkbox\']:checked, #payment-address select, #guestPostcodeAnywhere input[type=\'text\'], #guestPostcodeAnywhere input[type=\'checkbox\']:checked, #guestPostcodeAnywhere select, #shipping-address input[name=\'shipping_address\']:checked'),
            dataType: 'json',
            beforeSend: function() {
                $('#button-guest-shipping').attr('disabled', true);
                $('#button-guest-shipping').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },	
            complete: function() {
                $('#button-guest-shipping').attr('disabled', false); 
                $('.wait').remove();
            },			
            success: function(json) {
                $('.warning, .error').remove();
			
                if (json['redirect']) {
                    location = json['redirect'];
                } else if (json['error']) {
                    if (json['error']['warning']) {
                        $('#shipping-address .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
                        $('.warning').fadeIn('slow');
                    }
					
                    if (json['error']['company_id']) {
                        $('#guestPostcodeAnywhere input[name=\'company_id\']').after('<div class="error">' + json['error']['company_id'] + '</div>');
                    }	
				
                    if (json['error']['tax_id']) {
                        $('#guestPostcodeAnywhere input[name=\'tax_id\']').after('<div class="error">' + json['error']['tax_id'] + '</div>');
                    }	
																		
                    if (json['error']['address_1']) {
                        $('#guestPostcodeAnywhere input[name=\'address_1\']').after('<div class="error">' + json['error']['address_1'] + '</div>');
                    }	
				
                    if (json['error']['city']) {
                        $('#guestPostcodeAnywhere input[name=\'city\']').after('<div class="error">' + json['error']['city'] + '</div>');
                    }	
				
                    if (json['error']['postcode']) {
                        $('#guestPostcodeAnywhere input[name=\'postcode\']').after('<div class="error">' + json['error']['postcode'] + '</div>');
                    }	
				
                    if (json['error']['country']) {
                        $('#guestPostcodeAnywhere select[name=\'country_id\']').after('<div class="error">' + json['error']['country'] + '</div>');
                    }	
				
                    if (json['error']['zone']) {
                        $('#guestPostcodeAnywhere select[name=\'zone_id\']').after('<div class="error">' + json['error']['zone'] + '</div>');
                    }
                } else {
                
<?php if ($shipping_required) { ?>	
                                        var shipping_address = $('#shipping-address input[name=\'shipping_address\']:checked').attr('value');
    				
                                        if (shipping_address) {
                                            $.ajax({
                                                url: 'index.php?route=checkout/shipping_method',
                                                dataType: 'html',
                                                success: function(html) {
                                                    $('#shipping-method .checkout-content').html(html);
    							
                                                    $('#shipping-address .checkout-content').slideUp('slow');
    							
                                                    $('#shipping-method .checkout-content').slideDown('slow');
    							
                                                    $('#payment-address .checkout-heading a').remove();
                                                    $('#shipping-address .checkout-heading a').remove();
                                                    $('#shipping-method .checkout-heading a').remove();
                                                    $('#payment-method .checkout-heading a').remove();		
    															
                                                    $('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
                                                    $('#shipping-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');									
    							
                                                    $.ajax({
                                                        url: 'index.php?route=checkout/guest_shipping',
                                                        dataType: 'html',
                                                        success: function(html) {
                                                            $('#shipping-address .checkout-content').html(html);
                                                        },
                                                        error: function(xhr, ajaxOptions, thrownError) {
                                                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                                        }
                                                    });
                                                },
                                                error: function(xhr, ajaxOptions, thrownError) {
                                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                                }
                                            });					
                                        } else {
                                            $.ajax({
                                                url: 'index.php?route=checkout/guest_shipping/validate',
                                                type: 'post',
                                                data: $('#shipping-address input[type=\'text\'], #shipping-address select'),
                                                dataType: 'json',
                                                beforeSend: function() {
                                                    $('#button-guest-shipping').attr('disabled', true);
                                                    $('#button-guest-shipping').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                                                },	
                                                complete: function() {
                                                    $('#button-guest-shipping').attr('disabled', false); 
                                                    $('.wait').remove();
                                                },			
                                                success: function(json) {
                                                    $('.warning, .error').remove();

                                                    if (json['redirect']) {
                                                        location = json['redirect'];
                                                    } else if (json['error']) {
                                                        if (json['error']['warning']) {
                                                            $('#shipping-address .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                                                            $('.warning').fadeIn('slow');
                                                        }

                                                        if (json['error']['firstname']) {
                                                            $('#shipping-address input[name=\'firstname\']').after('<div class="error">' + json['error']['firstname'] + '</div>');
                                                        }

                                                        if (json['error']['lastname']) {
                                                            $('#shipping-address input[name=\'lastname\']').after('<div class="error">' + json['error']['lastname'] + '</div>');
                                                        }	

                                                        if (json['error']['address_1']) {
                                                            $('#shipping-address input[name=\'address_1\']').after('<div class="error">' + json['error']['address_1'] + '</div>');
                                                        }	

                                                        if (json['error']['city']) {
                                                            $('#shipping-address input[name=\'city\']').after('<div class="error">' + json['error']['city'] + '</div>');
                                                        }	

                                                        if (json['error']['postcode']) {
                                                            $('#shipping-address input[name=\'postcode\']').after('<div class="error">' + json['error']['postcode'] + '</div>');
                                                        }	

                                                        if (json['error']['country']) {
                                                            $('#shipping-address select[name=\'country_id\']').after('<div class="error">' + json['error']['country'] + '</div>');
                                                        }	

                                                        if (json['error']['zone']) {
                                                            $('#shipping-address select[name=\'zone_id\']').after('<div class="error">' + json['error']['zone'] + '</div>');
                                                        }
                                                    } else {
                                                        $.ajax({
                                                            url: 'index.php?route=checkout/shipping_method',
                                                            dataType: 'html',
                                                            success: function(html) {
                                                                $('#shipping-method .checkout-content').html(html);

                                                                $('#shipping-address .checkout-content').slideUp('slow');

                                                                $('#shipping-method .checkout-content').slideDown('slow');

                                                                $('#shipping-address .checkout-heading a').remove();
                                                                $('#shipping-method .checkout-heading a').remove();
                                                                $('#payment-method .checkout-heading a').remove();

                                                                $('#shipping-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
                                                            },
                                                            error: function(xhr, ajaxOptions, thrownError) {
                                                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                                            }
                                                        });				
                                                    }	 
                                                },
                                                error: function(xhr, ajaxOptions, thrownError) {
                                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                                }
                                            });
                                        }
<?php } else { ?>				
                                                        $.ajax({
                                                            url: 'index.php?route=checkout/payment_method',
                                                            dataType: 'html',
                                                            success: function(html) {
                                                                $('#payment-method .checkout-content').html(html);
    						
                                                                $('#payment-address .checkout-content').slideUp('slow');
    							
                                                                $('#payment-method .checkout-content').slideDown('slow');
    							
                                                                $('#payment-address .checkout-heading a').remove();
                                                                $('#payment-method .checkout-heading a').remove();
    														
                                                                $('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
                                                            },
                                                            error: function(xhr, ajaxOptions, thrownError) {
                                                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                                            }
                                                        });				
<?php } ?>
                                                }	 
                                            },
                                            error: function(xhr, ajaxOptions, thrownError) {
                                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                            }
                                        });	
                                    });

                                    $('#button-shipping-method').live('click', function() {
                                        $.ajax({
                                            url: 'index.php?route=checkout/shipping_method/validate',
                                            type: 'post',
                                            data: $('#shipping-method input[type=\'radio\']:checked, #shipping-method textarea'),
                                            dataType: 'json',
                                            beforeSend: function() {
                                                $('#button-shipping-method').attr('disabled', true);
                                                $('#button-shipping-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                                            },	
                                            complete: function() {
                                                $('#button-shipping-method').attr('disabled', false);
                                                $('.wait').remove();
                                            },			
                                            success: function(json) {
                                                $('.warning, .error').remove();
			
                                                if (json['redirect']) {
                                                    location = json['redirect'];
                                                } else if (json['error']) {
                                                    if (json['error']['warning']) {
                                                        $('#shipping-method .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
                                                        $('.warning').fadeIn('slow');
                                                    }			
                                                } else {
                                                    $.ajax({
                                                        url: 'index.php?route=checkout/payment_method',
                                                        dataType: 'html',
                                                        success: function(html) {
                                                            $('#payment-method .checkout-content').html(html);
						
                                                            $('#shipping-method .checkout-content').slideUp('slow');
						
                                                            $('#payment-method .checkout-content').slideDown('slow');

                                                            $('#shipping-method .checkout-heading a').remove();
                                                            $('#payment-method .checkout-heading a').remove();
						
                                                            $('#shipping-method .checkout-heading').append('<a><?php echo $text_modify; ?></a>');

                                                        },
                                                        error: function(xhr, ajaxOptions, thrownError) {
                                                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                                        }
                                                    });					
                                                }
                                            },
                                            error: function(xhr, ajaxOptions, thrownError) {
                                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                            }
                                        });	
                                    });

                                    $('#button-payment-method').live('click', function() {
                                        $.ajax({
                                            url: 'index.php?route=checkout/payment_method/validate', 
                                            type: 'post',
                                            data: $('#payment-method input[type=\'radio\']:checked, #payment-method input[type=\'checkbox\']:checked, #payment-method textarea'),
                                            dataType: 'json',
                                            beforeSend: function() {
                                                $('#payment-method div.buttons').show();
                                                $('#button-payment-method').attr('disabled', true);
                                                $('#button-payment-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                                                $('#confirm .checkout-content').html('');
                                            },	
                                            complete: function() {
                                                //                                                $('.checkout-heading').removeClass('active');
                                                //                                                $('#headConfirm').addClass('active');
                                                $('#button-payment-method').attr('disabled', false);
                                                $('.wait').remove();
                                            },			
                                            success: function(json) {
                                                $('.warning, .error').remove();
			
                                                if (json['redirect']) {
                                                    location = json['redirect'];
                                                } else if (json['error']) {
                                                    if (json['error']['warning']) {
                                                        $('#payment-method .checkout-product').after('<div class="warning" style="display: none;margin-bottom: 15px;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
                                                        $('.warning').fadeIn('slow');
                                                    }			
                                                } else {
                                                    $.ajax({
                                                        url: 'index.php?route=checkout/confirm',
                                                        dataType: 'html',
                                                        success: function(html) {
                                                            $('#payment-method div.buttons').hide();
                                                            $('#confirm .checkout-content').html(html).show();
						
                                                            //                                                            $('#payment-method .checkout-content').slideUp('slow');
                                                            //						
                                                            //						
                                                            //                                                            $('#payment-method .checkout-heading a').remove();
                                                            //						
                                                            //                                                            $('#payment-method .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
                                                        },
                                                        error: function(xhr, ajaxOptions, thrownError) {
                                                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                                        }
                                                    });			
                                                }
                                            },
                                            error: function(xhr, ajaxOptions, thrownError) {
                                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                            }
                                        });	
                                    });
                                    
                                    $('input[name="payment_method"]').live('change', function () {
                                        $('#button-payment-method').trigger('click');
                                    });
                                    
                                    
                                    $('input[name="agree"]').live('change', function () {
                                        $('#button-payment-method').trigger('click');
                                    });
                                    //--></script> 
<script type='text/javascript' src='https://platform.cloud-iq.com/cartrecovery/store.js?app_id=17262'></script>
<?php echo $footer; ?>