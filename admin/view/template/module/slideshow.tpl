<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-picture"></i> <?php echo $heading_title; ?></h1>
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
              <th class="column-name"><?php echo $entry_banner; ?></th>
              <th class="column-dimension"><?php echo $entry_dimension; ?></th>
              <th class="column-layout"><?php echo $entry_layout; ?></th>
              <th class="column-position"><?php echo $entry_position; ?></th>
              <th class="column-status"><?php echo $entry_status; ?></th>
              <th class="column-sort"><?php echo $entry_sort_order; ?></th>
              <th class="column-action"></th>
            </tr>
          </thead>
					<tbody>
						<?php $module_row = 0; ?>
						<?php foreach ($modules as $module) { ?>
						<tr id="module-row<?php echo $module_row; ?>">
              <td class="column-name">
								<label class="visible-480"><?php echo $entry_banner; ?></label>
								<select name="slideshow_module[<?php echo $module_row; ?>][banner_id]" class="input-large">
                  <?php echo p3html::oc_banner_options($banners, $module); ?>
                </select>
							</td>
              <td class="column-dimension <?php if (isset($error_dimension[$module_row])) { ?> error<?php } ?>">
								<label class="visible-480"><?php echo $entry_dimension; ?></label>
								<input type="text" name="slideshow_module[<?php echo $module_row; ?>][width]" value="<?php echo $module['width']; ?>" class="span1 i-mini">
                <input type="text" name="slideshow_module[<?php echo $module_row; ?>][height]" value="<?php echo $module['height']; ?>" class="span1 i-mini">
                <?php if (isset($error_dimension[$module_row])) { ?>
                <span class="error help-block"><?php echo $error_dimension[$module_row]; ?></span>
                <?php } ?>
							</td>
              <td class="column-layout">
								<label class="visible-480"><?php echo $entry_layout; ?></label>
								<select name="slideshow_module[<?php echo $module_row; ?>][layout_id]" class="span2 i-medium">
                  <?php echo p3html::oc_layout_options($layouts, $module); ?>
                </select>
							</td>
              <td class="column-position">
								<label class="visible-480"><?php echo $entry_position; ?></label>
								<select name="slideshow_module[<?php echo $module_row; ?>][position]" class="span2 i-medium">
                  <?php echo p3html::oc_position_options($this->language, $module); ?>
                </select>
							</td>
              <td class="column-status">
								<label class="visible-480"><?php echo $entry_status; ?></label>
								<select name="slideshow_module[<?php echo $module_row; ?>][status]" class="input-small">
                  <?php echo p3html::oc_status_options($this->language, $module); ?>
                </select>
							</td>
              <td class="column-sort">
								<label class="visible-480"><?php echo $entry_sort_order; ?></label>
								<input type="text" name="slideshow_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" class="span1 i-mini">
							</td>
              <td class="column-action">
								<a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
							</td>
            </tr>
						<?php $module_row++; ?>
						<?php } ?>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="6"></td>
              <td class="column-action"><a onclick="addModule();" class="btn btn-small" title="<?php echo $button_add_module; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_module; ?></span></a></td>
            </tr>
          </tfoot>
        </table>
		    </div>
				</div>

      </form>

    </div>
  </div>
</div>

<script>
var module_row = <?php echo $module_row; ?>;

function addModule() {
	html  = '<tr id="module-row' + module_row + '">';
	html += '	<td class="column-name"><label class="visible-480"><?php echo addslashes($entry_banner); ?></label><select name="slideshow_module[' + module_row + '][banner_id]" class="input-large">';
	html += '		<?php echo p3html::oc_banner_options($banners, null, true); ?>';
	html += '	</select></td>';
	html += '	<td class="column-dimension"><label class="visible-480"><?php echo addslashes($entry_dimension); ?></label><input type="text" name="slideshow_module[' + module_row + '][width]" value="" class="span1 i-mini"> <input type="text" name="slideshow_module[' + module_row + '][height]" value="" class="span1 i-mini"></td>';
	html += '	<td class="column-layout"><label class="visible-480"><?php echo addslashes($entry_status); ?></label><select name="slideshow_module[' + module_row + '][layout_id]" class="span2 i-medium">';
	html += '		<?php echo p3html::oc_layout_options($layouts, null, true); ?>';
	html += '	</select></td>';
	html += '	<td class="column-position"><label class="visible-480"><?php echo addslashes($entry_position); ?></label><select name="slideshow_module[' + module_row + '][position]" class="span2 i-medium">';
	html += '		<?php echo p3html::oc_position_options($this->language, null, true); ?>';
	html += '	</select></td>';
	html += '	<td class="column-status"><label class="visible-480"><?php echo addslashes($entry_status); ?></label><select name="slideshow_module[' + module_row + '][status]" class="input-small">';
	html += '		<?php echo p3html::oc_status_options($this->language, null, true); ?>';
  html += '	</select></td>';
	html += '	<td class="column-sort"><label class="visible-480"><?php echo addslashes($entry_sort_order); ?></label><input type="text" name="slideshow_module[' + module_row + '][sort_order]" value="" class="span1 i-mini"></td>';
	html += '	<td class="column-action"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
	html += '</tr>';

	$('#module tbody').append(html);

	<?php if ($this->config->get('p3adminrebooted_select2')) { ?>
	$('#module-row' + module_row + ' select').select2();
	<?php } ?>

	module_row++;
}
</script>
<?php echo $footer; ?>