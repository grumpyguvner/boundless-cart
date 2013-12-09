<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-chart-bar"></i> <?php echo $heading_title; ?></h1>
    </div>

    <div class="content">

      <div class="form well">
      <div class="row">
				<span class="span2">
					<label><?php echo $entry_date_start; ?></label>
					<input type="text" name="filter_date_start" value="<?php echo $filter_date_start; ?>" id="date-start" class="date span2 input-small" size="12">
				</span>

				<span class="span2">
					<label><?php echo $entry_date_end; ?></label>
					<input type="text" name="filter_date_end" value="<?php echo $filter_date_end; ?>" id="date-end" class="date span2 input-small" size="12">
				</span>

				<span class="span2">
					<label><?php echo $entry_group; ?></label>
					<select name="filter_group" class="span2">
						<?php echo p3html::options($groups, $filter_group, 'value', 'text'); ?>
					</select>
				</span>

				<span class="span3">
					<label><?php echo $entry_status; ?></label>
					<select name="filter_order_status_id" class="span3">
						<option value="0"><?php echo $text_all_status; ?></option>
						<?php echo p3html::oc_order_status_options($order_statuses, $filter_order_status_id); ?>
					</select>
				</span>

				<span class="span2 pull-right" style="text-align:right;">
					<label class="span2">&nbsp;</label>
					<?php echo p3html::tb_ajax_button($button_filter, "filter();", 'info', null, 'filter' , null); ?>
                    <?php echo p3html::tb_form_button($button_export, "location = '$export';", null, 'download'); ?>
				</span>
      </div>
      </div>

			<?php if ($orders) { ?>
      <table class="list table table-striped table-hover">
        <thead>
          <tr>
            <th class="column-date"><?php echo $column_date_start; ?></th>
            <th class="column-date"><?php echo $column_date_end; ?></th>
            <th class="column-number"><?php echo $column_orders; ?></th>
            <th class="column-number hidden-phone"><?php echo $column_products; ?></th>
            <th class="column-price hidden-phone"><?php echo $column_tax; ?></th>
            <th class="column-price"><?php echo $column_total; ?></th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($orders as $order) { ?>
          <tr>
            <td class="column-date"><?php echo $order['date_start']; ?></td>
            <td class="column-date"><?php echo $order['date_end']; ?></td>
            <td class="column-number"><?php echo $order['orders']; ?></td>
            <td class="column-number hidden-phone"><?php echo $order['products']; ?></td>
            <td class="column-price hidden-phone"><?php echo $order['tax']; ?></td>
            <td class="column-price"><?php echo $order['total']; ?></td>
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

<script>
function filter() {
	url = 'index.php?route=report/sale_order&token=<?php echo $token; ?>';

	var filter_date_start = $('input[name=\'filter_date_start\']').attr('value');

	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').attr('value');

	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}

	var filter_group = $('select[name=\'filter_group\']').attr('value');

	if (filter_group) {
		url += '&filter_group=' + encodeURIComponent(filter_group);
	}

	var filter_order_status_id = $('select[name=\'filter_order_status_id\']').attr('value');

	if (filter_order_status_id != 0) {
		url += '&filter_order_status_id=' + encodeURIComponent(filter_order_status_id);
	}

	location = url;
}
</script>

<script>
//$(document).ready(function() {
//	$('#date-start').datepicker({dateFormat: 'yy-mm-dd'});
//
//	$('#date-end').datepicker({dateFormat: 'yy-mm-dd'});
//});
</script>

<?php echo $footer; ?>