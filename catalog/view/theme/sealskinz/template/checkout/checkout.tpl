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
    <?php }
    if (isset($error_warning) && $error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php }
    ?>
</div>
<?php
$count = 1;
?>
<div id="mainContainer" class="container"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content">
        <?php echo $content_top; ?>
        <h1><?php echo $heading_title; ?></h1>
        <div class="checkout">
            <?php if (!$logged) { ?>
                <div id="checkout">
                    <div class="checkout-heading"><?php echo sprintf($text_checkout_option, $count++); ?></div>
                    <div class="checkout-content"></div>
                </div>
                <div id="payment-address">
                    <div class="checkout-heading"><span><?php echo sprintf($text_checkout_account, $count++); ?></span></div>
                    <div class="checkout-content"></div>
                </div>
            <?php } else { ?>
                <?php if ($shipping_required) { ?>
                    <div id="shipping-address">
                        <div class="checkout-heading"><span><?php echo sprintf($text_checkout_shipping_address, $count++); ?></span></div>
                        <div class="checkout-content"></div>
                        <div id="shipping-method" class="checkout-content"></div>
                    </div>
                <?php } ?>
                <div id="payment-address">
                    <div class="checkout-heading"><span><?php echo sprintf($text_checkout_payment_address, $count++); ?></span></div>
                    <div class="checkout-content"></div>
                    <div id="payment-method" class="checkout-content" style="padding-bottom: 0"></div>
                </div>
                <div id="confirm">
                    <div class="checkout-heading"><?php echo sprintf($text_checkout_confirm, $count++); ?></div>
                    <div class="checkout-content"></div>
                </div>
            <?php } ?>
        </div>



        <?php echo $content_bottom; ?>    
    </div></div>
<script type="text/javascript"><!--
    
    $('.pselect').live('change', function () {
        $(this).parents('.postcodeAnywhereContainer').find('button[name=address_select]').trigger('click');
    });

    $('.checkout-heading a').live('click', function() {
        
        $('.checkout .checkout-heading').removeClass('active');
        
        $('.checkout-content').slideUp('slow');
	
        $(this).parent().parent().find('.checkout-heading').addClass('active');
        
        $(this).parent().parent().find('.checkout-content').slideDown('slow');
    });
    
