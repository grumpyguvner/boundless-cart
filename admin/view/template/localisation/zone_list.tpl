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

			<?php if ($zones) { ?>
			<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <td class="column-checkbox">
								<input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);">
							</td>
              <td class="column-name">
								<?php echo p3html::tb_sort_heading($column_country, $sort_country, $sort, $order, 'c.name'); ?>
							</td>
              <td class="column-name">
								<?php echo p3html::tb_sort_heading($column_name, $sort_name, $sort, $order, 'z.name'); ?>
							</td>
              <td class="column-code">
								<?php echo p3html::tb_sort_heading($column_code, $sort_code, $sort, $order, 'z.code'); ?>
							</td>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($zones as $zone) { ?>
            <tr>
              <td class="column-checkbox">
                <input type="checkbox" name="selected[]" value="<?php echo $zone['zone_id']; ?>"<?php if ($zone['selected']) { ?> checked="checked"<?php } ?>>
							</td>
              <td class="column-name"><?php echo $zone['country']; ?></td>
              <td class="column-name"><?php echo $zone['name']; ?></td>
              <td class="column-code"><?php echo $zone['code']; ?></td>
              <td class="column-action">
								<?php echo p3html::tb_action_buttons($zone); ?>
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