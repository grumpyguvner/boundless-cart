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
          <div class="control-group<?php if ($error_email) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_email; ?></label>
            <div class="controls">
							<input type="text" name="nochex_email" value="<?php echo $nochex_email; ?>" class="span3">
              <?php if ($error_email) { ?>
              <span class="error help-block"><?php echo $error_email; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_account; ?></label>
            <div class="controls">
							<select name="nochex_account" class="span3">
                <option value="seller"<?php if ($nochex_account == 'seller') { ?> selected="selected"<?php } ?>><?php echo $text_seller; ?></option>
                <option value="merchant"<?php if ($nochex_account == 'merchant') { ?> selected="selected"<?php } ?>><?php echo $text_merchant; ?></option>
              </select>
						</div>
          </div>
          <div class="control-group<?php if ($error_merchant) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_merchant; ?></label>
            <div class="controls">
							<input type="text" name="nochex_merchant" value="<?php echo $nochex_merchant; ?>" class="span3">
              <?php if ($error_merchant) { ?>
              <span class="error help-block"><?php echo $error_merchant; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_template; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'nochex_template', $nochex_template); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'nochex_template', $nochex_template); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_test; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'nochex_test', $nochex_test); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'nochex_test', $nochex_test); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></label>
            <div class="controls">
							<input type="text" name="nochex_total" value="<?php echo $nochex_total; ?>" class="span2">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></label>
            <div class="controls">
							<select name="nochex_order_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $nochex_order_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls"><select name="nochex_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $nochex_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="nochex_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$nochex_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="nochex_sort_order" value="<?php echo $nochex_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>