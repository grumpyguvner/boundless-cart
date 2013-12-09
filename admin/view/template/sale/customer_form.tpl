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
				<li class="active"><a data-toggle="tab" href="#tab-general"><i class="icon-user"></i> <?php echo $tab_general; ?></a></li>
        <?php if ($customer_id) { ?>
        <li><a data-toggle="tab" href="#tab-transaction"><i class="icon-switch"></i> <?php echo $tab_transaction; ?></a></li>
				<li><a data-toggle="tab" href="#tab-reward"><i class="icon-star-empty"></i> <?php echo $tab_reward; ?></a></li>
        <?php } ?>
        <li><a data-toggle="tab" href="#tab-ip"><i class="icon-address"></i> <?php echo $tab_ip; ?></a></li>
			</ul>

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
			<div class="tab-content">

        <div class="tab-pane active tabbable tabs-left" id="tab-general">

          <ul id="vtabs" class="vtabs nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#tab-customer"><i class="icon-vcard"></i> <?php echo $tab_general; ?></a></li>
            <?php $address_row = 1; ?>
            <?php foreach ($addresses as $address) { ?>
            <li>
							<a data-toggle="tab" href="#tab-address-<?php echo $address_row; ?>" id="address-<?php echo $address_row; ?>">
								<i class="icon-trash" title="" onclick="$('#vtabs a:first').trigger('click'); $('#address-<?php echo $address_row; ?>').remove(); $('#tab-address-<?php echo $address_row; ?>').remove(); return false;"></i>
								<?php echo $tab_address . ' ' . $address_row; ?>
							</a>
						</li>
            <?php $address_row++; ?>
            <?php } ?>
            <li id="address-add">
							<a>
								<i class="icon-plus-squared" title="<?php echo $button_add_address; ?>" onclick="addAddress();"></i>
								<?php echo $button_add_address; ?>
							</a>
						</li>
					</ul>

					<div class="tab-content">

          <div class="tab-pane active" id="tab-customer" class="vtabs-content">
            <div class="form">
              <div class="control-group<?php if ($error_firstname) { ?> error<?php  } ?>">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_firstname; ?></label>
                <div class="controls">
									<input type="text" name="firstname" value="<?php echo $firstname; ?>" class="span3">
                  <?php if ($error_firstname) { ?>
                  <span class="error help-block"><?php echo $error_firstname; ?></span>
                  <?php } ?>
								</div>
              </div>
              <div class="control-group<?php if ($error_lastname) { ?> error<?php  } ?>">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_lastname; ?></label>
                <div class="controls">
									<input type="text" name="lastname" value="<?php echo $lastname; ?>" class="span3">
                  <?php if ($error_lastname) { ?>
                  <span class="error help-block"><?php echo $error_lastname; ?></span>
                  <?php } ?>
								</div>
              </div>
              <div class="control-group<?php if ($error_email) { ?> error<?php  } ?>">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_email; ?></label>
                <div class="controls">
									<input type="text" name="email" value="<?php echo $email; ?>" class="span4">
                  <?php if ($error_email) { ?>
                  <span class="error help-block"><?php echo $error_email; ?></span>
                  <?php  } ?>
								</div>
              </div>
              <div class="control-group<?php if ($error_telephone) { ?> error<?php  } ?>">
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
              <div class="control-group<?php if ($error_password) { ?> error<?php  } ?>">
                <label class="control-label">
									<?php if (!$customer_id) { ?><i class="required text-error icon-asterisk"></i><?php } ?>
										<?php echo $entry_password; ?>
								</label>
                <div class="controls">
									<input type="password" name="password" value="<?php echo $password; ?>" class="span2">
                  <br>
                  <?php if ($error_password) { ?>
                  <span class="error help-block"><?php echo $error_password; ?></span>
                  <?php  } ?>
								</div>
              </div>
              <div class="control-group<?php if ($error_confirm) { ?> error<?php  } ?>">
                <label class="control-label">
									<?php if (!$customer_id) { ?><i class="required text-error icon-asterisk"></i><?php } ?>
									<?php echo $entry_confirm; ?>
								</label>
                <div class="controls">
									<input type="password" name="confirm" value="<?php echo $confirm; ?>" class="span2">
                  <?php if ($error_confirm) { ?>
                  <span class="error help-block"><?php echo $error_confirm; ?></span>
                  <?php  } ?>
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_newsletter; ?></label>
                <div class="controls">
									<select name="newsletter" class="span2">
										<?php echo p3html::oc_status_options($this->language, $newsletter); ?>
                  </select>
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_customer_group; ?></label>
                <div class="controls">
									<select name="customer_group_id" class="span2">
										<?php echo p3html::oc_customer_group_options($customer_groups, $customer_group_id); ?>
                  </select>
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

          <?php $address_row = 1; ?>
          <?php foreach ($addresses as $address) { ?>
          <div class="tab-pane" id="tab-address-<?php echo $address_row; ?>" class="vtabs-content">
            <input type="hidden" name="address[<?php echo $address_row; ?>][address_id]" value="<?php echo $address['address_id']; ?>">
            <table class="form">
              <div class="control-group<?php if (isset($error_address_firstname[$address_row])) { ?> error<?php } ?>">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_firstname; ?></label>
                <div class="controls">
									<input type="text" name="address[<?php echo $address_row; ?>][firstname]" value="<?php echo $address['firstname']; ?>" class="span3">
                  <?php if (isset($error_address_firstname[$address_row])) { ?>
                  <span class="error help-block"><?php echo $error_address_firstname[$address_row]; ?></span>
                  <?php } ?>
								</div>
              </div>
              <div class="control-group<?php if (isset($error_address_lastname[$address_row])) { ?> error<?php } ?>">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_lastname; ?></label>
                <div class="controls">
									<input type="text" name="address[<?php echo $address_row; ?>][lastname]" value="<?php echo $address['lastname']; ?>" class="span3">
                  <?php if (isset($error_address_lastname[$address_row])) { ?>
                  <span class="error help-block"><?php echo $error_address_lastname[$address_row]; ?></span>
                  <?php } ?>
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_company; ?></label>
                <div class="controls">
									<input type="text" name="address[<?php echo $address_row; ?>][company]" value="<?php echo $address['company']; ?>" class="span4"></div>
              </div>
              <div class="control-group company-id-display">
                <label class="control-label"><?php echo $entry_company_id; ?></label>
                <div class="controls">
									<input type="text" name="address[<?php echo $address_row; ?>][company_id]" value="<?php echo $address['company_id']; ?>" class="span2">
								</div>
              </div>
              <div class="control-group tax-id-display<?php if (isset($error_address_tax_id[$address_row])) { ?> error<?php } ?>">
                <label class="control-label"><?php echo $entry_tax_id; ?></label>
                <div class="controls">
									<input type="text" name="address[<?php echo $address_row; ?>][tax_id]" value="<?php echo $address['tax_id']; ?>" class="span2">
                  <?php if (isset($error_address_tax_id[$address_row])) { ?>
                  <span class="error help-block"><?php echo $error_address_tax_id[$address_row]; ?></span>
                  <?php } ?>
								</div>
              </div>
              <div class="control-group<?php if (isset($error_address_address_1[$address_row])) { ?> error<?php } ?>">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_address_1; ?></label>
                <div class="controls">
									<input type="text" name="address[<?php echo $address_row; ?>][address_1]" value="<?php echo $address['address_1']; ?>" class="span4">
                  <?php if (isset($error_address_address_1[$address_row])) { ?>
                  <span class="error help-block"><?php echo $error_address_address_1[$address_row]; ?></span>
                  <?php } ?>
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_address_2; ?></label>
                <div class="controls">
									<input type="text" name="address[<?php echo $address_row; ?>][address_2]" value="<?php echo $address['address_2']; ?>" class="span4">
								</div>
              </div>
              <div class="control-group<?php if (isset($error_address_city[$address_row])) { ?> error<?php } ?>">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_city; ?></label>
                <div class="controls">
									<input type="text" name="address[<?php echo $address_row; ?>][city]" value="<?php echo $address['city']; ?>" class="span3">
                  <?php if (isset($error_address_city[$address_row])) { ?>
                  <span class="error help-block"><?php echo $error_address_city[$address_row]; ?></span>
                  <?php } ?>
								</div>
              </div>
              <div class="control-group">
                <label class="control-label">
									<span id="postcode-required<?php echo $address_row; ?>" class="required">*</span> <?php echo $entry_postcode; ?>
								</label>
                <div class="controls">
									<input type="text" name="address[<?php echo $address_row; ?>][postcode]" value="<?php echo $address['postcode']; ?>" class="span2">
								</div>
              </div>
              <div class="control-group<?php if (isset($error_address_country[$address_row])) { ?> error<?php } ?>">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_country; ?></label>
                <div class="controls">
									<select name="address[<?php echo $address_row; ?>][country_id]" onchange="country(this, '<?php echo $address_row; ?>', '<?php echo $address['zone_id']; ?>');" class="span3">
                    <option value=""><?php echo $text_select; ?></option>
										<?php echo p3html::oc_country_options($countries, $address); ?>
                  </select>
                  <?php if (isset($error_address_country[$address_row])) { ?>
                  <span class="error help-block"><?php echo $error_address_country[$address_row]; ?></span>
                  <?php } ?>
								</div>
              </div>
              <div class="control-group<?php if (isset($error_address_zone[$address_row])) { ?> error<?php } ?>">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_zone; ?></label>
                <div class="controls">
									<select name="address[<?php echo $address_row; ?>][zone_id]" class="span3">
                  </select>
                  <?php if (isset($error_address_zone[$address_row])) { ?>
                  <span class="error help-block"><?php echo $error_address_zone[$address_row]; ?></span>
                  <?php } ?>
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_default; ?></label>
                <div class="controls">
									<?php $checked = (int)(($address['address_id'] == $address_id) || !$addresses) ; ?>
									<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
									<?php echo p3html::tb_bool_buttons_checkbox($this->language, "address[$address_row][default]", $checked); ?>
									<?php } else { ?>
									<input type="checkbox" name="address[<?php echo $address_row; ?>][default]" value="1"<?php if ($checked) { ?> checked="checked"<?php } ?>>
									<?php } ?>
                </div>
              </div>
            </table>
          </div>
          <?php $address_row++; ?>
          <?php } ?>
        </div>

				</div>

        <?php if ($customer_id) { ?>
        <div class="tab-pane" id="tab-transaction">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_description; ?></label>
              <div class="controls"><input type="text" name="description" value="" class="span4"></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_amount; ?></label>
              <div class="controls"><input type="text" name="amount" value="" class="span2"></div>
            </div>
            <div class="control-group">
              <div class="controls">
								<?php //echo p3html::tb_ajax_button($button_add_transaction, "addTransaction();", null, null, 'plus-squared', 'button-transaction'); ?>
								<a id="button-transaction" class="btn" onclick="addTransaction();">
									<i class="icon-plus-squared"></i>
									<span><?php echo $button_add_transaction; ?></span>
								</a>
							</div>
            </div>
          </div>
          <div id="transaction"></div>
        </div>

        <div class="tab-pane" id="tab-reward">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_description; ?></label>
              <div class="controls"><input type="text" name="description" value="" class="span4"></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_points; ?></label>
              <div class="controls"><input type="text" name="points" value="" class="span2"></div>
            </div>
            <div class="control-group">
              <div class="controls">
								<a id="button-reward" class="btn" onclick="addRewardPoints();">
									<i class="icon-plus-squared"></i>
									<span><?php echo $button_add_reward; ?></span>
								</a>
							</div>
            </div>
          </div>
          <div id="reward"></div>
        </div>
        <?php } ?>

        <div class="tab-pane" id="tab-ip">
					<?php if ($ips) { ?>
          <table class="list table table-striped table-hover">
            <thead>
              <tr>
                <th class="column-number"><?php echo $column_ip; ?></th>
                <th class="column-number"><?php echo $column_total; ?></th>
                <th class="column-date"><?php echo $column_date_added; ?></th>
                <th class="column-action"><?php echo $column_action; ?></th>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($ips as $ip) { ?>
              <tr>
                <td class="column-number">
									<a onclick="window.open('http://www.geoiptool.com?IP=<?php echo $ip['ip']; ?>');"><?php echo $ip['ip']; ?></a>
								</td>
                <td class="column-number">
									<a onclick="window.open('<?php echo $ip['filter_ip']; ?>');"><?php echo $ip['total']; ?></a>
								</td>
                <td class="column-date"><?php echo $ip['date_added']; ?></td>
                <td class="column-action">
									<?php if ($ip['blacklist']) { ?>
									<?php echo p3html::tb_ajax_button($text_remove_blacklist, "removeBlacklist('".$ip['ip']."');", null, null, 'trash', str_replace('.', '-', $ip['ip'])); ?>
                  <?php } else { ?>
									<?php echo p3html::tb_ajax_button($text_add_blacklist, "addBlacklist('".$ip['ip']."');", null, null, 'plus-squared', str_replace('.', '-', $ip['ip'])); ?>
                  <?php } ?>
								</td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
					<?php } else { ?>
					<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
					<?php } ?>
        </div>

			</div>
      </form>

    </div>
  </div>
</div>

<script>
$('select[name=\'customer_group_id\']').on('change', function() {
	var customer_group = [];

<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
<?php } ?>

	if (customer_group[this.value]) {
		if (customer_group[this.value]['company_id_display'] == '1') {
			$('.company-id-display').show();
		} else {
			$('.company-id-display').hide();
		}

		if (customer_group[this.value]['tax_id_display'] == '1') {
			$('.tax-id-display').show();
		} else {
			$('.tax-id-display').hide();
		}
	}
});