<?php if (!$logged) { ?> 
        $(document).ready(function() {
            $.ajax({
                url: 'index.php?route=checkout/login',
                dataType: 'html',
                success: function(html) {
                    $('#checkout .checkout-content').html(html);
                    $('#checkout .checkout-heading').addClass('active');
                    $('#checkout .checkout-content').slideDown('slow');
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });	
        });		
<?php } else { ?>
    <?php if ($shipping_required) { ?>
        $(document).ready(function() {
                $.ajax({
                    url: 'index.php?route=checkout/shipping_address',
                    dataType: 'html',
                    success: function(html) {
                                $('#shipping-address .checkout-content:first').html(html);
                                $('.checkout-heading').removeClass('active');
                                $('#shipping-address .checkout-heading').addClass('active');
                                $('#shipping-address .checkout-content:first').slideDown('slow');
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                });	
                $.ajax({
                    url: 'index.php?route=checkout/shipping_method',
                    dataType: 'html',
                    success: function(html) {
                                $('#shipping-method.checkout-content').html(html);
                                $('#shipping-method.checkout-content').slideDown('slow');
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                });	
        });
    <?php } else { ?>
        $(document).ready(function() {
                $.ajax({
                    url: 'index.php?route=checkout/payment_address',
                    dataType: 'html',
                    success: function(html) {
                                $('#payment-address .checkout-content:first').html(html);
                                $('.checkout-heading').removeClass('active');
                                $('#payment-address .checkout-heading').addClass('active');
                                $('#payment-address .checkout-content:first').slideDown('slow');
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                });	
                $.ajax({
                    url: 'index.php?route=checkout/payment_method',
                    dataType: 'html',
                    success: function(html) {
                                $('#payment-method.checkout-content').html(html);
                                $('#payment-method.checkout-content').slideDown('slow');
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                });	
        });
    <?php } ?>
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
			
                $('#payment-address .checkout-content:first').html(html);
                                                                
                $('#checkout .checkout-heading').removeClass('active');
                $('#checkout .checkout-content').slideUp('slow');
    						
                $('#payment-address .checkout-heading').addClass('active');
                $('#payment-address .checkout-content:first').slideDown('slow');
    						
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

//--></script>



<script type="text/javascript"><!--
// Shipping Address			
$('#button-shipping-address').live('click', function() {

    $.ajax({
        url: 'index.php?route=checkout/shipping_address/validate',
        type: 'post',
        data: $('#shippingPostcodeAnywhere input[type=\'text\'], #shippingPostcodeAnywhere input[type=\'password\'], #shippingPostcodeAnywhere input[type=\'checkbox\']:checked, #shippingPostcodeAnywhere input[type=\'radio\']:checked, #shippingPostcodeAnywhere input[type=\'hidden\'], #shippingPostcodeAnywhere select'),
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
            
                if (json['error']['zone']) {
                    $('#shipping-address select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#shipping-address select[name=\'zone_id\']").offset().top
                    }, 2000);
                }

                if (json['error']['country']) {
                    $('#shipping-address select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#shipping-address select[name=\'country_id\']").offset().top
                    }, 2000);
                }	

                if (json['error']['postcode']) {
                    $('#shipping-address input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#shipping-address input[name=\'postcode\']").offset().top
                    }, 2000);
                }	

                if (json['error']['city']) {
                    $('#shipping-address input[name=\'city\']').after('<span class="error">' + json['error']['city'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#shipping-address input[name=\'city\']").offset().top
                    }, 2000);
                }	

                if (json['error']['address_1']) {
                    $('#shipping-address input[name=\'address_1\']').after('<span class="error">' + json['error']['address_1'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#shipping-address input[name=\'address_1\']").offset().top
                    }, 2000);
                }	

                if (json['error']['tax_id']) {
                    $('#shipping-address input[name=\'tax_id\']').after('<span class="error">' + json['error']['tax_id'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#shipping-address input[name=\'tax_id\']").offset().top
                    }, 2000);
                }	

                if (json['error']['company_id']) {
                    $('#shipping-address input[name=\'company_id\']').after('<span class="error">' + json['error']['company_id'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#shipping-address input[name=\'company_id\']").offset().top
                    }, 2000);
                }	

                if (json['error']['telephone']) {
                    $('#shipping-address input[name=\'telephone\']').after('<span class="error">' + json['error']['telephone'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#shipping-address input[name=\'telephone\']").offset().top
                    }, 2000);
                }		

                if (json['error']['lastname']) {
                    $('#shipping-address input[name=\'lastname\']').after('<span class="error">' + json['error']['lastname'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#shipping-address input[name=\'lastname\']").offset().top
                    }, 2000);
                }	

                if (json['error']['firstname']) {
                    $('#shipping-address input[name=\'firstname\']').after('<span class="error">' + json['error']['firstname'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#shipping-address input[name=\'firstname\']").offset().top
                    }, 2000);
                }
                
                if (json['error']['warning']) {
                    $('#shipping-address .checkout-content:first').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                    $('.warning').fadeIn('slow');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#shipping-address .checkout-content:first").offset().top
                    }, 2000);
                }
                
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/shipping_method',
                    dataType: 'html',
                    success: function(html) {
                        $('#shipping-method.checkout-content').html(html);

                        $('#shipping-method.checkout-content').slideDown('slow');

                        $.ajax({
                            url: 'index.php?route=checkout/shipping_address',
                            dataType: 'html',
                            success: function(html) {
                                $('#shipping-address .checkout-content:first').html(html);
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
            }  
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });	
});

//--></script>

<script type="text/javascript"><!--
    // Shipping Method
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
                    $('#shipping-method .checkout-content:first').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                    $('.warning').fadeIn('slow');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#shipping-method .checkout-content:first").offset().top
                    }, 2000);
                }
                
            } else {
            
                $.ajax({
                    url: 'index.php?route=checkout/payment_address',
                    dataType: 'html',
                    success: function(html) {
                        $('#payment-address .checkout-content:first').html(html);

                        $('#shipping-address .checkout-heading').removeClass('active');
                        $('#shipping-address .checkout-content').slideUp('slow');
                        $('#shipping-address .checkout-heading a').remove();							
                        $('#shipping-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');							

                        $('#payment-address .checkout-heading').addClass('active');
                        $('#payment-address .checkout-content:first').slideDown('slow');
                        container = $('#content');
                        container.animate({
                            scrollTop: $("#payment-address").offset().top - container.offset().top + container.scrollTop()
                            }, 2000);

                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
                $.ajax({
                    url: 'index.php?route=checkout/payment_method',
                    dataType: 'html',
                    success: function(html) {
                                $('#payment-method.checkout-content').html(html);
                                $('#payment-method.checkout-content').slideDown('slow');
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
//--></script>

<script type="text/javascript"><!--
// Payment Address	
$('#button-payment-address').live('click', function() {
    $.ajax({
        url: 'index.php?route=checkout/payment_address/validate',
        type: 'post',
        data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'password\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address input[type=\'hidden\'], #payment-address select'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-payment-address').attr('disabled', true);
            $('#button-payment-address').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
        },	
        complete: function() {
            $('#button-payment-address').attr('disabled', false);
            $('.wait').remove();
        },			
        success: function(json) {
            $('.warning, .error').remove();

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
            
                if (json['error']['zone']) {
                    $('#payment-address select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#payment-address select[name=\'zone_id\']").offset().top
                    }, 2000);
                }

                if (json['error']['country']) {
                    $('#payment-address select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#payment-address select[name=\'country_id\']").offset().top
                    }, 2000);
                }	

                if (json['error']['postcode']) {
                    $('#payment-address input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#payment-address input[name=\'postcode\']").offset().top
                    }, 2000);
                }	

                if (json['error']['city']) {
                    $('#payment-address input[name=\'city\']').after('<span class="error">' + json['error']['city'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#payment-address input[name=\'city\']").offset().top
                    }, 2000);
                }	

                if (json['error']['address_1']) {
                    $('#payment-address input[name=\'address_1\']').after('<span class="error">' + json['error']['address_1'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#payment-address input[name=\'address_1\']").offset().top
                    }, 2000);
                }	

                if (json['error']['tax_id']) {
                    $('#payment-address input[name=\'tax_id\']').after('<span class="error">' + json['error']['tax_id'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#payment-address input[name=\'tax_id\']").offset().top
                    }, 2000);
                }	

                if (json['error']['company_id']) {
                    $('#payment-address input[name=\'company_id\']').after('<span class="error">' + json['error']['company_id'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#payment-address input[name=\'company_id\']").offset().top
                    }, 2000);
                }	

                if (json['error']['telephone']) {
                    $('#payment-address input[name=\'telephone\']').after('<span class="error">' + json['error']['telephone'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#payment-address input[name=\'telephone\']").offset().top
                    }, 2000);
                }		

                if (json['error']['lastname']) {
                    $('#payment-address input[name=\'lastname\']').after('<span class="error">' + json['error']['lastname'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#payment-address input[name=\'lastname\']").offset().top
                    }, 2000);
                }	

                if (json['error']['firstname']) {
                    $('#payment-address input[name=\'firstname\']').after('<span class="error">' + json['error']['firstname'] + '</span>');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#payment-address input[name=\'firstname\']").offset().top
                    }, 2000);
                }
                
                if (json['error']['warning']) {
                    $('#payment-address .checkout-content:first').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                    $('.warning').fadeIn('slow');
                    $('html, body').stop(true, true).animate({
                        scrollTop: $("#payment-address .checkout-content:first").offset().top
                    }, 2000);
                }
                
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/payment_method',
                    dataType: 'html',
                    success: function(html) {
                        $('#payment-method.checkout-content').html(html);

                        $('#payment-method.checkout-content').slideDown('slow');

                        $.ajax({
                            url: 'index.php?route=checkout/payment_address',
                            dataType: 'html',
                            success: function(html) {
                                $('#payment-address .checkout-content:first').html(html);
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
            }	  
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });	
});
//--></script>

<script type="text/javascript"><!--
// Payment Method
$('#button-payment-method').live('click', function() {
    $.ajax({
        url: 'index.php?route=checkout/payment_method/validate', 
        type: 'post',
        data: $('#payment-method input[type=\'radio\']:checked, #payment-method input[type=\'checkbox\']:checked, #payment-method textarea'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-payment-method').attr('disabled', true);
            $('#button-payment-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
        },	
        complete: function() {
            $('#button-payment-method').attr('disabled', false);
            $('.wait').remove();
        },			
        success: function(json) {
            $('.warning, .error').remove();

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#payment-method.checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                    $('.warning').fadeIn('slow');
                }			
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/confirm',
                    dataType: 'html',
                    success: function(html) {
                        $('#confirm .checkout-content').html(html);

                        $('#payment-address .checkout-heading').removeClass('active');
                        $('#payment-address .checkout-content').slideUp('slow');
                        $('#payment-address .checkout-heading a').remove();							
                        $('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');							

                        $('#confirm .checkout-heading').addClass('active');
                        $('#confirm .checkout-content').slideDown('slow');
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
//--></script> 

<script type='text/javascript' src='https://platform.cloud-iq.com/cartrecovery/store.js?app_id=17262'></script>
<?php echo $footer; ?>