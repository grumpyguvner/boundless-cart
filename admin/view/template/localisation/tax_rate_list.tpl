<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-dollar"></i> <?php echo $heading_title; ?></h1>

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

			<?php if ($tax_rates) { ?>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-checkbox">
								<input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);">
							</th>
              <th class="column-name">
								<?php echo p3html::tb_sort_heading($column_name, $sort_name, $sort, $order, 'tr.name'); ?>
							</th>
              <th class="column-name">
								<?php echo p3html::tb_sort_heading($column_rate, $sort_rate, $sort, $order, 'tr.rate'); ?>
							</th>
              <th class="column-name">
								<?php echo p3html::tb_sort_heading($column_type, $sort_type, $sort, $order, 'tr.type'); ?>
							</th>
              <th class="column-name">
								<?php echo p3html::tb_sort_heading($column_geo_zone, $sort_geo_zone, $sort, $order, 'gz.name'); ?>
							</th>
              <th class="column-date">
								<?php echo p3html::tb_sort_heading($column_date_added, $sort_date_added, $sort, $order, 'tr.date_added'); ?>
							</th>
              <th class="column-date">
								<?php echo p3html::tb_sort_heading($column_date_modified, $sort_date_modified, $sort, $order, 'tr.date_modified'); ?>
							</th>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($tax_rates as $tax_rate) { ?>
            <tr>
              <td class="column-checkbox">
                <input type="checkbox" name="selected[]" value="<?php echo $tax_rate['tax_rate_id']; ?>"<?php if ($tax_rate['selected']) { ?> checked="checked"<?php } ?>>
							</td>
              <td class="column-name"><?php echo $tax_rate['name']; ?></td>
              <td class="column-name"><?php echo $tax_rate['rate']; ?></td>
              <td class="column-name"><?php echo $tax_rate['type']; ?></td>
              <td class="column-name"><?php echo $tax_rate['geo_zone']; ?></td>
              <td class="column-date"><?php echo $tax_rate['date_added']; ?></td>
              <td class="column-date"><?php echo $tax_rate['date_modified']; ?></td>
              <td class="column-action">
								<?php echo p3html::tb_action_buttons($tax_rate); ?>
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