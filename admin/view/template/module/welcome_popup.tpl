<?php echo $header; ?>
<div id="content">
  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
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
                    <label class="control-label"><?php echo $entry_status; ?></label>
                    <div class="controls">
                        <select name="welcome_popup_status" class="input-medium">
                            <?php
                            if ($welcome_popup_status) {
                                ?>
                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                <option value="0"><?php echo $text_disabled; ?></option>
                                <?php
                            } else {
                                ?>
                                <option value="1"><?php echo $text_enabled; ?></option>
                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php
                            } // end if 
                            ?>
                        </select>
                    </div>
                </div>
            </div>
            <div class="tab-pane active" id="tab-general">
                <ul id="languages" class="htabs nav nav-tabs">
                    <?php $langIndex = 0; ?>
                    <?php foreach ($languages as $language) { ?>
                        <li<?php if ($langIndex == 0) { ?> class="active"<?php } ?>>
                            <a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab">
                                <i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i>
                                <?php echo $language['name']; ?>
                            </a>
                        <li>
                            <?php $langIndex++; ?>
                        <?php } ?>
                </ul>
                <div class="tab-content">
                    <?php $langIndex = 0; ?>
                    <?php foreach ($languages as $language) { ?>
                        <div class="tab-pane<?php if ($langIndex == 0) { ?> active<?php } ?>" id="language<?php echo $language['language_id']; ?>">
                            <div class="form">

                                <div class="control-group">
                                    <label class="control-label"><?php echo $entry_content; ?></label>
                                    <div class="controls">
                                        <textarea name="welcome_popup_content[<?php echo $language['language_id']; ?>][content]" id="content<?php echo $language['language_id']; ?>" class="input-block-level"><?php echo isset($welcome_popup_content[$language['language_id']]) ? $welcome_popup_content[$language['language_id']]['content'] : ''; ?></textarea>
                                    </div>
                                </div>                            
                                    
                            </div>
                        </div>
                        <?php $langIndex++; ?>
                    <?php } ?>
                </div>
            </div>
            
            <div class="form">
                <div class="control-group">
                    <label class="control-label"><?php echo $entry_reset_cookie; ?></label>
                    <div class="controls">
                        <select name="welcome_popup_reset_cookie">
                            <?php
                            if ($welcome_popup_reset_cookie) {
                                ?>
                                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                                <option value="0"><?php echo $text_no; ?></option>
                                <?php
                            } else {
                                ?>
                                <option value="1"><?php echo $text_yes; ?></option>
                                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                                <?php
                            } // end if 
                            ?>
                        </select>
                        <input type="hidden" name="welcome_popup_timestamp" value="<?php echo time(); ?>" />
                    </div>
                </div>
            </div>    
            
            
        </form>
    </div>
  </div>
</div>
<!--CKEDITOR-->
<script src="<?php echo P3_CKEDITOR_DIR; ?>/ckeditor.js"></script>
<script>
<?php foreach ($languages as $language) { ?>
    <?php echo p3html::oc_ckeditor_replace('content' . $language['language_id'], $token); ?>
<?php } ?>
</script>
<!--CKEDITOR-->

<?php echo $footer; ?>