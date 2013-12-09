<?php echo $header; ?>

<div id="content">

	<?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-globe"></i> <?php echo $heading_title; ?></h1>
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

			<?php if ($countries) { ?>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">

        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-checkbox"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);"></th>
              <th class="column-name">
								<?php echo p3html::tb_sort_heading($column_name, $sort_name, $sort, $order, 'name'); ?>
							</th>
              <th class="column-code hidden-phone">
								<?php echo p3html::tb_sort_heading($column_iso_code_2, $sort_iso_code_2, $sort, $order, 'iso_code_2'); ?>
							</th>
              <th class="column-code hidden-phone">
								<?php echo p3html::tb_sort_heading($column_iso_code_3, $sort_iso_code_3, $sort, $order, 'iso_code_3'); ?>
							</th>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($countries as $country) { ?>
            <tr>
              <td class="column-checkbox">
                <input type="checkbox" name="selected[]" value="<?php echo $country['country_id']; ?>"<?php if ($country['selected']) { ?> checked="checked"<?php } ?>>
							</td>
              <td class="column-name"><?php echo $country['name']; ?></td>
              <td class="column-code hidden-phone"><?php echo $country['iso_code_2']; ?></td>
              <td class="column-code hidden-phone"><?php echo $country['iso_code_3']; ?></td>
              <td class="column-action">
								<?php echo p3html::tb_action_buttons($country); ?>
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