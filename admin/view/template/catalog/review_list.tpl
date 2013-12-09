<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-newspaper"></i> <?php echo $heading_title; ?></h1>

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

			<?php if ($reviews) { ?>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-checkbox">
								<input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);">
							</th>
              <th class="column-name">
									<?php echo p3html::tb_sort_heading($column_product, $sort_product, $sort, $order, 'pd.name'); ?>
							</th>
              <th class="column-name hidden-phone">
								<?php echo p3html::tb_sort_heading($column_author, $sort_author, $sort, $order, 'r.author'); ?>
							</th>
              <th class="column-number">
								<?php echo p3html::tb_sort_heading($column_rating, $sort_rating, $sort, $order, 'r.rating'); ?>
							</th>
              <th class="column-status hidden-phone">
								<?php echo p3html::tb_sort_heading($column_status, $sort_status, $sort, $order, 'r.status'); ?>
							</th>
              <th class="column-date hidden-phone">
								<?php echo p3html::tb_sort_heading($column_date_added, $sort_date_added, $sort, $order, 'r.date_added'); ?>
							</th>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($reviews as $review) { ?>
            <tr>
              <td class="column-checkbox">
                <input type="checkbox" name="selected[]" value="<?php echo $review['review_id']; ?>"<?php if ($review['selected']) { ?> checked="checked"<?php } ?>>
							</td>
              <td class="column-name"><?php echo $review['name']; ?></td>
              <td class="column-name hidden-phone"><?php echo $review['author']; ?></td>
              <td class="column-number"><?php echo $review['rating']; ?></td>
              <td class="column-status hidden-phone"><?php echo $review['status']; ?></td>
              <td class="column-date hidden-phone"><?php echo $review['date_added']; ?></td>
              <td class="column-action">
								<?php echo p3html::tb_action_buttons($review); ?>
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