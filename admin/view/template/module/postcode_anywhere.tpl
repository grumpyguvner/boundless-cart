<?php echo $header; ?>
<div id="content">
    
    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>
    
    <?php if ($error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <div class="box">
        <div class="heading">
    <h1><i class="icon-cogs"></i> <?php echo $heading_title; ?></h1>
    <?php if ($error_warning) { ?>
        <?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
    <?php } ?>
    <div class="buttons form-actions form-actions-top">
        <?php echo p3html::tb_form_button_save($button_save); ?>
        <?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
    </div>
        <div class="content">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
              <div class="form">  
                <div class="control-group">
                        <label class="control-label"><?php echo $entry_status; ?></label>
                        <div class="controls">
                            <select name="postcode_anywhere_status">
                                    <?php echo p3html::oc_status_options($this->language, $postcode_anywhere_status); ?>
                            </select>
                        </div>
                </div>
                <div class="control-group">
                        <label class="control-label"><?php echo $entry_account_code; ?></label>
                        <div class="controls">
                            <input type="text" name="postcode_anywhere_account_code" value="<?php echo $postcode_anywhere_account_code; ?>" />
                        </div>
                </div> 
                <div class="control-group">
                        <label class="control-label"><?php echo $entry_key; ?></label>
                        <div class="controls">
                            <input type="text" name="postcode_anywhere_key" value="<?php echo $postcode_anywhere_key; ?>" />
                        </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><?php echo $entry_check_credit; ?></label>
                    <div class="controls">
                        <?php if ($this->config->get('postcode_anywhere_check_credit')) { ?>
                            <?php echo p3html::tb_bool_buttons_radio($this->language, 'postcode_anywhere_check_credit', $postcode_anywhere_check_credit); ?>
                        <?php } else { ?>
                            <?php echo p3html::tb_bool_buttons_radio($this->language, 'postcode_anywhere_check_credit', $postcode_anywhere_check_credit); ?>
                        <?php } ?>
                    </div>
                </div>
                <div class="control-group">
                  <label class="control-label"><?php echo $entry_geolocation; ?></label>
                  <div class="controls">
                      <?php if ($this->config->get('postcode_anywhere_geolocation')) { ?>
                          <?php echo p3html::tb_bool_buttons_radio($this->language, 'postcode_anywhere_geolocation', $postcode_anywhere_geolocation); ?>
                      <?php } else { ?>
                          <?php echo p3html::tb_bool_buttons_radio($this->language, 'postcode_anywhere_geolocation', $postcode_anywhere_geolocation); ?>
                      <?php } ?>
                  </div>
                </div>
                <?php
                if ($this->user->isSuperuser())
                {
                ?>  
                <div class="control-group">
                    <label class="control-label"><?php echo $entry_cache; ?></label>
                    <div class="controls">
                        <select name="postcode_anywhere_cache">
                             <?php
                             if ($postcode_anywhere_cache) {
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
                <div class="control-group">
                    <label class="control-label"><?php echo $entry_cache_expire; ?></label>
                    <div class="controls">
                        <input type="text" name="postcode_anywhere_cache_expire" value="<?php echo $postcode_anywhere_cache_expire; ?>" />
                    </div>
                </div>  
                <?php
                  } else {
                      echo '<input type="hidden" name="postcode_anywhere_cache" value="<?php echo $postcode_anywhere_cache; ?>" />';
                      echo '<input type="hidden" name="postcode_anywhere_cache_expire" value="<?php echo $postcode_anywhere_cache_expire; ?>" />';
                  }
                  ?>
                  
              </div>
            </form>
        </div>
    </div>
