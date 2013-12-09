<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-truck"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_save($button_save); ?>
				<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
			</div>
    </div>

    <div class="content">

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
        <div class="form">
          <div class="control-group<?php if ($error_key) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_key; ?></label>
            <div class="controls">
							<input type="text" name="ups_key" value="<?php echo $ups_key; ?>" class="span3">
              <?php if ($error_key) { ?>
              <span class="error help-block"><?php echo $error_key; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_username) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_username; ?></label>
            <div class="controls">
							<input type="text" name="ups_username" value="<?php echo $ups_username; ?>" class="span3">
              <?php if ($error_username) { ?>
              <span class="error help-block"><?php echo $error_username; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_password) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_password; ?></label>
            <div class="controls">
							<input type="text" name="ups_password" value="<?php echo $ups_password; ?>" class="span3">
              <?php if ($error_password) { ?>
              <span class="error help-block"><?php echo $error_password; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_pickup; ?></label>
            <div class="controls">
							<select name="ups_pickup" class="span3">
                <?php foreach ($pickups as $pickup) { ?>
                <option value="<?php echo $pickup['value']; ?>"<?php if ($pickup['value'] == $ups_pickup) { ?> selected="selected"<?php } ?>><?php echo $pickup['text']; ?></option>
                <?php } ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_packaging; ?></label>
            <div class="controls">
							<select name="ups_packaging" class="span3">
                <?php foreach ($packages as $package) { ?>
                <option value="<?php echo $package['value']; ?>"<?php if ($package['value'] == $ups_packaging) { ?> selected="selected"<?php } ?>><?php echo $package['text']; ?></option>
                <?php } ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_classification; ?></label>
            <div class="controls">
							<select name="ups_classification" class="span1">
                <?php foreach ($classifications as $classification) { ?>
                <option value="<?php echo $classification['value']; ?>"<?php if ($classification['value'] == $ups_classification) { ?> selected="selected"<?php } ?>><?php echo $classification['text']; ?></option>
                <?php } ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_origin; ?></label>
            <div class="controls">
							<select name="ups_origin" class="span3">
                <?php foreach ($origins as $origin) { ?>
                <option value="<?php echo $origin['value']; ?>"<?php if ($origin['value'] == $ups_origin) { ?> selected="selected"<?php } ?>><?php echo $origin['text']; ?></option>
								<?php } ?>
              </select>
						</div>
          </div>
          <div class="control-group<?php if ($error_city) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_city; ?></label>
            <div class="controls">
							<input type="text" name="ups_city" value="<?php echo $ups_city; ?>" class="span3">
              <?php if ($error_city) { ?>
              <span class="error help-block"><?php echo $error_city; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_state) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_state; ?></label>
            <div class="controls">
							<input type="text" name="ups_state" value="<?php echo $ups_state; ?>" maxlength="2" class="span1 i-mini">
              <?php if ($error_state) { ?>
              <span class="error help-block"><?php echo $error_state; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_country) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_country; ?></label>
            <div class="controls">
							<input type="text" name="ups_country" value="<?php echo $ups_country; ?>" maxlength="2" class="span1 i-mini">
              <?php if ($error_country) { ?>
              <span class="error help-block"><?php echo $error_country; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_postcode; ?></label>
            <div class="controls">
							<input type="text" name="ups_postcode" value="<?php echo $ups_postcode; ?>" class="span2">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_test; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'ups_test', $ups_test); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'ups_test', $ups_test); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_quote_type; ?></label>
            <div class="controls">
							<select name="ups_quote_type" class="span2">
                <?php foreach ($quote_types as $quote_type) { ?>
                <option value="<?php echo $quote_type['value']; ?>"<?php if ($quote_type['value'] == $ups_quote_type) { ?> selected="selected"<?php } ?>><?php echo $quote_type['text']; ?></option>
                <?php } ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_service; ?></label>
            <div class="controls" id="service">
							<div id="US">
                <div class="scrollbox">
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_us_01" value="1"<?php if ($ups_us_01) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_next_day_air; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_us_02" value="1"<?php if ($ups_us_02) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_2nd_day_air; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_us_03" value="1"<?php if ($ups_us_03) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_ground; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_us_07" value="1"<?php if ($ups_us_07) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_worldwide_express; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_us_08" value="1"<?php if ($ups_us_08) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_worldwide_expedited; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_us_11" value="1"<?php if ($ups_us_11) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_standard; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_us_12" value="1"<?php if ($ups_us_12) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_3_day_select; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_us_13" value="1"<?php if ($ups_us_13) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_next_day_air_saver; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_us_14" value="1"<?php if ($ups_us_14) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_next_day_air_early_am; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_us_54" value="1"<?php if ($ups_us_54) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_worldwide_express_plus; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_us_59" value="1"<?php if ($ups_us_59) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_2nd_day_air_am; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_us_65" value="1"<?php if ($ups_us_65) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_saver; ?></label>
                  </div>
                </div>
              </div>
              <div id="PR">
                <div class="scrollbox">
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_pr_01" value="1"<?php if ($ups_pr_01) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_next_day_air; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_pr_02" value="1"<?php if ($ups_pr_02) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_2nd_day_air; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_pr_03" value="1"<?php if ($ups_pr_03) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_ground; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_pr_07" value="1"<?php if ($ups_pr_07) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_worldwide_express; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_pr_08" value="1"<?php if ($ups_pr_08) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_worldwide_expedited; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_pr_14" value="1"<?php if ($ups_pr_14) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_next_day_air_early_am; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_pr_54" value="1"<?php if ($ups_pr_54) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_worldwide_express_plus; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_pr_65" value="1"<?php if ($ups_pr_65) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_saver; ?></label>
                  </div>
                </div>
              </div>
              <div id="CA">
                <div class="scrollbox">
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_ca_01" value="1"<?php if ($ups_ca_01) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_express; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_ca_02" value="1"<?php if ($ups_ca_02) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_expedited; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_ca_07" value="1"<?php if ($ups_ca_07) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_worldwide_express; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_ca_08" value="1"<?php if ($ups_ca_08) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_worldwide_expedited; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_ca_11" value="1"<?php if ($ups_ca_11) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_standard; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_ca_12" value="1"<?php if ($ups_ca_12) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_3_day_select; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_ca_13" value="1"<?php if ($ups_ca_13) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_saver; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_ca_14" value="1"<?php if ($ups_ca_14) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_express_early_am; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_ca_54" value="1"<?php if ($ups_ca_54) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_worldwide_express_plus; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_ca_65" value="1"<?php if ($ups_ca_65) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_saver; ?></label>
                  </div>
                </div>
              </div>
              <div id="MX">
                <div class="scrollbox">
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_mx_07" value="1"<?php if ($ups_mx_07) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_worldwide_express; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_mx_08" value="1"<?php if ($ups_mx_08) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_worldwide_expedited; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_mx_54" value="1"<?php if ($ups_mx_54) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_worldwide_express_plus; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_mx_65" value="1"<?php if ($ups_mx_65) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_saver; ?></label>
                  </div>
                </div>
              </div>
              <div id="EU">
                <div class="scrollbox">
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_eu_07" value="1"<?php if ($ups_eu_07) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_express; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_eu_08" value="1"<?php if ($ups_eu_08) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_expedited; ?>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_eu_11" value="1"<?php if ($ups_eu_11) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_standard; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_eu_54" value="1"<?php if ($ups_eu_54) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_worldwide_express_plus; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_eu_65" value="1"<?php if ($ups_eu_65) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_saver; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_eu_82" value="1"<?php if ($ups_eu_82) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_today_standard; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_eu_83" value="1"<?php if ($ups_eu_83) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_today_dedicated_courier; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_eu_84" value="1"<?php if ($ups_eu_84) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_today_intercity; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_eu_85" value="1"<?php if ($ups_eu_85) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_today_express; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_eu_86" value="1"<?php if ($ups_eu_86) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_today_express_saver; ?></label>
                  </div>
                </div>
              </div>
              <div id="other">
                <div class="scrollbox">
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_other_07" value="1"<?php if ($ups_other_07) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_express; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_other_08" value="1"<?php if ($ups_other_08) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_expedited; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_other_11" value="1"<?php if ($ups_other_11) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_standard; ?></label>
                  </div>
                  <div class="odd">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_other_54" value="1"<?php if ($ups_other_54) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_worldwide_express_plus; ?></label>
                  </div>
                  <div class="even">
                    <label class="checkbox inline">
										<input type="checkbox" name="ups_other_65" value="1"<?php if ($ups_other_65) { ?> checked="checked"<?php } ?>>
                    <?php echo $text_saver; ?></label>
                  </div>
                </div>
              </div>
							<br>
              <a class="btn btn-small" onclick="$(this).parent().find(':checkbox').attr('checked', true);">
								<i class="icon-cb-checked"></i>
								<?php echo $text_select_all; ?>
							</a>
							<a class="btn btn-small" onclick="$(this).parent().find(':checkbox').attr('checked', false);">
								<i class="icon-cb-unchecked"></i>
								<?php echo $text_unselect_all; ?>
							</a>
	          </div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_insurance; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'ups_insurance', $ups_insurance); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'ups_insurance', $ups_insurance); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_display_weight; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'ups_display_weight', $ups_display_weight); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'ups_display_weight', $ups_display_weight); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_weight_class; ?></label>
            <div class="controls">
							<select name="ups_weight_class_id" class="span2">
								<?php echo p3html::oc_weight_class_options($weight_classes, $ups_weight_class_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_length_class; ?></label>
            <div class="controls">
							<select name="ups_length_class_id" class="span2">
								<?php echo p3html::oc_length_class_options($length_classes, $ups_length_class_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group<?php if ($error_dimension) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_dimension; ?></label>
            <div class="controls">
							<input type="text" name="ups_length" value="<?php echo $ups_length; ?>" class="input-small">
              <input type="text" name="ups_width" value="<?php echo $ups_width; ?>" class="input-small">
              <input type="text" name="ups_height" value="<?php echo $ups_height; ?>" class="input-small">
							<?php if ($error_dimension) { ?>
              <span class="error help-block"><?php echo $error_dimension; ?></span>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_tax_class; ?></label>
            <div class="controls">
							<select name="ups_tax_class_id" class="span3">
                <option value="0"><?php echo $text_none; ?></option>
								<?php echo p3html::oc_tax_class_options($tax_classes, $ups_tax_class_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="ups_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $ups_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="ups_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$ups_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="ups_sort_order" value="<?php echo $ups_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
					<div class="control-group">
            <label class="control-label"><?php echo $entry_debug; ?></label>
            <div class="controls">
							<select name="ups_debug" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$ups_debug); ?>
							</select>
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
$('select[name=\'ups_origin\']').bind('change', function() {
	$('#service > div').hide();

	$('#' + this.value).show();
});

$('select[name=\'ups_origin\']').trigger('change');
</script>

<?php echo $footer; ?>