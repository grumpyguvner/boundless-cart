<?php echo $header; ?>
<div id="content">
  
  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>
    
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?></h1>
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
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
         <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-checkbox">
                  <input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" />
              </th>
              <th class="column-name">
                  <?php if ($sort == 'cd.name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                <?php } ?>
              </th>
                <th class="column-code hidden-phone">
                    <?php if ($sort == 'cd.code') { ?>
                <a href="<?php echo $sort_code; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_code; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_code; ?>"><?php echo $column_code; ?></a>
                <?php } ?>
                </th>
              <th class="column-price hidden-phone">
                  <?php if ($sort == 'c.discount') { ?>
                <a href="<?php echo $sort_discount; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_discount; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_discount; ?>"><?php echo $column_discount; ?></a>
                <?php } ?>
              </th>
              <th class="column-date hidden-phone">
                  <?php if ($sort == 'c.date_start') { ?>
                <a href="<?php echo $sort_date_start; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_start; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_date_start; ?>"><?php echo $column_date_start; ?></a>
                <?php } ?>
              </th>
              <th class="column-date hidden-phone">
                  <?php if ($sort == 'c.date_end') { ?>
                <a href="<?php echo $sort_date_end; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_end; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_date_end; ?>"><?php echo $column_date_end; ?></a>
                <?php } ?>
              </th>
              <th class="column-status">
                  <?php if ($sort == 'c.status') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                <?php } ?>
              </th>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php if ($advanced_coupons) { ?>
            <?php foreach ($advanced_coupons as $advanced_coupon) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($advanced_coupon['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $advanced_coupon['advanced_coupon_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $advanced_coupon['advanced_coupon_id']; ?>" />
                <?php } ?></td>
              <td class="column-name"><?php echo $advanced_coupon['name']; ?></td>
              <td class="column-code hidden-phone"><?php echo $advanced_coupon['code']; ?></td>
              <td class="column-price hidden-phone"><?php echo $advanced_coupon['discount']; ?></td>
              <td class="column-date hidden-phone"><?php echo $advanced_coupon['date_start']; ?></td>
              <td class="column-date hidden-phone"><?php echo $advanced_coupon['date_end']; ?></td>
              <td class="column-status"><?php echo $advanced_coupon['status']; ?></td>
              <td class="column-action">
                 <?php echo p3html::tb_action_buttons($advanced_coupon); ?>
              </td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>