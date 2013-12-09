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
      <td class="column-date"><b><?php echo $column_date_added; ?></b></td>
      <td class="column-name"><b><?php echo $column_comment; ?></b></td>
      <td class="column-status"><b><?php echo $column_status; ?></b></td>
      <td class="column-notify"><b><?php echo $column_notify; ?></b></td>
    </tr>
  </thead>
  <tbody>
    <?php foreach ($histories as $history) { ?>
    <tr>
      <td class="column-date"><?php echo $history['date_added']; ?></td>
      <td class="column-name"><?php echo ($history['comment']) ? '<div class="comment">' . $history['comment'] . '</div>' : ''; ?><?php echo ($history['notes']) ? '<div class="notes">' . $history['notes'] . '</div>' : ''; ?></td>
      <td class="column-status"><?php echo $history['status']; ?></td>
      <td class="column-notify"><?php echo $history['notify']; ?></td>
    </tr>
    <?php } ?>
  </tbody>
</table>
<div class="pagination"><?php echo $pagination; ?></div>
<?php } else { ?>
<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
<?php } ?>
