<div class="box">
  <div class="box-content">
    <div id="register_product_message" style="display:none; background: #FFFFCC; border: 1px solid #FFCC33; padding: 10px; margin-top: 2px; margin-bottom: 15px;"></div>
   
    <form action="<?php echo $action; ?>" method="post" id="module_register_product" name="module_register_product" onsubmit="$('div#register_product_message').load('index.php?route=module/register_product/callback&email=' + escape($('input[name=\'register_product_email\']').val()) + '&name=' + escape($('input[name=\'register_product_name\']').val()) + '&location=' + escape($('input[name=\'register_product_location\']').val()) + '&date=' + escape($('input[name=\'register_product_date\']').val()) + '&barcode=' + escape($('input[name=\'register_product_barcode\']').val()), function() { $('div#register_product_message').hide(); $('div#register_product_message').show('slow'); });return false;">
      <div style="text-align: left;">
          
        <span class="required">*</span><b><?php echo $entry_name; ?></b><br />
        <input style="width:90%;" type="text" name="register_product_name"/><br />
        
        <span class="required">*</span><b><?php echo $entry_email; ?></b><br />
        <input style="width:90%;" type="text" name="register_product_email"/><br />
        
        <span class="required">*</span><b><?php echo $entry_location; ?></b><br />
        <input style="width:90%;" type="text" name="register_product_location"/><br />
        
        <span class="required">*</span><b><?php echo $entry_date; ?></b><br />
        <input style="width:90%;" type="text" name="register_product_date"/><br />
        
        <span class="required">*</span><b><?php echo $entry_barcode; ?></b><br />
        <input style="width:90%;" maxlength="13" type="text" name="register_product_barcode"/><br />
        
	    <input name="subscribe" value="1" type="hidden" />
        
        <a onclick="$('div#register_product_message').load('index.php?route=module/register_product/callback&email=' + escape($('input[name=\'register_product_email\']').val()) + '&name=' + escape($('input[name=\'register_product_name\']').val()) + '&location=' + escape($('input[name=\'register_product_location\']').val()) + '&date=' + escape($('input[name=\'register_product_date\']').val()) + '&barcode=' + escape($('input[name=\'register_product_barcode\']').val()), function() { $('div#register_product_message').hide(); $('div#register_product_message').show('slow'); });" class="button"><span><?php echo $button_go; ?></span></a>
	  </div>
    </form>
  </div>
</div>
