<?php echo $header; ?>
<div id="content">
     
<?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>
  
  <div class="box">
    <div class="heading">
    <h1><img src="view/image/feed.png" alt="" /> <?php echo $heading_title; ?></h1>
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
            <div class="control-group">
                <label class="control-label"><?php echo $entry_status; ?></label>
                <div class="controls">
                    <select name="articles_google_base_status" class="input-small">
                        <?php echo p3html::oc_status_options($this->language, $articles_google_base_status); ?>
                    </select>
                </div>
            </div>  
            <div class="control-group">
                <label class="control-label"><?php echo $entry_data_feed; ?></label>
                <div class="controls">
                    <textarea class="scrollbox"><?php echo $data_feed; ?></textarea>
                </div>
            </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>