<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
            <table class="form">
                <tr>
                    <td><?php echo $entry_status; ?></td>
                    <td><select name="geolocation_status">
                            <?php
                            if ($geolocation_status) {
                                ?>
                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                <option value="0"><?php echo $text_disabled; ?></option>
                                <?php
                            } else {
                                ?>
                                <option value="1"><?php echo $text_enabled; ?></option>
                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php
                            } // end if 
                            ?>
                        </select>
                    </td>
                </tr>
            </table>
        <table id="module" class="list">
          <thead>
            <tr>
              <td class="left"><?php echo $entry_country; ?></td>
              <td class="left"><?php echo $entry_currency; ?></td>
              <td class="left"><?php echo $entry_language; ?></td>
              <td class="left"><?php echo $entry_allow_to_buy; ?></td>
              <td></td>
            </tr>
          </thead>
          <?php $module_row = 0; ?>
          <?php foreach ($modules as $module) { ?>
          <tbody id="module-row<?php echo $module_row; ?>">
            <tr>
              <td class="left">
                  <select name="geolocation_module[<?php echo $module_row; ?>][country_id]">
                    <option value=""></option>
                    <?php foreach ($countries as $country) { ?>
                      <?php if ($country['country_id'] == $module['country_id']) { ?>
                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                        
                      <?php } else { ?>
                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                        
                      <?php } ?>
                   <?php } ?>
                  </select>
                  <?php if (isset($error_country_id[$module_row])) { ?>
                      <span class="error"><?php echo $error_country_id[$module_row]; ?></span>
                  <?php } ?>
              </td>
              <td class="left">
                  <select name="geolocation_module[<?php echo $module_row; ?>][currency_id]">
                      <option value=""></option>
                    <?php foreach($currencies as $currency) { ?>
                      <?php if ($currency['currency_id'] == $module['currency_id']) { ?>
                        <option value="<?php echo $currency['currency_id']; ?>" selected="selected"><?php echo $currency['title']; ?></option>
                      <?php } else { ?>  
                        <option value="<?php echo $currency['currency_id']; ?>"><?php echo $currency['title']; ?></option>
                      <?php } ?>
                    <?php } ?>
                  </select>
              </td>
              <td class="left"> 
                  <select name="geolocation_module[<?php echo $module_row; ?>][language_id]">
                    <option value=""></option>
                    <?php foreach($languages as $language) { ?>
                      <?php if ($language['language_id'] == $module['language_id']) { ?>
                        <option value="<?php echo $language['language_id']; ?>" selected="selected"><?php echo $language['name']; ?></option>
                      <?php } else { ?>
                        <option value="<?php echo $language['language_id']; ?>"><?php echo $language['name']; ?></option>
                      <?php } ?>
                    <?php } ?>
                  </select>
              </td>
              <td class="left">
                  <select name="geolocation_module[<?php echo $module_row; ?>][allow_to_buy]">
                      
                      <?php if ($module['allow_to_buy']) { ?>
                        <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                        <option value="0"><?php echo $text_no; ?></option>
                      <?php } elseif ($module['allow_to_buy'] == '0') { ?> 
                       <option value="1"><?php echo $text_yes; ?></option>
                       <option value="0" selected="selected"><?php echo $text_no; ?></option>
                      <?php } else { ?> 
                       <option value=""></option>
                       <option value="1"><?php echo $text_yes; ?></option>
                       <option value="0"><?php echo $text_no; ?></option>
                      <?php } ?> 
                  </select>
              </td>
              <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
            
            </tr>
          </tbody>
            <?php $module_row++; ?>
          <?php } ?>
          <tfoot>
            <tr>
              <td colspan="4"></td>
              <td class="left"><a onclick="addModule();" class="button"><?php echo $button_add_module; ?></a></td>
            </tr>
          </tfoot>
        </table>
        </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="geolocation_module[' + module_row + '][country_id]">';
        html += '    <option value="" selected="selected"></option>';
	<?php foreach ($countries as $country) { ?>
	html += '      <option value="<?php echo $country['country_id']; ?>"><?php echo addslashes($country['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
        html += '    <td class="left"><select name="geolocation_module[' + module_row + '][currency_id]">';
        html += '    <option value="" selected="selected"></option>';
	<?php foreach ($currencies as $currency) { ?>
	html += '      <option value="<?php echo $currency['currency_id']; ?>"><?php echo addslashes($currency['title']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
        html += '    <td class="left"><select name="geolocation_module[' + module_row + '][language_id]">';
        html += '    <option value="" selected="selected"></option>';
	<?php foreach ($languages as $language) { ?>
	html += '      <option value="<?php echo $language['language_id']; ?>"><?php echo addslashes($language['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="geolocation_module[' + module_row + '][allow_to_buy]">'; 
        html += '      <option value="" selected="selected"></option>';
	html += '      <option value="1"><?php echo $text_yes; ?></option>';
        html += '      <option value="0"><?php echo $text_no; ?></option>';
        html += '    </select></td>';
        html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script> 
<?php echo $footer; ?>