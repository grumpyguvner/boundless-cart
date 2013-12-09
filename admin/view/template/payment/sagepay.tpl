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
          <div class="control-group<?php if ($error_vendor) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_vendor; ?></label>
            <div class="controls">
							<input type="text" name="sagepay_vendor" value="<?php echo $sagepay_vendor; ?>" class="span3">
              <?php if ($error_vendor) { ?>
              <span class="error help-block"><?php echo $error_vendor; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_password) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_password; ?></label>
            <div class="controls">
							<input type="text" name="sagepay_password" value="<?php echo $sagepay_password; ?>" class="span3">
              <?php if ($error_password) { ?>
              <span class="error help-block"><?php echo $error_password; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_test; ?></label>
            <div class="controls">
							<select name="sagepay_test" class="span2">
                <option value="sim"<?php if ($sagepay_test == 'sim') { ?> selected="selected"<?php } ?>><?php echo $text_sim; ?></option>
                <option value="test"<?php if ($sagepay_test == 'test') { ?> selected="selected"<?php } ?>><?php echo $text_test; ?></option>
                <option value="live"<?php if ($sagepay_test == 'live') { ?> selected="selected"<?php } ?>><?php echo $text_live; ?></option>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_transaction; ?></label>
            <div class="controls">
							<select name="sagepay_transaction" class="span2">
                <option value="PAYMENT"<?php if ($sagepay_transaction == 'PAYMENT') { ?> selected="selected"<?php } ?>><?php echo $text_payment; ?></option>
                <option value="DEFERRED"<?php if ($sagepay_transaction == 'DEFERRED') { ?> selected="selected"<?php } ?>><?php echo $text_defered; ?></option>
                <option value="AUTHENTICATE"<?php if ($sagepay_transaction == 'AUTHENTICATE') { ?> selected="selected"<?php } ?>><?php echo $text_authenticate; ?></option>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></label>
            <div class="controls">
							<input type="text" name="sagepay_total" value="<?php echo $sagepay_total; ?>" class="span2">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></label>
            <div class="controls">
							<select name="sagepay_order_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $sagepay_order_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="sagepay_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $sagepay_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="sagepay_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$sagepay_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="sagepay_sort_order" value="<?php echo $sagepay_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>