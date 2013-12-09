<?php echo $header; ?>
<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

<?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
    <div class="heading">
            <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
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
      <table id="module" class="form table table-striped table-hover">
        <tr>
          <td><?php echo $store_loc_iWidth; ?></td>
          <td><input type="text" name="store_locations_iWidth" value="<?php echo $store_locations_iWidth; ?>" size="1" /></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_iHeight; ?></td>
          <td><input type="text" name="store_locations_iHeight" value="<?php echo $store_locations_iHeight; ?>" size="1" /></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_mdWidth; ?></td>
          <td><input type="text" name="store_locations_mdWidth" value="<?php echo $store_locations_mdWidth; ?>" size="1" /></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_mdHeight; ?></td>
          <td><input type="text" name="store_locations_mdHeight" value="<?php echo $store_locations_mdHeight; ?>" size="1" /></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_iaWidth; ?></td>
          <td><input type="text" name="store_locations_iaWidth" value="<?php echo $store_locations_iaWidth; ?>" size="1" /></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_iaHeight; ?></td>
          <td><input type="text" name="store_locations_iaHeight" value="<?php echo $store_locations_iaHeight; ?>" size="1" /></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_mWidth; ?></td>
          <td><input type="text" name="store_locations_mWidth" value="<?php echo $store_locations_mWidth; ?>" size="1" /></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_mHeight; ?></td>
          <td><input type="text" name="store_locations_mHeight" value="<?php echo $store_locations_mHeight; ?>" size="1" /></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_txt_per_page; ?></td>
          <td><input type="text" name="store_locations_per_page" value="<?php echo $store_locations_per_page; ?>" size="1" /></td>
        </tr>
        <tr>
              <td><?php echo $entry_icon; ?></td>
              <td valign="top">
                  
                  <div class="image"><img src="<?php echo $thumb_icon; ?>" alt="" id="thumb_icon" />
                <input type="hidden" name="store_locations_image_icon" value="<?php echo $store_locations_image_icon; ?>" id="store_locations_image_icon" />
                <br />
                <a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('store_locations_image_icon', 'thumb_icon');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span>&nbsp;&nbsp;|&nbsp;&nbsp;
                <a class="btn"  title="<?php echo $text_clear; ?>" onclick="$('#thumb_icon').attr('src', '<?php echo $no_image; ?>'); $('#store_locations_image_icon').attr('value', '');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>
                  </div>
              </td>
         </tr>
      </table>
      <table id="module" class="list table table-striped table-hover">
          <thead>
            <tr>
            	<td colspan="4"><div class="buttons"><a onclick="location = '<?php echo $insert; ?>'" class="button btn"><i class="icon-plus"></i><?php echo $button_insert; ?></a>&nbsp;<a onclick="$('#form').attr('action','<?php echo $delete; ?>');$('#form').submit();" class="button btn btn-danger"><i class="icon-trash"></i><?php echo $button_delete; ?></a></div></td>
            </tr>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php echo $column_name; ?></td>
              <td class="right"><?php echo $column_sort_order; ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($sLocations) { ?>
            <?php foreach ($sLocations as $location) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($location['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $location['location_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $location['location_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $location['name']; ?></td>
              <td class="right"><?php echo $location['sort_order']; ?></td>
              <td class="right"><?php foreach ($location['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      <table id="module" class="list table table-striped table-hover">
        <thead>
          <tr>
            <th class="column-number"><?php echo $entry_limit; ?></th>
            <th class="column-image"><?php echo $entry_image; ?></th>
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
            <td class="column-number">
                <label class="visible-480"><?php echo $entry_limit; ?></label>
                <input type="text" name="store_locations_module[<?php echo $module_row; ?>][limit]" value="<?php echo $module['limit']; ?>" size="1" class="input-small" /></td>
            <td class="column-number">
                <label class="visible-480"><?php echo $entry_image; ?></label>
                <input type="text" name="store_locations_module[<?php echo $module_row; ?>][image_width]" value="<?php echo $module['image_width']; ?>" size="3" class="input-small" />
              <input type="text" name="store_locations_module[<?php echo $module_row; ?>][image_height]" value="<?php echo $module['image_height']; ?>" size="3" class="input-small" />
              <?php if (isset($error_image[$module_row])) { ?>
              <span class="error"><?php echo $error_image[$module_row]; ?></span>
              <?php } ?></td>
            <td class="column-layout">
                <label class="visible-480"><?php echo $entry_layout; ?></label>
                <select name="store_locations_module[<?php echo $module_row; ?>][layout_id]" class="span2 i-medium">
                <?php foreach ($layouts as $layout) { ?>
                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            <td class="column-position">
                <label class="visible-480"><?php echo $entry_position; ?></label>
                <select name="store_locations_module[<?php echo $module_row; ?>][position]" class="span2 i-medium">
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
              </select></td>
            <td class="column-status">
                <label class="visible-480"><?php echo $entry_status; ?></label>
                <select name="store_locations_module[<?php echo $module_row; ?>][status]" class="input-small">
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
                <input type="text" name="store_locations_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" class="span1 i-mini" /></td>
            <td class="column-action"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>
          </tr>
        </tbody>
        <?php $module_row++; ?>
        <?php } ?>
        <tfoot>
          <tr>
            <td colspan="6"></td>
            <td class="column-action">
                <a onclick="addModule();" class="btn btn-small" title="<?php echo $button_add_module; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_module; ?></span></a>
            </td>
          </tr>
        </tfoot>
      </table>
    </form>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="column-number"><label class="visible-480"><?php echo addslashes($entry_limit); ?></label><input type="text" name="store_locations_module[' + module_row + '][limit]" value="5" size="1" class="input-small" /></td>';
	html += '    <td class="column-number"><label class="visible-480"><?php echo addslashes($entry_image); ?></label><input type="text" name="store_locations_module[' + module_row + '][image_width]" value="80" size="3" class="input-small" /> <input type="text" name="store_locations_module[' + module_row + '][image_height]" value="80" size="3" class="input-small" /></td>';		
	html += '    <td class="column-layout"><label class="visible-480"><?php echo addslashes($entry_layout); ?></label><select name="store_locations_module[' + module_row + '][layout_id]" class="span2 i-medium">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="column-position"><label class="visible-480"><?php echo addslashes($entry_position); ?></label><select name="store_locations_module[' + module_row + '][position]" class="span2 i-medium">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="column-status"><label class="visible-480"><?php echo addslashes($entry_status); ?></label><select name="store_locations_module[' + module_row + '][status]" class="input-small">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="column-sort"><label class="visible-480"><?php echo addslashes($entry_sort_order); ?></label><input type="text" name="store_locations_module[' + module_row + '][sort_order]" value="" size="3" class="span1 i-mini" /></td>';
	html += '    <td class="column-action"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script>
<!--FILEMANAGER-->
<?php include_once DIR_TEMPLATE . 'javascript/filemanager_dialog.tpl'; ?>
<!--FILEMANAGER-->
<?php echo $footer; ?>