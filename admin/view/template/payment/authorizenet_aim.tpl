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
          <div class="control-group<?php if ($error_login) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_login; ?></label>
            <div class="controls">
							<input type="text" name="authorizenet_aim_login" value="<?php echo $authorizenet_aim_login; ?>" class="span3">
              <?php if ($error_login) { ?>
              <span class="error help-block"><?php echo $error_login; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_key) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_key; ?></label>
            <div class="controls">
							<input type="text" name="authorizenet_aim_key" value="<?php echo $authorizenet_aim_key; ?>" class="span3">
              <?php if ($error_key) { ?>
              <span class="error help-block"><?php echo $error_key; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_hash; ?></label>
            <div class="controls"><input type="text" name="authorizenet_aim_hash" value="<?php echo $authorizenet_aim_hash; ?>"></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_server; ?></label>
            <div class="controls">
							<select name="authorizenet_aim_server" class="span2">
                <option value="live"<?php if ($authorizenet_aim_server == 'live') { ?> selected="selected"<?php } ?>><?php echo $text_live; ?></option>
                <option value="test" <?php if ($authorizenet_aim_server == 'test') { ?> selected="selected"<?php } ?>><?php echo $text_test; ?></option>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_mode; ?></label>
            <div class="controls">
							<select name="authorizenet_aim_mode" class="span2">
                <option value="live"<?php if ($authorizenet_aim_mode == 'live') { ?> selected="selected"<?php } ?>><?php echo $text_live; ?></option>
                <option value="test"<?php if ($authorizenet_aim_mode == 'test') { ?> selected="selected"<?php } ?>><?php echo $text_test; ?></option>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_method; ?></label>
            <div class="controls">
							<select name="authorizenet_aim_method" class="span2">
                <option value="authorization"<?php if ($authorizenet_aim_method == 'authorization') { ?> selected="selected"<?php } ?>><?php echo $text_authorization; ?></option>
                <option value="capture"<?php if ($authorizenet_aim_method == 'capture') { ?> selected="selected"<?php } ?>><?php echo $text_capture; ?></option>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></label>
            <div class="controls">
							<input type="text" name="authorizenet_aim_total" value="<?php echo $authorizenet_aim_total; ?>"></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></label>
            <div class="controls">
							<select name="authorizenet_aim_order_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $authorizenet_aim_order_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="authorizenet_aim_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $authorizenet_aim_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="authorizenet_aim_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$authorizenet_aim_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="authorizenet_aim_sort_order" value="<?php echo $authorizenet_aim_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

<?php echo $footer; ?>