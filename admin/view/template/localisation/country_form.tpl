<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

		<div class="heading">
      <h1><i class="icon-globe"></i> <?php echo $heading_title; ?></h1>
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
        <table class="form">
          <div class="control-group<?php if ($error_name) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
            <div class="controls">
							<input type="text" name="name" value="<?php echo $name; ?>" class="span4">
              <?php if ($error_name) { ?>
              <span class="error help-block"><?php echo $error_name; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_iso_code_2; ?></label>
            <div class="controls">
							<input type="text" name="iso_code_2" value="<?php echo $iso_code_2; ?>" class="span1">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_iso_code_3; ?></label>
            <div class="controls">
							<input type="text" name="iso_code_3" value="<?php echo $iso_code_3; ?>" class="span1">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_address_format; ?></label>
            <div class="controls">
							<textarea name="address_format" class="span6 i-xxlarge" rows="8"><?php echo $address_format; ?></textarea>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_postcode_required; ?></label>
            <div class="controls">
							<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
							<?php echo p3html::tb_bool_buttons_radio($this->language, 'postcode_required', $postcode_required); ?>
							<?php } else { ?>
							<?php echo p3html::tb_bool_radio_buttons($this->language, 'postcode_required', $postcode_required); ?>
							<?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="status" class="span2">
								<?php echo p3html::oc_status_options($this->language, $status); ?>
              </select>
						</div>
          </div>
        </div>
      </form>

    </div>
  </div>
</div>

<?php echo $footer; ?>