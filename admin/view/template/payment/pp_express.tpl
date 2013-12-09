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
          <div class="control-group">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_username; ?></div>
            <div class="controls"><input type="text" name="pp_express_username" value="<?php echo $pp_express_username; ?>">
              <?php if ($error_username) { ?>
              <span class="error help-block"><?php echo $error_username; ?></span>
              <?php } ?></div>
          </div>
          <div class="control-group">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_password; ?></div>
            <div class="controls"><input type="text" name="pp_express_password" value="<?php echo $pp_express_password; ?>">
              <?php if ($error_password) { ?>
              <span class="error help-block"><?php echo $error_password; ?></span>
              <?php } ?></div>
          </div>
          <div class="control-group">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_signature; ?></div>
            <div class="controls"><input type="text" name="pp_express_signature" value="<?php echo $pp_express_signature; ?>">
              <?php if ($error_signature) { ?>
              <span class="error help-block"><?php echo $error_signature; ?></span>
              <?php } ?></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_test; ?></div>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'pp_express_test', $pp_express_test); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'pp_express_test', $pp_express_test); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_method; ?></div>
            <div class="controls"><select name="pp_express_method">
                <?php if (!$pp_express_method) { ?>
                <option value="0" selected="selected"><?php echo $text_authorization; ?></option>
                <?php } else { ?>
                <option value="0"><?php echo $text_authorization; ?></option>
                <?php } ?>
                <?php if ($pp_express_method) { ?>
                <option value="1" selected="selected"><?php echo $text_sale; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_sale; ?></option>
                <?php } ?>
              </select></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></div>
            <div class="controls"><input type="text" name="pp_express_total" value="<?php echo $pp_express_total; ?>"></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></div>
            <div class="controls"><select name="pp_express_order_status_id" class="span2">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $pp_express_order_status_id) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></div>
            <div class="controls"><select name="pp_express_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
                <?php foreach ($geo_zones as $geo_zone) { ?>
                <?php if ($geo_zone['geo_zone_id'] == $pp_express_geo_zone_id) { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></div>
            <div class="controls"><select name="pp_express_status" class="span2">
                <?php if ($pp_express_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></div>
            <div class="controls"><input type="text" name="pp_express_sort_order" value="<?php echo $pp_express_sort_order; ?>" class="span1 i-mini"></div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>