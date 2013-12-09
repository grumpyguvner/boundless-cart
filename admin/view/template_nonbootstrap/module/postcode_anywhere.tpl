<?php echo $header; ?>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <?php if ($error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
            <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
        </div>
        <div class="content">
            <form action="<?php echo $action; ?>" method="post" id="form">
                <table class="form">
                    <tr>
                        <td><?php echo $entry_status; ?></td>
                        <td><select name="postcode_anywhere_status">
                                <?php
                                if ($postcode_anywhere_status) {
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
                            </select></td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_account_code; ?></td>
                        <td><input type="text" name="postcode_anywhere_account_code" value="<?php echo $postcode_anywhere_account_code; ?>" /></td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_key; ?></td>
                        <td><input type="text" name="postcode_anywhere_key" value="<?php echo $postcode_anywhere_key; ?>" /></td>
                 </tr>
  <!--                  <tr>
                        <td><?php echo $entry_international; ?></td>
                        <td><?php if ($postcode_anywhere_international) { ?>
                          <input type="radio" name="postcode_anywhere_international" value="1" checked="checked" />
                          <?php echo $text_yes; ?>
                          <input type="radio" name="postcode_anywhere_international" value="0" />
                          <?php echo $text_no; ?>
                          <?php } else { ?>
                          <input type="radio" name="postcode_anywhere_international" value="1" />
                          <?php echo $text_yes; ?>
                          <input type="radio" name="postcode_anywhere_international" value="0" checked="checked" />
                          <?php echo $text_no; ?>
                          <?php } ?></td>
                    </tr>-->
                    <tr>
                        <td><?php echo $entry_check_credit; ?></td>
                        <td><?php if ($postcode_anywhere_check_credit) { ?>
                          <input type="radio" name="postcode_anywhere_check_credit" value="1" checked="checked" />
                          <?php echo $text_yes; ?>
                          <input type="radio" name="postcode_anywhere_check_credit" value="0" />
                          <?php echo $text_no; ?>
                          <?php } else { ?>
                          <input type="radio" name="postcode_anywhere_check_credit" value="1" />
                          <?php echo $text_yes; ?>
                          <input type="radio" name="postcode_anywhere_check_credit" value="0" checked="checked" />
                          <?php echo $text_no; ?>
                          <?php } ?></td>
                    </tr>
                    
                 <tr>
                        <td><?php echo $entry_geolocation; ?></td>
                        <td><?php if ($postcode_anywhere_geolocation) { ?>
                          <input type="radio" name="postcode_anywhere_geolocation" value="1" checked="checked" />
                          <?php echo $text_yes; ?>
                          <input type="radio" name="postcode_anywhere_geolocation" value="0" />
                          <?php echo $text_no; ?>
                          <?php } else { ?>
                          <input type="radio" name="postcode_anywhere_geolocation" value="1" />
                          <?php echo $text_yes; ?>
                          <input type="radio" name="postcode_anywhere_geolocation" value="0" checked="checked" />
                          <?php echo $text_no; ?>
                          <?php } ?></td>
                    </tr>
                    <?php
                    if ($this->user->isSuperuser())
                    {
                    ?>
                    <tr>
                        <td><?php echo $entry_cache; ?></td>
                        <td><select name="postcode_anywhere_cache">
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
                            </select></td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_cache_expire; ?></td>
                        <td><input type="text" name="postcode_anywhere_cache_expire" value="<?php echo $postcode_anywhere_cache_expire; ?>" /></td>
                    </tr>
                    <?php
                    } else {
                        echo '<input type="hidden" name="postcode_anywhere_cache" value="<?php echo $postcode_anywhere_cache; ?>" />';
                        echo '<input type="hidden" name="postcode_anywhere_cache_expire" value="<?php echo $postcode_anywhere_cache_expire; ?>" />';
                    }
                    ?>
                </table>
            </form>
        </div>
    </div>
