<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-user"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_save($button_save); ?>
				<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
			</div>
    </div>

    <div class="content">

      <ul id="htabs" class="htabs nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#tab-general"><i class="icon-eye"></i> <?php echo $tab_general; ?></a></li>
				<li><a data-toggle="tab" href="#tab-payment"><i class="icon-dollar"></i> <?php echo $tab_payment; ?></a></li>
        <?php if ($affiliate_id) { ?>
        <li><a data-toggle="tab" href="#tab-transaction"><i class="icon-switch"></i> <?php echo $tab_transaction; ?></a></li>
        <?php } ?>
      </ul>

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
			<div class="tab-content">

        <div class="tab-pane active" id="tab-general">
          <div class="form">
            <div class="control-group<?php if ($error_firstname) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_firstname; ?></label>
              <div class="controls">
								<input type="text" name="firstname" value="<?php echo $firstname; ?>" class="span3">
                <?php if ($error_firstname) { ?>
                <span class="error help-block"><?php echo $error_firstname; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_lastname) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_lastname; ?></label>
              <div class="controls">
								<input type="text" name="lastname" value="<?php echo $lastname; ?>" class="span3">
                <?php if ($error_lastname) { ?>
                <span class="error help-block"><?php echo $error_lastname; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_email) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_email; ?></label>
              <div class="controls">
								<input type="text" name="email" value="<?php echo $email; ?>" class="span4">
                <?php if ($error_email) { ?>
                <span class="error help-block"><?php echo $error_email; ?></span>
                <?php  } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_telephone) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_telephone; ?></label>
              <div class="controls">
								<input type="text" name="telephone" value="<?php echo $telephone; ?>" class="span2">
                <?php if ($error_telephone) { ?>
                <span class="error help-block"><?php echo $error_telephone; ?></span>
                <?php  } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_fax; ?></label>
              <div class="controls"><input type="text" name="fax" value="<?php echo $fax; ?>" class="span2"></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_company; ?></label>
              <div class="controls"><input type="text" name="company" value="<?php echo $company; ?>" class="span3"></div>
            </div>
            <div class="control-group<?php if ($error_address_1) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_address_1; ?></label>
              <div class="controls">
								<input type="text" name="address_1" value="<?php echo $address_1; ?>" class="span4">
                <?php if ($error_address_1) { ?>
                <span class="error help-block"><?php echo $error_address_1; ?></span>
                <?php  } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_address_2; ?></label>
              <div class="controls">
								<input type="text" name="address_2" value="<?php echo $address_2; ?>" class="span4">
							</div>
            </div>
            <div class="control-group<?php if ($error_city) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_city; ?></label>
              <div class="controls">
								<input type="text" name="city" value="<?php echo $city; ?>" class="span3">
                <?php if ($error_city) { ?>
                <span class="error help-block"><?php echo $error_city ?></span>
                <?php  } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_postcode) { ?> error<?php } ?>">
              <label class="control-label">
								<i id="postcode-required" class="required icon-asterisk"></i> <?php echo $entry_postcode; ?>
							</label>
              <div class="controls">
								<input type="text" name="postcode" value="<?php echo $postcode; ?>" class="span2">
                <?php if ($error_postcode) { ?>
                <span class="error help-block"><?php echo $error_postcode ?></span>
                <?php  } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_country; ?></label>
              <div class="controls<?php if ($error_country) { ?> error<?php } ?>">
								<select name="country_id" class="span3">
                  <option value="false"><?php echo $text_select; ?></option>
									<?php echo p3html::oc_country_options($countries, $country_id); ?>
                </select>
                <?php if ($error_country) { ?>
                <span class="error help-block"><?php echo $error_country; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_zone; ?></label>
              <div class="controls<?php if ($error_zone) { ?> error<?php } ?>">
								<select name="zone_id" class="span3">
                </select>
                <?php if ($error_zone) { ?>
                <span class="error help-block"><?php echo $error_zone; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_code) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_code; ?></label>
              <div class="controls">
								<input type="text" name="code" value="<?php echo $code; ?>" class="span2">
                <?php if ($error_code) { ?>
                <span class="error help-block"><?php echo $error_code; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_password) { ?> error<?php } ?>">
              <label class="control-label"><?php echo $entry_password; ?></label>
              <div class="controls">
								<input type="password" name="password" value="<?php echo $password; ?>" class="span2">
                <?php if ($error_password) { ?>
                <span class="error help-block"><?php echo $error_password; ?></span>
                <?php  } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_confirm) { ?> error<?php } ?>">
              <label class="control-label"><?php echo $entry_confirm; ?></label>
              <div class="controls">
								<input type="password" name="confirm" value="<?php echo $confirm; ?>" class="span2">
                <?php if ($error_confirm) { ?>
                <span class="error help-block"><?php echo $error_confirm; ?></span>
                <?php  } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
								<select name="status" class="span2">
									<?php echo p3html::oc_status_options($this->language, $status); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-payment">
          <div class="form">
            <div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_account_commission; ?></label>
                <div class="controls"><input type="text" name="account_commission" value="<?php echo $account_commission; ?>" class="span2"></div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_commission; ?></label>
                <div class="controls"><input type="text" name="commission" value="<?php echo $commission; ?>" class="span2"></div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_tax; ?></label>
                <div class="controls">
									<input type="text" name="tax" value="<?php echo $tax; ?>">
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_payment; ?></label>
                <div class="controls">
                    <label for="voucher" class="radio inline">
                            <?php echo $text_voucher; ?>
                            <input type="radio" name="payment" value="voucher" id="voucher"<?php if ($payment == 'voucher') { ?> checked="checked"<?php } ?>>
                    </label>
                    <label for="cheque" class="radio inline">
                            <?php echo $text_cheque; ?>
                            <input type="radio" name="payment" value="cheque" id="cheque"<?php if ($payment == 'cheque') { ?> checked="checked"<?php } ?>>
                    </label>
                    <label for="paypal" class="radio inline">
                            <input type="radio" name="payment" value="paypal" id="paypal"<?php if ($payment == 'paypal') { ?> checked="checked"<?php } ?>>
                            <?php echo $text_paypal; ?>
                    </label>
                    <label for="bank" class="radio inline">
                            <input type="radio" name="payment" value="bank" id="bank"<?php if ($payment == 'bank') { ?> checked="checked"<?php } ?>>
                            <?php echo $text_bank; ?>
                    </label>
                </div>
              </div>
            </div>
            <div id="payment-cheque" class="payment">
              <div class="control-group">
                <label class="control-label"><?php echo $entry_cheque; ?></label>
                <div class="controls">
									<input type="text" name="cheque" value="<?php echo $cheque; ?>" class="span3">
								</div>
              </div>
            </div>
            <div id="payment-paypal" class="payment">
              <div class="control-group">
                <label class="control-label"><?php echo $entry_paypal; ?></label>
                <div class="controls">
									<input type="text" name="paypal" value="<?php echo $paypal; ?>" class="span3">
								</div>
              </div>
            </div>
            <div id="payment-bank" class="payment">
              <div class="control-group">
                <label class="control-label"><?php echo $entry_bank_name; ?></label>
                <div class="controls">
									<input type="text" name="bank_name" value="<?php echo $bank_name; ?>" class="span3">
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_bank_branch_number; ?></label>
                <div class="controls">
									<input type="text" name="bank_branch_number" value="<?php echo $bank_branch_number; ?>" class="span3">
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_bank_swift_code; ?></label>
                <div class="controls">
									<input type="text" name="bank_swift_code" value="<?php echo $bank_swift_code; ?>" class="span3">
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_bank_account_name; ?></label>
                <div class="controls">
									<input type="text" name="bank_account_name" value="<?php echo $bank_account_name; ?>" class="span3">
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_bank_account_number; ?></label>
                <div class="controls">
									<input type="text" name="bank_account_number" value="<?php echo $bank_account_number; ?>" class="span3">
								</div>
              </div>
            </div>
          </div>
        </div>

        <?php if ($affiliate_id) { ?>
        <div class="tab-pane" id="tab-transaction">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_description; ?></label>
              <div class="controls">
								<input type="text" name="description" value="" class="span4">
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_amount; ?></label>
              <div class="controls">
								<input type="text" name="amount" value="" class="span2">
							</div>
            </div>
            <div class="control-group">
              <div class="controls">
								<a id="button-reward" class="btn" onclick="addTransaction();">
									<i class="icon-plus-squared"></i>
									<span><?php echo $button_add_transaction; ?></span>
								</a>
							</div>
            </div>
          </div>
          <div id="transaction"></div>
        </div>
        <?php } ?>

			</div>
      </form>

    </div>
  </div>
