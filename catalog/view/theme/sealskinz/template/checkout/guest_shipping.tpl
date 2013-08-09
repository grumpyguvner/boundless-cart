<h2><?php echo $text_your_address; ?></h2>
<div id="guestPostcodeAnywhere" class="postcodeAnywhereContainer paCheckout paNoHide">
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
                <div class="prow">
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
                        </select>
                        <button class="btn" name="address_select" type="button"><?php echo $button_select_address; ?></button>
                    </div>
                </div>
            </div>
            <?php
        }
        ?> 
    </div>
    <div class="right" style="border-left: none;">
        <div class="paAddress content">
            <div class="prow" id="paCompany">
                <div class="pLabel">
                    <?php echo $entry_company; ?>
                </div>
                <div class="pInput">
                    <input type="text" name="company" value="<?php echo $payment_company; ?>" class="large-field" />
                </div>
            </div>

            <div id="company-id-display" class="paCompanyId">
                <div class="prow">
                    <div class="pLabel">
                        <span id="company-id-required" class="required">*</span> <?php echo $entry_company_id; ?>
                    </div>
                    <div class="pInput">    
                        <input type="text" name="company_id" value="<?php echo $payment_company_id; ?>" class="large-field" />
                    </div>
                </div>
            </div>

            <div id="tax-id-display">
                <div class="prow">
                    <div class="pLabel">
                        <span id="tax-id-required" class="required">*</span> <?php echo $entry_tax_id; ?>
                    </div>
                    <div class="pInput">    
                        <input type="text" name="tax_id" value="<?php echo $payment_tax_id; ?>" class="large-field" />
                    </div>
                </div>
            </div>

            <div class="prow">
                <div class="pLabel">
                    <span class="required">*</span> <?php echo $entry_address_1; ?>
                </div>
                <div class="pInput">    
                    <input type="text" name="address_1" value="<?php echo $payment_address_1; ?>" class="large-field" />
                </div>
            </div>
            <div class="prow">
                <div class="pLabel">
                    <?php echo $entry_address_2; ?>
                </div>
                <div class="pInput">
                    <input type="text" name="address_2" value="<?php echo $payment_address_2; ?>" class="large-field" />
                </div>
            </div>
            <div class="prow">
                <div class="pLabel">
                    <span class="required">*</span> <?php echo $entry_city; ?>
                </div>
                <div class="pInput">
                    <input type="text" name="city" value="<?php echo $payment_city; ?>" class="large-field" />
                </div>
            </div>
            <div class="prow">
                <div class="pLabel">
                    <span id="payment-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?>
                </div>
                <div class="pInput">
                    <input type="text" name="postcode" value="<?php echo $payment_postcode; ?>" class="large-field" />
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
                            <?php if ($country['country_id'] == $payment_country_id) { ?>
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
<script type="text/javascript"><!--
    $('#guestPostcodeAnywhere').postcodeAnywhere();
    //--></script> 
<script type="text/javascript"><!--
    $('#guestPostcodeAnywhere select[name=\'country_id\']').bind('change', function() {
        $.ajax({
            url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
            dataType: 'json',
            beforeSend: function() {
                $('#guestPostcodeAnywhere select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
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
	    			
                        if (json['zone'][i]['zone_id'] == '<?php echo $payment_zone_id; ?>') {
                            html += ' selected="selected"';
                        }
	
                        html += '>' + json['zone'][i]['name'] + '</option>';
                    }
                } else {
                    html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
                }
			
                $('#guestPostcodeAnywhere select[name=\'zone_id\']').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $('#guestPostcodeAnywhere select[name=\'country_id\']').trigger('change');
    //--></script>
<script type="text/javascript"><!--
    
    $('#payment-address input[name=\'customer_group_id\']:checked').live('change', function() {
        var customer_group = [];
	
<?php foreach ($customer_groups as $customer_group) { ?>
            customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
            customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
            customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
            customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
            customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
<?php } ?>	

        if (customer_group[this.value]) {
            if (customer_group[this.value]['company_id_display'] == '1') {
                $('#company-id-display').show();
            } else {
                $('#company-id-display').hide();
            }
		
            if (customer_group[this.value]['company_id_required'] == '1') {
                $('#company-id-required').show();
            } else {
                $('#company-id-required').hide();
            }
		
            if (customer_group[this.value]['tax_id_display'] == '1') {
                $('#tax-id-display').show();
            } else {
                $('#tax-id-display').hide();
            }
		
            if (customer_group[this.value]['tax_id_required'] == '1') {
                $('#tax-id-required').show();
            } else {
                $('#tax-id-required').hide();
            }	
        }
    });

    $('#payment-address input[name=\'customer_group_id\']:checked').trigger('change');
    //--></script> 

<?php if ($shipping_required) { ?>
    <div style="clear: both; padding: 0 0 15px 0; border-top: 1px solid #DDDDDD;">
        <h2><?php echo $text_your_shipping_address; ?></h2>
        
        <label for="shipping" class="checkbox"><?php if ($shipping_address) { ?>
                <input type="checkbox" name="shipping_address" value="1" id="shipping" checked="checked" />
            <?php } else { ?>
                <input type="checkbox" name="shipping_address" value="1" id="shipping" />
            <?php } ?>
            <?php echo $entry_shipping; ?></label>

    </div>
    <div id="shippingPostcodeAnywhere" class="postcodeAnywhereContainer paCheckout paNoHide">
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
                    <div class="prow">
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
                            </select>
                            <button class="btn" name="address_select" type="button"><?php echo $button_select_address; ?></button>
                        </div>
                    </div>
                </div>
                <?php
            }
            ?> 
        </div>
        <div class="right" style="border-left: none;">
            <div class="paAddress content">
                <div class="prow">
                    <div class="pLabel">  
                        <span class="required">*</span> <?php echo $entry_firstname; ?>
                    </div>
                    <div class="pInput">
                        <input type="text" name="firstname" value="<?php echo $firstname ?>" class="large-field" />
                    </div>
                </div>
                <div class="prow">
                    <div class="pLabel">
                        <span class="required">*</span> <?php echo $entry_lastname; ?>
                    </div>
                    <div class="pInput">
                        <input type="text" name="lastname" value="<?php echo $lastname ?>" class="large-field" />
                    </div>
                </div>
                <div class="prow" id="paCompany">
                    <div class="pLabel">
                        <?php echo $entry_company; ?>
                    </div>
                    <div class="pInput">
                        <input type="text" name="company" value="<?php echo $company ?>" class="large-field" />
                    </div>
                </div>
                <div class="prow">
                    <div class="pLabel">
                        <span class="required">*</span> <?php echo $entry_address_1; ?>
                    </div>
                    <div class="pInput">
                        <input type="text" name="address_1" value="<?php echo $address_1 ?>" class="large-field" />
                    </div>
                </div>
                <div class="prow">
                    <div class="pLabel">
                        <?php echo $entry_address_2; ?>
                    </div>
                    <div class="pInput">
                        <input type="text" name="address_2" value="<?php echo $address_2 ?>" class="large-field" />
                    </div>
                </div>
                <div class="prow">
                    <div class="pLabel">
                        <span class="required">*</span> <?php echo $entry_city; ?>
                    </div>
                    <div class="pInput">
                        <input type="text" name="city" value="<?php echo $city ?>" class="large-field" />
                    </div>
                </div>
                <div class="prow">
                    <div class="pLabel">
                        <span id="shipping-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?>
                    </div>
                    <div class="pInput">
                        <input type="text" name="postcode" value="<?php echo $postcode; ?>" class="large-field" />
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

<?php } ?>
<br />

<div class="buttons">
    <input type="button" value="<?php echo $button_continue; ?>" id="button-guest-shipping" class="button" />
</div>

<script type="text/javascript"><!--
    $('#shippingPostcodeAnywhere').postcodeAnywhere();
    
    $('#shipping-address input[name=\'shipping_address\']').live('change', function() {
        if ($(this).is(':checked')) {
            $('#shippingPostcodeAnywhere').hide();
        } else {
            $('#shippingPostcodeAnywhere').show();
        }
    });
    
    $('#shipping-address input[name=\'shipping_address\']').trigger('change');
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
                        html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
                        if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
                            html += ' selected="selected"';
                        }
	
                        html += '>' + json['zone'][i]['name'] + '</option>';
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