
        <?php if (isset($error_warning) && $error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
        <?php } ?>
        
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
                <td class="name"> <?php if ($product['thumb']) { ?>
                                        <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                                    <?php } ?>
                        <div class="namePOption"><h4><?php echo $product['name']; ?></h4></a>
                    
                  <?php foreach ($product['option'] as $option) { ?>
                 
                  <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                  <?php } ?></div></td>
                <td class="model"><h4 style="font-weight: normal"><?php echo $product['model']; ?></h4></td>
                <!--td class="rrp"><h4 style="font-weight: normal"></h4></td-->
                <td class="quantity"><h4 style="font-weight: normal"><?php echo $product['quantity']; ?></h4></td>
                <td class="price"><h4 style="font-weight: normal"><?php echo $product['price']; ?></h4></td>
                <td class="total"><h4 style="font-weight: normal"><?php echo $product['total']; ?></h4></td>
              </tr>
              <?php } ?>
              <?php foreach ($vouchers as $voucher) { ?>
              <tr>
                <td class="name"><?php echo $voucher['description']; ?></h4></td>
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
                <td class="total"><h4 <?php if ($total['code'] == 'total') { echo 'style="font-weight: bold;"'; } else { echo 'style="font-weight: normal;"'; } ?>><?php echo $total['text']; ?></h4></td>
              </tr>
              <?php } ?>
            </tfoot>
          </table>
                
            
        </div>
        
        <?php if ($payment_methods) { ?>
        <p><b><?php echo $text_payment_method; ?></b></p>
        <table class="radio">
          <?php foreach ($payment_methods as $payment_method) { ?>
          <tr class="highlight">
            <td><?php if ($payment_method['code'] == $code || !$code) { ?>
              <?php $code = $payment_method['code']; ?>
              <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" />
              <?php } else { ?>
              <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" />
              <?php } ?></td>
            <td><img src="catalog/view/theme/soactive/image/payment/<?php echo $payment_method['code']; ?>.png" alt="" >
                <label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></td>
          </tr>
          <?php } ?>
        </table>
        <br />
        <?php } ?>
        <div class="comments" style="display: none">
        <b><?php echo $text_comments; ?></b>
        <textarea name="comment" rows="8"><?php echo $comment; ?></textarea>
        </div>
        <?php if ($text_agree) { ?>
        <div class="buttons">
          <label class="checkbox"><?php echo $text_agree; ?>
            <?php if ($agree) { ?>
            <input type="checkbox" name="agree" value="1" checked="checked" />
            <?php } else { ?>
            <input type="checkbox" name="agree" value="1" />
            <?php } ?>
             </label> 
            <input type="button" value="<?php echo strtoupper($button_continue); ?>" id="button-payment-method" class="button" style="display: none" />
        </div>
        <?php } else { ?>
        <div class="buttons" style="display: none">
            <input type="button" value="<?php echo strtoupper($button_continue); ?>" id="button-payment-method" class="button" />
        </div>
        <?php } ?>

<script type="text/javascript"><!--
$('.colorbox').colorbox({
	width: 640,
	height: 480
});
//--></script> 