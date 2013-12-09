<?php echo $header; ?>
<div id="breadcrumb">
    <div class="container">
        <?php
        foreach ($breadcrumbs as $breadcrumb) {
            echo $breadcrumb['separator'] . '<a href="' . $breadcrumb['href'] . '">' . $breadcrumb['text'] . '</a>';
        }
        ?>
    </div>
</div>
<div id="notification">
    <?php if (isset($success) && $success) { ?>
        <div class="success"><?php echo $success; ?></div>
        <?php
    }
    if (isset($error_warning) && $error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
        <?php
    }
    if (isset($attention) && $attention) {
        ?>
        <div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
        <?php
    }
    ?>
</div>
<div id="content-back">
    <div class="green-bar">  
        <div id="infoContainer" class="container"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content">
                <?php echo $content_top; ?>
                    <div id="description-info" class="infoHasImage">
                      <div class="infoDescription">  
                        <h1><?php echo $text_linecontact ?></h1>
                        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                            <div class="text-contact">
                                <p><?php echo $text_titlecontact ?></p>
                                <p id="text-cont"><?php echo $text_contactinfo ?></p>
                            </div>
                            <div id="left" class="contact-name">   
                                <p><b><?php echo $entry_name; ?></b><p><br />
                                    <input type="text" name="name" value="<?php echo $name; ?>" />

                                    <?php if ($error_name) { ?>
                                        <span class="error"><?php echo $error_name; ?></span>
                                    <?php } ?>
                            </div>
                            <div id="right" class="contact-email">
                                <p><b><?php echo $entry_email; ?></b><p><br />
                                    <input type="text" name="email" value="<?php echo $email; ?>" />

                                    <?php if ($error_email) { ?>
                                        <span class="error"><?php echo $error_email; ?></span>
                                    <?php } ?>
                            </div>
                            <br />
                            <div class="contact-message">
                                <p><b><?php echo $entry_enquiry; ?></b><p><br />
                                    <textarea name="enquiry" cols="40" rows="6"><?php echo $enquiry; ?></textarea>

                                    <?php if ($error_enquiry) { ?>
                                        <span class="error"><?php echo $error_enquiry; ?></span>
                                    <?php } ?>
                            </div>
                            <div class="contact-captcha">
                                <p> <b><?php echo $entry_captcha; ?></b><p><br />
                                    <input type="text" name="captcha" value="<?php echo $captcha; ?>" />

                                    <img src="index.php?route=information/contact/captcha" alt="" style="margin-top: -9px;"/>
                                    <?php if ($error_captcha) { ?>
                                        <span class="error"><?php echo $error_captcha; ?></span>
                                    <?php } ?>
                            </div>
                            <div class="buttons">
                                <div class="left"><input type="submit" value="<?php echo $button_continue; ?>" class="button" /></div>
                            </div>
                        </form>

                        <div class="contact-info">
                            <div class="left">
                                <h3><?php echo $text_contact_us; ?></h3>
                                <?php if ($telephone) { ?>
                                    <span><?php echo $text_telephone; ?></span>
                                    <span><?php echo $telephone; ?></span><br />

                                <?php } ?>
                                <?php if ($fax) { ?>
                                    <span><?php echo $text_fax; ?></span>
                                    <span><?php echo $fax; ?></span>
                                    <br/>
                                <?php } ?>
                                <?php if ($email) { ?>
                                    <span><?php echo $text_email; ?></span>
                                    <span style="color: #74964B; font-weight: bold;"><?php echo $email_store; ?></span>
                                    <br/>
                                <?php } ?>
                            </div>
                            <div class="right">
                                <h3><?php echo $text_location; ?></h3>

                                <p><?php echo $store; ?><br />
                                    <?php echo $address; ?><br />
                                </p>
                            </div>
                        </div>
                        <?php echo $content_bottom; ?>
                      </div>
                </div>
                
            </div></div>
    </div>
</div>
<?php echo $footer; ?>