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
          <div class="control-group<?php if ($error_auth_id) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_auth_id; ?></label>
            <div class="controls">
							<input type="text" name="perpetual_payments_auth_id" value="<?php echo $perpetual_payments_auth_id; ?>" class="span3">
              <?php if ($error_auth_id) { ?>
              <span class="error help-block"><?php echo $error_auth_id; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_auth_pass) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_auth_pass; ?></label>
            <div class="controls">
							<input type="text" name="perpetual_payments_auth_pass" value="<?php echo $perpetual_payments_auth_pass; ?>" class="span3">
              <?php if ($error_auth_pass) { ?>
              <span class="error help-block"><?php echo $error_auth_pass; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_test; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'perpetual_payments_test', $perpetual_payments_test); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'perpetual_payments_test', $perpetual_payments_test); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></label>
            <div class="controls">
							<input type="text" name="perpetual_payments_total" value="<?php echo $perpetual_payments_total; ?>" class="span2">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></label>
            <div class="controls">
							<select name="perpetual_payments_order_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $perpetual_payments_order_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="perpetual_payments_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $perpetual_payments_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="perpetual_payments_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$perpetual_payments_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="perpetual_payments_sort_order" value="<?php echo $perpetual_payments_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>