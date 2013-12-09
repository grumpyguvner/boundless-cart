<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-star"></i> <?php echo $heading_title; ?></h1>
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
            <label class="control-label"><?php echo $entry_product; ?></label>
            <div class="controls"><input type="text" name="product" value="" class="span6 i-xxlarge"></div>
          </div>
          <div class="control-group">
            <label class="control-label">&nbsp;</label>
            <div class="controls">
							<div id="featured-product" class="scrollbox">
                <?php $class = 'odd'; ?>
                <?php foreach ($products as $product) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div id="featured-product<?php echo $product['product_id']; ?>" class="<?php echo $class; ?>">
									<i class="btn btn-small icon-trash ims remove" title="<?php echo $button_remove; ?>"></i> <?php echo $product['name']; ?>
                  <input type="hidden" value="<?php echo $product['product_id']; ?>">
                </div>
                <?php } ?>
              </div>
              <input type="hidden" name="featured_product" value="<?php echo $featured_product; ?>">
						</div>
          </tr>
        </div>

        <div class="row">
        <div id="module-wrapper" class="span12">
        <table id="module" class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-number"><?php echo $entry_limit; ?></th>
              <th class="column-dimension"><?php echo $entry_image; ?></th>
              <th class="column-layout"><?php echo $entry_layout; ?></th>
              <th class="column-position"><?php echo $entry_position; ?></th>
              <th class="column-status"><?php echo $entry_status; ?></th>
              <th class="column-sort"><?php echo $entry_sort_order; ?></th>
              <th></th>
            </tr>
          </thead>
          <?php $module_row = 0; ?>
          <?php foreach ($modules as $module) { ?>
          <tbody id="module-row<?php echo $module_row; ?>">
            <tr>
              <td class="column-number">
								<label class="visible-480"><?php echo $entry_limit; ?></label>
								<input type="text" name="featured_module[<?php echo $module_row; ?>][limit]" value="<?php echo $module['limit']; ?>" class="span1 i-mini">
							</td>
              <td class="column-dimension<?php if (isset($error_image[$module_row])) { ?> error<?php } ?>">
								<label class="visible-480"><?php echo $entry_image; ?></label>
								<input type="text" name="featured_module[<?php echo $module_row; ?>][image_width]" value="<?php echo $module['image_width']; ?>" class="span1 i-mini">
                <input type="text" name="featured_module[<?php echo $module_row; ?>][image_height]" value="<?php echo $module['image_height']; ?>" class="span1 i-mini">
                <?php if (isset($error_image[$module_row])) { ?>
                <span class="error help-block"><?php echo $error_image[$module_row]; ?></span>
                <?php } ?>
							</td>
              <td class="column-layout">
								<label class="visible-480"><?php echo $entry_layout; ?></label>
								<select name="featured_module[<?php echo $module_row; ?>][layout_id]" class="span2 i-large">
                  <?php echo p3html::oc_layout_options($layouts, $module); ?>
                </select>
							</td>
              <td class="column-position">
								<label class="visible-480"><?php echo $entry_position; ?></label>
								<select name="featured_module[<?php echo $module_row; ?>][position]" class="span2 i-medium">
                  <?php echo p3html::oc_position_options($this->language, $module); ?>
                </select>
							</td>
              <td class="column-status">
								<label class="visible-480"><?php echo $entry_status; ?></label>
								<select name="featured_module[<?php echo $module_row; ?>][status]" class="input-small">
                  <?php echo p3html::oc_status_options($this->language, $module); ?>
                </select>
							</td>
              <td class="column-sort">
								<label class="visible-480"><?php echo $entry_sort_order; ?></label>
								<input type="text" name="featured_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" class="span1 i-mini">
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
$('input[name=\'product\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('#featured-product' + ui.item.value).remove();

		$('#featured-product').append('<div id="featured-product' + ui.item.value + '"><i class="btn btn-small icon-trash ims" title="<?php echo $button_remove; ?>"></i> ' + ui.item.label + '<input type="hidden" value="' + ui.item.value + '"></div>');

		$('#featured-product div:odd').attr('class', 'odd');
		$('#featured-product div:even').attr('class', 'even');

		data = $.map($('#featured-product input'), function(element){
			return $(element).attr('value');
		});

		$('input[name=\'featured_product\']').attr('value', data.join());

		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

$('#featured-product div i').live('click', function() {
	$(this).parent().remove();

	$('#featured-product div:odd').attr('class', 'odd');
	$('#featured-product div:even').attr('class', 'even');

	data = $.map($('#featured-product input'), function(element){
		return $(element).attr('value');
	});

	$('input[name=\'featured_product\']').attr('value', data.join());
});
</script>
<script>
var module_row = <?php echo $module_row; ?>;

function addModule() {
	html  = '<tr id="module-row' + module_row + '">';
	html += '	<td class="column-number"><label class="visible-480"><?php echo addslashes($entry_limit); ?></label><input type="text" name="featured_module[' + module_row + '][limit]" value="5" class="span1 i-mini"></td>';
	html += '	<td class="column-dimension"><label class="visible-480"><?php echo addslashes($entry_image); ?></label><input type="text" name="featured_module[' + module_row + '][image_width]" value="80" class="span1 i-mini"> <input type="text" name="featured_module[' + module_row + '][image_height]" value="80" class="span1 i-mini"></td>';
	html += '	<td class="column-layout"><label class="visible-480"><?php echo addslashes($entry_layout); ?></label><select name="featured_module[' + module_row + '][layout_id]" class="span2 i-large">';
	html += '		<?php echo p3html::oc_layout_options($layouts, null, true); ?>';
	html += '	</select></td>';
	html += '	<td class="column-position"><label class="visible-480"><?php echo addslashes($entry_position); ?></label><select name="featured_module[' + module_row + '][position]" class="span2 i-medium">';
	html += '		<?php echo p3html::oc_position_options($this->language, null, true); ?>';
	html += '	</select></td>';
	html += '	<td class="column-status"><label class="visible-480"><?php echo addslashes($entry_status); ?></label><select name="featured_module[' + module_row + '][status]" class="input-small">';
	html += '		<?php echo p3html::oc_status_options($this->language, null, true); ?>';
  html += '	</select></td>';
	html += '	<td class="column-sort"><label class="visible-480"><?php echo addslashes($entry_sort_order); ?></label><input type="text" name="featured_module[' + module_row + '][sort_order]" value="" class="span1 i-mini"></td>';
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