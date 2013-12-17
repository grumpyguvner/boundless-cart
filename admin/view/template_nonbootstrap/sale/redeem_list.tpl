<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/payment.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><!--<a onclick="location = '<?php //echo $insert; ?>'" class="button"><?php //echo $button_insert; ?></a>--><a onclick="document.getElementById('form').submit();" class="button"><?php echo $button_redeem; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $redeemCode; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php if ($sort == 'redeem_id') { ?>
                <a href="<?php echo $sort_code; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_redeem_id; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_code; ?>"><?php echo $column_redeem_id; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'product_id') { ?>
                <a href="<?php echo $sort_from; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_product_id; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_from; ?>"><?php echo $column_product_id; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'order_id') { ?>
                <a href="<?php echo $sort_to; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_order_id; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_to; ?>"><?php echo $column_order_id; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'code') { ?>
                <a href="<?php echo $sort_amount; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_code; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_amount; ?>"><?php echo $column_code; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'status') { ?>
                <a href="<?php echo $sort_theme; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_theme; ?>"><?php echo $column_status; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'redeem') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_redeem; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_redeem; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'date_added') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_date_added; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($redeems) { ?>
            <?php foreach ($redeems as $redeem) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($redeem['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $redeem['redeem_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $redeem['redeem_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $redeem['redeem_id']; ?></td>
              <td class="left"><a href="<?php echo $redeem['product_link']; ?>"><?php echo $redeem['product_id']; ?></a> - <?php echo $redeem['product_model']; ?></td>
              <td class="left"><a href="<?php echo $redeem['order_link']; ?>"><?php echo $redeem['order_id']; ?></a></td>
              <td class="left"><?php echo $redeem['code']; ?></td>
              <td class="left">
                  <?php
                    if ($redeem['status']) {
                        echo $text_enabled;
                    } else {
                        echo $text_disabled;
                    }
                  ?>
              </td>
              <td class="left">
                  <?php
                    if ($redeem['redeem']) {
                        echo $text_yes;
                    } else {
                        echo $text_no;
                    }
                  ?>
              </td>
              <td class="left"><?php echo $redeem['date_added']; ?></td>
              <td class="right">
                <?php foreach ($redeem['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="9"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function sendVoucher(redeem_id) {
	$.ajax({
		url: 'index.php?route=sale/redeem/send&token=<?php echo $token; ?>&redeem_id=' + redeem_id,
		type: 'post',
		dataType: 'json',
		beforeSend: function() {
			$('.success, .warning').remove();
			$('.box').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('.attention').remove();
		},
		success: function(json) {
			if (json['error']) {
				$('.box').before('<div class="warning">' + json['error'] + '</div>');
			}
			
			if (json['success']) {
				$('.box').before('<div class="success">' + json['success'] + '</div>');
			}		
		}
	});
}
//--></script> 
<?php echo $footer; ?>