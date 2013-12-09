<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-chart-bar"></i> <?php echo $heading_title; ?></h1>
      <div class="buttons form-actions form-actions-top">
          <?php echo p3html::tb_form_button($button_export, "location = '$export';", null, 'download'); ?>
			</div>
    </div>

    <div class="content">

			<?php if ($customers) { ?>
      <table class="list table table-striped table-hover">
        <thead>
          <tr>
            <th class="column-name"><?php echo $column_customer; ?></th>
            <th class="column-email hidden-phone"><?php echo $column_email; ?></th>
            <th class="column-name hidden-phone"><?php echo $column_customer_group; ?></th>
            <th class="column-status"><?php echo $column_status; ?></th>
            <th class="column-price"><?php echo $column_total; ?></th>
            <th class="column-action"><?php echo $column_action; ?></th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($customers as $customer) { ?>
          <tr>
            <td class="column-name"><?php echo $customer['customer']; ?></td>
            <td class="column-email hidden-phone"><?php echo $customer['email']; ?></td>
            <td class="column-name hidden-phone"><?php echo $customer['customer_group']; ?></td>
            <td class="column-status">
							<?php // echo $customer['status']; ?>
							<?php $status = $customer['status']==$this->language->get('text_enabled'); ?>
							<?php echo p3html::tb_status_label($status, $customer['status']); ?>
						</td>
            <td class="column-price"><?php echo $customer['total']; ?></td>
            <td class="column-action">
							<?php echo p3html::tb_action_buttons($customer); ?>
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
<?php echo $footer; ?>