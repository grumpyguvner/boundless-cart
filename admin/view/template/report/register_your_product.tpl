<?php echo $header; ?>
<div id="content">
    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">
    <div class="heading">
      <h1><img src="view/image/report.png" alt="" /> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
      
        <?php if ($customers) { ?>
            <table class="list table table-striped table-hover">
                <thead>
                    <tr>
                        <th class="column-name"><?php echo $column_name; ?></th>
                        <th class="column-email hidden-phone"><?php echo $column_email; ?></th>
                        <th class="column-location"><?php echo $column_location; ?></th>
                        <th class="column-barcode"><?php echo $column_barcode; ?></th>
                        <th class="column-date"><?php echo $column_date_purchased; ?></th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($customers as $customer) { ?>
                        <tr>
                            <td class="column-name"><?php echo $customer['name']; ?></td>
                            <td class="column-email hidden-phone"><?php echo $customer['email']; ?></td>
                            <td class="column-location"><?php echo $customer['location']; ?></td>
                            <td class="column-barcode"><?php echo $customer['barcode']; ?></td>
                            <td class="column-date"><?php echo $customer['date_purchased']; ?></td>
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