<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-user"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
			<?php if ($success) { ?>
				<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_ajax_button($button_approve, "$('form').attr('action', '$approve'); $('form').submit();", null, null, 'check'); ?>
				<?php echo p3html::tb_form_button_insert($button_insert, $insert); ?>
				<?php echo p3html::tb_ajax_button($button_delete, "$('form').attr('action', '$delete'); $('form').submit();", 'danger', null, 'trash'); ?>
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
              <th class="column-name">
								<?php echo p3html::tb_sort_heading($column_name, $sort_name, $sort, $order, 'name'); ?>
							</th>
              <th class="column-email hidden-phone">
								<?php echo p3html::tb_sort_heading($column_email, $sort_email, $sort, $order, 'c.email'); ?>
							</th>
              <th class="column-group hidden-phone hidden-tablet">
								<?php echo p3html::tb_sort_heading($column_customer_group, $sort_customer_group, $sort, $order, 'customer_group'); ?>
							</th>
              <th class="column-status hidden-phone">
  							<?php echo p3html::tb_sort_heading($column_status, $sort_status, $sort, $order, 'c.status'); ?>
							</th>
              <th class="column-status">
  							<?php echo p3html::tb_sort_heading($column_approved, $sort_approved, $sort, $order, 'c.approved'); ?>
							</th>
              <th class="column-ip hidden-1024">
								<?php echo p3html::tb_sort_heading($column_ip, $sort_ip, $sort, $order, 'c.ip'); ?>
							</th>
              <th class="column-date hidden-1024">
  							<?php echo p3html::tb_sort_heading($column_date_added, $sort_date_added, $sort, $order, 'c.date_added'); ?>
							</th>
              <th class="column-action hidden-phone"><?php //echo $column_login; ?>Login</th>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
            <tr class="filter">
              <td class="column-checkbox"></td>
              <td class="column-name">
								<input type="text" name="filter_name" value="<?php echo $filter_name; ?>" class="span2 i-medium">
							</td>
              <td class="column-email hidden-phone">
								<input type="text" name="filter_email" value="<?php echo $filter_email; ?>" class="span2 i-medium ">
							</td>
              <td class="column-group hidden-phone hidden-tablet">
								<select name="filter_customer_group_id" class="span2 i-medium">
                  <option value="*">&nbsp;</option>
									<?php echo p3html::oc_customer_group_options($customer_groups, $filter_customer_group_id); ?>
                </select>
							</td>
              <td class="column-status hidden-phone">
								<select name="filter_status" class="input-small">
                  <option value="*">&nbsp;</option>
									<?php echo p3html::oc_status_options($this->language, $filter_status); ?>
                </select>
							</td>
              <td class="column-status">
								<select name="filter_approved" class="input-mini">
                  <option value="*">&nbsp;</option>
									<?php echo p3html::oc_bool_options($this->language, $filter_approved); ?>
                </select>
							</td>
              <td class="column-ip hidden-1024">
								<input type="text" name="filter_ip" value="<?php echo $filter_ip; ?>" class="input-small">
							</td>
              <td class="column-date hidden-1024">
								<input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" class="input-small date" id="date">
							</td>
              <td class="column-action hidden-phone"></td>
              <td class="column-action">
								<?php echo p3html::tb_ajax_button($button_filter, "filter();", 'info', null, 'filter' , null, 'hidden-1024'); ?>
							</td>
            </tr>
          </thead>
          <tbody>
						<?php if ($customers) { ?>
            <?php foreach ($customers as $customer) { ?>
            <tr>
              <td class="column-checkbox">
                <input type="checkbox" name="selected[]" value="<?php echo $customer['customer_id']; ?>"<?php if ($customer['selected']) { ?> checked="checked"<?php } ?>>
							</td>
              <td class="column-name"><?php echo $customer['name']; ?></td>
              <td class="column-email hidden-phone"><?php echo $customer['email']; ?></td>
              <td class="column-group hidden-phone hidden-tablet"><?php echo $customer['customer_group']; ?></td>
              <td class="column-status">
								<?php // echo $customer['status']; ?>
								<?php $status = $customer['status']==$this->language->get('text_enabled'); ?>
								<?php echo p3html::tb_status_label($status, $customer['status']); ?>
							</td>
              <td class="column-status hidden-phone">
								<?php //echo $customer['approved']; ?>
								<?php $approved= $customer['approved']==$this->language->get('text_yes'); ?>
								<?php echo p3html::tb_status_label($approved, $customer['approved']); ?>
							</td>
              <td class="column-ip hidden-1024"><?php echo $customer['ip']; ?></td>
              <td class="column-date hidden-1024"><?php echo $customer['date_added']; ?></td>
              <td class="column-action hidden-phone">
								<div class="btn-group pull-right">
									<button class="btn btn-small dropdown-toggle" data-toggle="dropdown">
										<i class="icon-signin"></i>
									</button>
									<ul class="dropdown-menu">
										<li>
											<a href="index.php?route=sale/customer/login&token=<?php echo $token; ?>&customer_id=<?php echo $customer['customer_id']; ?>&store_id=0" target="_blank">
												<?php echo $text_default; ?></a>
										</li>
										<?php foreach ($stores as $store) { ?>
										<li>
											<a href="index.php?route=sale/customer/login&token=<?php echo $token; ?>&customer_id=<?php echo $customer['customer_id']; ?>&store_id=<?php echo $store['store_id']; ?>" target="_blank">
												<?php echo $store['name']; ?></a>
										</li>
										<?php } ?>
									</ul>
								</div>
							</td>
              <td class="column-action">
								<?php echo p3html::tb_action_buttons($customer); ?>
							</td>
            </tr>
            <?php } ?>
						<?php } ?>
          </tbody>
        </table>
      </form>

			<?php if ($customers) { ?>
      <div class="pagination"><?php echo $pagination; ?></div>
			<?php } else { ?>
			<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
			<?php } ?>

     </div>

  </div>

</div>

<script>
function filter() {
	url = 'index.php?route=sale/customer&token=<?php echo $token; ?>';

	var filter_name = $('input[name=\'filter_name\']').attr('value');

	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}

	var filter_email = $('input[name=\'filter_email\']').attr('value');

	if (filter_email) {
		url += '&filter_email=' + encodeURIComponent(filter_email);
	}

	var filter_customer_group_id = $('select[name=\'filter_customer_group_id\']').attr('value');

	if (filter_customer_group_id != '*') {
		url += '&filter_customer_group_id=' + encodeURIComponent(filter_customer_group_id);
	}

	var filter_status = $('select[name=\'filter_status\']').attr('value');

	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}

	var filter_approved = $('select[name=\'filter_approved\']').attr('value');

	if (filter_approved != '*') {
		url += '&filter_approved=' + encodeURIComponent(filter_approved);
	}

	var filter_ip = $('input[name=\'filter_ip\']').attr('value');

	if (filter_ip) {
		url += '&filter_ip=' + encodeURIComponent(filter_ip);
	}

	var filter_date_added = $('input[name=\'filter_date_added\']').attr('value');

	if (filter_date_added) {
		url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
	}

	location = url;
}
</script>

<?php echo $footer; ?>