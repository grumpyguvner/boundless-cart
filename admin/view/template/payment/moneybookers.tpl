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
            <label class="control-label"><?php echo $entry_email; ?></label>
            <div class="controls">
							<input type="text" name="moneybookers_email" value="<?php echo $moneybookers_email; ?>" class="span3">
              <?php if ($error_email) { ?>
              <span class="error help-block"><?php echo $error_email; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_secret; ?></label>
            <div class="controls">
							<input type="text" name="moneybookers_secret" value="<?php echo $moneybookers_secret; ?>" class="span3">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></label>
            <div class="controls">
							<input type="text" name="moneybookers_total" value="<?php echo $moneybookers_total; ?>" class="span2">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></label>
            <div class="controls">
							<select name="moneybookers_order_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $moneybookers_order_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_pending_status; ?></label>
            <div class="controls">
							<select name="moneybookers_pending_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $moneybookers_pending_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_canceled_status; ?></label>
            <div class="controls">
							<select name="moneybookers_canceled_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $moneybookers_canceled_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_failed_status; ?></label>
            <div class="controls">
							<select name="moneybookers_failed_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $moneybookers_failed_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_chargeback_status; ?></label>
            <div class="controls">
							<select name="moneybookers_chargeback_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $moneybookers_chargeback_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="moneybookers_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $moneybookers_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="moneybookers_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$moneybookers_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="moneybookers_sort_order" value="<?php echo $moneybookers_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>