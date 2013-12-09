<?php require_once DIR_TEMPLATE.'helper/p3html.php'?>

<?php if ($error_warning) { ?>
	<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
<?php } ?>
<?php if ($success) { ?>
	<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
<?php } ?>

<?php if ($rewards) { ?>
<table class="list table table-striped table-hover">
  <thead>
    <tr>
      <th class="column-date"><?php echo $column_date_added; ?></th>
      <th class="column-name"><?php echo $column_description; ?></th>
      <th class="column-number"><?php echo $column_points; ?></th>
    </tr>
  </thead>
  <tbody>
    <?php foreach ($rewards as $reward) { ?>
    <tr>
      <td class="column-date"><?php echo $reward['date_added']; ?></td>
      <td class="column-name"><?php echo $reward['description']; ?></td>
      <td class="column-number"><?php echo $reward['points']; ?></td>
    </tr>
    <?php } ?>
  </tbody>
  <tfoot>
    <tr>
      <th class="column-total" colspan="2"><?php echo $text_balance; ?></th>
      <td class="column-number"><?php echo $balance; ?></td>
    </tr>
  </tfoot>
</table>

<div class="pagination"><?php echo $pagination; ?></div>

<?php } else { ?>
<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
<?php } ?>
