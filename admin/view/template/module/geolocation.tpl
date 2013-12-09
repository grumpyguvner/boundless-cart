<?php echo $header; ?>
<div id="content">
  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-globe"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_save($button_save); ?>
				<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
			</div>
    </div>
    <div class="content">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
            <div class="form">
                <div class="control-group">
                    <label class="control-label"><?php echo $entry_status; ?></label>
                    <div class="controls">
                        <select name="geolocation_status" class="input-medium">
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
                    </div>
                </div>
            </div>
        <table id="module" class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-name"><?php echo $entry_country; ?></th>
              <th class="column-currency"><?php echo $entry_currency; ?></th>
              <th class="column-language"><?php echo $entry_language; ?></th>
              <th class="column-catalog-mode"><?php echo $entry_catalog_mode; ?></th>
              <th class="column-action"></th>
            </tr>
          </thead>
          <?php $module_row = 0; ?>
          <?php foreach ($geolocation_countries as $module) { ?>
          <tbody id="module-row<?php echo $module_row; ?>">
            <tr>
              <td class="column-name">
                    <select name="geolocation_countries[<?php echo $module_row; ?>][iso_code_2]">
                    <option value=""></option>
                    <?php foreach ($countries as $country) { ?>
                      <?php if ($country['iso_code_2'] == $module['iso_code_2']) { ?>
                        <option value="<?php echo $country['iso_code_2']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                        
                      <?php } else { ?>
                        <option value="<?php echo $country['iso_code_2']; ?>"><?php echo $country['name']; ?></option>
                        
                      <?php } ?>
                   <?php } ?>
                  </select>
                  <?php if (isset($error_country_id[$module_row])) { ?>
                      <span class="error"><?php echo $error_country_id[$module_row]; ?></span>
                  <?php } ?>
              </td>
              <td class="column-currency">
                    <select name="geolocation_countries[<?php echo $module_row; ?>][currency_code]">
                    <option value=""><?php echo $text_default; ?></option>
                    <?php foreach ($currencies as $currency) { ?>
                      <?php if ($currency['code'] == $module['currency_code']) { ?>
                        <option value="<?php echo $currency['code']; ?>" selected="selected"><?php echo $currency['title']; ?></option>
                        
                      <?php } else { ?>
                        <option value="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?></option>
                        
                      <?php } ?>
                   <?php } ?>
                  </select>
              </td>
              <td class="column-language">
                    <select name="geolocation_countries[<?php echo $module_row; ?>][language_code]">
                    <option value=""><?php echo $text_default; ?></option>
                    <?php foreach ($languages as $language) { ?>
                      <?php if ($language['code'] == $module['language_code']) { ?>
                        <option value="<?php echo $language['code']; ?>" selected="selected"><?php echo $language['name']; ?></option>
                        
                      <?php } else { ?>
                        <option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
                        
                      <?php } ?>
                   <?php } ?>
                  </select>
              </td>
              <td class="column-catalog-mode">
                    <select name="geolocation_countries[<?php echo $module_row; ?>][catalog_mode]">
                      <?php if ($module['catalog_mode'] == '1') { ?>
                       <option value=""><?php echo $text_default; ?></option>
                        <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                        <option value="0"><?php echo $text_no; ?></option>
                      <?php } elseif ($module['catalog_mode'] == '0') { ?> 
                       <option value=""><?php echo $text_default; ?></option>
                       <option value="1"><?php echo $text_yes; ?></option>
                       <option value="0" selected="selected"><?php echo $text_no; ?></option>
                      <?php } else { ?> 
                       <option value=""><?php echo $text_default; ?></option>
                       <option value="1"><?php echo $text_yes; ?></option>
                       <option value="0"><?php echo $text_no; ?></option>
                      <?php } ?> 
                  </select>
              </td>
              <td class="column-action">
                    <a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
              </td>
            </tr>
          </tbody>
            <?php $module_row++; ?>
          <?php } ?>
          <tfoot>
              <tr>
                  <td colspan="4"></td>
                  <td class="column-action">
                      <a onclick="addModule();" class="btn btn-small" title="<?php echo $button_add_module; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_module; ?></a>
                  </td>
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
	html += '    <td class="column-name"><select name="geolocation_countries[' + module_row + '][iso_code_2]">';
        html += '    <option value="" selected="selected"></option>';
	<?php foreach ($countries as $country) { ?>
	html += '      <option value="<?php echo $country['iso_code_2']; ?>"><?php echo addslashes($country['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
        html += '    <td class="column-currency"><select name="geolocation_countries[' + module_row + '][currency_code]">';
        html += '    <option value="" selected="selected"><?php echo $text_default; ?></option>';
	<?php foreach ($currencies as $currency) { ?>
	html += '      <option value="<?php echo $currency['code']; ?>"><?php echo addslashes($currency['title']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
        html += '    <td class="column-language"><select name="geolocation_countries[' + module_row + '][language_code]">';
        html += '    <option value="" selected="selected"><?php echo $text_default; ?></option>';
	<?php foreach ($languages as $language) { ?>
	html += '      <option value="<?php echo $language['code']; ?>"><?php echo addslashes($language['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="column-catalog-mode"><select name="geolocation_countries[' + module_row + '][catalog_mode]">'; 
        html += '      <option value="" selected="selected"><?php echo $text_default; ?></option>';
	html += '      <option value="1"><?php echo $text_yes; ?></option>';
        html += '      <option value="0"><?php echo $text_no; ?></option>';
        html += '    </select></td>';
        html += '    <td class="column-action"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script> 
<?php echo $footer; ?>