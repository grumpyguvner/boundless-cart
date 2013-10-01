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
      <h1><i class="icon-home"></i> <?php echo $heading_title; ?></h1>
			<?php /* if ($error_install) { ?>
			<div class="warning alert alert-error"><?php echo $error_install; ?></div>
			<?php } */ ?>
			<?php if ($error_image) { ?>
			<div class="warning alert alert-error"><?php echo $error_image; ?></div>
			<?php } ?>
			<?php if ($error_image_cache) { ?>
			<div class="warning alert alert-error"><?php echo $error_image_cache; ?></div>
			<?php } ?>
			<?php if ($error_cache) { ?>
			<div class="warning alert alert-error"><?php echo $error_cache; ?></div>
			<?php } ?>
			<?php if ($error_download) { ?>
			<div class="warning alert alert-error"><?php echo $error_download; ?></div>
			<?php } ?>
			<?php if ($error_logs) { ?>
			<div class="warning alert alert-error"><?php echo $error_logs; ?></div>
			<?php } ?>
    </div>

    <div class="content">

			<div class="row">
                <?php echo $newspanel; ?> <br />


				<div class="overview span6">
					<div class="dashboard-heading"><h4><i class="icon-list"></i> <?php echo $text_overview; ?></h4></div>
					<div class="dashboard-content">
						<table class="table table-striped table-hover table-condensed">
							<!--<caption class="dashboard-heading"><h4><i class="icon-list"></i> <?php echo $text_overview; ?></h4></caption>-->
							<tr>
								<th class="span5"><?php echo $text_total_sale; ?></th>
								<td class="column-quantity span1"><?php echo $total_sale; ?></td>
							</tr>
							<tr>
								<th class="span5"><?php echo $text_total_sale_year; ?></th>
								<td class="column-quantity span1"><?php echo $total_sale_year; ?></td>
							</tr>
							<tr>
								<th class="span5"><?php echo $text_total_order; ?></th>
								<td class="column-quantity span1"><?php echo $total_order; ?></td>
							</tr>
							<tr>
								<th class="span5"><?php echo $text_total_customer; ?></th>
								<td class="column-quantity span1"><?php echo $total_customer; ?></td>
							</tr>
							<tr>
								<th class="span5"><?php echo $text_total_customer_approval; ?></th>
								<td class="column-quantity span1"><?php echo $total_customer_approval; ?></td>
							</tr>
							<tr>
								<th class="span5"><?php echo $text_total_review_approval; ?></th>
								<td class="column-quantity span1"><?php echo $total_review_approval; ?></td>
							</tr>
							<tr>
								<th class="span5"><?php echo $text_total_affiliate; ?></th>
								<td class="column-quantity span1"><?php echo $total_affiliate; ?></td>
							</tr>
							<tr>
								<th class="span5"><?php echo $text_total_affiliate_approval; ?></th>
								<td class="column-quantity span1"><?php echo $total_affiliate_approval; ?></td>
							</tr>
						</table>
					</div>
				</div>

				<div class="statistic span6">
					<div class="dashboard-heading"><h4><i class="icon-chart-line"></i> <?php echo $text_statistics; ?></h4></div>
					<div class="dashboard-content row">
						<div id="report" class="span6" style="height: 238px;"></div>
						<div class="range pull-right form-horizontal">
							<div class="control-group">
								<label for="range" class="control-label"><?php echo $entry_range; ?></label>
								<div class="controls">
									<select id="range" onchange="getSalesChart(this.value)" class="input-medium">
										<option value="day"><?php echo $text_day; ?></option>
										<option value="week"><?php echo $text_week; ?></option>
										<option value="month"><?php echo $text_month; ?></option>
										<option value="year"><?php echo $text_year; ?></option>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
     <?php if ($this->user->hasPermission('access', 'sale/order')) { ?>
      <div class="latest">
        <div class="dashboard-heading"><h4><i class="icon-dollar"></i> <?php echo $text_latest_10_orders; ?></div>
        <div class="dashboard-content">
					<?php if ($orders) { ?>
          <table class="list table table-striped table-hover table-condensed">
						<!--<caption class="dashboard-heading"><h4><i class="icon-dollar"></i> <?php echo $text_latest_10_orders; ?></h4></caption>-->
            <thead>
              <tr>
                <th class="column-id">
									<span class="hidden-320"><?php echo $column_order; ?></span>
									<span class="visible-320">#</span>
								</th>
                <th class="column-name">
									<span class="hidden-320"><?php echo $column_customer; ?></span>
									<span class="visible-320"><i class="icon-user"></i></span>
								</th>
                <th class="column-status"><?php echo $column_status; ?></th>
                <th class="column-date"><?php echo $column_date_added; ?></th>
                <th class="column-price hidden-phone"><?php echo $column_total; ?></th>
                <th class="column-action"><?php echo $column_action; ?></th>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($orders as $order) { ?>
              <tr>
                <td class="column-id"><?php echo $order['order_id']; ?></td>
                <td class="column-name">
									<span class="hidden-320"><?php echo $order['customer']; ?></span>
									<a class="tip visible-320" title="<?php echo $order['customer']; ?>" data-hint="tooltip" data-placement="right" href="#" onclick="return false;">
										<i class="icon-user"></i>
									</a>
								</td>
                <td class="column-status">
									<?php $order_status_label = isset($order['order_status_label']) ? $order['order_status_label'] : ''; ?>
									<?php if ($order_status_label) { ?><span class="label label-<?php echo $order_status_label; ?>"><?php } ?>
									<?php echo $order['status']; ?>
									<?php if ($order_status_label) { ?></span><?php } ?>
								</td>
                <td class="column-date"><?php echo $order['date_added']; ?></td>
                <td class="column-price hidden-phone"><?php echo $order['total']; ?></td>
                <td class="column-action">
									<?php echo p3html::tb_action_buttons($order); ?>
								</td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
					<?php } else { ?>
					<?php echo p3html::tb_alert('info', $text_no_results, false, 'no-results'); ?>
					<?php } ?>
        </div>
      </div>
     <?php } ?>   
    </div>

  </div>
</div>

<!--[if IE]>
<script src="view/javascript/jquery/flot/excanvas.js"></script>
<![endif]-->
<script src="view/javascript/jquery/flot/jquery.flot.js"></script>
<script>
function getSalesChart(range) {
	$.ajax({
		type: 'get',
		url: 'index.php?route=common/home/chart&token=<?php echo $token; ?>&range=' + range,
		dataType: 'json',
		async: false,
		success: function(json) {
			var option = {
				shadowSize: 1,
				lines: {
					show: true,
					fill: true,
					lineWidth: 1
				},
				grid: {
					backgroundColor: '#FFFFFF'
				},
				xaxis: {
					ticks: json.xaxis
				}
			}

			$.plot($('#report'), [json.order, json.customer], option);
			$(window).resize(function() {
				$('#report').html('');
				$.plot($('#report'), [json.order, json.customer], option);
			});
		}
	});
}

getSalesChart($('#range').val());
</script>
<?php echo $footer; ?>