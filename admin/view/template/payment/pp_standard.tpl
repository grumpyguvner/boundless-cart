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
          <div class="control-group<?php if ($error_email) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_email; ?></label>
            <div class="controls">
							<input type="text" name="pp_standard_email" value="<?php echo $pp_standard_email; ?>">
              <?php if ($error_email) { ?>
              <span class="error help-block"><?php echo $error_email; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_test; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'pp_standard_test', $pp_standard_test); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'pp_standard_test', $pp_standard_test); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_transaction; ?></label>
            <div class="controls">
							<select name="pp_standard_transaction" class="span2">
                <option value="0" <?php if (!$pp_standard_transaction) { ?> selected="selected"<?php } ?>><?php echo $text_authorization; ?></option>
                <option value="1" <?php if ($pp_standard_transaction) { ?> selected="selected"<?php } ?>><?php echo $text_sale; ?></option>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_debug; ?></label>
            <div class="controls">
							<select name="pp_standard_debug" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$pp_standard_debug); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></label>
            <div class="controls">
							<input type="text" name="pp_standard_total" value="<?php echo $pp_standard_total; ?>">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_canceled_reversal_status; ?></label>
            <div class="controls">
							<select name="pp_standard_canceled_reversal_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $pp_standard_canceled_reversal_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_completed_status; ?></label>
            <div class="controls">
							<select name="pp_standard_completed_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $pp_standard_completed_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_denied_status; ?></label>
            <div class="controls">
							<select name="pp_standard_denied_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $pp_standard_denied_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_expired_status; ?></label>
            <div class="controls">
							<select name="pp_standard_expired_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $pp_standard_expired_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_failed_status; ?></label>
            <div class="controls">
							<select name="pp_standard_failed_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $pp_standard_failed_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_pending_status; ?></label>
            <div class="controls">
							<select name="pp_standard_pending_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $pp_standard_pending_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_processed_status; ?></label>
            <div class="controls">
							<select name="pp_standard_processed_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $pp_standard_processed_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_refunded_status; ?></label>
            <div class="controls">
							<select name="pp_standard_refunded_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $pp_standard_refunded_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_reversed_status; ?></label>
            <div class="controls">
							<select name="pp_standard_reversed_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $pp_standard_reversed_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_voided_status; ?></label>
            <div class="controls">
							<select name="pp_standard_voided_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $pp_standard_voided_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="pp_standard_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $pp_standard_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="pp_standard_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$pp_standard_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="pp_standard_sort_order" value="<?php echo $pp_standard_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>