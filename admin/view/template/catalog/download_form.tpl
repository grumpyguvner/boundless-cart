<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-download"></i> <?php echo $heading_title; ?></h1>

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
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
						<?php foreach ($languages as $language) { ?>
            <div class="controls language-row<?php if (isset($error_name[$language['language_id']])) { ?> error<?php } ?>">
              <input type="text" name="download_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($download_description[$language['language_id']]) ? $download_description[$language['language_id']]['name'] : ''; ?>" class="span4">
              <i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i>
              <?php if (isset($error_name[$language['language_id']])) { ?>
              <span class="error help-block"><?php echo $error_name[$language['language_id']]; ?></span>
              <?php } ?>
						</div>
						<?php } ?>
          </div>
          <div class="control-group<?php if ($error_filename) { ?> error<?php } ?>">
            <label class="control-label"><?php echo $entry_filename; ?></label>
            <div class="controls">
							<input type="text" name="filename" value="<?php echo $filename; ?>" class="span5"> <a id="button-upload" class="btn"><?php echo $button_upload; ?></a>
              <?php if ($error_filename) { ?>
              <span class="error help-block"><?php echo $error_filename; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_mask) { ?> error<?php } ?>">
            <label class="control-label"><?php echo $entry_mask; ?></label>
            <div class="controls">
							<input type="text" name="mask" value="<?php echo $mask; ?>" class="span4">
              <?php if ($error_mask) { ?>
              <span class="error help-block"><?php echo $error_mask; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_remaining; ?></label>
            <div class="controls"><input type="text" name="remaining" value="<?php echo $remaining; ?>"  class="span1"></div>
          </div>
          <?php if ($download_id) { ?>
          <div class="control-group">
            <label class="control-label" for="download-update"><?php echo $entry_update; ?></label>
            <div class="controls">
              <input type="checkbox" id="download-update" name="update" value="1"<?php if ($update) { ?> checked="checked"<?php } ?>>
						</div>
          </div>
          <?php } ?>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="view/javascript/jquery/ajaxupload.js"></script>
<script>
new AjaxUpload('#button-upload', {
	action: 'index.php?route=catalog/download/upload&token=<?php echo $token; ?>',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-upload').after('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;">');
		$('#button-upload').attr('disabled', true);
	},
	onComplete: function(file, json) {
		$('#button-upload').attr('disabled', false);

		if (json['success']) {
			alert(json['success']);

			$('input[name=\'filename\']').attr('value', json['filename']);
			$('input[name=\'mask\']').attr('value', json['mask']);
		}

		if (json['error']) {
			alert(json['error']);
		}

		$('.loading').remove();
	}
});
</script>

<?php echo $footer; ?>