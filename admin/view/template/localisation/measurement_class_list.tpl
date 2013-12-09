<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-compass"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
			<?php if ($success) { ?>
				<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_insert($button_insert, $insert); ?>
				<?php echo p3html::tb_form_button_delete($button_delete); ?>
			</div>
    </div>

    <div class="content">

			<?php if ($measurement_classes) { ?>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-checkbox">
								<input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);">
							</th>
              <th class="column-name">
								<?php echo p3html::tb_sort_heading($column_title, $sort_title, $sort, $order, 'title'); ?>
							</th>
              <th class="column-code">
								<?php echo p3html::tb_sort_heading($column_unit, $sort_unit, $sort, $order, 'unit'); ?>
							</th>
              <th class="column-number">
								<?php echo p3html::tb_sort_heading($column_value, $sort_value, $sort, $order, 'value'); ?>
							</th>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($measurement_classes as $measurement_class) { ?>
            <tr>
              <td class="column-checkbox">
                <input type="checkbox" name="selected[]" value="<?php echo $measurement_class['measurement_class_id']; ?>"<?php if ($measurement_class['selected']) { ?> checked="checked"<?php } ?>>
							</td>
              <td class="column-name"><?php echo $measurement_class['title']; ?></td>
              <td class="column-code"><?php echo $measurement_class['unit']; ?></td>
              <td class="column-number"><?php echo $measurement_class['value']; ?></td>
              <td class="column-action">
								<?php echo p3html::tb_action_buttons($measurement_class); ?>
							</td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>

      <div class="pagination"><?php echo $pagination; ?></div>
			<?php } else { ?>
			<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
			<?php } ?>

    </div>
  </div>
</div>
<?php echo $footer; ?>