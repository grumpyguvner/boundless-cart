<?php require_once DIR_TEMPLATE.'helper/p3html.php'?>

<?php if ($error) { ?>
	<?php echo p3html::tb_alert('error', $error, true, 'warning'); ?>
<?php } ?>
<?php if ($success) { ?>
	<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
<?php } ?>

<?php if ($histories) { ?>
<table class="list table table-striped table-hover">
  <thead>
    <tr>
      <th class="column-date"><?php echo $column_date_added; ?></th>
      <th class="column-name"><?php echo $column_comment; ?></th>
      <th class="column-status"><?php echo $column_status; ?></th>
      <th class="column-status"><?php echo $column_notify; ?></th>
    </tr>
  </thead>
  <tbody>
    <?php foreach ($histories as $history) { ?>
    <tr>
      <td class="column-date"><?php echo $history['date_added']; ?></td>
      <td class="column-name"><?php echo $history['comment']; ?></td>
      <td class="column-status"><?php echo $history['status']; ?></td>
      <td class="column-status"><?php echo $history['notify']; ?></td>
    </tr>
    <?php } ?>
  </tbody>
</table>

<div class="pagination"><?php echo $pagination; ?></div>

<?php } else { ?>
<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
<?php } ?>
