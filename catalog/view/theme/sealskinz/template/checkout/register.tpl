<div class="left" style="border-right: none;">
    
        <h2><?php echo $text_your_details; ?></h2>
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
        <div class="prow">
            <div class="pLabel">
                <span class="required">*</span> <?php echo $entry_email; ?>
            </div>
            <div class="pInput">  
                <input type="text" name="email" value="" class="large-field" />
            </div>
        </div>
        <div class="prow">
            <div class="pLabel">
                <span class="required">*</span> <?php echo $entry_telephone; ?>
            </div>
            <div class="pInput">
                <input type="text" name="telephone" value="" class="large-field" />
            </div>
        </div>
        <div class="prow">
            <div class="pLabel">
                <?php echo $entry_fax; ?>
            </div>
            <div class="pInput">  
                <input type="text" name="fax" value="" class="large-field" />
            </div>
        </div>
        <h2><?php echo $text_your_password; ?></h2>
        <div class="prow">
            <div class="pLabel">
                <span class="required">*</span> <?php echo $entry_password; ?>
            </div>
            <div class="pInput">  
                <input type="password" name="password" value="" class="large-field" />
            </div>
        </div>
        <div class="prow">
            <div class="pLabel">
                <span class="required">*</span> <?php echo $entry_confirm; ?>
            </div>
            <div class="pInput">   
                <input type="password" name="confirm" value="" class="large-field" />
            </div>
        </div>
    
</div>
<div class="right"  style="border-right: none;">
    
        <h2><?php echo $text_your_address; ?></h2>
        <div id="registerPostcodeAnywhere" class="postcodeAnywhereContainer paCheckout">
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
                            </select><br />
                            <button class="btn" name="address_select" type="button"><?php echo $button_select_address; ?></button>
                        </div>
                    </div>
                </div>
                <?php
            }
            ?>
            <div class="paAddress content">
                <div class="prow" id="paCompany">
                    <div class="pLabel">
                        <?php echo $entry_company; ?>
                    </div>
                    <div class="pInput">  
                        <input type="text" name="company" value="" class="large-field" />
                    </div>
                </div>

                <div style="display: <?php echo (count($customer_groups) > 1 ? 'table-row' : 'none'); ?>;">
                    <?php echo $entry_customer_group; ?><br />
                    <?php foreach ($customer_groups as $customer_group) { ?>
                        <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
                            <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                            <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
                            <br />
                        <?php } else { ?>
                            <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
                            <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
                            <br />
                        <?php } ?>
                    <?php } ?>
                    <br />
                </div>
                <input type="hidden" name="company_id" value="" />
                <input type="hidden" name="tax_id" value="" />
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
<div style="clear: both; padding-top: 15px; border-top: 1px solid #EEEEEE;">  
    <?php
    if ($show_newsletter) {
        ?>
        <label for="newsletter" class="checkbox"><input type="checkbox" name="newsletter" value="1" id="newsletter" />
            <?php echo $entry_newsletter; ?></label>
        <br />
        <?php
    } else {
        ?>
        <input type="hidden" name="newsletter" value="1" />
        <?php
    }
    ?>
    <?php if ($shipping_required) { ?>
        <label for="shipping" class="checkbox"><input type="checkbox" name="shipping_address" value="1" id="shipping" checked="checked" />
            <?php echo $entry_shipping; ?></label>
        <br />
    <?php } ?>
    <br />
    <br />
</div>
<?php if ($text_agree) { ?>
    <div class="buttons">
        <label class="checkbox"><?php echo $text_agree; ?>
                <input type="checkbox" name="agree" value="1" /></label>
            <input type="button" value="<?php echo $button_continue; ?>" id="button-register" class="button" />
    </div>
<?php } else { ?>
    <div class="buttons">
            <input type="button" value="<?php echo $button_continue; ?>" id="button-register" class="button" />
    </div>
<?php } ?>
<script type="text/javascript"><!--
    $('#registerPostcodeAnywhere').postcodeAnywhere();

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
<script type="text/javascript"><!--
    $('#payment-address select[name=\'country_id\']').bind('change', function() {
        $.ajax({
            url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
            dataType: 'json',
            beforeSend: function() {
                $('#payment-address select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
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
			
                $('#payment-address select[name=\'zone_id\']').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $('#payment-address select[name=\'country_id\']').trigger('change');
    //--></script> 
<script type="text/javascript"><!--
    $('.colorbox').colorbox({
        width: 640,
        height: 480
    });
    //--></script> 