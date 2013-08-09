
<?php if (isset($error_warning) && $error_warning) { ?>
    <div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($shipping_methods) { ?>
    <p><?php echo $text_shipping_method; ?></p>

    <?php foreach ($shipping_methods as $shipping_method) { ?>
        <p><b><?php echo $shipping_method['title']; ?></b></p>
        <?php if (!$shipping_method['error']) { ?>
            <?php foreach ($shipping_method['quote'] as $quote) { ?>
                <div><label for="<?php echo $quote['code']; ?>" class="radio"><?php if ($quote['code'] == $code || !$code) { ?>
                            <?php $code = $quote['code']; ?>
                            <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked" />
                        <?php } else { ?>
                            <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" />
                        <?php } ?>
                        <?php echo $quote['title'] ?> &nbsp; <?php echo $quote['text']; ?></label></div>
            <?php } ?>
        <?php } else { ?>
            <div class="error"><?php echo $shipping_method['error']; ?></div>
        <?php } ?>
    <?php } ?>
    <br />
<?php } ?>
<!--        <div class="comments">
        <b><?php echo $text_comments; ?></b>
        <br/>
        <textarea name="comment" rows="8"><?php echo $comment; ?></textarea>
        </div><br />
        <br />-->

<div class="buttons">
    <input type="button" value="<?php echo $button_continue; ?>" id="button-shipping-method" class="button" />
</div>
