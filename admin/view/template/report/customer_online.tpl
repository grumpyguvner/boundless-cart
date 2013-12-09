<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-chart-bar"></i> <?php echo $heading_title; ?></h1>
    </div>

    <div class="content">
      <table class="list table table-striped table-hover">
        <thead>
          <tr>
            <th class="column-ip"><?php echo $column_ip; ?></th>
            <th class="column-name"><?php echo $column_customer; ?></th>
            <th class="column-url hidden-480"><?php echo $column_url; ?></th>
            <th class="column-url hidden-800"><?php echo $column_referer; ?></th>
            <th class="column-date hidden-400"><?php echo $column_date_added; ?></th>
            <th class="column-action"><?php echo $column_action; ?></th>
          </tr>
          <tr class="filter">
            <td class="column-ip">
							<input type="text" name="filter_ip" value="<?php echo $filter_ip; ?>" class="span2">
						</td>
            <td class="column-name">
							<input type="text" name="filter_customer" value="<?php echo $filter_customer; ?>" class="span2">
						</td>
            <td class="column-url hidden-480">&nbsp;</td>
            <td class="column-url hidden-800">&nbsp;</td>
            <td class="column-date hidden-400">&nbsp;</td>
            <td class="column-action">
							<?php echo p3html::tb_ajax_button($button_filter, "filter();", 'info', null, 'filter' , null, 'hidden-1024'); ?>
                            <?php echo p3html::tb_form_button($button_export, "location = '$export';", null, 'download'); ?>
						</td>
          </tr>
        </thead>
        <tbody>
					<?php if ($customers) { ?>
          <?php foreach ($customers as $customer) { ?>
          <tr>
            <td class="column-ip">
							<a onclick="window.open('http://whatismyipaddress.com/ip/<?php echo $customer['ip']; ?>');">
								<?php echo $customer['ip']; ?></a>
						</td>
            <td class="column-name">
							<?php echo $customer['customer']; ?>
							<a class="tip visible-480" title="<?php echo $column_url.': '.$customer['url']; ?>" data-hint="tooltip" data-placement="top" href="#" onclick="return false;">
								<i class="icon-eye"></i>
							</a>
							<a class="tip visible-800" title="<?php echo $column_referer.': '.$customer['referer']; ?>" data-hint="tooltip" data-placement="top" href="#" onclick="return false;">
								<i class="icon-reply"></i>
							</a>
							<a class="tip visible-400" title="<?php echo $column_date_added.': '.$customer['date_added']; ?>" data-hint="tooltip" data-placement="top" href="#" onclick="return false;">
								<i class="icon-clock"></i>
							</a>
						</td>
            <td class="column-url hidden-480">
							<a onclick="window.open('<?php echo $customer['url']; ?>');"><?php echo implode('<br>', str_split($customer['url'], 30)); ?></a>
						</td>
            <td class="column-url hidden-800">
							<?php if ($customer['referer']) { ?>
              <a class="hidden-1024" onclick="window.open('<?php echo $customer['referer']; ?>');"><?php echo implode('<br>', str_split($customer['referer'], 30)); ?></a>
							<a class="tip visible-1024" title="<?php echo $column_referer.': '.$customer['referer']; ?>" data-hint="tooltip" data-placement="top" href="#" onclick="return false;">
								<i class="icon-reply"></i>
							</a>
              <?php } ?>
						</td>
            <td class="column-date hidden-400"><?php echo $customer['date_added']; ?></td>
            <td class="column-action">
							<?php echo p3html::tb_action_buttons($customer); ?>
						</td>
          </tr>
          <?php } ?>
					<?php } ?>
        </tbody>
      </table>

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
	url = 'index.php?route=report/customer_online&token=<?php echo $token; ?>';

	var filter_customer = $('input[name=\'filter_customer\']').attr('value');

	if (filter_customer) {
		url += '&filter_customer=' + encodeURIComponent(filter_customer);
	}

	var filter_ip = $('input[name=\'filter_ip\']').attr('value');

	if (filter_ip) {
		url += '&filter_ip=' + encodeURIComponent(filter_ip);
	}

	location = url;
}
</script>

<?php echo $footer; ?>