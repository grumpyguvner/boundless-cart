<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-wrench"></i> <?php echo $heading_title; ?></h1>
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

			<?php if ($stores) { ?>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-checkbox"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);"></th>
              <th class="column-name"><?php echo $column_name; ?></a></th>
              <th class="column-url hidden-phone"><?php echo $column_url; ?></th>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($stores as $store) { ?>
            <tr>
              <td class="column-checkbox">
                <input type="checkbox" name="selected[]" value="<?php echo $store['store_id']; ?>"<?php if ($store['selected']) { ?> checked="checked"<?php } ?>>
							</td>
              <td class="column-name"><?php echo $store['name']; ?></td>
              <td class="column-url hidden-phone"><?php echo $store['url']; ?></td>
              <td class="column-action">
								<?php echo p3html::tb_action_buttons($store); ?>
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