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
          <div class="control-group">
            <label class="control-label"><?php echo $entry_code; ?></label>
            <div class="controls"><input type="text" name="code" value="<?php echo $code; ?>" class="span1"></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_country; ?></label>
            <div class="controls">
							<select name="country_id" class="span3">
								<?php echo p3html::oc_country_options($countries, $country_id); ?>
              </select>
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