
        <?php if (isset($error_warning) && $error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
        <?php } ?>
        <?php if ($payment_methods) { ?>
        <p><?php echo $text_payment_method; ?></p>
        <table class="radio">
          <?php foreach ($payment_methods as $payment_method) { ?>
          <tr class="highlight">
            <td><?php if ($payment_method['code'] == $code || !$code) { ?>
              <?php $code = $payment_method['code']; ?>
              <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" />
              <?php } else { ?>
              <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" />
              <?php } ?></td>
            <td><label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></td>
          </tr>
          <?php } ?>
        </table>
        <br />
        <?php } ?>
<!--        <div class="comments">
        <b><?php echo $text_comments; ?></b>
        <textarea name="comment" rows="8"><?php echo $comment; ?></textarea>
        </div>
        <br />
        <br />-->
        <?php if ($text_agree) { ?>
        <div class="buttons">
          <label class="checkbox"><?php echo $text_agree; ?>
            <?php if ($agree) { ?>
            <input type="checkbox" name="agree" value="1" checked="checked" />
            <?php } else { ?>
            <input type="checkbox" name="agree" value="1" />
            <?php } ?>
             </label> 
            <input type="button" value="<?php echo $button_continue; ?>" id="button-payment-method" class="button" />
        </div>
        <?php } else { ?>
        <div class="buttons">
            <input type="button" value="<?php echo $button_continue; ?>" id="button-payment-method" class="button" />
        </div>
        <?php } ?>

<script type="text/javascript"><!--
$('.colorbox').colorbox({
	width: 640,
	height: 480
});
//--></script> 