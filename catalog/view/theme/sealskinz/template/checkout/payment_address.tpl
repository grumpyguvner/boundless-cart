<h2><?php echo $text_your_address ?></h2>
<?php 
    $continueEnabled = false;
//    if (!$address_id || !$use_postcode_anywhere) {
//        $continueEnabled = true;
//    }
?>
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
                        <input type="button" id="button-payment-address" class="button paymentAddressSelect" value="<?php echo $text_select_continue; ?>" />
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
                <br />
                <div class="buttons">
                    <input type="button" value="<?php echo $button_update; ?>" id="button-payment-address" class="button" />
                </div>
            </div>
        </div>

    </div>
</div>

<script type="text/javascript"><!--
    $('#paymentPostcodeAnywhere').postcodeAnywhere();
    
    $('.paymentAddressExisting').bind('click', function() {
        $('#payment_address').val("existing");
        $('#payment-new').hide();
        $('.paAddress #button-payment-address').hide();
        $('#payment-existing').show();
        
        $('#payment-method.checkout-content').slideDown('slow');
    });
    $('.paymentAddressNew').bind('click', function() {
        $('#payment-method.checkout-content').slideUp('slow');
        
        $('#payment_address').val("new");
        $('#paymentPostcodeAnywhere #address_id').val("0");
        $('.paymentAddressNew').hide();
        $('#payment-existing').hide();
        $('#payment-new').show();
        $('.paAddress #button-payment-address').show();
    });
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
    
    $('.paymentAddressSelect').bind('click', function() {
        varId=$(this).parent().attr('id');
        $('#paymentPostcodeAnywhere #address_id').val(varId);
        $('#payment_address').val("existing");
        $('.paAddress #button-payment-address').trigger('click');
    });
    $('.manualAddress').bind('click', function() {
        $('.paAddress #button-payment-address').show();
    });
    $('#paymentPostcodeAnywhere select[name=\'address_dropdown\']').bind('click', function() {
        $('.paAddress #button-payment-address').show();
    });
    $('.searchAddress').bind('click', function() {
        $('.paAddress #button-payment-address').hide();
    });

    $('#paymentPostcodeAnywhere select[name=\'country_id\']').trigger('change');
    //--></script>

<?php // if (!$continueEnabled) { ?>
<script type="text/javascript"><!--
    $('.paAddress #button-payment-address').hide();
//--></script>
<?php // } ?>
