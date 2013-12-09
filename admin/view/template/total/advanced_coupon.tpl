<?php echo $header; ?>
<div id="content">
     
<?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>
  
  <div class="box">
    <div class="heading">
    <h1><img src="view/image/total.png" alt="" /> <?php echo $heading_title; ?></h1>
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
                <select name="advanced_coupon_status" class="input-small">
                    <?php echo p3html::oc_status_options($this->language, $advanced_coupon_status); ?>
                </select>
            </div>
        </div> 
        <div class="control-group">
            <label class="control-label"><?php echo $entry_multiple; ?></label>
            <div class="controls">
                <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                    <?php echo p3html::tb_bool_buttons_radio($this->language, 'advanced_coupon_multiple', $advanced_coupon_multiple); ?>
                <?php } else { ?>
                    <?php echo p3html::tb_bool_radio_buttons($this->language, 'advanced_coupon_multiple', $advanced_coupon_multiple); ?>
                <?php } ?>
            </div>
        </div>   
        <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
                <input type="text" name="advanced_coupon_sort_order" value="<?php echo $advanced_coupon_sort_order; ?>" class="span1 i-mini">        
            </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>