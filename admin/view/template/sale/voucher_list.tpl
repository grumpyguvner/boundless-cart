<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">
    <div class="heading">
      <h1><i class="icon-ticket"></i> <?php echo $heading_title; ?></h1>
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

			<?php if ($vouchers) { ?>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-checkbox hidden-phone">
								<input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);">
							</th>
              <th class="column-code hidden-phone">
								<?php echo p3html::tb_sort_heading($column_code, $sort_code, $sort, $order, 'v.code'); ?>
							</th>
              <th class="column-name">
								<?php echo p3html::tb_sort_heading($column_from, $sort_from, $sort, $order, 'v.from_name'); ?>
							</th>
              <th class="column-name">
								<?php echo p3html::tb_sort_heading($column_to, $sort_to, $sort, $order, 'v.to_name'); ?>
							</th>
              <th class="column-price">
								<?php echo p3html::tb_sort_heading($column_amount, $sort_amount, $sort, $order, 'v.amount'); ?>
							</th>
              <th class="column-layout hidden-phone">
								<?php echo p3html::tb_sort_heading($column_theme, $sort_theme, $sort, $order, 'theme'); ?>
							</th>
              <th class="column-status hidden-phone">
								<?php echo p3html::tb_sort_heading($column_status, $sort_status, $sort, $order, 'v.status'); ?>
							</th>
              <th class="column-date hidden-phone">
								<?php echo p3html::tb_sort_heading($column_date_added, $sort_date_added, $sort, $order, 'v.date_added'); ?>
							</th>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($vouchers as $voucher) { ?>
            <tr>
              <td class="column-checkbox hidden-phone">
                <input type="checkbox" name="selected[]" value="<?php echo $voucher['voucher_id']; ?>"<?php if ($voucher['selected']) { ?> checked="checked"<?php } ?>>
							</td>
              <td class="column-code hidden-phone"><?php echo $voucher['code']; ?></td>
              <td class="column-name"><?php echo $voucher['from']; ?></td>
              <td class="column-name"><?php echo $voucher['to']; ?></td>
              <td class="column-price"><?php echo $voucher['amount']; ?></td>
              <td class="column-layout hidden-phone"><?php echo $voucher['theme']; ?></td>
              <td class="column-status hidden-phone">
								<?php // echo $voucher['status']; ?>
								<?php $status = $voucher['status']==$this->language->get('text_enabled'); ?>
								<?php echo p3html::tb_status_label($status, $voucher['status']); ?>
							</td>
              <td class="column-date hidden-phone"><?php echo $voucher['date_added']; ?></td>
              <td class="column-action">
								<?php echo p3html::tb_ajax_button($text_send, "sendVoucher('{$voucher['voucher_id']}');", null, 'small'); ?>
								<?php echo p3html::tb_action_buttons($voucher); ?>
							</td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>

			<div class="pagination"><?php echo $pagination; ?></div>

			<?php } else { ?>
			<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
			<?php } ?>

    </div>
  </div>
</div>

<script>
function sendVoucher(voucher_id) {
	$.ajax({
		url: 'index.php?route=sale/voucher/send&token=<?php echo $token; ?>&voucher_id=' + voucher_id,
		type: 'post',
		dataType: 'json',
		beforeSend: function() {
			$('.success, .warning').remove();
			$('.box .heading .buttons').before('<div class="attention"><img src="view/image/loading.gif" alt=""> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('.attention').remove();
		},
		success: function(json) {
			if (json['error']) {
				$('.box .heading .buttons').before('<div class="warning alert alert-warning"><button type="button" class="close" data-dismiss="alert">&times;</button>' + json['error'] + '</div>');
			}

			if (json['success']) {
				$('.box .heading .buttons').before('<div class="success alert alert-success"><button type="button" class="close" data-dismiss="alert">&times;</button>' + json['success'] + '</div>');
			}
		}
	});
}
</script>
<?php echo $footer; ?>