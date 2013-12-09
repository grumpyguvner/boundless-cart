<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-paypal"></i> <?php echo $heading_title; ?></h1>
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
          <div class="control-group<?php if ($error_username) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_username; ?></label>
            <div class="controls">
							<input type="text" name="pp_pro_username" value="<?php echo $pp_pro_username; ?>" class="span3">
              <?php if ($error_username) { ?>
              <span class="error help-block"><?php echo $error_username; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_password) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_password; ?></label>
            <div class="controls">
							<input type="text" name="pp_pro_password" value="<?php echo $pp_pro_password; ?>" class="span3">
              <?php if ($error_password) { ?>
              <span class="error help-block"><?php echo $error_password; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_signature) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_signature; ?></label>
            <div class="controls">
							<input type="text" name="pp_pro_signature" value="<?php echo $pp_pro_signature; ?>" class="span3">
              <?php if ($error_signature) { ?>
              <span class="error help-block"><?php echo $error_signature; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_test; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'pp_pro_test', $pp_pro_test); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'pp_pro_test', $pp_pro_test); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_transaction; ?></label>
            <div class="controls">
							<select name="pp_pro_transaction" class="span2">
                <option value="0"<?php if (!$pp_pro_transaction) { ?> selected="selected"<?php } ?>><?php echo $text_authorization; ?></option>
                <option value="1"<?php if ($pp_pro_transaction) { ?> selected="selected"<?php } ?>><?php echo $text_sale; ?></option>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></label>
            <div class="controls"><input type="text" name="pp_pro_total" value="<?php echo $pp_pro_total; ?>"></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></label>
            <div class="controls">
							<select name="pp_pro_order_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $pp_pro_order_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="pp_pro_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $pp_pro_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="pp_pro_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$pp_pro_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="pp_pro_sort_order" value="<?php echo $pp_pro_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>