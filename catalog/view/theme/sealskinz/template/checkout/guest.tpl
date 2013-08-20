
    <div class="left" style="border-right: none;">
        
            <h2><?php echo $text_your_details; ?></h2>
        <div id="guestAccount">
            <div class="prow">
                <div class="pLabel">
                    <span class="required">*</span> <?php echo $entry_firstname; ?>
                </div>
                <div class="pInput">
                    <input type="text" name="firstname" value="<?php echo $firstname; ?>" class="large-field" />
                </div>
            </div>
            <div class="prow">
                <div class="pLabel">
                    <span class="required">*</span> <?php echo $entry_lastname; ?>
                </div>
                <div class="pInput">
                    <input type="text" name="lastname" value="<?php echo $lastname; ?>" class="large-field" />
                </div>
            </div>
            <div class="prow">
                <div class="pLabel">
                    <span class="required">*</span> <?php echo $entry_email; ?>
                </div>
                <div class="pInput">
                    <input type="text" name="email" value="<?php echo $email; ?>" class="large-field" />
                </div>
            </div>
            <div class="prow">
                <div class="pLabel">
                    <span class="required">*</span> <?php echo $entry_telephone; ?>
                </div>
                <div class="pInput">
                    <input type="text" name="telephone" value="<?php echo $telephone; ?>" class="large-field" />
                </div>
            </div>
            <div class="prow" style="display: <?php echo (count($customer_groups) > 1 ? 'table-row' : 'none'); ?>;"> <?php echo $entry_customer_group; ?>
                <div class="prow">
                    <?php foreach ($customer_groups as $customer_group) { ?>
                        <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
                            <div class="pLabel">  
                                <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                            </div>
                            <div class="pInput">
                                <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
                            </div>
                        <?php } else { ?>
                            <div class="pLabel">
                                <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
                            </div>
                            <div class="pInput">  
                                <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
                            </div>
                        <?php } ?>
                    <?php } ?>
                </div>

            </div>
            <input type="hidden" name="fax" value="<?php echo $fax; ?>" />
        </div>
    </div>
