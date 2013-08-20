
        <div class="checkout-product">
            
            <table class="table">
            <thead>
              <tr>
                <td class="name"><h4><?php echo $column_name; ?></h4></td>
                <td class="model"><h4><?php echo $column_model; ?></h4></td>
                <!--td class="rrp"><h4><?php /* echo $column_rrp; */ ?></h4></td-->
                <td class="quantity"><h4><?php echo $column_quantity; ?></h4></td>
                <td class="price"><h4><?php echo $column_price; ?></h4></td>
                <td class="total"><h4><?php echo $column_total; ?></h4></td>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($products as $product) { ?>
              <tr>
                <td class="name"><a href="<?php echo $product['href']; ?>"><h4><?php echo $product['name']; ?></h4></a>
                  <?php foreach ($product['option'] as $key => $option) { ?>
                    <?php echo ($key > 0 ? "<br />" : ""); ?>
                  &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                  <?php } ?></td>
                <td class="model"><h4 style="font-weight: normal"><?php echo $product['model']; ?></h4></td>
                <!--td class="rrp"><h4 style="font-weight: normal"></h4></td-->
                <td class="quantity"><h4 style="font-weight: normal"><?php echo $product['quantity']; ?></h4></td>
                <td class="price"><h4 style="font-weight: normal"><?php echo $product['price']; ?></h4></td>
                <td class="total"><h4 style="font-weight: normal"><?php echo $product['total']; ?></h4></td>
              </tr>
              <?php } ?>
              <?php foreach ($vouchers as $voucher) { ?>
              <tr>
                <td class="name"><h4><?php echo $voucher['description']; ?></h4></td>
                <td class="model"></td>
                <td class="quantity"><h4>1</h4></td>
                <td class="price"><h4><?php echo $voucher['amount']; ?></h4></td>
                <td class="total"><h4><?php echo $voucher['amount']; ?></h4></td>
              </tr>
              <?php } ?>
            </tbody>
            <tfoot>
              <?php foreach ($totals as $total) { ?>
              <tr>
                <td colspan="4" class="price"><h4><?php echo $total['title']; ?>:</h4></td>
                <td class="total"><h4 style="font-weight: normal"><?php echo $total['text']; ?></h4></td>
              </tr>
              <?php } ?>
            </tfoot>
          </table>
                
            
        </div>
        
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
        <?php if (isset($error_warning) && $error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
        <?php } ?>

        <?php if ($text_agree) { ?>
            <div class="buttons">
                    <label class="checkbox"><?php echo $text_agree; ?>
                    <input type="checkbox" id="agree" name="agree" value="1" /></label>
                    <input type="button" value="<?php echo $button_continue; ?>" id="button-payment-method" class="button" />
            </div>
        <?php } else { ?>
            <div class="buttons">
                    <input type="checkbox" id="agree" name="agree" value="1" checked />
                    <input type="button" value="<?php echo $button_continue; ?>" id="button-payment-method" class="button" />
            </div>
        <?php } ?>

<?php if ($text_agree) { ?>
<script type="text/javascript"><!--
    $('#agree').on('click', function () {
        if ($(this).is(':checked'))
        {
            $('#button-payment-method').attr('disabled', false);
        } else {
            $('#button-payment-method').attr('disabled', 'disabled');
        }
    }).trigger('click');
    //--></script>
<?php } ?>