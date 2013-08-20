<h2><?php echo $text_credit_card; ?></h2>
<div class="content" id="payment">
    <p>When you click Continue you will be redirected to the paypal website to enter your paypal login and password, once you have done that you will be returned back to this website.</p>
    <p>Your payment will not be processed and your order will not be placed until you return to this website.</p>
</div>
<div class="buttons">
  <div class="right"><input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="button" /></div>
</div>
<script type="text/javascript"><!--
$('#button-confirm').bind('click', function() {
        location = '<?php echo $action ?>';
});
//--></script>