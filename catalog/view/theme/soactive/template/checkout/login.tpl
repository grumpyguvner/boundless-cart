<div class="new-customer">
    <h2><?php echo $text_new_customer; ?></h2>
    <p style="color: #777777"><?php echo $text_register; ?></p>
    <b><?php echo $entry_email; ?></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
    <input type="text" name="new-email" value="" />
    <input type="hidden" name="account" value="register" />
    <?php if ($guest_checkout) { ?>
        <label for="guest" class="radio">
            <?php if ($account == 'guest') { ?>
                <input type="radio" name="account" value="guest" id="guest" checked="checked" />
            <?php } else { ?>
                <input type="radio" name="account" value="guest" id="guest" />
            <?php } ?>
            <b><?php echo $text_guest; ?></b></label>

    <?php } ?>
    <br />
    <p style="color: #777777"><?php echo $text_register_account; ?></p>
    <input type="button" value="<?php echo strtoupper($button_continue); ?>" id="button-account" class="button" />
    <br />
    <br />
</div>

<div id="login" class="returning-customer">
    <h2><?php echo $text_returning_customer; ?></h2>
    <p style="color: #777777"><?php echo $text_i_am_returning_customer; ?></p>
    <b><?php echo $entry_email; ?></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
    <input type="text" name="email" value="" />
    <br />
    <br />
    <b><?php echo $entry_password; ?></b>
    <input type="password" name="password" value="" />
    <br />
    <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />
    <br />
    <input type="button" value="<?php echo strtoupper($button_login); ?>" id="button-login" class="button" />
    <br />
    <?php echo $fbconnect; ?>
</div>