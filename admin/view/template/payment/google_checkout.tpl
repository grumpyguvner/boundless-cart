<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-google"></i> <?php echo $heading_title; ?></h1>
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
          <div class="control-group<?php if ($error_merchant_id) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_merchant_id; ?></div>
            <div class="controls">
							<input type="text" name="google_checkout_merchant_id" value="<?php echo $google_checkout_merchant_id; ?>" class="span3">
              <?php if ($error_merchant_id) { ?>
              <span class="error help-block"><?php echo $error_merchant_id; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_merchant_key) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_merchant_key; ?></div>
            <div class="controls">
							<input type="text" name="google_checkout_merchant_key" value="<?php echo $google_checkout_merchant_key; ?>" class="span3">
              <?php if ($error_merchant_key) { ?>
              <span class="error help-block"><?php echo $error_merchant_key; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_callback; ?></div>
            <div class="controls">
							<textarea class="span6 i-xxlarge" rows="5"><?php echo $callback; ?></textarea>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_test; ?></div>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'google_checkout_test', $google_checkout_test); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'google_checkout_test', $google_checkout_test); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></div>
            <div class="controls">
							<input type="text" name="google_checkout_total" value="<?php echo $google_checkout_total; ?>" class="span2">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></div>
            <div class="controls">
							<select name="google_checkout_order_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $google_checkout_order_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></div>
            <div class="controls">
							<select name="google_checkout_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $google_checkout_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></div>
            <div class="controls">
							<select name="google_checkout_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$google_checkout_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></div>
            <div class="controls">
							<input type="text" name="google_checkout_sort_order" value="<?php echo $google_checkout_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>