$('select[name=\'customer_group_id\']').trigger('change');
</script>

<script>
function country(element, index, zone_id) {
	$.ajax({
		url: 'index.php?route=sale/customer/country&token=<?php echo $token; ?>&country_id=' + element.value,
		dataType: 'json',
		beforeSend: function() {
			//$('select[name=\'address[' + index + '][zone_id]\']').after('<span class="wait">&nbsp;<img src="view/image/loading.gif" alt=""></span>');
		},
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#postcode-required' + index).show();
			} else {
				$('#postcode-required' + index).hide();
			}

			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';

					if (json['zone'][i]['zone_id'] == zone_id) {
	      				html += ' selected="selected"';
	    			}

	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0"><?php echo $text_none; ?></option>';
			}

			$('select[name="address[' + index + '][zone_id]"]').html(html);
			$('select[name="address[' + index + '][zone_id]"]').trigger('change');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

$('select[name$="[country_id]"]').trigger('change');
</script>

<script>
var address_row = <?php echo $address_row; ?>;

function addAddress() {
	html  = '<div class="tab-pane" id="tab-address-' + address_row + '" class="vtabs-content">';
	html += '	<input type="hidden" name="address[' + address_row + '][address_id]" value="">';
	html += '	<div class="form">';
	html += '		<div class="control-group">';
  html += '			<label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_firstname; ?></label>';
  html += '			<div class="controls"><input type="text" name="address[' + address_row + '][firstname]" value="" class="span3"></div>';
  html += '		</div>';
  html += '		<div class="control-group">';
  html += '			<label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_lastname; ?></label>';
  html += '			<div class="controls"><input type="text" name="address[' + address_row + '][lastname]" value="" class="span3"></div>';
  html += '		</div>';
  html += '		<div class="control-group">';
  html += '			<label class="control-label"><?php echo $entry_company; ?></label>';
  html += '			<div class="controls"><input type="text" name="address[' + address_row + '][company]" value="" class="span4"></div>';
  html += '		</div>';
  html += '		<div class="control-group company-id-display">';
  html += '			<label class="control-label"><?php echo $entry_company_id; ?></label>';
  html += '			<div class="controls"><input type="text" name="address[' + address_row + '][company_id]" value="" class="span2"></div>';
  html += '		</div>';
  html += '		<div class="control-group tax-id-display">';
  html += '			<label class="control-label"><?php echo $entry_tax_id; ?></label>';
  html += '			<div class="controls"><input type="text" name="address[' + address_row + '][tax_id]" value="" class="span2"></div>';
  html += '		</div>';
  html += '    <div class="control-group">';
  html += '      <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_address_1; ?></label>';
  html += '      <div class="controls"><input type="text" name="address[' + address_row + '][address_1]" value="" class="span4"></div>';
  html += '    </div>';
  html += '    <div class="control-group">';
  html += '      <label class="control-label"><?php echo $entry_address_2; ?></label>';
  html += '      <div class="controls"><input type="text" name="address[' + address_row + '][address_2]" value="" class="span4"></div>';
  html += '    </div>';
  html += '    <div class="control-group">';
  html += '      <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_city; ?></label>';
  html += '      <div class="controls"><input type="text" name="address[' + address_row + '][city]" value="" class="span3"></div>';
  html += '    </div>';
  html += '    <div class="control-group">';
  html += '      <label class="control-label"><span id="postcode-required' + address_row + '" class="required">*</span> <?php echo $entry_postcode; ?></label>';
  html += '      <div class="controls"><input type="text" name="address[' + address_row + '][postcode]" value="" class="span2"></div>';
  html += '    </div>';
	html += '    <div class="control-group">';
  html += '      <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_country; ?></label>';
  html += '      <div class="controls"><select name="address[' + address_row + '][country_id]" onchange="country(this, \'' + address_row + '\', \'0\');" class="span3">';
  html += '         <option value=""><?php echo $text_select; ?></option>';
	html += '					<?php echo p3html::oc_country_options($countries, null, true); ?>';
  html += '      </select></div>';
  html += '    </div>';
  html += '    <div class="control-group">';
  html += '      <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_zone; ?></label>';
  html += '      <div class="controls"><select name="address[' + address_row + '][zone_id]" class="span3"><option value="false"><?php echo $this->language->get('text_none'); ?></option></select></div>';
  html += '    </div>';
	html += '    <div class="control-group">';
  html += '      <label class="control-label" for="cb-default-address-'+address_row+'"><?php echo $entry_default; ?></label>';
  //html += '      <div class="controls"><input type="checkbox" name="address[' + address_row + '][default]" value="1" id="cb-default-address-'+address_row+'"></div>';
	<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
	html += '      <div class="controls"><?php echo p3html::tb_bool_buttons_radio($this->language, "address[' + address_row + '][default]"); ?></div>';
	<?php } else { ?>
	html += '      <div class="controls"><?php echo p3html::tb_bool_radio_buttons($this->language, "address[' + address_row + '][default]"); ?></div>';
	<?php } ?>
  html += '    </div>';
  html += '  </div>';
  html += '</div>';

	$('#tab-general .tab-content').append(html);

	$('select[name=\'address[' + address_row + '][country_id]\']').trigger('change');

	<?php if ($this->config->get('p3adminrebooted_select2')) { ?>
	$('#tab-address-' + address_row + ' select').select2();
	<?php } ?>

	$('#address-add').before('<li><a data-toggle="tab" href="#tab-address-' + address_row + '" id="address-' + address_row + '"><i class="icon-trash" onclick="$(\'#vtabs a:first\').trigger(\'click\'); $(\'#address-' + address_row + '\').remove(); $(\'#tab-address-' + address_row + '\').remove(); return false;"></i> <?php echo $tab_address; ?> ' + address_row + '</a></li>');

	$('#address-' + address_row).trigger('click');

	address_row++;
}
</script>
<script>
$('#transaction .pagination a').live('click', function() {
	$('#transaction').load(this.href);

	return false;
});

