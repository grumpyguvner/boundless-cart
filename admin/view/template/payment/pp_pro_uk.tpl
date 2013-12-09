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
          <div class="control-group<?php if ($error_vendor) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_vendor; ?></label>
            <div class="controls">
							<input type="text" name="pp_pro_uk_vendor" value="<?php echo $pp_pro_uk_vendor; ?>" class="span3">
              <?php if ($error_vendor) { ?>
              <span class="error help-block"><?php echo $error_vendor; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_user) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_user; ?></label>
            <div class="controls">
							<input type="text" name="pp_pro_uk_user" value="<?php echo $pp_pro_uk_user; ?>" class="span3">
              <?php if ($error_user) { ?>
              <span class="error help-block"><?php echo $error_user; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_password) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_password; ?></label>
            <div class="controls">
							<input type="text" name="pp_pro_uk_password" value="<?php echo $pp_pro_uk_password; ?>" class="span3">
              <?php if ($error_password) { ?>
              <span class="error help-block"><?php echo $error_password; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_partner) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_partner; ?></label>
            <div class="controls">
							<input type="text" name="pp_pro_uk_partner" value="<?php echo $pp_pro_uk_partner; ?>" class="span3">
              <?php if ($error_partner) { ?>
              <span class="error help-block"><?php echo $error_partner; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_test; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'pp_pro_uk_test', $pp_pro_uk_test); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'pp_pro_uk_test', $pp_pro_uk_test); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_transaction; ?></label>
            <div class="controls">
							<select name="pp_pro_uk_transaction" class="span2">
                <option value="0"<?php if (!$pp_pro_uk_transaction) { ?> selected="selected"<?php } ?>><?php echo $text_authorization; ?></option>
                <option value="1"<?php if ($pp_pro_uk_transaction) { ?> selected="selected"<?php } ?>><?php echo $text_sale; ?></option>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></label>
            <div class="controls">
							<input type="text" name="pp_pro_uk_total" value="<?php echo $pp_pro_uk_total; ?>" class="span2">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></label>
            <div class="controls">
							<select name="pp_pro_uk_order_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $pp_pro_uk_order_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="pp_pro_uk_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $pp_pro_uk_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="pp_pro_uk_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$pp_pro_uk_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="pp_pro_uk_sort_order" value="<?php echo $pp_pro_uk_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>