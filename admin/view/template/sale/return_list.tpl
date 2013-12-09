<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">
    <div class="heading">
      <h1><i class="icon-back"></i> <?php echo $heading_title; ?></h1>
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

      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-checkbox">
								<input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);">
							</th>
              <th class="column-id hidden-1024">
								<?php echo p3html::tb_sort_heading($column_return_id, $sort_return_id, $sort, $order, 'r.return_id'); ?>
							</th>
              <th class="column-id">
								<?php // echo p3html::tb_sort_heading($column_order_id, $sort_order_id, $sort, $order, 'r.order_id'); ?>
								<?php echo p3html::tb_sort_heading('<span class="hidden-phone">'.$column_order_id.'</span><span class="visible-phone">#</span>', $sort_order_id, $sort, $order, 'o.order_id'); ?>
							</th>
              <th class="column-name hidden-480">
								<?php echo p3html::tb_sort_heading($column_customer, $sort_customer, $sort, $order, 'customer'); ?>
							</th>
              <th class="column-name">
								<?php echo p3html::tb_sort_heading($column_product, $sort_product, $sort, $order, 'r.product'); ?>
							</th>
              <th class="column-model hidden-1024">
								<?php echo p3html::tb_sort_heading($column_model, $sort_model, $sort, $order, 'r.model'); ?>
							</th>
              <th class="column-status hidden-phone">
								<?php echo p3html::tb_sort_heading($column_status, $sort_status, $sort, $order, 'status'); ?>
							</th>
              <th class="column-date hidden-phone">
								<?php echo p3html::tb_sort_heading($column_date_added, $sort_date_added, $sort, $order, 'r.date_added'); ?>
							</th>
              <th class="column-date hidden-1024">
								<?php echo p3html::tb_sort_heading($column_date_modified, $sort_date_modified, $sort, $order, 'r.date_modified'); ?>
							</th>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
            <tr class="filter">
              <td class="column-checkbox"></td>
              <td class="column-id hidden-1024">
								<input type="text" name="filter_return_id" value="<?php echo $filter_return_id; ?>" class="span1 i-mini">
							</td>
              <td class="column-id">
								<input type="text" name="filter_order_id" value="<?php echo $filter_order_id; ?>" class="span1 i-mini">
							</td>
              <td class="column-name hidden-480">
								<input type="text" name="filter_customer" value="<?php echo $filter_customer; ?>" class="input-block-level i-medium">
							</td>
              <td class="column-name">
								<input type="text" name="filter_product" value="<?php echo $filter_product; ?>" class="input-block-level i-small">
							</td>
              <td class="column-model hidden-1024">
								<input type="text" name="filter_model" value="<?php echo $filter_model; ?>" class="input-block-level i-small">
							</td>
              <td class="column-status hidden-phone">
								<select name="filter_return_status_id" class="span2 i-medium">
                  <option value="*">&nbsp;</option>
									<?php echo p3html::oc_return_status_options($return_statuses, $filter_return_status_id); ?>
                </select>
							</td>
              <td class="column-date hidden-phone"><input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" size="12" class="date input-small"></td>
              <td class="column-date hidden-1024"><input type="text" name="filter_date_modified" value="<?php echo $filter_date_modified; ?>" size="12" class="date input-small"></td>
              <td class="column-action">
								<?php echo p3html::tb_ajax_button($button_filter, "filter();", 'info', null, 'filter' , null, 'hidden-phone'); ?>
							</td>
            </tr>
          </thead>
          <tbody>
						<?php if ($returns) { ?>
            <?php foreach ($returns as $return) { ?>
            <tr>
              <td class="column-checkbox">
                <input type="checkbox" name="selected[]" value="<?php echo $return['return_id']; ?>"<?php if ($return['selected']) { ?> checked="checked"<?php } ?>>
							</td>
              <td class="column-id hidden-1024"><?php echo $return['return_id']; ?></td>
              <td class="column-id">
								<?php echo $return['order_id']; ?>
								<a class="tip visible-480" title="<?php echo $return['customer']; ?>" data-hint="tooltip" data-placement="right" href="#" onclick="return false;">
									<i class="icon-user"></i>
								</a>
							</td>
              <td class="column-name hidden-480"><?php echo $return['customer']; ?></td>
              <td class="column-name">
								<?php echo $return['product']; ?>
								<a class="tip visible-phone" title="<?php echo $return['status']; ?>" data-hint="tooltip" data-placement="right" href="#" onclick="return false;">
									<i class="icon-info"></i>
								</a>
							</td>
              <td class="column-model hidden-1024"><?php echo $return['model']; ?></td>
              <td class="column-status hidden-phone"><?php echo $return['status']; ?></td>
              <td class="column-date hidden-phone"><?php echo $return['date_added']; ?></td>
              <td class="column-date hidden-1024"><?php echo $return['date_modified']; ?></td>
              <td class="column-action">
								<?php echo p3html::tb_action_buttons($return); ?>
							</td>
            </tr>
            <?php } ?>
						<?php } ?>
          </tbody>
        </table>
      </form>

			<?php if ($returns) { ?>
      <div class="pagination"><?php echo $pagination; ?></div>
			<?php } else { ?>
			<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
			<?php } ?>

    </div>
  </div>
</div>

<script>
function filter() {
	url = 'index.php?route=sale/return&token=<?php echo $token; ?>';

	var filter_return_id = $('input[name=\'filter_return_id\']').attr('value');

	if (filter_return_id) {
		url += '&filter_return_id=' + encodeURIComponent(filter_return_id);
	}

	var filter_order_id = $('input[name=\'filter_order_id\']').attr('value');

	if (filter_order_id) {
		url += '&filter_order_id=' + encodeURIComponent(filter_order_id);
	}

	var filter_customer = $('input[name=\'filter_customer\']').attr('value');

	if (filter_customer) {
		url += '&filter_customer=' + encodeURIComponent(filter_customer);
	}

	var filter_product = $('input[name=\'filter_product\']').attr('value');

	if (filter_product) {
		url += '&filter_product=' + encodeURIComponent(filter_product);
	}

	var filter_model = $('input[name=\'filter_model\']').attr('value');

	if (filter_model) {
		url += '&filter_model=' + encodeURIComponent(filter_model);
	}

	var filter_return_status_id = $('select[name=\'filter_return_status_id\']').attr('value');

	if (filter_return_status_id != '*') {
		url += '&filter_return_status_id=' + encodeURIComponent(filter_return_status_id);
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

<!--<script>
$(document).ready(function() {
	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
});
</script>-->

<?php echo $footer; ?>