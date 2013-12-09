<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-chart-bar"></i> <?php echo $heading_title; ?></h1>
			<?php if ($success) { ?>
				<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
          <?php echo p3html::tb_form_button($button_reset, "location = '$reset';", null, 'back'); ?>
          <?php echo p3html::tb_form_button($button_export, "location = '$export';", null, 'download'); ?>
			</div>
    </div>

    <div class="content">

			<?php if ($products) { ?>
      <table class="list table table-striped table-hover">
        <thead>
          <tr>
            <th class="column-name"><?php echo $column_name; ?></th>
            <th class="column-model hidden-phone"><?php echo $column_model; ?></th>
            <th class="column-number"><?php echo $column_viewed; ?></th>
            <th class="column-number"><?php echo $column_percent; ?></th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($products as $product) { ?>
          <tr>
            <td class="column-name"><?php echo $product['name']; ?></td>
            <td class="column-model hidden-phone"><?php echo $product['model']; ?></td>
            <td class="column-number"><?php echo $product['viewed']; ?></td>
            <td class="column-number"><?php echo $product['percent']; ?></td>
          </tr>
          <?php } ?>
        </tbody>
      </table>

      
      <div class="pagination"><?php echo $pagination; ?></div>
			<?php } else { ?>
			<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
			<?php } ?>

    </div>
  </div>
</div>

<?php echo $footer; ?>