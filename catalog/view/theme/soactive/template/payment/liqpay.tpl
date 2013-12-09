<form action="<?php echo $action; ?>" method="post">
  <input type="hidden" name="operation_xml" value="<?php echo $xml; ?>">
  <input type="hidden" name="signature" value="<?php echo $signature; ?>">
  <div class="buttons">
      <input type="submit" value="<?php echo strtoupper($button_confirm); ?>" class="button" />
  </div>
</form>
