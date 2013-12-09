<div class="row">
    <div class="span12">
        
        <?php if ($addresses) { ?>
        <div class="row">
            <div class="span12">
                <input type="radio" name="payment_address" value="existing" id="payment-address-existing" checked="checked" />
                <label for="payment-address-existing"><?php echo $text_address_existing; ?></label>
            </div>
        </div>
        <div class="row">
            <div class="span12">
                <div id="payment-existing">
                    <div class="row">
                        <div class="span12">
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
                     </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="span12">
                <p>
                  <input type="radio" name="payment_address" value="new" id="payment-address-new" />
                  <label for="payment-address-new"><?php echo $text_address_new; ?></label>
                </p>
            </div>
        </div>
        <?php } ?>
        <div class="row"> 
            <div class="span12">
                <div id="payment-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
                    <div class="row">
                        <div class="span3">
                        <span class="required">*</span> <?php echo $entry_firstname; ?>
                        </div>
                        <div class="span9">
                        <input type="text" name="firstname" value="" class="large-field" />
                        </div>
                        <div class="span3">
                        <span class="required">*</span> <?php echo $entry_lastname; ?>
                        </div>
                        <div class="span9">
                        <input type="text" name="lastname" value="" class="large-field" />
                        </div>
                        <div class="span3">
                        <?php echo $entry_company; ?>
                        </div>
                        <div class="span9">
                        <input type="text" name="company" value="" class="large-field" />
                        </div>
                        <?php if ($company_id_display) { ?>
                          <div class="span3">
                             <?php if ($company_id_required) { ?>
                                  <span class="required">*</span>
                              <?php } ?>
                                  <?php echo $entry_company_id; ?>
                                <td></td>
                          </div>
                          <div class="span9">
                            <input type="text" name="company_id" value="" class="large-field" />
                          </div>
                        <?php } ?>
                        <?php if ($tax_id_display) { ?>
                            <div class="span3">
                              <?php if ($tax_id_required) { ?>
                                <span class="required">*</span>
                              <?php } ?>
                              <?php echo $entry_tax_id; ?>
                            </div>
                            <div class="span9">
                                <input type="text" name="tax_id" value="" class="large-field" />
                            </div>
                        <?php } ?>
                        <div class="span3">
                            <span class="required">*</span> <?php echo $entry_address_1; ?>
                        </div>
                        <div class="span9">
                            <input type="text" name="address_1" value="" class="large-field" />
                        </div>
                        <div class="span3">
                            <?php echo $entry_address_2; ?>
                        </div>
                        <div class="span9">
                            <input type="text" name="address_2" value="" class="large-field" />
                        </div>
                        <div class="span3">
                            <span class="required">*</span> <?php echo $entry_city; ?>
                        </div>
                        <div class="span9">
                            <input type="text" name="city" value="" class="large-field" />
                        </div>
                        <div class="span3">
                            <span id="payment-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?>
                        </div>
                        <div class="span9">
                            <input type="text" name="postcode" value="" class="large-field" />
                        </div>
                        <div class="span3">
                            <span class="required">*</span> <?php echo $entry_country; ?>
                        </div>
                        <div class="span9">
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
                        <div class="span3">
                            <span class="required">*</span> <?php echo $entry_zone; ?>
                        </div>
                        <div class="span9">
                            <select name="zone_id" class="large-field">
                            </select>
                        </div>
                    </div>
            </div>
          </div>
        </div>
      <br />
      <div class="row">
             <div class="span12">
                <div class="buttons">
                  <div class="right">
                    <input type="button" value="<?php echo $button_continue; ?>" id="button-payment-address" class="btn" />
                  </div>
                </div>
             </div>
      </div>
    </div>
</div>
<script type="text/javascript"><!--
$('#payment-address input[name=\'payment_address\']').live('change', function() {
	if (this.value == 'new') {
		$('#payment-existing').hide();
		$('#payment-new').show();
	} else {
		$('#payment-existing').show();
		$('#payment-new').hide();
	}
});
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