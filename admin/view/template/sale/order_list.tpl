<?php
//------------------------------------------------------------------------------
// ORDER STATUS LABEL
//------------------------------------------------------------------------------
p3html::set_order_status_label_for_orders($this, $orders);
//------------------------------------------------------------------------------
?>
<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-clipboard"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
			<?php if ($success) { ?>
				<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_ajax_button($button_invoice, "$('#form').attr('action', '$invoice'); $('#form').attr('target', '_blank'); $('#form').submit();", null, null, 'print'); ?>
				<?php echo p3html::tb_form_button_insert($button_insert, $insert); ?>
				<?php echo p3html::tb_ajax_button($button_delete, "$('#form').attr('action', '$delete'); $('#form').attr('target', '_self'); $('#form').submit();", 'danger', null, 'trash'); ?>
			</div>
    </div>

    <div class="content">

      <form action="" method="post" enctype="multipart/form-data" id="form">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-checkbox">
								<input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);">
							</th>
              <th class="column-id">
								<?php echo p3html::tb_sort_heading('<span class="hidden-320">'.$column_order_id.'</span><span class="visible-320">#</span>', $sort_order, $sort, $order, 'o.order_id'); ?>
							</th>
              <th class="column-name hidden-320">
								<?php echo p3html::tb_sort_heading($column_customer, $sort_customer, $sort, $order, 'customer'); ?>
							</th>
              <th class="column-status">
								<?php echo p3html::tb_sort_heading($column_status, $sort_status, $sort, $order, 'status'); ?>
							</th>
              <th class="column-price hidden-phone">
								<?php echo p3html::tb_sort_heading($column_total, $sort_total, $sort, $order, 'o.total'); ?>
							</th>
              <th class="column-date hidden-phone">
								<?php echo p3html::tb_sort_heading($column_date_added, $sort_date_added, $sort, $order, 'o.date_added'); ?>
							</th>
							<?php /* NOT USED IN DB QUERY ?>
              <th class="column-date hidden-phone hidden-tablet">
								<?php echo p3html::tb_sort_heading($column_date_modified, $sort_date_modified, $sort, $order, 'o.date_modified'); ?>
							</th>
							<?php */ ?>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
            <tr class="filter">
              <td></td>
              <td class="column-id">
								<input type="text" name="filter_order_id" value="<?php echo $filter_order_id; ?>" class="span1 i-mini">
							</td>
              <td class="column-name hidden-320">
								<input type="text" name="filter_customer" value="<?php echo $filter_customer; ?>" class="span3 i-xlarge">
							</td>
              <td class="column-status">
								<select name="filter_order_status_id" class="span2 i-medium" data-allow-deselect="true">
                  <option value="*">&nbsp;</option>
                  <option value="0"<?php if ($filter_order_status_id == '0') { ?> selected="selected"<?php } ?>><?php echo $text_missing; ?></option>
									<?php echo p3html::oc_order_status_options($order_statuses, $filter_order_status_id); ?>
                </select>
							</td>
              <td class="column-price hidden-phone">
								<input type="text" name="filter_total" value="<?php echo $filter_total; ?>" class="span1 i-small">
							</td>
              <td class="column-date hidden-phone">
								<input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" id="filter-date-added" class="date input-append input-small">
							</td>
							<?php /* NOT USED IN DB QUERY ?>
              <td class="column-date hidden-phone hidden-tablet">
								<input type="text" name="filter_date_modified" value="<?php echo $filter_date_modified; ?>" id="filter-date-modified" class="date input-append input-small">
							</td>
							 <?php */ ?>
              <td class="column-action">
								<?php echo p3html::tb_ajax_button($button_filter, "filter();", 'info', null, 'filter' , null, 'hidden-phone'); ?>
							</td>
            </tr>
          </thead>
          <tbody>
						<?php if ($orders) { ?>
            <?php foreach ($orders as $order) { ?>
            <tr>
              <td class="column-checkbox">
                <input type="checkbox" name="selected[]" value="<?php echo $order['order_id']; ?>"<?php if ($order['selected']) { ?> checked="checked"<?php } ?>>
							</td>
              <td class="column-id">
								<?php echo $order['order_id']; ?>
								<a class="tip visible-320" title="<?php echo $order['customer']; ?>" data-hint="tooltip" data-placement="right" href="#" onclick="return false;">
									<i class="icon-user"></i>
								</a>
							</td>
              <td class="column-name hidden-320"><?php echo $order['customer']; ?></td>
              <td class="column-status">
								<?php $order_status_label = isset($order['order_status_label']) ? $order['order_status_label'] : ''; ?>
								<?php if ($order_status_label) { ?><span class="label label-<?php echo $order_status_label; ?>"><?php } ?>
								<?php echo $order['status']; ?>
								<?php if ($order_status_label) { ?></span><?php } ?>
							</td>
              <td class="column-price hidden-phone"><?php echo $order['total']; ?></td>
              <td class="column-date hidden-phone"><?php echo $order['date_added']; ?></td>
              <?php /* NOT USED IN DB QUERY ?><td class="column-date hidden-phone hidden-tablet"><?php echo $order['date_modified']; ?></td><?php */ ?>
              <td class="column-action">
								<?php echo p3html::tb_action_buttons($order); ?>
							</td>
            </tr>
            <?php } ?>
						<?php } ?>
          </tbody>
        </table>
      </form>

			<?php if ($orders) { ?>
      <div class="pagination"><?php echo $pagination; ?></div>
			<?php } else { ?>
			<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
			<?php } ?>

     </div>

  </div>

</div>

<script>
function filter() {
	url = 'index.php?route=sale/order&token=<?php echo $token; ?>';

	var filter_order_id = $('input[name=\'filter_order_id\']').attr('value');

	if (filter_order_id) {
		url += '&filter_order_id=' + encodeURIComponent(filter_order_id);
	}

	var filter_customer = $('input[name=\'filter_customer\']').attr('value');

	if (filter_customer) {
		url += '&filter_customer=' + encodeURIComponent(filter_customer);
	}

	var filter_order_status_id = $('select[name=\'filter_order_status_id\']').attr('value');

	if (filter_order_status_id != '*') {
		url += '&filter_order_status_id=' + encodeURIComponent(filter_order_status_id);
	}

	var filter_total = $('input[name=\'filter_total\']').attr('value');

	if (filter_total) {
		url += '&filter_total=' + encodeURIComponent(filter_total);
	}

	var filter_date_added = $('input[name=\'filter_date_added\']').attr('value');

	if (filter_date_added) {
		url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
	}

	var filter_date_modified = $('input[name=\'filter_date_modified\']').attr('value');

	if (filter_date_modified) {
		url += '&filter_date_modified=' + encodeURIComponent(filter_date_modified);
	}

	location = url;
}
</script>
<script>
$(document).ready(function() {
//	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
});
</script>
<script>
$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		filter();
	}
});
</script>
<script>
$.widget('custom.catcomplete', $.ui.autocomplete, {
	_renderMenu: function(ul, items) {
		var self = this, currentCategory = '';

		$.each(items, function(index, item) {
			if (item.category != currentCategory) {
				ul.append('<li class="ui-autocomplete-category">' + item.category + '</li>');

				currentCategory = item.category;
			}

			self._renderItem(ul, item);
		});
	}
});

$('input[name=\'filter_customer\']').catcomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/customer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						category: item.customer_group,
						label: item.name,
						value: item.customer_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'filter_customer\']').val(ui.item.label);

		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});
</script>
<?php echo $footer; ?>