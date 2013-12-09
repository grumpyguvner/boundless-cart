
        <?php if (isset($error_warning) && $error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
        <?php } ?>
        <?php if ($shipping_methods) { ?>
        <p><b><?php echo $text_shipping_method; ?></b></p>
        <table class="radio">
          <?php foreach ($shipping_methods as $shipping_method) { ?>
          <tr>
            <td colspan="3"><b><?php echo $shipping_method['title']; ?></b></td>
          </tr>
          <?php if (!$shipping_method['error']) { ?>
          <?php foreach ($shipping_method['quote'] as $quote) { ?>
          <tr class="highlight">
            <td id="quoteTitle"><?php if ($quote['code'] == $code || !$code) { ?>
              <?php $code = $quote['code']; ?>
              <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked" />
              <?php } else { ?>
              <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" />
              <?php } ?></td>
            <td><label for="<?php echo $quote['code']; ?>"><b><?php echo $quote['title'] ?></b></label></td>
            <td style="text-align: right;"><label for="<?php echo $quote['code']; ?>"><b><?php echo $quote['text']; ?></b></label></td>
          </tr>
          <?php } ?>
          <?php } else { ?>
          <tr>
            <td colspan="3"><div class="error"><?php echo $shipping_method['error']; ?></div></td>
          </tr>
          <?php } ?>
          <?php } ?>
        </table>
        <br />
        <?php } ?>
        <div class="comments" style="display: none">
        <b><?php echo $text_comments; ?></b>
        <br/>
        <textarea name="comment" rows="8"><?php echo $comment; ?></textarea>
        </div>
        
        <div class="buttons">
            <input type="button" value="<?php echo strtoupper($button_continue); ?>" id="button-shipping-method" class="button" />
        </div>