<div style="clear: both; padding-top: 15px;">
    <h2><?php echo $text_your_address ?></h2>
    <div id="paymentPostcodeAnywhere" class="postcodeAnywhereContainer paCheckout">
        <?php if ($addresses) { ?>
            <?php $continueEnabled = ($address_id != 0); ?>
            <div><input type="hidden" id="payment_address" name="payment_address" value="existing" /><input type="hidden" id="address_id" name="address_id" value="<?php echo $address_id; ?>" /></div>
            <div id="payment-existing">
                <?php foreach ($addresses as $address) { ?>
                    <?php if ($address_id == $address['address_id']) { ?>
                    <div id="<?php echo $address['address_id']; ?>" style="display: inline-block;">
                        <?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?><br/>
                        <?php echo $address['address_1']; ?><br/>
                        <?php echo $address['city']; ?><br/>
                        <?php echo $address['zone']; ?><br/>
                        <?php echo $address['country']; ?><br/><br/>
                    </div>
                    <?php } ?>
                <?php } ?>
            </div>
            <br/><input type="button" class="button paymentAddressNew" value="<?php echo $text_address_new; ?>" />
        <?php } else { ?>
            <div><input type="hidden" id="payment_address" name="payment_address" value="new" /><input type="hidden" id="address_id" name="address_id" value="0" /></div>
        <?php } ?>
        <div id="payment-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
            <?php if ($addresses) { ?>
                <div class="right">
                    <p><?php echo $text_your_addresses; ?></p>
                    <div style="clear: both;">
                    <?php foreach ($addresses as $address) { ?>
                        <div id="<?php echo $address['address_id']; ?>" style="display: inline-block">
                            <?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?><br/>
                            <?php echo $address['address_1']; ?><br/>
                            <?php echo $address['city']; ?><br/>
                            <?php echo $address['zone']; ?><br/>
                            <?php echo $address['country']; ?><br/><br/>
                            <input type="button" class="button paymentAddressSelect" value="<?php echo $text_select_continue; ?>" />
                        </div>
                    <?php } ?>
                    </div>
                </div>
            <?php } ?>
            <div class="left">
                <?php
                if ($use_postcode_anywhere) {
                    ?>
                    <div class="paLookup content">
                        <div class="prow">
                            <div class="pLabel"><span class="paLookup_required required">*</span> <?php echo $entry_search_address; ?></div>
                            <div class="pInput"><select name="postcode_lookup_country_id">
                                    <?php foreach ($countries as $country) { ?>
                                        <?php if ($country['country_id'] == $postcode_lookup_country_id) { ?>
                                            <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select><br />

                                <input class="span2" name="postcode_lookup" type="text" value="<?php echo $postcode_lookup; ?>">
                                <input class="button" name="lookup" type="button" value="<?php echo $button_find_address; ?>" >
                                <?php if ($error_postcode_lookup) { ?>
                                    <span class="error"><?php echo $error_postcode_lookup; ?></span>
                                <?php } ?>
                                <br><a href="#" class="manualAddress"><?php echo $text_enter_manually; ?></a>
                            </div>
                        </div>
                    </div>
                    <div class="paSelect content">
                        <div class="payform-right">
                            <div class="pInput"><span class="paSelect_required required">*</span> <?php echo $entry_select_address; ?><br/>
                                <select name="address_dropdown"<?php if ($paAddresses) echo ' size="' . (count($paAddresses) > 9 ? 10 : count($paAddresses)) . '"'; ?> class="pselect">
                                    <?php
                                    if ($paAddresses) {
                                        foreach ($paAddresses as $address_info) {
                                            echo "<option value='" . $address_info['value'] . "'";
                                            if ($address_dropdown == $address_info['value'])
                                                echo ' selected="selected"';
                                            echo '>' . $address_info['text'] . '</option>';
                                        }
                                    }
                                    ?>
                                </select><br />
                                <button class="btn" name="address_select" type="button"><?php echo $button_select_address; ?></button>
                            </div>
                        </div>
                    </div>
                    <?php
                }
                ?>

            </div>

            <div class="left">


                <div class="paAddress content">
                <?php if ($use_postcode_anywhere) { ?>
                    <div class="prow">
                        <a href="#" class="searchAddress"><?php echo $text_search_address; ?></a>
                    </div>
                <?php } ?>
                    <div class="prow" id="paCompany">
                        <div class="pLabel" >
                            <?php echo $entry_company; ?>
                        </div>
                        <div class="pInput">
                            <input type="text" name="company" value="" class="large-field" />
                        </div>
                    </div>
                    <?php if ($company_id_display) { ?>
                        <div class="prow" id="paCompanyId">
                            <div class="pLabel">
                                <?php if ($company_id_required) { ?>
                                    <span class="required">*</span>
                                <?php } ?>
                                <?php echo $entry_company_id; ?>
                                <td></td>
                            </div>
                            <div class="pInput">
                                <input type="text" name="company_id" value="" class="large-field" />
                            </div>
                        </div>
                    <?php } ?>
                    <?php if ($tax_id_display) { ?>
                        <div class="prow">
                            <div class="pLabel">
                                <?php if ($tax_id_required) { ?>
                                    <span class="required">*</span>
                                <?php } ?>
                                <?php echo $entry_tax_id; ?>
                            </div>
                            <div class="pInput">
                                <input type="text" name="tax_id" value="" class="large-field" />
                            </div>
                        </div>
                    <?php } ?>
                    <div class="prow">
                        <div class="pLabel">
                            <span class="required">*</span> <?php echo $entry_address_1; ?>
                        </div>
                        <div class="pInput">
                            <input type="text" name="address_1" value="" class="large-field" />
                        </div>
                    </div>
                    <div class="prow">
                        <div class="pLabel">
                            <?php echo $entry_address_2; ?>
                        </div>
                        <div class="pInput">
                            <input type="text" name="address_2" value="" class="large-field" />
                        </div>
                    </div>
                    <div class="prow">
                        <div class="pLabel">
                            <span class="required">*</span> <?php echo $entry_city; ?>
                        </div>
                        <div class="pInput">
                            <input type="text" name="city" value="" class="large-field" />
                        </div>
                    </div>
                    <div class="prow">
                        <div class="pLabel">
                            <span id="payment-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?>
                        </div>
                        <div class="pInput">
                            <input type="text" name="postcode" value="" class="large-field" />
                        </div>
                    </div>
                    <div class="prow">
                        <div class="pLabel">
                            <span class="required">*</span> <?php echo $entry_country; ?>
                        </div>
                        <div class="pInput">
                            <select name="country_id" class="large-field">
                                <option value=""><?php echo $text_select; ?></option>
                                <?php foreach ($countries as $country) { ?>
                                    <?php if ($country['country_id'] == $country_id) { ?>
                                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="prow">
                        <div class="pLabel">
                            <span class="required">*</span> <?php echo $entry_zone; ?>
                        </div>
                        <div class="pInput">
                            <select name="zone_id" class="large-field">
                            </select>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript"><!--
    $('#guestAccount input, .paAddress input, #registerPassword input').on('keyup', function () {
        var txtInput = $('#guestAccount input[name=firstname]').val()+":"+
            $('#guestAccount input[name=lastname]').val()+":"+
            $('#guestAccount input[name=email]').val()+":"+
            $('#guestAccount input[name=telephone]').val()+":"+
            $('.paAddress input[name=address_1]').val()+":"+
            $('.paAddress input[name=city]').val()+":"+
            $('.paAddress input[name=postcode]').val()+":"+
            $('.paAddress select[name=country_id]').val()+":"+
            $('.paAddress select[name=zone_id]').val()+":";
        console.log(txtInput);
    
        if ($('#guestAccount input[name=firstname]').val() &&
            $('#guestAccount input[name=lastname]').val() &&
            $('#guestAccount input[name=email]').val() &&
            $('#guestAccount input[name=telephone]').val() &&
            $('.paAddress input[name=address_1]').val() &&
            $('.paAddress input[name=city]').val() &&
            $('.paAddress input[name=postcode]').val() &&
            $('.paAddress select[name=\'country_id\']').val() &&
            $('.paAddress select[name=\'zone_id\']').val()
            )
        {
            $('#button-guest').attr('disabled', false);
        } else {
            $('#button-guest').attr('disabled', 'disabled');
        }
    });
    
    $('#guestAccount input[name=firstname]').trigger('keyup');
    
//--></script>

<script type="text/javascript"><!--
    $('#paymentPostcodeAnywhere').postcodeAnywhere();
    
    //--></script> 

<script type="text/javascript"><!--
    $('#paymentPostcodeAnywhere select[name=\'country_id\']').bind('change', function() {
        $.ajax({
            url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
            dataType: 'json',
            beforeSend: function() {
                $('#paymentPostcodeAnywhere select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },
            complete: function() {
                $('.wait').remove();
            },			
            success: function(json) {
                if (json['postcode_required'] == '1') {
                    $('#payment-postcode-required').show();
                } else {
                    $('#payment-postcode-required').hide();
                }
			
                html = '<option value=""><?php echo $text_select; ?></option>';
			
                if (json['zone'] != '') {
                    for (i = 0; i < json['zone'].length; i++) {
                        html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
                        if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
                            html += ' selected="selected"';
                        }
	
                        html += '>' + json['zone'][i]['name'] + '</option>';
                    }
                } else {
                    html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
                }
			
                $('#paymentPostcodeAnywhere select[name=\'zone_id\']').html(html);
                
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
    
    $('.manualAddress').on('click', function() {
        $('#registerAccount input[name=firstname]').trigger('keyup');
    });
    $('.searchAddress').on('click', function() {
        $('#button-register').attr('disabled', 'disabled');
    });
    $('#paymentPostcodeAnywhere select[name=\'address_dropdown\']').on('change', function() {
        $('#registerAccount input[name=firstname]').trigger('keyup');
    });

    $('#paymentPostcodeAnywhere select[name=\'country_id\']').trigger('change');
    //--></script> 


<div class="buttons">
        <input type="button" value="<?php echo $button_continue; ?>" id="button-guest" class="button" />
</div>
<script type="text/javascript"><!--

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
<?php if ($shipping_required) { ?>	
                                                        var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').attr('value');
    				
                                                        if (shipping_address) {
                                                            $.ajax({
                                                                url: 'index.php?route=checkout/shipping_method',
                                                                dataType: 'html',
                                                                success: function(html) {
                                                                    $('#shipping-method .checkout-content').html(html);
    							
                                                                    $('#payment-address .checkout-content').slideUp('slow');
    							
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
//--></script> 