<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-dollar"></i> <?php echo $heading_title; ?></h1>
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
          <div class="control-group<?php if ($error_account) { ?> error<?php } ?>">
            <label class="control-label"><?php echo $entry_account; ?></label>
            <div class="controls">
							<input type="text" name="twocheckout_account" value="<?php echo $twocheckout_account; ?>" class="span3">
              <?php if ($error_account) { ?>
              <span class="error help-block"><?php echo $error_account; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_secret) { ?> error<?php } ?>">
            <label class="control-label"><?php echo $entry_secret; ?></label>
            <div class="controls">
							<input type="text" name="twocheckout_secret" value="<?php echo $twocheckout_secret; ?>" class="span3">
              <?php if ($error_secret) { ?>
              <span class="error help-block"><?php echo $error_secret; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_test; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'twocheckout_test', $twocheckout_test); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'twocheckout_test', $twocheckout_test); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></label>
            <div class="controls">
							<input type="text" name="twocheckout_total" value="<?php echo $twocheckout_total; ?>" class="span2">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></label>
            <div class="controls">
							<select name="twocheckout_order_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $twocheckout_order_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="twocheckout_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $twocheckout_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="twocheckout_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$twocheckout_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="twocheckout_sort_order" value="<?php echo $twocheckout_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>