<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <?php if ($error_warning) { ?>
  	<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
  <?php } ?>
  <div class="box">

    <div class="heading">
      <h1><i class="icon-truck"></i> <?php echo $heading_title; ?></h1>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_save($button_save); ?>
				<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
			</div>
    </div>

    <div class="content">

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
        <div class="form">
          <div class="control-group<?php if ($error_user_id) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_user_id; ?></label>
            <div class="controls">
							<input type="text" name="usps_user_id" value="<?php echo $usps_user_id; ?>" class="span2">
              <?php if ($error_user_id) { ?>
              <span class="error help-block"><?php echo $error_user_id; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_user_id) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_postcode; ?></label>
            <div class="controls">
							<input type="text" name="usps_postcode" value="<?php echo $usps_postcode; ?>" class="span2">
              <?php if ($error_postcode) { ?>
              <span class="error help-block"><?php echo $error_postcode; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_domestic; ?></label>
            <div class="controls">
							<div class="scrollbox">
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_00" value="1"<?php if ($usps_domestic_00) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_00; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_01" value="1"<?php if ($usps_domestic_01) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_01; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_02" value="1"<?php if ($usps_domestic_02) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_02; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_03" value="1"<?php if ($usps_domestic_03) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_03; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_1" value="1"<?php if ($usps_domestic_1) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_1; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_2" value="1"<?php if ($usps_domestic_2) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_2; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_3" value="1"<?php if ($usps_domestic_3) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_3; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_4" value="1"<?php if ($usps_domestic_4) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_4; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_5" value="1"<?php if ($usps_domestic_5) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_5; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_6" value="1"<?php if ($usps_domestic_6) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_6; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_7" value="1"<?php if ($usps_domestic_7) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_7; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_12" value="1"<?php if ($usps_domestic_12) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_12; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_13" value="1"<?php if ($usps_domestic_13) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_13; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_16" value="1"<?php if ($usps_domestic_16) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_16; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_17" value="1"<?php if ($usps_domestic_17) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_17; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_18" value="1"<?php if ($usps_domestic_18) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_18; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_19" value="1"<?php if ($usps_domestic_19) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_19; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_22" value="1"<?php if ($usps_domestic_22) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_22; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_23" value="1"<?php if ($usps_domestic_23) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_23; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_25" value="1"<?php if ($usps_domestic_25) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_25; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_27" value="1"<?php if ($usps_domestic_27) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_27; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_domestic_28" value="1"<?php if ($usps_domestic_28) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_domestic_28; ?></label>
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
            <label class="control-label"><?php echo $entry_international; ?></label>
            <div class="controls">
							<div class="scrollbox">
                <?php $class = 'odd'; ?>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_1" value="1"<?php if ($usps_international_1) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_1; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_2" value="1"<?php if ($usps_international_2) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_2; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_4" value="1"<?php if ($usps_international_4) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_4; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_5" value="1"<?php if ($usps_international_5) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_5; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_6" value="1"<?php if ($usps_international_6) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_6; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_7" value="1"<?php if ($usps_international_7) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_7; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_8" value="1"<?php if ($usps_international_8) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_8; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_9" value="1"<?php if ($usps_international_9) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_9; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_10" value="1"<?php if ($usps_international_10) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_10; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_11" value="1"<?php if ($usps_international_11) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_11; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_12" value="1"<?php if ($usps_international_12) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_12; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_13" value="1"<?php if ($usps_international_13) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_13; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_14" value="1"<?php if ($usps_international_14) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_14; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_15" value="1"<?php if ($usps_international_15) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_15; ?></label>
                </div>
                <div class="even">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_16" value="1"<?php if ($usps_international_16) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_16; ?></label>
                </div>
                <div class="odd">
                  <label class="checkbox inline">
									<input type="checkbox" name="usps_international_21" value="1"<?php if ($usps_international_21) { ?> checked="checked"<?php } ?>>
                  <?php echo $text_international_21; ?></label>
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
            <label class="control-label"><?php echo $entry_size; ?></label>
            <div class="controls">
							<select name="usps_size" class="span2">
                <?php foreach ($sizes as $size) { ?>
                <option value="<?php echo $size['value']; ?>"<?php if ($size['value'] == $usps_size) { ?> selected="selected"<?php } ?>><?php echo $size['text']; ?></option>
                <?php } ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_container; ?></label>
            <div class="controls">
							<select name="usps_container" class="span2">
                <?php foreach ($containers as $container) { ?>
                <option value="<?php echo $container['value']; ?>"<?php if ($container['value'] == $usps_container) { ?> selected="selected"<?php } ?>><?php echo $container['text']; ?></option>
                <?php } ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_machinable; ?></label>
            <div class="controls">
							<select name="usps_machinable" class="span1">
								<?php echo p3html::oc_bool_options($this->language, $usps_machinable); ?>
              </select>
						</div>
          </div>
          <div class="control-group<?php if ($error_width or $error_length or $error_height) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_dimension; ?></label>
            <div class="controls">
							<input type="text" name="usps_length" value="<?php echo $usps_length; ?>" class="span1 i-mini">
              <input type="text" name="usps_width" value="<?php echo $usps_width; ?>" class="span1 i-mini">
              <input type="text" name="usps_height" value="<?php echo $usps_height; ?>" class="span1 i-mini">
							<?php if ($error_width or $error_length or $error_height) { ?>
							<span class="error help-block">
								<?php if ($error_width) { ?>
								<span class="error"><?php echo $error_width; ?></span>
								<?php } ?>
								<?php if ($error_length) { ?>
								<span class="error"><?php echo $error_length; ?></span>
								<?php } ?>
								<?php if ($error_height) { ?>
								<span class="error"><?php echo $error_height; ?></span>
								<?php } ?>
							</span>
							<?php } ?>
		    </div>
          </div>
		  <div class="control-group">
            <label class="control-label"><?php echo $entry_display_time; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'usps_display_time', $usps_display_time); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'usps_display_time', $usps_display_time); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_display_weight; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'usps_display_weight', $usps_display_weight); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'usps_display_weight', $usps_display_weight); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_weight_class; ?></label>
            <div class="controls">
							<select name="usps_weight_class_id" class="span2">
								<?php echo p3html::oc_weight_class_options($weight_classes, $usps_weight_class_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_tax; ?></label>
            <div class="controls">
							<select name="usps_tax_class_id" class="span3">
                <option value="0"><?php echo $text_none; ?></option>
								<?php echo p3html::oc_tax_class_options($tax_classes, $usps_tax_class_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="usps_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $usps_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="usps_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$usps_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="usps_sort_order" value="<?php echo $usps_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
					<div class="control-group">
            <label class="control-label"><?php echo $entry_debug; ?></label>
            <div class="controls">
							<select name="usps_debug" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$usps_debug); ?>
            </select>
						</div>
          </div>
        </div>
      </form>

    </div>

  </div>

</div>

<?php echo $footer; ?>