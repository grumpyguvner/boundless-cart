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
    <?php }
    ?>
</div>
<div id="content-back">
    <div class="green-bar">
        <div id="accountContainer" class="container"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content"> 
                <?php echo $content_top; ?>
                <div class="content-account">

                    <h1><?php echo $heading_title; ?></h1>
                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                        <h2><?php echo $text_your_details; ?></h2>

                        <div class="content">
                            <div class="row">

                                <div class="span2">
                                    <span class="required">*</span> <?php echo $entry_firstname; ?>
                                </div>
                                <div class="span7">
                                    <input type="text" name="firstname" value="<?php echo $firstname; ?>" />
                                    <?php if ($error_firstname) { ?>
                                        <span class="error"><?php echo $error_firstname; ?></span>
                                    <?php } ?>
                                </div>
                                <div class="span2">
                                    <span class="required">*</span> <?php echo $entry_lastname; ?>
                                </div>
                                <div class="span7">
                                    <input type="text" name="lastname" value="<?php echo $lastname; ?>" />
                                    <?php if ($error_lastname) { ?>
                                        <span class="error"><?php echo $error_lastname; ?></span>
                                    <?php } ?>
                                </div>
                                <div class="span2">
                                    <span class="required">*</span> <?php echo $entry_email; ?>
                                </div>
                                <div class="span7">
                                    <input type="text" name="email" value="<?php echo $email; ?>" />
                                    <?php if ($error_email) { ?>
                                        <span class="error"><?php echo $error_email; ?></span>
                                    <?php } ?>
                                </div>
                                <div class="span2">
                                    <span class="required">*</span> <?php echo $entry_telephone; ?>
                                </div>
                                <div class="span7">
                                    <input type="text" name="telephone" value="<?php echo $telephone; ?>" />
                                    <?php if ($error_telephone) { ?>
                                        <span class="error"><?php echo $error_telephone; ?></span>
                                    <?php } ?>
                                </div>
                                <div class="span2">
                                    <?php echo $entry_fax; ?>
                                </div>
                                <div class="span7">
                                    <input type="text" name="fax" value="<?php echo $fax; ?>" />
                                </div>

                            </div>

                        </div>



                        <div class="buttons">

                            <div class="left"><a href="<?php echo $back; ?>" class="button-account"><?php echo $button_back; ?></a></div>
                            <div class="right">
                                <input type="submit" value="<?php echo $button_continue; ?>" class="button-account" />
                            </div>

                        </div>
                    </form>
                </div>
                    <?php echo $content_bottom; ?>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>