$('#transaction').load('index.php?route=sale/customer/transaction&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>');

function addTransaction() {
	$.ajax({
		url: 'index.php?route=sale/customer/transaction&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>',
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
<script>
$('#reward .pagination a').live('click', function() {
	$('#reward').load(this.href);

	return false;
});

$('#reward').load('index.php?route=sale/customer/reward&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>');

function addRewardPoints() {
	$.ajax({
		url: 'index.php?route=sale/customer/reward&token=<?php echo $token; ?>&customer_id=<?php echo $customer_id; ?>',
		type: 'post',
		dataType: 'html',
		data: 'description=' + encodeURIComponent($('#tab-reward input[name=\'description\']').val()) + '&points=' + encodeURIComponent($('#tab-reward input[name=\'points\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-reward').attr('disabled', true);
			$('#reward').before('<div class="attention"><img src="view/image/loading.gif" alt=""> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-reward').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(html) {
			$('#reward').html(html);

			$('#tab-reward input[name=\'points\']').val('');
			$('#tab-reward input[name=\'description\']').val('');
		}
	});
}

function addBlacklist(ip) {
	$.ajax({
		url: 'index.php?route=sale/customer/addblacklist&token=<?php echo $token; ?>',
		type: 'post',
		dataType: 'json',
		data: 'ip=' + encodeURIComponent(ip),
		beforeSend: function() {
			$('.success, .warning').remove();

			$('.box').before('<div class="attention"><img src="view/image/loading.gif" alt=""> Please wait!</div>');
		},
		complete: function() {
			$('.attention').remove();
		},
		success: function(json) {
			if (json['error']) {
				 $('.box .heading .buttons').before('<div class="warning alert alert-warning" style="display: none;">' + json['error'] + '</div>');

				$('.warning').fadeIn('slow');
			}

			if (json['success']) {
                $('.box .heading .buttons').before('<div class="success alert alert-success" style="display: none;">' + json['success'] + '</div>');

				$('.success').fadeIn('slow');

				$('#' + ip.replace(/\./g, '-')).replaceWith('<a class="btn" id="' + ip.replace(/\./g, '-') + '" onclick="removeBlacklist(\'' + ip + '\');"><i class="icon-trash"></i> <?php echo $text_remove_blacklist; ?></a>');
			}
		}
	});
}

function removeBlacklist(ip) {
	$.ajax({
		url: 'index.php?route=sale/customer/removeblacklist&token=<?php echo $token; ?>',
		type: 'post',
		dataType: 'json',
		data: 'ip=' + encodeURIComponent(ip),
		beforeSend: function() {
			$('.success, .warning').remove();

			$('.box .heading .buttons').before('<div class="attention"><img src="view/image/loading.gif" alt=""> Please wait!</div>');
		},
		complete: function() {
			$('.attention').remove();
		},
		success: function(json) {
			if (json['error']) {
				 $('.box .heading .buttons').before('<div class="warning alert alert-warning" style="display: none;">' + json['error'] + '</div>');

				$('.warning').fadeIn('slow');
			}

			if (json['success']) {
				 $('.box .heading .buttons').before('<div class="success alert alert-success" style="display: none;">' + json['success'] + '</div>');

				$('.success').fadeIn('slow');

				$('#' + ip.replace(/\./g, '-')).replaceWith('<a class="btn" id="' + ip.replace(/\./g, '-') + '" onclick="addBlacklist(\'' + ip + '\');"><i class="icon-plus-squared"></i> <?php echo $text_add_blacklist; ?></a>');
			}
		}
	});
};
</script>

<?php echo $footer; ?>