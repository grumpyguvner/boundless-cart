<?php echo $header; ?>
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
</div>
<div id="notification">
    <?php if (isset($success) && $success) { ?>
        <div class="success"><?php echo $success; ?></div>
    <?php }
    if (isset($error_warning) && $error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php }
    ?>
</div>

<div id="content-back">
    <div class="green-bar">
        <div id="accountNoImage"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content"> 
                <?php echo $content_top; ?>
                <div class="content-account">
                    <h1><?php echo $heading_title; ?></h1>
                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                        <h2><?php echo $text_password; ?></h2>

                        <div class="wrapContentAccount content">
                            <div class="prow">
                                <div class="pLabel">
                                    <span class="required">*</span> <span><?php echo $entry_password; ?></span>
                                </div>
                                <div class="pInput">
                                    <input type="password" name="password" value="<?php echo $password; ?>" />
                                    <?php if ($error_password) { ?>
                                        <span class="error"><?php echo $error_password; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="prow">
                                <div class="pLabel">
                                    <span class="required">*</span> <span><?php echo $entry_confirm; ?></span>
                                </div>
                                <div class="pInput">
                                    <input type="password" name="confirm" value="<?php echo $confirm; ?>" />
                                    <?php if ($error_confirm) { ?>
                                        <span class="error"><?php echo $error_confirm; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                        
                        <div class="buttons">
                            <div class="buttonLeft"><a href="<?php echo $back; ?>" class="button"><?php echo strtoupper($button_back); ?></a></div>
                            <div class="buttonRight"><input type="submit" value="<?php echo strtoupper($button_continue); ?>" class="button" /></div>
                        </div>
                        
                    </form>
                </div>
                <?php echo $content_bottom; ?>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>