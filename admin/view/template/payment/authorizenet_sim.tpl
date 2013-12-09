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
          <div class="control-group<?php if ($error_merchant) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_merchant; ?></div>
            <div class="controls">
							<input type="text" name="authorizenet_merchant" value="<?php echo $authorizenet_merchant; ?>">
              <?php if ($error_merchant) { ?>
              <span class="error help-block"><?php echo $error_merchant; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_key) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_key ?></div>
            <div class="controls">
							<input type="text" name="authorizenet_key" value="<?php echo $authorizenet_key; ?>">
              <?php if ($error_key) { ?>
              <span class="error help-block"><?php echo $error_key; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_callback; ?></div>
            <div class="controls"><textarea class="span6 i-xxlarge" rows="5"><?php echo $callback; ?></textarea></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_test; ?></div>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'authorizenet_test', $authorizenet_test); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'pp_express_test', $authorizenet_test); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></div>
            <div class="controls">
							<input type="text" name="authorizenet_total" value="<?php echo $authorizenet_total; ?>" class="span2">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></div>
            <div class="controls">
							<select name="authorizenet_order_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $authorizenet_order_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></div>
            <div class="controls">
							<select name="authorizenet_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $authorizenet_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></div>
            <div class="controls">
							<select name="authorizenet_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$authorizenet_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></div>
            <div class="controls">
							<input type="text" name="authorizenet_sort_order" value="<?php echo $authorizenet_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>