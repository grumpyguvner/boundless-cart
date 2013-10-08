
        <div class="checkout-product">
            
            <table class="table-condensed">
            <thead>
              <tr>
                <th class="name" colspan="2"><?php echo $column_name; ?></th>
                <th class="model"><?php echo $column_model; ?></th>
                <!--th class="rrp"><?php /* echo $column_rrp; */ ?></th-->
                <th class="quantity"><?php echo $column_quantity; ?></th>
                <th class="price"><?php echo $column_price; ?></th>
                <th class="total"><?php echo $column_total; ?></th>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($products as $product) { ?>
              <tr>
                <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></td>
                <td class="options"><?php foreach ($product['option'] as $key => $option) { ?>
                    <?php echo ($key > 0 ? "<br />" : ""); ?>
                  &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                  <?php } ?></td>
                <td class="model"><?php echo $product['model']; ?></td>
                <!--td class="rrp"></td-->
                <td class="quantity"><?php echo $product['quantity']; ?></td>
                <td class="price"><?php echo $product['price']; ?></td>
                <td class="total"><?php echo $product['total']; ?></td>
              </tr>
              <?php } ?>
              <?php foreach ($vouchers as $voucher) { ?>
              <tr>
                <td class="name" colspan="2"><?php echo $voucher['description']; ?></td>
                <td class="model"></td>
                <td class="quantity">1</td>
                <td class="price"><?php echo $voucher['amount']; ?></td>
                <td class="total"><?php echo $voucher['amount']; ?></td>
              </tr>
              <?php } ?>
            </tbody>
            <tfoot>
              <?php foreach ($totals as $total) { ?>
              <tr>
                <td colspan="5" class="price"><?php echo $total['title']; ?>:</td>
                <td class="total"><?php echo $total['text']; ?></td>
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
    $('a.colorbox').colorbox({width:"50%", height:"50%"});
    
    if ($(this).is(':checked'))
    {
        $('#button-payment-method').attr('disabled', false);
    } else {
        $('#button-payment-method').attr('disabled', 'disabled');
    }

    $('#agree').on('click', function () {
        if ($(this).is(':checked'))
        {
            $('#button-payment-method').attr('disabled', false);
        } else {
            $('#button-payment-method').attr('disabled', 'disabled');
        }
    })
    //--></script>
<?php } ?>