<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">
    <div class="heading">
      <h1><i class="truck"></i> <?php echo $heading_title; ?></h1>
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
          <div class="control-group<?php if ($error_postcode) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_postcode; ?></label>
            <div class="controls">
							<input type="text" name="auspost_postcode" class="span1 i-small" maxlength="4" value="<?php echo $auspost_postcode; ?>">
              <?php if ($error_postcode) { ?>
              <span class="error help-block"><?php echo $error_postcode; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_standard ?></label>
            <div class="controls">
							<select name="auspost_standard" class="span2 i-small">
								<?php echo p3html::oc_status_options($this->language, (int)$auspost_standard); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_express ?></label>
            <div class="controls">
							<select name="auspost_express" class="span2 i-small">
								<?php echo p3html::oc_status_options($this->language, (int)$auspost_express); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_display_time ?></label>
            <div class="controls">
							<select name="auspost_display_time" class="span2 i-small">
								<?php echo p3html::oc_status_options($this->language, (int)$auspost_display_time); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_weight_class; ?></label>
            <div class="controls">
							<select name="auspost_weight_class_id" class="span2">
								<?php echo p3html::oc_weight_class_options($weight_classes, $auspost_weight_class_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_tax_class; ?></label>
            <div class="controls">
							<select name="auspost_tax_class_id" class="span3">
                <option value="0"><?php echo $text_none; ?></option>
								<?php echo p3html::oc_tax_class_options($tax_classes, $auspost_tax_class_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="auspost_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $auspost_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status ?></label>
            <div class="controls">
							<select name="auspost_status" class="span2 i-small">
								<?php echo p3html::oc_status_options($this->language, (int)$auspost_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="auspost_sort_order" value="<?php echo $auspost_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

<?php echo $footer; ?>