<?php if ($addresses) { ?>
    <label for="shipping-address-existing" class="radio"><input type="radio" name="shipping_address" value="existing" id="shipping-address-existing" checked="checked" />
        <?php echo $text_address_existing; ?></label>
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

    <p>
        <label for="shipping-address-new" class="radio"><input type="radio" name="shipping_address" value="new" id="shipping-address-new" />
            <?php echo $text_address_new; ?></label>
    </p>

<?php } ?>
<div class="row"> 
    <div class="span10">
        <div id="shipping-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
            <div id="shippingPostcodeAnywhere" class="postcodeAnywhereContainer paCheckout">
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
                                <button class="btn" name="lookup" type="button"><?php echo $button_find_address; ?></button>
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
                            <input type="text" name="postcode" value="<?php echo $postcode; ?>" class="large-field" />
                            <?php
                                        if ($use_postcode_anywhere) {
                                            ?>
                                            <button class="btn" name="lookup" type="submit"><?php echo $button_find_address; ?></button>
                                            <?php
                                        }
                            ?>
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
<br />

<div class="buttons">
        <input type="button" value="<?php echo $button_continue; ?>" id="button-shipping-address" class="button" />
</div>

<script type="text/javascript"><!--
    $('#shippingPostcodeAnywhere').postcodeAnywhere();
    
    $('#shipping-address input[name=\'shipping_address\']').live('change', function() {
        if (this.value == 'new') {
            $('#shipping-existing').hide();
            $('#shipping-new').show();
        } else {
            $('#shipping-existing').show();
            $('#shipping-new').hide();
        }
    });
    //--></script> 
<script type="text/javascript"><!--
    $('#shipping-address select[name=\'country_id\']').bind('change', function() {
        $.ajax({
            url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
            dataType: 'json',
            beforeSend: function() {
                $('#shipping-address select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
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
			
                $('#shipping-address select[name=\'zone_id\']').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $('#shipping-address select[name=\'country_id\']').trigger('change');
    //--></script>