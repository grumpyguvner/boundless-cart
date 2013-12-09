<?php require_once DIR_TEMPLATE.'helper/p3html.php'?>

<?php if ($histories) { ?>
<table class="list table table-striped table-hover">
  <thead>
    <tr>
      <th class="column-id"><b><?php echo $column_order_id; ?></b></th>
      <th class="column-name"><b><?php echo $column_customer; ?></b></th>
      <th class="column-price"><b><?php echo $column_amount; ?></b></th>
      <th class="column-date"><b><?php echo $column_date_added; ?></b></th>
    </tr>
  </thead>
  <tbody>
    <?php foreach ($histories as $history) { ?>
    <tr>
      <td class="column-id"><?php echo $history['order_id']; ?></td>
      <td class="column-name"><?php echo $history['customer']; ?></td>
      <td class="column-price"><?php echo $history['amount']; ?></td>
      <td class="column-date"><?php echo $history['date_added']; ?></td>
    </tr>
    <?php } ?>
  </tbody>
</table>

<div class="pagination"><?php echo $pagination; ?></div>

<?php } else { ?>
<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
<?php } ?>
