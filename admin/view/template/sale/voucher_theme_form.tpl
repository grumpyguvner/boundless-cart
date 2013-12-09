<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">
    <div class="heading">
      <h1><i class="icon-ticket"></i> <?php echo $heading_title; ?></h1>
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
            <div class="controls">
							<?php foreach ($languages as $language) { ?>
							<div class="language-row<?php if (isset($error_name[$language['language_id']])) { ?> error<?php } ?>">
								<input type="text" name="voucher_theme_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($voucher_theme_description[$language['language_id']]) ? $voucher_theme_description[$language['language_id']]['name'] : ''; ?>">
								<i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i>
								<?php if (isset($error_name[$language['language_id']])) { ?>
								<span class="error help-block"><?php echo $error_name[$language['language_id']]; ?></span>
								<?php } ?>
							</div>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_image; ?></label>
            <div class="controls">
							<div class="image">
								<img src="<?php echo $thumb; ?>" alt="" id="thumb">
                <input type="hidden" name="image" value="<?php echo $image; ?>" id="image">
								<br><br>
								<a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('image', 'thumb');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>
								<a class="btn" title="<?php echo $text_clear; ?>" onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>
							</div>
              <?php if ($error_image) { ?>
              <span class="error help-block"><?php echo $error_image; ?></span>
              <?php } ?>
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

<!--FILEMANAGER-->
<?php include_once DIR_TEMPLATE.'javascript/filemanager_dialog.tpl'; ?>
<!--FILEMANAGER-->

<?php echo $footer; ?>