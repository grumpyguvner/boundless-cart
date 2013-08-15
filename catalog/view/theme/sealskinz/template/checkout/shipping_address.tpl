<div style="clear: both; padding: 0 0 15px 0; border-top: 1px solid #DDDDDD;">
    <h2><?php echo $text_your_shipping_address; ?></h2>

    <label for="shipping" class="checkbox"><?php if ($shipping_address) { ?>
        <input type="checkbox" id="shipping" value="payment" checked="checked" />
        <?php } else { ?>
            <input type="checkbox" id="shipping" value="payment" />
        <?php } ?>
        <?php echo $entry_shipping; ?></label>

</div>
<div id="shippingPostcodeAnywhere" class="postcodeAnywhereContainer paCheckout paNoHide">
    <?php if ($addresses) { ?>
        <div><label for="shipping-address-existing" class="radio"><input type="radio" name="shipping_address_radio" value="existing" id="shipping-address-existing" checked="checked" />
                <?php echo $text_address_existing; ?></label></div>
        <div id="shipping-existing">
            <select name="address_id" style="width: 100%; margin-bottom: 15px;" size="5">
                <?php foreach ($addresses as $address) { ?>
                    <?php if ($address['address_id'] == $address_id) { ?>
                        <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                    <?php } else { ?>
                        <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                    <?php } ?>
                <?php } ?>
            </select>
        </div>

        <div><label for="shipping-address-new" class="radio"><input type="radio" name="shipping_address_radio" value="new" id="shipping-address-new" /> <?php echo $text_address_new; ?></label></div>
        <input type="hidden" name="shipping_address" value="<?php if ($shipping_address) { ?>payment<?php } else { ?>existing<?php } ?>" />
    <?php } ?>
    <div id="shipping-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
        <div class="left" style="border-right: none;">
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
                        <div class="pLabel"><span class="paSelect_required required">*</span> <?php echo $entry_select_address; ?></div>
                        <div class="pInput">
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
        <div class="right">
            <div class="paAddress">
                <div class="prow">
                    <div class="pLabel">  
                        <span class="required">*</span> <?php echo $entry_firstname; ?>
                    </div>
                    <div class="pInput">
                        <input type="text" name="firstname" value="" class="large-field" />
                    </div>
                </div>
                <div class="prow">
                    <div class="pLabel">
                        <span class="required">*</span> <?php echo $entry_lastname; ?>
                    </div>
                    <div class="pInput">
                        <input type="text" name="lastname" value="" class="large-field" />
                    </div>
                </div>
                <div class="prow" id="paCompany">
                    <div class="pLabel">
                        <?php echo $entry_company; ?>
                    </div>
                    <div class="pInput">
                        <input type="text" name="company" value="" class="large-field" />
                    </div>
                </div>
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
                        <span id="shipping-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?>
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
<br />
<div class="buttons">
    <input type="button" value="<?php echo $button_continue; ?>" id="button-shipping-address" class="button" />
</div>
<script type="text/javascript"><!--
    $('#shippingPostcodeAnywhere').postcodeAnywhere();
    
    $('#shippingPostcodeAnywhere input[name=\'shipping_address_radio\']').live('change', function() {
        if (this.value == 'new') {
            $('#shipping-existing').hide();
            $('#shipping-new').show();
        } else {
            $('#shipping-existing').show();
            $('#shipping-new').hide();
        }
        $('#shippingPostcodeAnywhere input[name=\'shipping_address\']').val(this.value);
    });
    
    $('#shipping').live('change', function() {
        if ($(this).is(':checked')) {
            $('#shippingPostcodeAnywhere').hide();
            $('#shippingPostcodeAnywhere input[name=\'shipping_address\']').val(this.value);
        } else {
            $('#shippingPostcodeAnywhere input[name=\'shipping_address\']').val($('#shippingPostcodeAnywhere input[name=\'shipping_address_radio\']').val());
            $('#shippingPostcodeAnywhere').show();
        }
    });
    
    $('#shipping').trigger('change');
    //--></script> 
<script type="text/javascript"><!--
    $('#shippingPostcodeAnywhere select[name=\'country_id\']').bind('change', function() {
        $.ajax({
            url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
            dataType: 'json',
            beforeSend: function() {
                $('#shippingPostcodeAnywhere select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },
            complete: function() {
                $('.wait').remove();
            },			
            success: function(json) {
                if (json['postcode_required'] == '1') {
                    $('#shipping-postcode-required').show();
                } else {
                    $('#shipping-postcode-required').hide();
                }
			
                html = '<option value=""><?php echo $text_select; ?></option>';
			
                if (json['zone'] != '') {
                    for (i = 0; i < json['zone'].length; i++) {
                        html += '<option value="' + json['zone'][i]['zone_id'] + '">' + json['zone'][i]['name'] + '</option>';
                    }
                } else {
                    html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
                }
			
                $('#shippingPostcodeAnywhere select[name=\'zone_id\']').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $('#shippingPostcodeAnywhere select[name=\'country_id\']').trigger('change');
    //--></script>

<script type="text/javascript"><!--
    $('#shipping-address input, #shipping-address select').live('keydown, change', function () {
        if ($('#paymentPostcodeAnywhere select[name=address_id]').val() || ($('#paymentPostcodeAnywhere input[name=address_1]').val() &&
            $('#paymentPostcodeAnywhere input[name=city]').val() &&
            $('#paymentPostcodeAnywhere input[name=postcode]').val() &&
            $('#paymentPostcodeAnywhere select[name=country_id]').val() &&
            $('#paymentPostcodeAnywhere select[name=zone_id]').val()) &&
            ($('#shipping').is(':checked') || $('#shippingPostcodeAnywhere select[name=address_id]').val() || ($('#shippingPostcodeAnywhere input[name=firstname]').val() &&
                $('#shippingPostcodeAnywhere input[name=lastname]').val() &&
                $('#shippingPostcodeAnywhere input[name=address_1]').val() &&
                $('#shippingPostcodeAnywhere input[name=city]').val() &&
                $('#shippingPostcodeAnywhere input[name=postcode]').val() &&
                $('#shippingPostcodeAnywhere select[name=country_id]').val() &&
                $('#shippingPostcodeAnywhere select[name=zone_id]').val())))
        {
            $('#button-shipping-address').attr('disabled', false);
        } else {
            $('#button-shipping-address').attr('disabled', 'disabled');
        }
    }).trigger('change');
    //--></script>