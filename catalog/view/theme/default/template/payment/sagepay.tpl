<form action="<?php echo $action; ?>" method="post">
  <input type="hidden" name="VPSProtocol" value="3.0" />
  <input type="hidden" name="TxType" value="<?php echo $transaction; ?>" />
  <input type="hidden" name="Vendor" value="<?php echo $vendor; ?>" />
  <input type="hidden" name="Crypt" value="<?php echo $crypt; ?>" />
  <div class="buttons">
    <div class="right">
      <input type="submit" value="<?php echo $button_confirm; ?>" class="button" />
    </div>
  </div>
</form>
