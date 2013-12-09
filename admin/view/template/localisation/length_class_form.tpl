<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-compass"></i> <?php echo $heading_title; ?></h1>
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
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_title; ?></label>
            <div class="controls">
							<?php foreach ($languages as $language) { ?>
							<div class="language-row<?php if (isset($error_title[$language['language_id']])) { ?> error<?php } ?>">
								<input type="text" name="length_class_description[<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($length_class_description[$language['language_id']]) ? $length_class_description[$language['language_id']]['title'] : ''; ?>" class="span2">
								<i class="flag flag-<?php echo $language['code'];?>"></i>
								<?php if (isset($error_title[$language['language_id']])) { ?>
								<span class="error help-block"><?php echo $error_title[$language['language_id']]; ?></span>
								<?php } ?>
							</div>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_unit; ?></label>
            <div class="controls">
							<?php foreach ($languages as $language) { ?>
							<div class="language-row<?php if (isset($error_unit[$language['language_id']])) { ?> error<?php } ?>">
								<input type="text" name="length_class_description[<?php echo $language['language_id']; ?>][unit]" value="<?php echo isset($length_class_description[$language['language_id']]) ? $length_class_description[$language['language_id']]['unit'] : ''; ?>" class="span1">
								<i class="flag flag-<?php echo $language['code'];?>"></i>
								<?php if (isset($error_unit[$language['language_id']])) { ?>
								<span class="error help-block"><?php echo $error_unit[$language['language_id']]; ?></span>
								<?php } ?>
							</div>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_value; ?></label>
            <div class="controls"><input type="text" name="value" value="<?php echo $value; ?>" class="span2"></div>
          </div>
        </div>
      </form>

    </div>
  </div>
</div>

<?php echo $footer; ?>