<?php require_once DIR_TEMPLATE.'helper/p3html.php'?>

<?php if ($histories) { ?>
<table class="list table table-striped table-hover">
  <thead>
    <tr>
      <th class="column-id"><?php echo $column_order_id; ?></th>
      <th class="column-name"><?php echo $column_customer; ?></th>
      <th class="column-price"><?php echo $column_amount; ?></th>
      <th class="column-date hidden-phone"><?php echo $column_date_added; ?></th>
    </tr>
  </thead>
  <tbody>
    <?php foreach ($histories as $history) { ?>
    <tr>
      <td class="column-id"><?php echo $history['order_id']; ?></td>
      <td class="column-name"><?php echo $history['customer']; ?></td>
      <td class="column-price"><?php echo $history['amount']; ?></td>
      <td class="column-date hidden-phone"><?php echo $history['date_added']; ?></td>
    </tr>
    <?php } ?>
  </tbody>
</table>

<div class="pagination"><?php echo $pagination; ?></div>

<?php } else { ?>
<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
<?php } ?>
