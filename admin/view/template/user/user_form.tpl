<?php echo $header; ?>

<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <div class="box">

        <div class="heading">
            <h1><i class="icon-user"></i> <?php echo $heading_title; ?></h1>
            <?php if ($error_warning) { ?>
                <?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
            <?php } ?>
            <div class="buttons form-actions form-actions-top">
                <?php
                if (!$is_superuser || $this->user->isSuperuser()) {
                    echo p3html::tb_form_button_save($button_save);
                    echo p3html::tb_form_button_cancel($button_cancel, $cancel);
                } else {
                    echo p3html::tb_form_button($button_back, "location = '$cancel';", null, 'back');
                }
                ?>
            </div>
        </div>

        <div class="content">

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
                <?php
                if (!$is_superuser || $this->user->isSuperuser()) {
                    ?>
                    <div class="form">
                        <div class="control-group<?php if ($error_username) { ?> error<?php } ?>">
                            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_username; ?></label>
                            <div class="controls">
                                <input type="text" name="username" value="<?php echo $username; ?>" class="span2">
                                <?php if ($error_username) { ?>
                                    <span class="error help-block"><?php echo $error_username; ?></span>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="control-group<?php if ($error_firstname) { ?> error<?php } ?>">
                            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_firstname; ?></label>
                            <div class="controls">
                                <input type="text" name="firstname" value="<?php echo $firstname; ?>" class="span3">
                                <?php if ($error_firstname) { ?>
                                    <span class="error help-block"><?php echo $error_firstname; ?></span>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="control-group<?php if ($error_lastname) { ?> error<?php } ?>">
                            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_lastname; ?></label>
                            <div class="controls">
                                <input type="text" name="lastname" value="<?php echo $lastname; ?>" class="span3">
                                <?php if ($error_lastname) { ?>
                                    <span class="error help-block"><?php echo $error_lastname; ?></span>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><?php echo $entry_email; ?></label>
                            <div class="controls"><input type="text" name="email" value="<?php echo $email; ?>" class="span4"></div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><?php echo $entry_user_group; ?></label>
                            <div class="controls">
                                <select name="user_group_id">
                                    <?php echo p3html::oc_user_group_options($user_groups, $user_group_id); ?>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><?php echo $entry_password; ?></label>
                            <div class="controls">
                                <input type="password" name="password" value="<?php echo $password; ?>" class="span2">
                                <?php if ($error_password) { ?>
                                    <span class="error help-block"><?php echo $error_password; ?></span>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><?php echo $entry_confirm; ?></label>
                            <div class="controls">
                                <input type="password" name="confirm" value="<?php echo $confirm; ?>" class="span2">
                                <?php if ($error_confirm) { ?>
                                    <span class="error help-block"><?php echo $error_confirm; ?></span>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><?php echo $entry_status; ?></label>
                            <div class="controls">
                                <select name="status" class="span2">
                                    <?php echo p3html::oc_status_options($this->language, $status); ?>
                                </select>
                            </div>
                        </div>
                    </div>
                    <?php
                } else {
                    ?>
                    <div class="control-group">
                        <label class="control-label"><?php echo $entry_firstname; ?></label>
                        <div class="controls">
                            <?php echo $firstname; ?>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"><?php echo $entry_lastname; ?></label>
                        <div class="controls">
                            <?php echo $lastname; ?>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"><?php echo $entry_email; ?></label>
                        <div class="controls">
                            <?php echo $email; ?>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"><?php echo $entry_user_group; ?></label>
                        <div class="controls">
                            <?php echo $user_group_name; ?>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"><?php echo $entry_status; ?></label>
                        <div class="controls">
                            <?php echo ($status) ? $text_enabled : $text_disabled; ?>
                        </div>
                    </div>

                    <?php
                }
                ?>

            </form>

        </div>
    </div>
</div>

<?php echo $footer; ?>