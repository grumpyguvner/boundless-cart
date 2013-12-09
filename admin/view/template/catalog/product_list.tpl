<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-archive"></i> <?php echo $heading_title; ?></h1>

			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>

			<?php if ($success) { ?>
				<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
			<?php } ?>

      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_insert($button_insert, $insert); ?>
				<a onclick="$('#form').attr('action', '<?php echo $copy; ?>'); $('#form').submit();" class="btn"><i class="icon-paste"></i> <?php echo $button_copy; ?></a>
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
              <th class="column-image hidden-phone hidden-tablet"><?php echo $column_image; ?></th>
              <th class="column-name">
								<?php echo p3html::tb_sort_heading($column_name, $sort_name, $sort, $order, 'pd.name'); ?>
							</th>
              <th class="column-model hidden-phone hidden-tablet">
								<?php echo p3html::tb_sort_heading($column_model, $sort_model, $sort, $order, 'p.model'); ?>
							</th>
              <th class="column-price hidden-phone">
								<?php echo p3html::tb_sort_heading($column_price, $sort_price, $sort, $order, 'p.price'); ?>
							</th>
              <th class="column-quantity hidden-phone">
								<?php echo p3html::tb_sort_heading($column_quantity, $sort_quantity, $sort, $order, 'p.quantity'); ?>
							</th>
              <th class="column-status">
								<?php echo p3html::tb_sort_heading($column_status, $sort_status, $sort, $order, 'p.status'); ?>
							</th>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
            <tr class="filter">
              <td class="column-checkbox"><i class="icon-cb-checked"></i></td>
              <td class="column-image hidden-phone hidden-tablet"><i class="icon-picture"></i></td>
              <td class="column-name"><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" class="span3 i-xlarge"></td>
              <td class="column-model hidden-phone hidden-tablet"><input type="text" name="filter_model" value="<?php echo $filter_model; ?>" class="span2 i-large"></td>
              <td class="column-price hidden-phone"><input type="text" name="filter_price" value="<?php echo $filter_price; ?>" class="input-small"></td>
              <td class="column-quantity hidden-phone"><input type="text" name="filter_quantity" value="<?php echo $filter_quantity; ?>" class="input-mini"></td>
              <td class="column-status">
								<select name="filter_status" class="input-small">
                  <option value="*">&nbsp;</option>
									<?php echo p3html::oc_status_options($this->language, $filter_status); ?>
                </select>
							</td>
              <td class="column-action">
								<?php echo p3html::tb_ajax_button($button_filter, "filter();", 'info', null, 'filter' , null, 'hidden-phone'); ?>
							</td>
            </tr>
          </thead>
					<?php if ($products) { ?>
          <tbody>
            <?php foreach ($products as $product) { ?>
            <tr>
              <td class="column-checkbox">
                <input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>"<?php if ($product['selected']) { ?> checked="checked"<?php } ?>>
							</td>
              <td class="column-image hidden-phone hidden-tablet">
								<img src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>" style="padding: 1px; border: 1px solid #DDDDDD;">
							</td>
              <td class="column-name"><?php echo $product['name']; ?></td>
              <td class="column-model hidden-phone hidden-tablet"><?php echo $product['model']; ?></td>
              <td class="column-price hidden-phone">
								<?php if ($product['special']) { ?>
                <span style="text-decoration: line-through;"><?php echo $product['price']; ?></span><br>
                <span class="text-error"><?php echo $product['special']; ?></span>
                <?php } else { ?>
                <?php echo $product['price']; ?>
                <?php } ?>
							</td>
              <td class="column-quantity hidden-phone">
								<?php if ($product['quantity'] <= 0) { ?>
                <span class="text-warning">
                <?php } elseif ($product['quantity'] <= 5) { ?>
                <span class="text-warning">
                <?php } else { ?>
                <span class="text-success">
                <?php } ?><?php echo $product['quantity']; ?></span>
							</td>
              <td class="column-status">
								<?php $status = $product['status']==$this->language->get('text_enabled');?>
								<?php // echo p3html::tb_bool_icon($status); ?>
								<?php echo p3html::tb_status_label($status, $product['status']); ?>
							</td>
              <td class="column-action">
								<?php echo p3html::tb_action_buttons($product); ?>
							</td>
            </tr>
            <?php } ?>
          </tbody>
					<?php } ?>
        </table>
      </form>

			<?php if ($products) { ?>
      <div class="pagination"><?php echo $pagination; ?></div>
			<?php } else { ?>
			<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
			<?php } ?>

    </div>
  </div>
</div>

<script>
function filter() {
	url = 'index.php?route=catalog/product&token=<?php echo $token; ?>';

	var filter_name = $('input[name=\'filter_name\']').attr('value');

	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}

	var filter_model = $('input[name=\'filter_model\']').attr('value');

	if (filter_model) {
		url += '&filter_model=' + encodeURIComponent(filter_model);
	}

	var filter_price = $('input[name=\'filter_price\']').attr('value');

	if (filter_price) {
		url += '&filter_price=' + encodeURIComponent(filter_price);
	}

	var filter_quantity = $('input[name=\'filter_quantity\']').attr('value');

	if (filter_quantity) {
		url += '&filter_quantity=' + encodeURIComponent(filter_quantity);
	}

	var filter_status = $('select[name=\'filter_status\']').attr('value');

	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}

	location = url;
}
</script>
<script>
$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		filter();
	}
});
</script>
<script>
$('input[name=\'filter_name\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'filter_name\']').val(ui.item.label);

		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

$('input[name=\'filter_model\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_model=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.model,
						value: item.product_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'filter_model\']').val(ui.item.label);

		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});
</script>
<?php echo $footer; ?>