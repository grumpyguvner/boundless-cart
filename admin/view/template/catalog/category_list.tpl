<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-sitemap"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
			<?php if ($success) { ?>
				<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_insert($button_insert, $insert); ?>
				<?php echo p3html::tb_form_button_delete($button_delete, '#form'); ?>
			</div>
    </div>

		<?php if ($categories) { ?>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-checkbox">
								<input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);">
							</th>
              <th class="column-name"><?php echo $column_name; ?></th>
              <th class="column-sort"><?php echo $column_sort_order; ?></th>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($categories as $category) { ?>
            <tr>
              <td class="column-checkbox" style="text-align: center;">
                <input type="checkbox" name="selected[]" value="<?php echo $category['category_id']; ?>"<?php if ($category['selected']) { ?> checked="checked"<?php } ?>>
							</td>
              <td class="column-name"><?php echo $category['name']; ?></td>
              <td class="column-sort"><?php echo $category['sort_order']; ?></td>
              <td class="column-action">
								<?php echo p3html::tb_action_buttons($category); ?>
							</td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
			<?php } else { ?>
			<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
			<?php } ?>

    </div>
  </div>
</div>

<?php echo $footer; ?>