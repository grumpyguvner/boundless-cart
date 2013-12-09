<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-tags"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
			<?php if ($success) { ?>
				<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
			<?php } ?>
			<?php if (!$error_warning) { ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_save($button_save); ?>
			</div>
			<?php } ?>
    </div>

    <div class="content">

			<?php if (!$error_warning) { ?>
			
			<?php if ($order_statuses) { ?>
      <form action="<?php echo $update; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
							<?php /*
              <th class="column-checkbox">
								<input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);">
							</th>
							*/?>
              <th class="column-name">
								<?php echo $column_name; ?>
							</th>
              <th class="column-action">Label</th>
            </tr>
          </thead>
          <tbody>
						<?php $count = 0; ?>
            <?php foreach ($order_statuses as $order_status) { ?>
						<?php $order_status_id = $order_status['order_status_id']; ?>
            <tr>
							<?php /*
              <td class="column-checkbox">
                <input type="checkbox" name="selected[]" value="<?php echo $order_status_id; ?>"<?php if ($order_status['selected']) { ?> checked="checked"<?php } ?>>
							</td>
							*/?>
              <td class="column-name">
								<?php if ($order_status['label']) { ?><span class="label label-<?php echo $order_status['label']; ?>"><?php } ?>
								<?php echo $order_status['name']; ?>
								<?php if ($order_status['label']) { ?></span><?php } ?>
							</td>
							<td class="column-action">
								<select name="order_status_labels[<?php echo $count; ?>][label]" class="span2">
									<?php echo $order_status['label_options']; ?>
								</select>
								<input type="hidden" name="order_status_labels[<?php echo $count; ?>][order_status_id]" value="<?php echo $order_status_id; ?>">
							</td>
            </tr>
						<?php $count++; ?>
						<?php } ?>
          </tbody>
        </table>
      </form>

			<?php } else { ?>
			<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
			<?php } ?>

			<?php } ?>

    </div>
  </div>
</div>

<?php echo $footer; ?>