</div>

<script>
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=sale/affiliate/country&token=<?php echo $token; ?>&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'payment_country_id\']').after('<span class="wait">&nbsp;<img src="view/image/loading.gif" alt=""></span>');
		},
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#postcode-required').show();
			} else {
				$('#postcode-required').hide();
			}

			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json != '' && json['zone'] != '') {
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

			$('select[name=\'zone_id\']').html(html);
			$('select[name=\'zone_id\']').trigger('change');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'country_id\']').trigger('change');
</script>

<script>
$('input[name=\'payment\']').bind('change', function() {
	$('.payment').hide();

	$('#payment-' + this.value).show();
});

$('input[name=\'payment\']:checked').trigger('change');
</script>
<script>
$('#transaction .pagination a').live('click', function() {
	$('#transaction').load(this.href);

	return false;
});

$('#transaction').load('index.php?route=sale/affiliate/transaction&token=<?php echo $token; ?>&affiliate_id=<?php echo $affiliate_id; ?>');

function addTransaction() {
	$.ajax({
		url: 'index.php?route=sale/affiliate/transaction&token=<?php echo $token; ?>&affiliate_id=<?php echo $affiliate_id; ?>',
		type: 'post',
		dataType: 'html',
		data: 'description=' + encodeURIComponent($('#tab-transaction input[name=\'description\']').val()) + '&amount=' + encodeURIComponent($('#tab-transaction input[name=\'amount\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-transaction').attr('disabled', true);
			$('#transaction').before('<div class="attention"><img src="view/image/loading.gif" alt=""> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-transaction').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(html) {
			$('#transaction').html(html);

			$('#tab-transaction input[name=\'amount\']').val('');
			$('#tab-transaction input[name=\'description\']').val('');
		}
	});
}
</script>

<?php echo $footer; ?>