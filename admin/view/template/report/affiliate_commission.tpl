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

				<span class="span2 pull-right" style="text-align:right;">
					<label class="span2">&nbsp;</label>
					<?php echo p3html::tb_ajax_button($button_filter, "filter();", 'info', null, 'filter' , null, 'hidden-phone'); ?>
				</span>

      </div>
      </div>

			<?php if ($affiliates) { ?>
      <table class="list table table-striped table-hover">
        <thead>
          <tr>
            <th class="column-name"><?php echo $column_affiliate; ?></th>
            <th class="column-email hidden-phone"><?php echo $column_email; ?></th>
            <th class="column-status"><?php echo $column_status; ?></th>
            <th class="column-number"><?php echo $column_commission; ?></th>
            <th class="column-number hidden-phone"><?php echo $column_orders; ?></th>
            <th class="column-price"><?php echo $column_total; ?></th>
            <th class="column-action"><?php echo $column_action; ?></th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($affiliates as $affiliate) { ?>
          <tr>
            <td class="column-name"><?php echo $affiliate['affiliate']; ?></td>
            <td class="column-email hidden-phone"><?php echo $affiliate['email']; ?></td>
            <td class="column-status">
							<?php // echo $affiliate['status']; ?>
							<?php $status = $affiliate['status']==$this->language->get('text_enabled'); ?>
							<?php echo p3html::tb_status_label($status, $affiliate['status']); ?>
						</td>
            <td class="column-number"><?php echo $affiliate['commission']; ?></td>
            <td class="column-number hidden-phone"><?php echo $affiliate['orders']; ?></td>
            <td class="column-price"><?php echo $affiliate['total']; ?></td>
            <td class="column-action">
							<?php echo p3html::tb_action_buttons($affiliate); ?>
						</td>
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
	url = 'index.php?route=report/affiliate_commission&token=<?php echo $token; ?>';

	var filter_date_start = $('input[name=\'filter_date_start\']').attr('value');

	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').attr('value');

	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}

	location = url;
}
</script>

<script>
$(document).ready(function() {
//	$('#date-start').datepicker({dateFormat: 'yy-mm-dd'});
//
//	$('#date-end').datepicker({dateFormat: 'yy-mm-dd'});
});
</script>

<?php echo $footer; ?>