<?php if (!isset($redirect)) { ?>
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
                  <?php foreach ($product['option'] as $option) { ?>
                  <br />
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
        <div class="payment"><?php echo $payment; ?></div>
<script type='text/javascript' src='https://platform.cloud-iq.com/cartrecovery/store.js?app_id=17262'></script>    

<?php } else { ?>
<script type="text/javascript"><!--
location = '<?php echo $redirect; ?>';
//--></script> 
<?php } ?>
