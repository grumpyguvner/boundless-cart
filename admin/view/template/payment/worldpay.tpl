<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <?php if ($error_warning) { ?>
  	<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
  <?php } ?>
  <div class="box">

    <div class="heading">
      <h1><i class="icon-dollar"></i> <?php echo $heading_title; ?></h1>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_save($button_save); ?>
				<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
			</div>
    </div>

    <div class="content">

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
        <div class="form">
          <div class="control-group<?php if ($error_merchant) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_merchant; ?></label>
            <div class="controls">
							<input type="text" name="worldpay_merchant" value="<?php echo $worldpay_merchant; ?>" class="span3">
              <?php if ($error_merchant) { ?>
              <span class="error help-block"><?php echo $error_merchant; ?></span>
              <?php } ?>
							</div>
          </div>
          <div class="control-group<?php if ($error_password) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_password; ?></label>
            <div class="controls">
							<input type="text" name="worldpay_password" value="<?php echo $worldpay_password; ?>" class="span3">
              <?php if ($error_password) { ?>
              <span class="error help-block"><?php echo $error_password; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_callback; ?></label>
            <div class="controls">
							<textarea class="span6 i-xxlarge" rows="5"><?php echo $callback; ?></textarea>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_test; ?></label>
            <div class="controls">
							<select name="worldpay_test" class="span3">
                <option value="0" <?php if ($worldpay_test == '0') { ?> selected="selected"<?php } ?>><?php echo $text_off; ?></option>
                <option value="100" <?php if ($worldpay_test == '100') { ?> selected="selected"<?php } ?>><?php echo $text_successful; ?></option>
                <option value="101"<?php if ($worldpay_test == '101') { ?> selected="selected"<?php } ?>><?php echo $text_declined; ?></option>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></label>
            <div class="controls">
							<input type="text" name="worldpay_total" value="<?php echo $worldpay_total; ?>" class="span2">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></label>
            <div class="controls">
							<select name="worldpay_order_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $worldpay_order_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="worldpay_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $worldpay_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="worldpay_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$worldpay_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="worldpay_sort_order" value="<?php echo $worldpay_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>