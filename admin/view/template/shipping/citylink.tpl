<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-truck"></i> <?php echo $heading_title; ?></h1>
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
            <label class="control-label"><?php echo $entry_rate; ?></label>
            <div class="controls">
							<textarea name="citylink_rate" class="span6 i-xxlarge" rows="5"><?php echo $citylink_rate; ?></textarea>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_tax_class; ?></label>
            <div class="controls">
							<select name="citylink_tax_class_id" class="span3">
                <option value="0"><?php echo $text_none; ?></option>
								<?php echo p3html::oc_tax_class_options($tax_classes, $citylink_tax_class_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="citylink_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $citylink_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="citylink_status" class="span2 i-small">
								<?php echo p3html::oc_status_options($this->language, (int)$citylink_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="citylink_sort_order" value="<?php echo $citylink_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>

    </div>
  </div>
</div>

<?php echo $footer; ?>