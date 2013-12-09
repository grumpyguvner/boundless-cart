<?php echo $header; ?>
<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
<div class="heading">
  <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
  <div class="buttons form-actions form-actions-top">
        <?php echo p3html::tb_form_button_save($button_save); ?>
        <?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
  </div>
</div>
<div class="content">

<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
  <div id="tab_general" class="page">
	  
	  <table id="module" class="list table table-striped table-hover">
        <thead>
          <tr>
            <th class="column-limit"><?php echo $entry_limit; ?></th>
            <th class="column-cat"><?php echo $entry_cat; ?></th>
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
                      <input type="text" name="news_module[<?php echo $module_row; ?>][news_limit]" value="<?php echo $module['news_limit']; ?>" size="3" class="span1 i-mini" /></td>
		  <td class="column-cat">
                      <label class="visible-480"><?php echo $entry_cat; ?></label>
                      <select name="news_module[<?php echo $module_row; ?>][ncategory_id]" class="span2 i-medium">
		  <?php if ($module['ncategory_id'] == 'all') { ?>
		  <option value="all" selected="selected"><?php echo $entry_nocat; ?></option>
		  <?php } else { ?>
		  <option value="all"><?php echo $entry_nocat; ?></option>
          <?php } ?>
		  <option value="" disabled="disabled">By Categories:</option>
		  <?php foreach ($ncategories as $ncategory ){ ?>
		  <?php if ($ncategory['ncategory_id'] == $module['ncategory_id']) { ?>
		  <option value="<?php echo $ncategory['ncategory_id']; ?>" selected="selected"><?php echo $ncategory['name']; ?></option>
		  <?php } else { ?>
          <option value="<?php echo $ncategory['ncategory_id']; ?>"><?php echo $ncategory['name']; ?></option>
          <?php } ?>
          <?php } ?>
          </select>
          </td>
          <td class="column-layout">
              <label class="visible-480"><?php echo $entry_layout; ?></label>
              <select name="news_module[<?php echo $module_row; ?>][layout_id]" class="span2 i-medium">
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
                <select name="news_module[<?php echo $module_row; ?>][position]" class="span2 i-medium">
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
                <select name="news_module[<?php echo $module_row; ?>][status]" class="input-small">
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
                <input type="text" name="news_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" class="span1 i-mini" /></td>
            <td class="column-action"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>
          </tr>
        </tbody>
        <?php $module_row++; ?>
        <?php } ?>
        <tfoot>
            <tr>
              <td colspan="6"></td>
              <td class="column-action"><a onclick="addModule();" class="btn btn-small" title="<?php echo $button_add_module; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_module; ?></span></a></td>
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
	html += '    <td class="column-number"><label class="visible-480"><?php echo addslashes($entry_limit); ?></label><input type="text" name="news_module[' + module_row + '][news_limit]" value="4" size="3" class="span1 i-mini"/></td>';
	html += '    <td class="column-cat"><label class="visible-480"><?php echo addslashes($entry_cat); ?></label><select name="news_module[' + module_row + '][ncategory_id]" class="span2 i-medium">';
	html += '      <option value="all"><?php echo $entry_nocat; ?></option>';
	html += '      <option value="" disabled="disabled">By Categories:</option>';
	<?php foreach ($ncategories as $ncategory ){ ?>
	html += '      <option value="<?php echo $ncategory['ncategory_id']; ?>"><?php echo str_replace("'", "s", $ncategory['name']); ?></option>';
	<?php } ?>       
	html += '    </select></td>';
	html += '    <td class="column-layout"><label class="visible-480"><?php echo addslashes($entry_layout); ?></label><select name="news_module[' + module_row + '][layout_id]" class="span2 i-medium">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="column-position"><label class="visible-480"><?php echo addslashes($entry_position); ?></label><select name="news_module[' + module_row + '][position]" class="span2 i-medium">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="column-status"><label class="visible-480"><?php echo addslashes($entry_status); ?></label><select name="news_module[' + module_row + '][status]" class="input-small">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="column-sort"><label class="visible-480"><?php echo addslashes($entry_sort_order); ?></label><input type="text" name="news_module[' + module_row + '][sort_order]" value="" size="3" class="span1 i-mini"/></td>';
	html += '    <td class="column-action"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
        
         <?php if ($this->config->get('p3adminrebooted_select2')) { ?>
             $('#module-row' + module_row + ' select').select2();
        <?php } ?>
            
	module_row++;
}
//--></script>
<?php echo $newspanel; ?>