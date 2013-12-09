<?php if (count($currencies) > 1) { ?>
<form name="modulo">
  <div id="currency">
  
      <select name="currency_code" id="mymenu" size="1" onchange="SelectPost()">
   
    <?php foreach ($currencies as $currency) { ?>
    <?php if ($currency['code'] == $currency_code) { ?>
   
    <?php if ($currency['symbol_left']) { ?>
          <option value="<?php echo $currency['code']; ?>" selected="selected">
    <?php echo $currency['symbol_left']; ?>
    <?php } else { ?>
    <option value="<?php echo $currency['code']; ?>" selected="selected">
    <a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_right']; ?></b></a>
    <?php } ?>
    </option>
    <?php }  else { ?>
   
    <?php if ($currency['symbol_left']) { ?>
    <option value="<?php echo $currency['code']; ?>">
    <a title="<?php echo $currency['title']; ?>" <!--onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().submit();"--><?php echo $currency['symbol_left']; ?></a>
    </option>
    <?php }  else { ?>
    <option value="<?php echo $currency['code']; ?>">
    <a title="<?php echo $currency['title']; ?>" <!--onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().submit();"--><?php echo $currency['symbol_right']; ?></a>
    <?php } ?>
    </option>
    <?php } ?>
    <?php } ?>
    </select>
    
   </div>
</form>
<?php } ?>
  
<script type="text/javascript">
function SelectPost()
{
    document.modulo.method = "post";
    document.modulo.action = "<?php echo $action; ?>";
    document.modulo.enctype = "multipart/form-data";
    document.modulo.submit();
}
</script>


<!--script type="text/javascript">

var selectmenu=document.getElementById("mymenu")
selectmenu.onchange=function(){ //run some code when "onchange" event fires
 var chosenoption=this.options[this.selectedIndex] //this refers to "selectmenu"
 if (chosenoption.value!="nothing"){
  window.open(chosenoption.value, "_self", "") //open target site (based on option's value attr) in new window
 }
}

</script-->   