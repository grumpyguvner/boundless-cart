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
							<input type="text" name="fedex_key" value="<?php echo $fedex_key; ?>" class="span3">
              <?php if ($error_key) { ?>
              <span class="error help-block"><?php echo $error_key; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_password) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_password; ?></label>
            <div class="controls">
							<input type="text" name="fedex_password" value="<?php echo $fedex_password; ?>" class="span3">
              <?php if ($error_password) { ?>
              <span class="error help-block"><?php echo $error_password; ?></span>
              <?php } ?></div>
          </div>
          <div class="control-group<?php if ($error_account) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_account; ?></label>
            <div class="controls">
							<input type="text" name="fedex_account" value="<?php echo $fedex_account; ?>" class="span3">
              <?php if ($error_account) { ?>
              <span class="error help-block"><?php echo $error_account; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_meter) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_meter; ?></label>
            <div class="controls">
							<input type="text" name="fedex_meter" value="<?php echo $fedex_meter; ?>" class="span3">
              <?php if ($error_meter) { ?>
              <span class="error help-block"><?php echo $error_meter; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_postcode) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_postcode; ?></label>
            <div class="controls">
							<input type="text" name="fedex_postcode" value="<?php echo $fedex_postcode; ?>" class="span3">
              <?php if ($error_postcode) { ?>
              <span class="error help-block"><?php echo $error_postcode; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_test; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'fedex_test', $fedex_test); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'fedex_test', $fedex_test); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_service; ?></label>
            <div class="controls">
							<div class="scrollbox">
                <?php $class = 'odd'; ?>
                <?php foreach ($services as $service) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
									<label class="checkbox inline">
										<input type="checkbox" name="fedex_service[]" value="<?php echo $service['value']; ?>"<?php if (in_array($service['value'], $fedex_service)) { ?> checked="checked"<?php } ?>>
										<?php echo $service['text']; ?>
									</label>
                </div>
                <?php } ?>
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
            <label class="control-label"><?php echo $entry_dropoff_type; ?></label>
            <div class="controls">
							<select name="fedex_dropoff_type" class="span3">
                <?php if ($fedex_dropoff_type == 'REGULAR_PICKUP') { ?>
                <option value="REGULAR_PICKUP" selected="selected"><?php echo $text_regular_pickup; ?></option>
                <?php } else { ?>
                <option value="REGULAR_PICKUP"><?php echo $text_regular_pickup; ?></option>
                <?php } ?>
                <?php if ($fedex_dropoff_type == 'REQUEST_COURIER') { ?>
                <option value="REQUEST_COURIER" selected="selected"><?php echo $text_request_courier; ?></option>
                <?php } else { ?>
                <option value="REQUEST_COURIER"><?php echo $text_request_courier; ?></option>
                <?php } ?>
                <?php if ($fedex_dropoff_type == 'DROP_BOX') { ?>
                <option value="DROP_BOX" selected="selected"><?php echo $text_drop_box; ?></option>
                <?php } else { ?>
                <option value="DROP_BOX"><?php echo $text_drop_box; ?></option>
                <?php } ?>
                <?php if ($fedex_dropoff_type == 'BUSINESS_SERVICE_CENTER') { ?>
                <option value="BUSINESS_SERVICE_CENTER" selected="selected"><?php echo $text_business_service_center; ?></option>
                <?php } else { ?>
                <option value="BUSINESS_SERVICE_CENTER"><?php echo $text_business_service_center; ?></option>
                <?php } ?>
                <?php if ($fedex_dropoff_type == 'STATION') { ?>
                <option value="STATION" selected="selected"><?php echo $text_station; ?></option>
                <?php } else { ?>
                <option value="STATION"><?php echo $text_station; ?></option>
                <?php } ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_packaging_type; ?></label>
            <div class="controls">
							<select name="fedex_packaging_type" class="span3">
                <?php if ($fedex_packaging_type == 'FEDEX_ENVELOPE') { ?>
                <option value="FEDEX_ENVELOPE" selected="selected"><?php echo $text_fedex_envelope; ?></option>
                <?php } else { ?>
                <option value="FEDEX_ENVELOPE"><?php echo $text_fedex_envelope; ?></option>
                <?php } ?>
                <?php if ($fedex_packaging_type == 'FEDEX_PAK') { ?>
                <option value="FEDEX_PAK" selected="selected"><?php echo $text_fedex_pak; ?></option>
                <?php } else { ?>
                <option value="FEDEX_PAK"><?php echo $text_fedex_pak; ?></option>
                <?php } ?>
                <?php if ($fedex_packaging_type == 'FEDEX_BOX') { ?>
                <option value="FEDEX_BOX" selected="selected"><?php echo $text_fedex_box; ?></option>
                <?php } else { ?>
                <option value="FEDEX_BOX"><?php echo $text_fedex_box; ?></option>
                <?php } ?>
                <?php if ($fedex_packaging_type == 'FEDEX_TUBE') { ?>
                <option value="FEDEX_TUBE" selected="selected"><?php echo $text_fedex_tube; ?></option>
                <?php } else { ?>
                <option value="FEDEX_TUBE"><?php echo $text_fedex_tube; ?></option>
                <?php } ?>
                <?php if ($fedex_packaging_type == 'FEDEX_10KG_BOX') { ?>
                <option value="FEDEX_10KG_BOX" selected="selected"><?php echo $text_fedex_10kg_box; ?></option>
                <?php } else { ?>
                <option value="FEDEX_10KG_BOX"><?php echo $text_fedex_10kg_box; ?></option>
                <?php } ?>
                <?php if ($fedex_packaging_type == 'STATION') { ?>
                <option value="FEDEX_25KG_BOX" selected="selected"><?php echo $text_fedex_25kg_box; ?></option>
                <?php } else { ?>
                <option value="FEDEX_25KG_BOX"><?php echo $text_fedex_25kg_box; ?></option>
                <?php } ?>
                <?php if ($fedex_packaging_type == 'STATION') { ?>
                <option value="YOUR_PACKAGING" selected="selected"><?php echo $text_your_packaging; ?></option>
                <?php } else { ?>
                <option value="YOUR_PACKAGING"><?php echo $text_your_packaging; ?></option>
                <?php } ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_rate_type; ?></label>
            <div class="controls">
							<select name="fedex_rate_type" class="span2">
                <?php if ($fedex_rate_type == 'LIST') { ?>
                <option value="LIST" selected="selected"><?php echo $text_list_rate; ?></option>
                <?php } else { ?>
                <option value="LIST"><?php echo $text_list_rate; ?></option>
                <?php } ?>
                <?php if ($fedex_rate_type == 'ACCOUNT') { ?>
                <option value="ACCOUNT" selected="selected"><?php echo $text_account_rate; ?></option>
                <?php } else { ?>
                <option value="ACCOUNT"><?php echo $text_account_rate; ?></option>
                <?php } ?>
              </select>
						</div>
          </div>
					<div class="control-group">
            <label class="control-label"><?php echo $entry_display_time; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'fedex_display_time', $fedex_display_time); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'fedex_display_time', $fedex_display_time); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_display_weight; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'fedex_display_weight', $fedex_display_weight); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'fedex_display_weight', $fedex_display_weight); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_weight_class; ?></label>
            <div class="controls">
							<select name="fedex_weight_class_id" class="span2">
								<?php echo p3html::oc_weight_class_options($weight_classes, $fedex_weight_class_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_tax_class; ?></label>
            <div class="controls">
							<select name="fedex_tax_class_id" class="span3">
                <option value="0"><?php echo $text_none; ?></option>
								<?php echo p3html::oc_tax_class_options($tax_classes, $fedex_tax_class_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="fedex_geo_zone_id" class="span3">
                <option value="0">
								<?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $fedex_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status ?></label>
            <div class="controls">
							<select name="fedex_status" class="span2 i-small">
								<?php echo p3html::oc_status_options($this->language, (int)$fedex_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="fedex_sort_order" value="<?php echo $fedex_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

<?php echo $footer; ?>