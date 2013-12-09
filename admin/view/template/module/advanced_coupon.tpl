<?php echo $header; ?>
<div id="content">
    
<?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>
    
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
  <div class="heading">
    <h1><i class="icon-user"></i> <?php echo $heading_title; ?></h1>
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
     <div class="row">
        <div id="module-wrapper" class="span12">
        <table id="module" class="list table table-striped table-hover">
        <thead>
          <tr>
            <th class="column-name"><?php echo $entry_advanced_coupon; ?></th>
            <th class="column-name"><?php echo $entry_product; ?></th>
            <th class="column-number"><?php echo $entry_limit; ?></th>
            <th class="column-number"><?php echo $entry_image; ?></th>
            <th class="column-layout"><?php echo $entry_layout; ?></th>
            <th class="column-position"><?php echo $entry_position; ?></th>
            <th class="column-status"><?php echo $entry_status; ?></th>
            <th class="column-sort"><?php echo $entry_sort_order; ?></th>
            <th class="column-action"></th>
          </tr>
        </thead>
        <?php $module_row = 0; ?>
        <?php foreach ($modules as $module) { ?>
        <tbody id="module-row<?php echo $module_row; ?>">
          <tr>
            <td class="column-name">
                <label class="visible-480"><?php echo $entry_advanced_coupon; ?></label>
                <select name="advanced_coupon_module[<?php echo $module_row; ?>][advanced_coupon_id]" class="span2 i-medium">
                <?php foreach ($coupons as $coupon) { ?>
                <?php if ($coupon['advanced_coupon_id'] == $module['advanced_coupon_id']) { ?>
                <option value="<?php echo $coupon['advanced_coupon_id']; ?>" selected="selected"><?php echo $coupon['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $coupon['advanced_coupon_id']; ?>"><?php echo $coupon['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </td>
            <td class="column-name">
                <label class="visible-480"><?php echo $entry_product; ?></label>
                <select name="advanced_coupon_module[<?php echo $module_row; ?>][product]" class="span2 i-medium">
                <?php if ($module['product'] == 'product') { ?>
                <option value="product" selected="selected"><?php echo $text_product; ?></option>
                <?php } else { ?>
                <option value="product"><?php echo $text_product; ?></option>
                <?php } ?>
                 <?php if ($module['product'] == 'product_buy') { ?>
                <option value="product_buy" selected="selected"><?php echo $text_product_buy; ?></option>
                <?php } else { ?>
                <option value="product_buy"><?php echo $text_product_buy; ?></option>
                <?php } ?>
               </select>
            </td>
            <td class="column-number">
                <label class="visible-480"><?php echo $entry_limit; ?></label>
                <input type="text" name="advanced_coupon_module[<?php echo $module_row; ?>][limit]" value="<?php echo $module['limit']; ?>" size="1" class="span1 i-mini" />
            </td>
            <td class="column-number">
                <label class="visible-480"><?php echo $entry_image; ?></label>
                <input type="text" name="advanced_coupon_module[<?php echo $module_row; ?>][image_width]" value="<?php echo $module['image_width']; ?>" size="3" class="span1 i-mini" />
              <input type="text" name="advanced_coupon_module[<?php echo $module_row; ?>][image_height]" value="<?php echo $module['image_height']; ?>" size="3" class="span1 i-mini" />
              <?php if (isset($error_image[$module_row])) { ?>
              <span class="error"><?php echo $error_image[$module_row]; ?></span>
              <?php } ?>
            </td>
            <td class="column-layout">
                <label class="visible-480"><?php echo $entry_layout; ?></label>
                <select name="advanced_coupon_module[<?php echo $module_row; ?>][layout_id]" class="span2 i-medium">
                <?php foreach ($layouts as $layout) { ?>
                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </td>
            <td class="column-position">
                <label class="visible-480"><?php echo $entry_position; ?></label>
                <select name="advanced_coupon_module[<?php echo $module_row; ?>][position]" class="span2 i-medium">
                <?php if ($module['position'] == 'content_top') { ?>
                <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                <?php } else { ?>
                <option value="content_top"><?php echo $text_content_top; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'content_bottom') { ?>
                <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                <?php } else { ?>
                <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_left') { ?>
                <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                <?php } else { ?>
                <option value="column_left"><?php echo $text_column_left; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_right') { ?>
                <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                <?php } else { ?>
                <option value="column_right"><?php echo $text_column_right; ?></option>
                <?php } ?>
              </select>
            </td>
            <td class="column-status">
                <label class="visible-480"><?php echo $entry_status; ?></label>
                <select name="advanced_coupon_module[<?php echo $module_row; ?>][status]">
                <?php if ($module['status']) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            <td class="column-sort">
                <label class="visible-480"><?php echo $entry_sort_order; ?></label>
                <input type="text" name="advanced_coupon_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3"  class="span1 i-mini" /></td>
            <td class="column-action">
                    <a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
            </td>
          </tr>
        </tbody>
        <?php $module_row++; ?>
        <?php } ?>
        <tfoot>
            <tr>
              <td colspan="8"></td>
              <td class="column-action"><a onclick="addModule();" class="btn btn-small" title="<?php echo $button_add_module; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_module; ?></span></a></td>
            </tr>
          </tfoot>
      </table>
      <div><?php echo $text_advanced_coupon_note; ?></div>
      </div>
				</div>
    </form>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="column-name"><label class="visible-480"><?php echo addslashes($entry_advanced_coupon); ?></label><select name="advanced_coupon_module[' + module_row + '][advanced_coupon_id]" class="span2 i-medium">';
	<?php foreach ($coupons as $coupon) { ?>
	html += '      <option value="<?php echo $coupon['advanced_coupon_id']; ?>"><?php echo addslashes($coupon['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="column-name"><label class="visible-480"><?php echo addslashes($entry_product); ?></label><select name="advanced_coupon_module[' + module_row + '][product]" class="span2 i-medium">';
	html += '      <option value="product"><?php echo $text_product; ?></option>';
	html += '      <option value="product_buy"><?php echo $text_product_buy; ?></option>';
	html += '    </select></td>';
	html += '    <td class="column-number"><label class="visible-480"><?php echo addslashes($entry_limit); ?></label><input type="text" name="advanced_coupon_module[' + module_row + '][limit]" value="5" size="1" class="span1 i-mini" /></td>';
	html += '    <td class="column-number"><label class="visible-480"><?php echo addslashes($entry_image); ?></label><input type="text" name="advanced_coupon_module[' + module_row + '][image_width]" value="80" size="3" class="span1 i-mini" /> <input type="text" name="advanced_coupon_module[' + module_row + '][image_height]" value="80" size="3" class="span1 i-mini"/></td>';	
	html += '    <td class="column-layout"><label class="visible-480"><?php echo addslashes($entry_layout); ?></label><select name="advanced_coupon_module[' + module_row + '][layout_id]" class="span2 i-medium">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <?php echo p3html::oc_layout_options($layouts, null, true); ?>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="column-position"><label class="visible-480"><?php echo addslashes($entry_position); ?></label><select name="advanced_coupon_module[' + module_row + '][position]" class="span2 i-medium">';
	html += '      <?php echo p3html::oc_position_options($this->language, null, true); ?>';
	html += '    </select></td>';
	html += '    <td class="column-status"><label class="visible-480"><?php echo addslashes($entry_status); ?></label><select name="advanced_coupon_module[' + module_row + '][status]" class="input-small">';
        html += '      <?php echo p3html::oc_status_options($this->language, null, true); ?>';
        html += '    </select></td>';
        html += '    <td class="column-sort"><label class="visible-480"><?php echo addslashes($entry_sort_order); ?></label><input type="text" name="advanced_coupon_module[' + module_row + '][sort_order]" value="" class="span1 i-mini"></td>';
	html += '    <td class="column-action"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	<?php if ($this->config->get('p3adminrebooted_select2')) { ?>
	$('#module-row' + module_row + ' select').select2();
	<?php } ?>
}
//--></script> 
<?php echo $footer; ?>