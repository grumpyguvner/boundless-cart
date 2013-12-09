<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-flag"></i> <?php echo $heading_title; ?></h1>
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
          <div class="control-group<?php if ($error_code) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_code; ?></label>
            <div class="controls">
							<input type="text" name="code" value="<?php echo $code; ?>" class="span1">
              <?php if ($error_code) { ?>
              <span class="error help-block"><?php echo $error_code; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_locale) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_locale; ?></label>
            <div class="controls">
							<input type="text" name="locale" value="<?php echo $locale; ?>" class="span4">
              <?php if ($error_locale) { ?>
              <span class="error help-block"><?php echo $error_locale; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_image) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_image; ?></label>
            <div class="controls">
							<input type="text" name="image" value="<?php echo $image; ?>" class="span2">
              <?php if ($error_image) { ?>
              <span class="error help-block"><?php echo $error_image; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_directory) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_directory; ?></label>
            <div class="controls">
							<input type="text" name="directory" value="<?php echo $directory; ?>" class="span2">
              <?php if ($error_directory) { ?>
              <span class="error help-block"><?php echo $error_directory; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_filename) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_filename; ?></label>
            <div class="controls">
							<input type="text" name="filename" value="<?php echo $filename; ?>" class="span2">
              <?php if ($error_filename) { ?>
              <span class="error help-block"><?php echo $error_filename; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="status" class="span2">
								<?php echo p3html::oc_status_options($this->language, $status) ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls"><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" class="span1 i-mini"></div>
          </div>
        </div>
      </form>

    </div>
  </div>
</div>
<?php echo $footer; ?>