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
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_merchant; ?></label>
            <div class="controls">
							<input type="text" name="liqpay_merchant" value="<?php echo $liqpay_merchant; ?>" class="span3">
              <?php if ($error_merchant) { ?>
              <span class="error help-block"><?php echo $error_merchant; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_signature) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_signature; ?></label>
            <div class="controls">
							<input type="text" name="liqpay_signature" value="<?php echo $liqpay_signature; ?>" class="span3">
              <?php if ($error_signature) { ?>
              <span class="error help-block"><?php echo $error_signature; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_type; ?></label>
            <div class="controls">
							<select name="liqpay_type" class="span2">
                <option value="liqpay"<?php if ($liqpay_type == 'liqpay') { ?> selected="selected"<?php } ?>><?php echo $text_pay; ?></option>
                <option value="card"<?php if ($liqpay_type == 'card') { ?> selected="selected"<?php } ?>><?php echo $text_card; ?></option>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></label>
            <div class="controls">
							<input type="text" name="liqpay_total" value="<?php echo $liqpay_total; ?>" class="span2">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></label>
            <div class="controls">
							<select name="liqpay_order_status_id" class="span2">
								<?php echo p3html::oc_order_status_options($order_statuses, $liqpay_order_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="liqpay_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $liqpay_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="liqpay_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$liqpay_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="liqpay_sort_order" value="<?php echo $liqpay_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>