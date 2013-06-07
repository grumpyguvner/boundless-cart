<?php echo $header; ?>
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
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
        <div id="accountContainer"><div id="column-left"><div class="account"></div></div><div id="content"> 
                <?php echo $content_top; ?>

                <div class="content-account">
                    <h1><?php echo strtoupper($heading_title); ?></h1>
                    <div class="newCustomer">
                        <h3><?php echo $text_new_customer; ?></h3>
                        <div>
                                <p><?php echo $text_register; ?></p>
                                <p><?php echo $text_register_account; ?></p><br /><br /><br />
                                <a href="<?php echo $register; ?>" class="button"><?php echo strtoupper($button_continue); ?></a>
                        </div>
                    </div>

                    <div class="returningCustomer">
                      <div class="content">
                        <h3><?php echo $text_returning_customer; ?></h3>
                        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                                <p><?php echo $text_i_am_returning_customer; ?></p>
                                <table>
                                    <tr>
                                        <td><b><?php echo $entry_email; ?></b></td>
                                        <td><input type="text" name="email" value="<?php echo $email; ?>" /></td>
                                    </tr>
                                    <tr>
                                        <td><b><?php echo $entry_password; ?></b></td>
                                        <td><input type="password" name="password" value="<?php echo $password; ?>" /></td>
                                    </tr>
                                </table>
                                <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />
                                <br />
                                <input type="submit" value="<?php echo strtoupper($button_login); ?>" class="button" />
                                <?php if ($redirect) { ?>
                                    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                                <?php } ?>
                        </form>
                      </div>
                    </div>
                </div>
                <?php echo $content_bottom; ?>
            </div>
        </div>
   
<script type="text/javascript"><!--
    $('#login input').keydown(function(e) {
        if (e.keyCode == 13) {
            $('#login').submit();
        }
    });
    //--></script> 
<?php echo $footer; ?>