<form action="<?php echo $action; ?>" method="post">
  <input type="hidden" name="VPSProtocol" value="2.23" />
  <input type="hidden" name="TxType" value="<?php echo $transaction; ?>" />
  <input type="hidden" name="Vendor" value="<?php echo $vendor; ?>" />
  <input type="hidden" name="Crypt" value="<?php echo $crypt; ?>" />
  <div class="buttons">
      <input type="submit" value="<?php echo strtoupper($button_confirm); ?>" class="button" />
  </div>
</form>
