<?php echo $header; ?>
<div id="content">
  
  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-flag"></i> <?php echo $heading_title; ?></h1>
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
        <table id="module" class="list table table-striped table-hover">
          <thead>
            <tr>
              <td class="column-name"><?php echo $entry_banner; ?></td>
              <td class="column-dimension"><i class="required text-error icon-asterisk"></i> <?php echo $entry_dimension; ?></td>
              <td class="column-layout"><?php echo $entry_layout; ?></td>
              <td class="column-category"><?php echo $entry_category; ?></td>
              <td class="column-position"><?php echo $entry_position; ?></td>
              <td class="column-status"><?php echo $entry_status; ?></td>
              <td class="column-sort"><?php echo $entry_sort_order; ?></td>
              <td></td>
            </tr>
          </thead>
          <?php $module_row = 0; ?>
          <?php foreach ($modules as $module) { ?>
          <tbody id="module-row<?php echo $module_row; ?>">
            <tr>
                <td class="column-name">
                    <label class="visible-480"><?php echo $entry_banner; ?></label>
                    <select name="category_banner_module[<?php echo $module_row; ?>][banner_id]" class="span2 i-large">
                        <?php echo p3html::oc_banner_options($banners, $module); ?>
                    </select>
                </td>
                <td class="column-dimension<?php if (isset($error_dimension[$module_row])) { ?> error<?php } ?>">
                    <label class="visible-480"><?php echo $entry_dimension; ?></label>
                    <input type="text" name="category_banner_module[<?php echo $module_row; ?>][width]" value="<?php echo $module['width']; ?>" class="span1 i-mini">
                    <input type="text" name="category_banner_module[<?php echo $module_row; ?>][height]" value="<?php echo $module['height']; ?>" class="span1 i-mini">
                    <?php if (isset($error_dimension[$module_row])) { ?>
                    <span class="error help-block"><?php echo $error_dimension[$module_row]; ?></span>
                    <?php } ?>
                </td>
                <td class="column-layout">
                    <label class="visible-480"><?php echo $entry_layout; ?></label>
                    <select name="category_banner_module[<?php echo $module_row; ?>][layout_id]" class="span2 i-medium">
                        <?php echo p3html::oc_layout_options($layouts, $module); ?>
                    </select>
                </td>
                <td class="column-layout">
                    <select name="category_banner_module[<?php echo $module_row; ?>][category_id]">
                  <?php foreach ($categories as $category) { ?>
                  <?php if ($category['category_id'] == $module['category_id']) { ?>
                        <option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?></option>
                  <?php } else { ?>
                        <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                    </select>
                </td>
                <td class="column-position">
                    <label class="visible-480"><?php echo $entry_position; ?></label>
                    <select name="category_banner_module[<?php echo $module_row; ?>][position]" class="span2 i-medium">
                  <?php echo p3html::oc_position_options($this->language, $module); ?>
                    </select>
                </td>
                <td class="column-status">
                    <label class="visible-480"><?php echo $entry_status; ?></label>
                    <select name="category_banner_module[<?php echo $module_row; ?>][status]" class="input-small">
                  <?php echo p3html::oc_status_options($this->language, $module); ?>
                    </select>
                </td>
                <td class="column-sort">
                        <label class="visible-480"><?php echo $entry_sort_order; ?></label>
                        <input type="text" name="category_banner_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" class="span1 i-mini">
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
              <td colspan="7"></td>
              <td class="left"><a onclick="addModule();" class="button"><?php echo $button_add_module; ?></a></td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>
<script>
var module_row = <?php echo $module_row; ?>;

function addModule() {
	html  = '<tr id="module-row' + module_row + '">';
	html += '	<td class="column-name">';
	html += '		<label class="visible-480"><?php echo addslashes($entry_banner); ?></label>';
	html += '		<select name="category_banner_module[' + module_row + '][banner_id]" class="span2 i-large">';
	html += '			<?php echo p3html::oc_banner_options($banners, null, true); ?>';
	html += '		</select>';
	html += '	</td>';
	html += '	<td class="column-dimension"><label class="visible-480"><?php echo addslashes($entry_dimension); ?></label><input type="text" name="category_banner_module[' + module_row + '][width]" value="" class="span1 i-mini"> <input type="text" name="category_banner_module[' + module_row + '][height]" value="" class="span1 i-mini"></td>';
	html += '	<td class="column-layout">';
	html += '		<label class="visible-480"><?php echo addslashes($entry_layout); ?></label>';
	html += '		<select name="category_banner_module[' + module_row + '][layout_id]" class="span2 i-medium">';
	html += '			<?php echo p3html::oc_layout_options($layouts, null, true); ?>';
	html += '		</select>';
	html += '	</td>';
        html += '    <td class="column-category"><select name="category_banner_module[' + module_row + '][category_id]">';
	<?php foreach ($categories as $category) { ?>
	html += '      <option value="<?php echo $category['category_id']; ?>"><?php echo addslashes($category['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '	<td class="column-position">';
	html += '		<label class="visible-480"><?php echo addslashes($entry_position); ?></label>';
	html += '		<select name="category_banner_module[' + module_row + '][position]" class="span2 i-medium">';
	html += '			<?php echo p3html::oc_position_options($this->language); ?>';
	html += '		</select>';
	html += '	</td>';
	html += '	<td class="column-status">';
	html += '		<label class="visible-480"><?php echo addslashes($entry_status); ?></label>';
	html += '		<select name="name="category_banner_module[' + module_row + '][status]" class="input-small">';
	html += '			<?php echo p3html::oc_status_options($this->language, null, true); ?>';
  html += '		</select>';
  html += '	</td>';
	html += '	<td class="column-sort"><label class="visible-480"><?php echo addslashes($entry_sort_order); ?></label><input type="text" name="category_banner_module[' + module_row + '][sort_order]" value="" class="span1 i-mini"></td>';
	html += '	<td class="column-action"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
	html += '</tr>';

	$('#module tbody').append(html);

	<?php if ($this->config->get('p3adminrebooted_select2')) { ?>
	$('#module-row' + module_row + ' select').select2();
	<?php } ?>

	module_row++;
}
</script>
<?php echo $footer; ?>