<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-list"></i> <?php echo $heading_title; ?></h1>
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
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
						<?php foreach ($languages as $language) { ?>
            <div class="controls language-row<?php if (isset($error_name[$language['language_id']])) { ?> error<?php } ?>">
              <input type="text" name="option_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($option_description[$language['language_id']]) ? $option_description[$language['language_id']]['name'] : ''; ?>" class="span3 i-xlarge">
              <i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i>
              <?php if (isset($error_name[$language['language_id']])) { ?>
              <span class="error help-block"><?php echo $error_name[$language['language_id']]; ?></span>
              <?php } ?>
  					</div>
						<?php } ?>
	        </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_type; ?></label>
            <div class="controls">
							<select name="type" class="input-medium">
                <optgroup label="<?php echo $text_choose; ?>">
									<option value="select"<?php if ($type == 'select') { ?> selected="selected"<?php } ?>><?php echo $text_select; ?></option>
									<option value="radio"<?php if ($type == 'radio') { ?> selected="selected"<?php } ?>><?php echo $text_radio; ?></option>
									<option value="checkbox"<?php if ($type == 'checkbox') { ?> selected="selected"<?php } ?>><?php echo $text_checkbox; ?></option>
									<option value="image"<?php if ($type == 'image') { ?> selected="selected"<?php } ?>><?php echo $text_image; ?></option>
                </optgroup>
                <optgroup label="<?php echo $text_input; ?>">
									<option value="text"<?php if ($type == 'text') { ?> selected="selected"<?php } ?>><?php echo $text_text; ?></option>
									<option value="textarea"<?php if ($type == 'textarea') { ?> selected="selected"<?php } ?>><?php echo $text_textarea; ?></option>
                </optgroup>
                <optgroup label="<?php echo $text_file; ?>">
									<option value="file"<?php if ($type == 'file') { ?> selected="selected"<?php } ?>><?php echo $text_file; ?></option>
                </optgroup>
                <optgroup label="<?php echo $text_date; ?>">
									<option value="date"<?php if ($type == 'date') { ?> selected="selected"<?php } ?>><?php echo $text_date; ?></option>
									<option value="time"<?php if ($type == 'time') { ?> selected="selected"<?php } ?>><?php echo $text_time; ?></option>
									<option value="datetime"<?php if ($type == 'datetime') { ?> selected="selected"<?php } ?>><?php echo $text_datetime; ?></option>
                </optgroup>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls"><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" class="input-mini"></div>
          </div>
        </div>

        <table id="option-value" class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-name"><i class="required text-error icon-asterisk"></i> <?php echo $entry_value; ?></th>
              <th class="column-image"><?php echo $entry_image; ?></th>
              <th class="column-sort"><?php echo $entry_sort_order; ?></th>
              <th class="column-action"></th>
            </tr>
          </thead>
          <tbody>
						<?php $option_value_row = 0; ?>
						<?php foreach ($option_values as $option_value) { ?>
            <tr id="option-value-row<?php echo $option_value_row; ?>">
              <td class="column-name span6">
								<input type="hidden" name="option_value[<?php echo $option_value_row; ?>][option_value_id]" value="<?php echo $option_value['option_value_id']; ?>">
                <?php foreach ($languages as $language) { ?>
								<div class="language-row<?php if (isset($error_option_value[$option_value_row][$language['language_id']])) { ?> error<?php } ?>">
									<input type="text" name="option_value[<?php echo $option_value_row; ?>][option_value_description][<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($option_value['option_value_description'][$language['language_id']]) ? $option_value['option_value_description'][$language['language_id']]['name'] : ''; ?>" class="span3 i-xlarge">
									<i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i>
									<?php if (isset($error_option_value[$option_value_row][$language['language_id']])) { ?>
									<span class="error help-block"><?php echo $error_option_value[$option_value_row][$language['language_id']]; ?></span>
									<?php } ?>
								</div>
                <?php } ?>
							</td>
              <td class="column-image span4">
								<div class="image">
									<img src="<?php echo $option_value['thumb']; ?>" alt="" id="thumb<?php echo $option_value_row; ?>">
                  <input type="hidden" name="option_value[<?php echo $option_value_row; ?>][image]" value="<?php echo $option_value['image']; ?>" id="image<?php echo $option_value_row; ?>" >
									<br><br>
									<a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('image<?php echo $option_value_row; ?>', 'thumb<?php echo $option_value_row; ?>', '<?php echo $token; ?>');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>
									<a class="btn" title="<?php echo $text_clear; ?>" onclick="$('#thumb<?php echo $option_value_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $option_value_row; ?>', '<?php echo $token; ?>').attr('value', '');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>
								</div>
							</td>
              <td class="column-sort span1"><input type="text" name="option_value[<?php echo $option_value_row; ?>][sort_order]" value="<?php echo $option_value['sort_order']; ?>" class="span1 i-mini"></td>
              <td class="column-action span1"><a onclick="$('#option-value-row<?php echo $option_value_row; ?>').remove();" class="btn btn-small"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>
            </tr>
						<?php $option_value_row++; ?>
						<?php } ?>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="3"></td>
              <td class="column-action">
								<a onclick="addOptionValue();" class="btn btn-small" title="<?php echo $button_add_option_value; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"><?php echo $button_add_option_value; ?></span></a>
							</td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>

<!--FILEMANAGER-->
<?php include_once DIR_TEMPLATE.'javascript/filemanager_dialog.tpl'; ?>
<!--FILEMANAGER-->

<script>
$('select[name=\'type\']').bind('change', function() {
	if (this.value == 'select' || this.value == 'radio' || this.value == 'checkbox' || this.value == 'image') {
		$('#option-value').show();
	} else {
		$('#option-value').hide();
	}
});

var option_value_row = <?php echo $option_value_row; ?>;

function addOptionValue() {
	html  = '\
	<tr id="option-value-row' + option_value_row + '">\n\
		<td class="column-name">\n\
			<input type="hidden" name="option_value[' + option_value_row + '][option_value_id]" value="">\n\
';
	<?php foreach ($languages as $language) { ?>
	html += '\
			<div class="language-row">\n\
				<input type="text" name="option_value[' + option_value_row + '][option_value_description][<?php echo $language['language_id']; ?>][name]" value=""> \n\
				<i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i>\n\
			</div>\n\
	';
  <?php } ?>
	html += '\
		</td>\n\
		<td class="column-image">\n\
			<div class="image">\n\
				<img src="<?php echo $no_image; ?>" alt="" id="thumb' + option_value_row + '"> \n\
				<input type="hidden" name="option_value[' + option_value_row + '][image]" value="" id="image' + option_value_row + '">\n\
				<br><br>\n\
				<a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload(\'image' + option_value_row + '\', \'thumb' + option_value_row + '\');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>\n\
				<a class="btn" title="<?php echo $text_clear; ?>" onclick="$(\'#thumb' + option_value_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + option_value_row + '\').attr(\'value\', \'\');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>\n\
			</div>\n\
		</td>\n\
		<td class="column-sort">\n\
			<input type="text" name="option_value[' + option_value_row + '][sort_order]" value="" class="span1 i-mini">\n\
		</td>\n\
		<td class="column-action">\n\
			<a onclick="$(\'#option-value-row' + option_value_row + '\').remove();" class="btn btn-small"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>\n\
		</td>\n\
	</tr>\n\
';

	$('#option-value tbody').append(html);

	option_value_row++;
}
</script>

<?php echo $footer; ?>