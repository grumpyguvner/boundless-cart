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
          <div class="control-group<?php if ($error_name) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
            <div class="controls">
							<input type="text" name="name" value="<?php echo $name; ?>" class="span3">
              <?php if ($error_name) { ?>
              <span class="error help-block"><?php echo $error_name; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_rate) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_rate; ?></label>
            <div class="controls">
							<input type="text" name="rate" value="<?php echo $rate; ?>" class="span2">
              <?php if ($error_rate) { ?>
              <span class="error help-block"><?php echo $error_rate; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_type; ?></label>
            <div class="controls">
							<select name="type" class="span2">
								<?php echo p3html::oc_rate_type_options($this->language, $type); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_customer_group; ?></label>
            <div class="controls">
							<div class="scrollbox">
                <?php $class = 'even'; ?>
                <?php foreach ($customer_groups as $customer_group) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
                  <?php $checked = (in_array($customer_group['customer_group_id'], $tax_rate_customer_group)); ?>
									<label class="checkbox inline">
										<input type="checkbox" name="tax_rate_customer_group[]" value="<?php echo $customer_group['customer_group_id']; ?>"<?php if ($checked) { ?> checked="checked"<?php } ?>>
										<?php echo $customer_group['name']; ?>
									</label>
                </div>
                <?php } ?>
              </div>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="geo_zone_id" class="span3">
								<?php echo p3html::oc_geo_zone_options($geo_zones, $geo_zone_id); ?>
              </select>
						</div>
          </div>
        </div>
      </form>

    </div>
  </div>
</div>

<?php echo $footer; ?>