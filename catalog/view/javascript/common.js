(function( $ ){
    $.fn.postcodeAnywhere = function() {
        if ($(this).find('.paLookup').length)
        {
            if (!$(this).find('.paAddress input[name=address_1]').val() && !$(this).find('.paAddress input[name=postcode]').val())
            {
                $(this).find('.paLookup').show();
                $(this).find('.paAddress').hide();
            }
            $(this).find('.paAddress button[name=lookup]').show();
        }
        
        
        if ($(this).hasClass('paNoHide'))
        {
            $(this).find('.paLookup').show();
        }
    
        $(this).on('click','button[name=lookup], input[name=lookup]', function (event) {
            event.preventDefault();
            var paContainer = $(this).parents('.postcodeAnywhereContainer');
            
            paContainer.find('.error').remove();
            
            if ($(this).parents('.paAddress').length)
            {
                paContainer.find('input[name=postcode_lookup]').val(paContainer.find('input[name=postcode]').val());
                paContainer.find('select[name=postcode_lookup_country_id]').val(paContainer.find('select[name=country_id]').val());
                paContainer.find('.paAddress input').val('').trigger('change');
                paContainer.find('input[name=postcode]').val(paContainer.find('input[name=postcode_lookup]').val());
            } else {
                paContainer.find('input[name=\'postcode\']').val(paContainer.find('input[name=postcode_lookup]').val());
                paContainer.find('select[name=\'country_id\']').val(paContainer.find('select[name=postcode_lookup_country_id]').val()).trigger('change');
                paContainer.find('input[name=\'company\']').val();
                paContainer.find('input[name=\'address_1\']').val();
                paContainer.find('input[name=\'address_2\']').val();
                paContainer.find('input[name=\'city\']').val();
                paContainer.find('select[name=\'zone_id\']').val();
            }
            
            paContainer.find('.paLookup').show();
            paContainer.find('.paSelect').hide();
            paContainer.find('.paAddress').hide();
            paContainer.find('select[name=\'address_dropdown\'] option').remove();
            
            $.ajax({
                url: 'index.php?route=module/postcode_anywhere/postcode&country_id=' + paContainer.find('select[name=postcode_lookup_country_id]').val() + '&postcode=' + encodeURIComponent(paContainer.find('input[name=postcode_lookup]').val()),
                dataType: 'json',
                beforeSend: function() {
                    $(this).after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                },
                complete: function() {
                    $('.wait').remove();
                },			
                success: function(json) {
                    html = '';
                        
                    if (json['error'])
                    {
                        if (json['fail'])
                        {
                            
                            if (!paContainer.hasClass('paNoHide'))
                            {
                                paContainer.find('.paLookup').hide();
                            }
                            paContainer.find('.paSelect').hide();
                            paContainer.find('.paAddress').show();
                            paContainer.find('.paAddress').prepend('<span class="error">' + json['error'] + '</span>');
                        } else {
                            paContainer.find('.paLookup').prepend('<span class="error">' + json['error'] + '</span>');
                        }
                    } else {
                        paSelect = paContainer.find('select[name=\'address_dropdown\']');
                        for (i = 0; i < json['addresses'].length; i++) {
                            var option = $('<option/>');
                            option.attr({
                                'value': json['addresses'][i]['value']
                            }).text(json['addresses'][i]['text']);
                            paSelect.append(option);
                        }
                        selectSize = (paSelect.find('option').length > 9) ? 10 : paSelect.find('option').length;
                        paSelect.attr('size', selectSize);
                        paContainer.find('.paSelect').show();
                    }
                        
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        });
    
        $(this).on('click','button[name=address_select], input[name=address_select]', function (event) {
            event.preventDefault();
            var paContainer = $(this).parents('.postcodeAnywhereContainer');
            
            paContainer.find('.error').remove();
            
            $.ajax({
                url: 'index.php?route=module/postcode_anywhere/address&country_id=' + paContainer.find('select[name=postcode_lookup_country_id]').val() + '&address=' + encodeURIComponent(paContainer.find('select[name=address_dropdown]').val()),
                dataType: 'json',
                beforeSend: function() {
                    $(this).after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                },
                complete: function() {
                    $('.wait').remove();
                },			
                success: function(json) {
                    if (json['error'])
                    {
                        if (json['fail'])
                        {
                            
                            if (!paContainer.hasClass('paNoHide'))
                            {
                                paContainer.find('.paLookup').hide();
                            }
                            paContainer.find('.paSelect').hide();
                            paContainer.find('.paAddress').show();
                            paContainer.find('.paAddress').prepend('<span class="error">' + json['error'] + '</span>');
                        } else {
                            paContainer.find('.paLookup').show();
                            paContainer.find('.paSelect').hide();
                            paContainer.find('.paAddress').hide();
                            paContainer.find('.paLookup').prepend('<span class="error">' + json['error'] + '</span>');
                        }
                    } else {
                        paContainer.find('input[name=\'company\']').val(json['address']['company']);
                        paContainer.find('input[name=\'address_1\']').val(json['address']['address_1']);
                        paContainer.find('input[name=\'address_2\']').val(json['address']['address_2']);
                        paContainer.find('input[name=\'postcode\']').val(json['address']['postcode']);
                        paContainer.find('input[name=\'city\']').val(json['address']['city']);
                        paContainer.find('select[name=\'country_id\']').val(json['address']['country_id']);
                        paContainer.find('select[name=\'zone_id\']').val(json['address']['zone_id']);
                        
                        if (!paContainer.hasClass('paNoHide'))
                        {
                            paContainer.find('.paLookup').hide();
                            paContainer.find('.paSelect').hide();
                        }
                        paContainer.find('.paAddress').show();
                    }
                        
                },
                error: function(xhr, ajaxOptions, thrownError) {
                //alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        });
        
        $(this).on('click','.manualAddress', function (event) {
            event.preventDefault();
            var paContainer = $(this).parents('.postcodeAnywhereContainer');
            
            paContainer.find('.error').remove();
            
            if (!paContainer.hasClass('paNoHide'))
            {
                paContainer.find('.paLookup').hide();
            }
            paContainer.find('.paSelect').hide();
            paContainer.find('.paAddress').show();
        });
    }; 
})( jQuery );

$(document).ready(function() {
    
    /* Search */
    $('.button-search').bind('click', function() {
        url = $('base').attr('href') + 'index.php?route=product/search';
				 
        var filter_name = $('input[name=\'filter_name\']').attr('value');
		
        if (filter_name) {
            url += '&filter_name=' + encodeURIComponent(filter_name);
        }
		
        location = url;
    });
	
    $('#header input[name=\'filter_name\']').bind('keydown', function(e) {
        if (e.keyCode == 13) {
            url = $('base').attr('href') + 'index.php?route=product/search';
			 
            var filter_name = $('input[name=\'filter_name\']').attr('value');
			
            if (filter_name) {
                url += '&filter_name=' + encodeURIComponent(filter_name);
            }
			
            location = url;
        }
    });
    
    $('.button-form-search').bind('click', function() {
        url = $('base').attr('href') + 'index.php?route=product/search';
				 
        var filter_name = $('input[name=\'filter_name\']').attr('value');
        var filter_sub_category = $('input[name=\'filter_sub_category\']').attr('value');
        var filter_description = $('input[name=\'filter_description\']').attr('value');
		
        if (filter_name) {
            url += '&filter_name=' + encodeURIComponent(filter_name);
            url += '&filter_sub_category=' + encodeURIComponent(filter_sub_category);
            url += '&filter_description=' + encodeURIComponent(filter_description);
        }
		
        location = url;
    });
    
    $('#header .wrap-form input[name=\'filter_name\']').bind('keydown', function(e) {
        if (e.keyCode == 13) {
            url = $('base').attr('href') + 'index.php?route=product/search';
			 
            var filter_name = $('input[name=\'filter_name\']').attr('value');
            var filter_sub_category = $('input[name=\'filter_sub_category\']').attr('value');
            var filter_description = $('input[name=\'filter_description\']').attr('value');
			
            if (filter_name) {
                url += '&filter_name=' + encodeURIComponent(filter_name);
                url += '&filter_sub_category=' + encodeURIComponent(filter_sub_category);
                url += '&filter_description=' + encodeURIComponent(filter_description);
            }
			
            location = url;
        }
    });
        
    $('form.newsletter-form').submit(function() {
        $('.success, .warning, .attention, .information, .error').remove();
        
        $.ajax({
            url: 'index.php?ajax=1',
            type: 'get',
            data: $(this).serialize(),
            dataType: 'json',
            success: function(json) {

                if (json['redirect']) {
                    location = json['redirect'];
                }

                if (json['success']) {
                    $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                    $('.success').fadeIn('slow');

                    $('html, body').animate({
                        scrollTop: 0
                    }, 'slow'); 
                }	
                
                if (json['error']) {
                    $('#notification').html('<div class="warning" style="display: none;">' + json['error'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                    $('.warning').fadeIn('slow');

                    $('html, body').animate({
                        scrollTop: 0
                    }, 'slow'); 
                }
            }
        });
        return false;
    });
    
    $('form.newsletter-form .submit, form.newsletter-form .action').click(function () {
        $(this).parents('form').trigger('submit');
        return false;
    });
    
    /* Ajax Cart */
    $('#header').on({mouseenter: function() {
            if ($(this).hasClass('mouseover'))
            {
                openCart();
            }
        },mouseleave:  function() {
            closeCart();
        }
    }, '#cart');
    
    $('#header').on('click', '#cart .heading a', function(event) {
        event.preventDefault();
        openCart(false, true);
    });
	
    /* Mega Menu */
    $('#menu ul > li > a + div').each(function(index, element) {
        // IE6 & IE7 Fixes
        if ($.browser.msie && ($.browser.version == 7 || $.browser.version == 6)) {
            var category = $(element).find('a');
            var columns = $(element).find('ul').length;
			
            $(element).css('width', (columns * 143) + 'px');
            $(element).find('ul').css('float', 'left');
        }		
		
        var menu = $('#menu').offset();
        var dropdown = $(this).parent().offset();
		
        i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());
		
        if (i > 0) {
            $(this).css('margin-left', '-' + (i + 5) + 'px');
        }
    });

    // IE6 & IE7 Fixes
    if ($.browser.msie) {
        if ($.browser.version <= 6) {
            $('#column-left + #column-right + #content, #column-left + #content').css('margin-left', '195px');
			
            $('#column-right + #content').css('margin-right', '195px');
		
            $('.box-category ul li a.active + ul').css('display', 'block');	
        }
		
        if ($.browser.version <= 7) {
            $('#menu > ul > li').bind('mouseover', function() {
                $(this).addClass('active');
            });
				
            $('#menu > ul > li').bind('mouseout', function() {
                $(this).removeClass('active');
            });	
        }
    }
	
    $('.success img, .warning img, .attention img, .information img').live('click', function() {
        $(this).parent().fadeOut('slow', function() {
            $(this).remove();
        });
    });	
});

function getURLVar(urlVarName) {
    var urlHalves = String(document.location).toLowerCase().split('?');
    var urlVarValue = '';
	
    if (urlHalves[1]) {
        var urlVars = urlHalves[1].split('&');

        for (var i = 0; i <= (urlVars.length); i++) {
            if (urlVars[i]) {
                var urlVarPair = urlVars[i].split('=');
				
                if (urlVarPair[0] && urlVarPair[0] == urlVarName.toLowerCase()) {
                    urlVarValue = urlVarPair[1];
                }
            }
        }
    }
	
    return urlVarValue;
} 

cartTimeout = null;
function openCart(delay, update) {
    clearTimeout(cartTimeout);
    if (typeof update != 'undefined' && update)
    {
        $("html, body").animate({ scrollTop: 0 }, 600);
        $('#cart').load('index.php?route=module/cart #cart');
    }
    $('#cart').addClass("active");
    if (typeof delay != 'undefined' && delay)
    {
        cartTimeout = setTimeout('closeCart()', delay);
    }
} 

function closeCart() {
    $('#cart').removeClass("active");
}

function addToCart(product_id, quantity) {
    quantity = typeof(quantity) != 'undefined' ? quantity : 1;

    $.ajax({
        url: 'index.php?route=checkout/cart/add',
        type: 'post',
        data: 'product_id=' + product_id + '&quantity=' + quantity,
        dataType: 'json',
        success: function(json) {
            $('.success, .warning, .attention, .information, .error').remove();
			
            if (json['redirect']) {
                location = json['redirect'];
            }
			
            if (json['success']) {
                $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
                $('.success').fadeIn('slow');
				
                $('#cart-total').html(json['total']);
				
                $('html, body').animate({
                    scrollTop: 0
                }, 'slow'); 
            }	
        }
    });
}
function addToWishList(product_id) {
    $.ajax({
        url: 'index.php?route=account/wishlist/add',
        type: 'post',
        data: 'product_id=' + product_id,
        dataType: 'json',
        success: function(json) {
            $('.success, .warning, .attention, .information').remove();
						
            if (json['success']) {
                $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
                $('.success').fadeIn('slow');
				
                $('#wishlist-total').html(json['total']);
				
                $('html, body').animate({
                    scrollTop: 0
                }, 'slow');
            }	
        }
    });
}

function addToCompare(product_id) { 
    $.ajax({
        url: 'index.php?route=product/compare/add',
        type: 'post',
        data: 'product_id=' + product_id,
        dataType: 'json',
        success: function(json) {
            $('.success, .warning, .attention, .information').remove();
						
            if (json['success']) {
                $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
                $('.success').fadeIn('slow');
				
                $('#compare-total').html(json['total']);
				
                $('html, body').animate({
                    scrollTop: 0
                }, 'slow'); 
            }	
        }
    });
}