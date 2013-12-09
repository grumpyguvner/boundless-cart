<?php echo $header; ?>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <?php if ($success) { ?>
        <div class="success"><?php echo $success; ?></div>
    <?php } ?>
    <?php if ($error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
            <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
        </div>
        <div class="content">
            <div class="p3adminForm">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                <table class="form">
                    <tr>
                        <td><?php echo $entry_flavour; ?></td>
                        <td><select name="p3adminrebooted_flavour">
                                <?php foreach ($p3adminrebooted_flavour_options as $p3adminrebooted_flavour_option) { ?>
                                    <?php if ($p3adminrebooted_flavour_option['value'] == $p3adminrebooted_flavour) { ?>
                                        <option value="<?php echo $p3adminrebooted_flavour_option['value']; ?>" selected="selected"><?php echo $p3adminrebooted_flavour_option['label']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $p3adminrebooted_flavour_option['value']; ?>"><?php echo $p3adminrebooted_flavour_option['label']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_jui_full; ?></td>
                        <td><select name="p3adminrebooted_jui_full">
                                <?php foreach ($p3adminrebooted_jui_full_options as $p3adminrebooted_jui_full_option) { ?>
                                    <?php if ($p3adminrebooted_jui_full_option['value'] == $p3adminrebooted_jui_full) { ?>
                                        <option value="<?php echo $p3adminrebooted_jui_full_option['value']; ?>" selected="selected"><?php echo $p3adminrebooted_jui_full_option['label']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $p3adminrebooted_jui_full_option['value']; ?>"><?php echo $p3adminrebooted_jui_full_option['label']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_select2; ?></td>
                        <td>
                            <select name="p3adminrebooted_select2">
                                <?php if ($p3adminrebooted_select2) { ?>
                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                <?php } else { ?>
                                    <option value="1"><?php echo $text_enabled; ?></option>
                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php } ?>
                            </select>
                        </td> 
                    </tr>
                    <tr>
                        <td><?php echo $entry_toggle_buttons; ?></td>
                        <td>
                            <select name="p3adminrebooted_toggle_buttons">
                                <?php if ($p3adminrebooted_toggle_buttons) { ?>
                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                <?php } else { ?>
                                    <option value="1"><?php echo $text_enabled; ?></option>
                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php } ?>
                            </select>
                        </td> 
                    </tr>
                    <tr>
                        <td><?php echo $entry_ckeditor4; ?></td>
                        <td><select name="p3adminrebooted_ckeditor4">
                                <?php foreach ($p3adminrebooted_ckeditor4_options as $p3adminrebooted_ckeditor4_option) { ?>
                                    <?php if ($p3adminrebooted_ckeditor4_option['value'] == $p3adminrebooted_ckeditor4) { ?>
                                        <option value="<?php echo $p3adminrebooted_ckeditor4_option['value']; ?>" selected="selected"><?php echo $p3adminrebooted_ckeditor4_option['label']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $p3adminrebooted_ckeditor4_option['value']; ?>"><?php echo $p3adminrebooted_ckeditor4_option['label']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_menu_highlight; ?></td>
                        <td>
                            <select name="p3adminrebooted_menu_highlight">
                                <?php if ($p3adminrebooted_menu_highlight) { ?>
                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                <?php } else { ?>
                                    <option value="1"><?php echo $text_enabled; ?></option>
                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php } ?>
                            </select>
                        </td> 
                    </tr>
                    <tr>
                        <td><?php echo $entry_hide_helpmenu; ?></td>
                        <td>
                            <select name="p3adminrebooted_hide_helpmenu">
                                <?php if ($p3adminrebooted_hide_helpmenu) { ?>
                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                <?php } else { ?>
                                    <option value="1"><?php echo $text_enabled; ?></option>
                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php } ?>
                            </select>
                        </td> 
                    </tr>
                </table>
            </form>
          </div>
          <div class="form well">
            <h5>ORDER STATUS LABELS</h5>
            <?php if ($osl_installed) { ?>
            <div class="alert alert-success">
                    THIS FEATURE IS INSTALLED!
            </div>
            <?php } else { ?>
                <?php if (isset($error_db_permission)) { ?>
                    <span class="error"><?php echo $error_db_permission; ?></span><br />
                <?php } ?>
                <div class="alert alert-info">
                        <p><strong><i class="icon-attention"></i> This add-on is not installed yet.</strong><p>
                        <p>Before installing make sure your opencart database user has <strong>CREATE PERMISSION</strong>
                                granted and press the following button!
                        <p>
                </div>
            <?php echo p3html::tb_form_button('INSTALL', "location = '$installosl'", 'primary', 'cog'); ?>
            <?php } ?>
        </div>  
      </div>
    </div>
</div>
<?php echo $footer; ?>