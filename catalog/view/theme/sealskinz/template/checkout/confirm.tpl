<?php if (!isset($redirect)) { ?>
        <div class="payment"><?php echo $payment; ?></div>
<script type='text/javascript' src='https://platform.cloud-iq.com/cartrecovery/store.js?app_id=17262'></script>    

<?php } else { ?>
<script type="text/javascript"><!--
location = '<?php echo $redirect; ?>';
//--></script> 
<?php } ?>
