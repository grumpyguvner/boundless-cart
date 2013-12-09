<?php
//------------------------------------------------------------------------------
// ORDER STATUS LABEL
//------------------------------------------------------------------------------
$order_status_label = p3html::order_status_label_for_order_id($this, $order_id);
//------------------------------------------------------------------------------
?>
<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-clipboard"></i> <?php echo $heading_title; ?></h1>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_ajax_button($button_invoice, "window.open('$invoice');", null, null, 'print'); ?>
				<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
			</div>
    </div>

    <div class="content">
    <div class="tabbable tabs-left">

      <ul class="vtabs nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#tab-order"><i class="icon-eye"></i> <?php echo $tab_order; ?></a></li>
				<li><a data-toggle="tab" href="#tab-payment"><i class="icon-dollar"></i> <?php echo $tab_payment; ?></a></li>
        <?php if ($shipping_method) { ?>
        <li><a data-toggle="tab" href="#tab-shipping"><i class="icon-truck"></i> <?php echo $tab_shipping; ?></a></li>
        <?php } ?>
        <li><a data-toggle="tab" href="#tab-product"><i class="icon-list"></i> <?php echo $tab_product; ?></a></li>
				<li><a data-toggle="tab" href="#tab-history"><i class="icon-clock"></i> <?php echo $tab_order_history; ?></a></li>
        <?php if ($maxmind_id) { ?>
        <li><a data-toggle="tab" href="#tab-fraud"><i class="icon-key"></i> <?php echo $tab_fraud; ?></a></li>
        <?php } ?>
      </ul>

			<div class="tab-content">
      <div class="tab-pane active" id="tab-order" class="vtabs-content">
        <table class="form table table-hover">
          <tr>
            <th class="span3"><?php echo $text_order_id; ?></th>
            <td class="span9">#<?php echo $order_id; ?></td>
          </tr>
          <tr>
            <th class="span3"><?php echo $text_invoice_no; ?></th>
            <td class="span9">
							<?php if ($invoice_no) { ?>
              <?php echo $invoice_no; ?>
              <?php } else { ?>
              <span id="invoice"><b>[</b> <a id="invoice-generate"><?php echo $text_generate; ?></a> <b>]</b></span>
              <?php } ?>
						</td>
          </tr>
          <tr>
            <th class="span3"><?php echo $text_store_name; ?></th>
            <td class="span9"><?php echo $store_name; ?></td>
          </tr>
          <tr>
            <th class="span3"><?php echo $text_store_url; ?></th>
            <td class="span9"><a onclick="window.open('<?php echo $store_url; ?>');"><u><?php echo $store_url; ?></u></a></td>
          </tr>
          <?php if ($customer) { ?>
          <tr>
            <th class="span3"><?php echo $text_customer; ?></th>
            <td class="span9"><a href="<?php echo $customer; ?>"><?php echo $firstname; ?> <?php echo $lastname; ?></a></td>
          </tr>
          <?php } else { ?>
          <tr>
            <th class="span3"><?php echo $text_customer; ?></th>
            <td class="span9"><?php echo $firstname; ?> <?php echo $lastname; ?></td>
          </tr>
          <?php } ?>
          <?php if ($customer_group) { ?>
          <tr>
            <th class="span3"><?php echo $text_customer_group; ?></th>
            <td class="span9"><?php echo $customer_group; ?></td>
          </tr>
          <?php } ?>
          <tr>
            <th class="span3"><?php echo $text_email; ?></th>
            <td class="span9"><?php echo $email; ?></td>
          </tr>
          <tr>
            <th class="span3"><?php echo $text_telephone; ?></th>
            <td class="span9"><?php echo $telephone; ?></td>
          </tr>
          <?php if ($fax) { ?>
          <tr>
            <div><?php echo $text_fax; ?></td>
            <td class="span9"><?php echo $fax; ?></td>
          </tr>
          <?php } ?>
          <tr>
            <th class="span3"><?php echo $text_total; ?></th>
            <td class="span9">
							<?php echo $total; ?>
              <?php if ($credit && $customer) { ?>
              <?php if (!$credit_total) { ?>
              <span id="credit"><b>[</b> <a id="credit-add"><?php echo $text_credit_add; ?></a> <b>]</b></span>
              <?php } else { ?>
              <span id="credit"><b>[</b> <a id="credit-remove"><?php echo $text_credit_remove; ?></a> <b>]</b></span>
              <?php } ?>
              <?php } ?>
						</td>
          </tr>
          <?php if ($reward && $customer) { ?>
          <tr>
            <th class="span3"><?php echo $text_reward; ?></th>
            <td class="span9">
							<?php echo $reward; ?>
              <?php if (!$reward_total) { ?>
              <span id="reward"><b>[</b> <a id="reward-add"><?php echo $text_reward_add; ?></a> <b>]</b></span>
              <?php } else { ?>
              <span id="reward"><b>[</b> <a id="reward-remove"><?php echo $text_reward_remove; ?></a> <b>]</b></span>
              <?php } ?>
						</td>
          </tr>
          <?php } ?>
          <?php if ($order_status) { ?>
          <tr>
            <th class="span3"><?php echo $text_order_status; ?></th>
            <td id="order-status" class="controls">
							<?php if ($order_status_label) { ?><span class="label label-<?php echo $order_status_label; ?>"><?php } ?>
							<?php echo $order_status; ?>
							<?php if ($order_status_label) { ?></span><?php } ?>
						</td>
          </tr>
          <?php } ?>
          <?php if ($comment) { ?>
          <tr>
            <th class="span3"><?php echo $text_comment; ?></th>
            <td class="span9"><?php echo $comment; ?></td>
          </tr>
          <?php } ?>
          <?php if ($affiliate) { ?>
          <tr>
            <th class="span3"><?php echo $text_affiliate; ?></th>
            <td class="span9">
							<a href="<?php echo $affiliate; ?>"><?php echo $affiliate_firstname; ?> <?php echo $affiliate_lastname; ?></a>
						</td>
          </tr>
          <tr>
            <th class="span3"><?php echo $text_commission; ?></th>
            <td class="span9">
							<?php echo $commission; ?>
              <?php if (!$commission_total) { ?>
              <span id="commission"><b>[</b> <a id="commission-add"><?php echo $text_commission_add; ?></a> <b>]</b></span>
              <?php } else { ?>
              <span id="commission"><b>[</b> <a id="commission-remove"><?php echo $text_commission_remove; ?></a> <b>]</b></span>
              <?php } ?>
						</td>
          </tr>
          <?php } ?>
          <?php if ($ip) { ?>
          <tr>
            <th class="span3"><?php echo $text_ip; ?></th>
            <td class="span9"><?php echo $ip; ?></td>
          </tr>
          <?php } ?>
          <?php if ($forwarded_ip) { ?>
          <tr>
            <th class="span3"><?php echo $text_forwarded_ip; ?></th>
            <td class="span9"><?php echo $forwarded_ip; ?></td>
          </div>
          <?php } ?>
          <?php if ($user_agent) { ?>
          <tr>
            <th class="span3"><?php echo $text_user_agent; ?></th>
            <td class="span9"><?php echo $user_agent; ?></td>
          </tr>
          <?php } ?>
          <?php if ($accept_language) { ?>
          <tr>
            <th class="span3"><?php echo $text_accept_language; ?></th>
            <td class="span9"><?php echo $accept_language; ?></td>
          </tr>
          <?php } ?>
          <tr>
            <th class="span3"><?php echo $text_date_added; ?></th>
            <td class="span9"><?php echo $date_added; ?></td>
          </tr>
          <tr>
            <th class="span3"><?php echo $text_date_modified; ?></th>
            <td class="span9"><?php echo $date_modified; ?></td>
          </tr>
        </table>
      </div>

      <div class="tab-pane" id="tab-payment" class="vtabs-content">
        <table class="form table table-hover">
          <tr>
            <th class="span3"><?php echo $text_firstname; ?></th>
            <td class="controls span9"><?php echo $payment_firstname; ?></td>
          </tr>
          <tr>
            <th class="span3"><?php echo $text_lastname; ?></th>
            <td class="span9"><?php echo $payment_lastname; ?></td>
          </tr>
          <?php if ($payment_company) { ?>
          <tr>
            <th class="span3"><?php echo $text_company; ?></th>
            <td class="span9"><?php echo $payment_company; ?></td>
          </tr>
          <?php } ?>
          <?php if ($payment_company_id) { ?>
          <tr>
            <th class="span3"><?php echo $text_company_id; ?></th>
            <td class="span9"><?php echo $payment_company_id; ?></td>
          </tr>
          <?php } ?>
          <?php if ($payment_tax_id) { ?>
          <tr>
            <th class="span3"><?php echo $text_tax_id; ?></th>
            <td class="span9"><?php echo $payment_tax_id; ?></td>
          </tr>
          <?php } ?>
          <tr>
            <th class="span3"><?php echo $text_address_1; ?></th>
            <td class="span9"><?php echo $payment_address_1; ?></td>
          </tr>
          <?php if ($payment_address_2) { ?>
          <tr>
            <th class="span3"><?php echo $text_address_2; ?></th>
            <td class="span9"><?php echo $payment_address_2; ?></td>
          </tr>
          <?php } ?>
          <tr>
            <th class="span3"><?php echo $text_city; ?></th>
            <td class="span9"><?php echo $payment_city; ?></td>
          </tr>
          <?php if ($payment_postcode) { ?>
          <tr>
            <th class="span3"><?php echo $text_postcode; ?></th>
            <td class="span9"><?php echo $payment_postcode; ?></td>
          </tr>
          <?php } ?>
          <tr>
            <th class="span3"><?php echo $text_zone; ?></th>
            <td class="span9"><?php echo $payment_zone; ?></td>
          </tr>
          <?php if ($payment_zone_code) { ?>
          <tr>
            <th class="span3"><?php echo $text_zone_code; ?></th>
            <td class="span9"><?php echo $payment_zone_code; ?></td>
          </tr>
          <?php } ?>
          <tr>
            <th class="span3"><?php echo $text_country; ?></th>
            <td class="span9"><?php echo $payment_country; ?></td>
          </tr>
          <tr>
            <th class="span3"><?php echo $text_payment_method; ?></th>
            <td class="span9"><?php echo $payment_method; ?></td>
          </tr>
        </table>
      </div>

      <?php if ($shipping_method) { ?>
      <div class="tab-pane" id="tab-shipping" class="vtabs-content">
        <table class="form table table-hover">
          <tr>
            <th class="span3"><?php echo $text_firstname; ?></th>
            <td class="span9"><?php echo $shipping_firstname; ?></td>
          </tr>
          <tr>
            <th class="span3"><?php echo $text_lastname; ?></th>
            <td class="span9"><?php echo $shipping_lastname; ?></td>
          </tr>
          <?php if ($shipping_company) { ?>
          <tr>
            <th class="span3"><?php echo $text_company; ?></th>
            <td class="span9"><?php echo $shipping_company; ?></td>
          </tr>
          <?php } ?>
          <tr>
            <th class="span3"><?php echo $text_address_1; ?></th>
            <td class="span9"><?php echo $shipping_address_1; ?></td>
          </tr>
          <?php if ($shipping_address_2) { ?>
          <tr>
            <th class="span3"><?php echo $text_address_2; ?></th>
            <td class="span9"><?php echo $shipping_address_2; ?></td>
          </tr>
          <?php } ?>
          <tr>
            <th class="span3"><?php echo $text_city; ?></th>
            <td class="span9"><?php echo $shipping_city; ?></td>
          </tr>
          <?php if ($shipping_postcode) { ?>
          <tr>
            <th class="span3"><?php echo $text_postcode; ?></th>
            <td class="span9"><?php echo $shipping_postcode; ?></td>
          </tr>
          <?php } ?>
          <tr>
            <th class="span3"><?php echo $text_zone; ?></th>
            <td class="span9"><?php echo $shipping_zone; ?></td>
          </tr>
          <?php if ($shipping_zone_code) { ?>
          <tr>
            <th class="span3"><?php echo $text_zone_code; ?></th>
            <td class="span9"><?php echo $shipping_zone_code; ?></td>
          </tr>
          <?php } ?>
          <tr>
            <th class="span3"><?php echo $text_country; ?></th>
            <td class="span9"><?php echo $shipping_country; ?></td>
          </tr>
          <?php if ($shipping_method) { ?>
          <tr>
            <th class="span3"><?php echo $text_shipping_method; ?></th>
            <td class="span9"><?php echo $shipping_method; ?></td>
          </tr>
          <?php } ?>
        </table>
      </div>
      <?php } ?>

      <div class="tab-pane" id="tab-product" class="vtabs-content">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-name"><?php echo $column_product; ?></th>
              <th class="column-model"><?php echo $column_model; ?></th>
              <th class="column-quantity"><?php echo $column_quantity; ?></th>
              <th class="column-price"><?php echo $column_price; ?></th>
              <th class="column-price"><?php echo $column_total; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($products as $product) { ?>
            <tr>
              <td class="column-name">
								<a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                <?php foreach ($product['option'] as $option) { ?>
                <br>
                <?php if ($option['type'] != 'file') { ?>
                &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                <?php } else { ?>
                &nbsp;<small> - <?php echo $option['name']; ?>: <a href="<?php echo $option['href']; ?>"><?php echo $option['value']; ?></a></small>
                <?php } ?>
                <?php } ?>
							</td>
              <td class="column-model"><?php echo $product['model']; ?></td>
              <td class="column-quantity"><?php echo $product['quantity']; ?></td>
              <td class="column-price"><?php echo $product['price']; ?></td>
              <td class="column-price"><?php echo $product['total']; ?></td>
            </tr>
            <?php } ?>
            <?php foreach ($vouchers as $voucher) { ?>
            <tr>
              <td class="column-name"><a href="<?php echo $voucher['href']; ?>"><?php echo $voucher['description']; ?></a></td>
              <td></td>
              <td class="column-quantity">1</td>
              <td class="column-price"><?php echo $voucher['amount']; ?></td>
              <td class="column-price"><?php echo $voucher['amount']; ?></td>
            </tr>
            <?php } ?>
          </tbody>
          <tfoot id="totals">
	          <?php foreach ($totals as $totals) { ?>
            <tr>
              <th colspan="4" class="column-total"><?php echo $totals['title']; ?>:</th>
              <th class="column-price"><?php echo $totals['text']; ?></th>
            </tr>
	          <?php } ?>
          </tfoot>
        </table>

        <?php if ($downloads) { ?>
        <h3><?php echo $text_download; ?></h3>
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-name"><b><?php echo $column_download; ?></b></th>
              <th class="column-name"><b><?php echo $column_filename; ?></b></th>
              <th class="column-quantity"><b><?php echo $column_remaining; ?></b></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($downloads as $download) { ?>
            <tr>
              <td class="column-name"><?php echo $download['name']; ?></td>
              <td class="column-name"><?php echo $download['filename']; ?></td>
              <td class="column-quantity"><?php echo $download['remaining']; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
        <?php } ?>
      </div>

      <div class="tab-pane" id="tab-history" class="vtabs-content">
        <div id="history"></div>
        <div class="form form-horizontal">
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></label>
            <div class="controls">
                <select name="order_status_id" class="span2 i-medium">
                    <?php echo p3html::oc_order_status_options($order_statuses, $order_status_id); ?>
                </select>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label"></label>
            <div class="controls">
							<label class="checkbox inline" for="notify-customer">
								<input type="checkbox" name="notify" value="1" id="notify-customer">
								<?php echo $entry_notify; ?>
							</label>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_comment; ?></label>
            <div class="controls">
							<textarea name="comment" class="input-block-level" rows="8"></textarea>
  
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_notes; ?></label>
            <div class="controls">
							<textarea name="notes" class="input-block-level" rows="8"></textarea>
              <div style="margin-top: 10px; text-align: right;">
								<a id="button-history" class="btn"><i class="icon-clock"></i> <?php echo $button_add_history; ?></a>
							</div>
						</div>
          </div>
        </div>
      </div>

      <?php if ($maxmind_id) { ?>
      <div class="tab-pane" id="tab-fraud" class="vtabs-content">
        <table class="form table table-hover">
          <?php if ($country_match) { ?>
          <tr>
            <th><?php echo $text_country_match; ?></th>
            <td><?php echo $country_match; ?></td>
          </tr>
          <?php } ?>
          <?php if ($country_code) { ?>
          <tr>
            <th><?php echo $text_country_code; ?></th>
            <td><?php echo $country_code; ?></td>
          </tr>
          <?php } ?>
          <?php if ($high_risk_country) { ?>
          <tr>
            <th><?php echo $text_high_risk_country; ?></th>
            <td><?php echo $high_risk_country; ?></td>
          </tr>
          <?php } ?>
          <?php if ($distance) { ?>
          <tr>
            <th><?php echo $text_distance; ?></th>
            <td><?php echo $distance; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_region) { ?>
          <tr>
            <th><?php echo $text_ip_region; ?></th>
            <td><?php echo $ip_region; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_city) { ?>
          <tr>
            <th><?php echo $text_ip_city; ?></th>
            <td><?php echo $ip_city; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_latitude) { ?>
          <tr>
            <th><?php echo $text_ip_latitude; ?></th>
            <td><?php echo $ip_latitude; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_longitude) { ?>
          <tr>
            <th><?php echo $text_ip_longitude; ?></th>
            <td><?php echo $ip_longitude; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_isp) { ?>
          <tr>
            <th><?php echo $text_ip_isp; ?></th>
            <td><?php echo $ip_isp; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_org) { ?>
          <tr>
            <th><?php echo $text_ip_org; ?></th>
            <td><?php echo $ip_org; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_asnum) { ?>
          <tr>
            <th><?php echo $text_ip_asnum; ?></th>
            <td><?php echo $ip_asnum; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_user_type) { ?>
          <tr>
            <th><?php echo $text_ip_user_type; ?></th>
            <td><?php echo $ip_user_type; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_country_confidence) { ?>
          <tr>
            <th><?php echo $text_ip_country_confidence; ?></th>
            <td><?php echo $ip_country_confidence; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_region_confidence) { ?>
          <tr>
            <th><?php echo $text_ip_region_confidence; ?></th>
            <td><?php echo $ip_region_confidence; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_city_confidence) { ?>
          <tr>
            <th><?php echo $text_ip_city_confidence; ?></th>
            <td><?php echo $ip_city_confidence; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_postal_confidence) { ?>
          <tr>
            <th><?php echo $text_ip_postal_confidence; ?></th>
            <td><?php echo $ip_postal_confidence; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_postal_code) { ?>
          <tr>
            <th><?php echo $text_ip_postal_code; ?></th>
            <td><?php echo $ip_postal_code; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_accuracy_radius) { ?>
          <tr>
            <th><?php echo $text_ip_accuracy_radius; ?></th>
            <td><?php echo $ip_accuracy_radius; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_net_speed_cell) { ?>
          <tr>
            <th><?php echo $text_ip_net_speed_cell; ?></th>
            <td><?php echo $ip_net_speed_cell; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_metro_code) { ?>
          <tr>
            <th><?php echo $text_ip_metro_code; ?></th>
            <td><?php echo $ip_metro_code; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_area_code) { ?>
          <tr>
            <th><?php echo $text_ip_area_code; ?></th>
            <td><?php echo $ip_area_code; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_time_zone) { ?>
          <tr>
            <th><?php echo $text_ip_time_zone; ?></th>
            <td><?php echo $ip_time_zone; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_region_name) { ?>
          <tr>
            <th><?php echo $text_ip_region_name; ?></th>
            <td><?php echo $ip_region_name; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_domain) { ?>
          <tr>
            <th><?php echo $text_ip_domain; ?></th>
            <td><?php echo $ip_domain; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_country_name) { ?>
          <tr>
            <th><?php echo $text_ip_country_name; ?></th>
            <td><?php echo $ip_country_name; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_continent_code) { ?>
          <tr>
            <th><?php echo $text_ip_continent_code; ?></th>
            <td><?php echo $ip_continent_code; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ip_corporate_proxy) { ?>
          <tr>
            <th><?php echo $text_ip_corporate_proxy; ?></th>
            <td><?php echo $ip_corporate_proxy; ?></td>
          </tr>
          <?php } ?>
          <?php if ($anonymous_proxy) { ?>
          <tr>
            <th><?php echo $text_anonymous_proxy; ?></th>
            <td><?php echo $anonymous_proxy; ?></td>
          </tr>
          <?php } ?>
          <?php if ($proxy_score) { ?>
          <tr>
            <th><?php echo $text_proxy_score; ?></th>
            <td><?php echo $proxy_score; ?></td>
          </tr>
          <?php } ?>
          <?php if ($is_trans_proxy) { ?>
          <tr>
            <th><?php echo $text_is_trans_proxy; ?></th>
            <td><?php echo $is_trans_proxy; ?></td>
          </tr>
          <?php } ?>
          <?php if ($free_mail) { ?>
          <tr>
            <th><?php echo $text_free_mail; ?></th>
            <td><?php echo $free_mail; ?></td>
          </tr>
          <?php } ?>
          <?php if ($carder_email) { ?>
          <tr>
            <th><?php echo $text_carder_email; ?></th>
            <td><?php echo $carder_email; ?></td>
          </tr>
          <?php } ?>
          <?php if ($high_risk_username) { ?>
          <tr>
            <th><?php echo $text_high_risk_username; ?></th>
            <td><?php echo $high_risk_username; ?></td>
          </tr>
          <?php } ?>
          <?php if ($high_risk_password) { ?>
          <tr>
            <th><?php echo $text_high_risk_password; ?></th>
            <td><?php echo $high_risk_password; ?></td>
          </tr>
          <?php } ?>
          <?php if ($bin_match) { ?>
          <tr>
            <th><?php echo $text_bin_match; ?></th>
            <td><?php echo $bin_match; ?></td>
          </tr>
          <?php } ?>
          <?php if ($bin_country) { ?>
          <tr>
            <th><?php echo $text_bin_country; ?></th>
            <td><?php echo $bin_country; ?></td>
          </tr>
          <?php } ?>
          <?php if ($bin_name_match) { ?>
          <tr>
            <th><?php echo $text_bin_name_match; ?></th>
            <td><?php echo $bin_name_match; ?></td>
          </tr>
          <?php } ?>
          <?php if ($bin_name) { ?>
          <tr>
            <th><?php echo $text_bin_name; ?></th>
            <td><?php echo $bin_name; ?></td>
          </tr>
          <?php } ?>
          <?php if ($bin_phone_match) { ?>
          <tr>
            <th><?php echo $text_bin_phone_match; ?></th>
            <td><?php echo $bin_phone_match; ?></td>
          </tr>
          <?php } ?>
          <?php if ($bin_phone) { ?>
          <tr>
            <th><?php echo $text_bin_phone; ?></th>
            <td><?php echo $bin_phone; ?></td>
          </tr>
          <?php } ?>
          <?php if ($customer_phone_in_billing_location) { ?>
          <tr>
            <th><?php echo $text_customer_phone_in_billing_location; ?></th>
            <td><?php echo $customer_phone_in_billing_location; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ship_forward) { ?>
          <tr>
            <th><?php echo $text_ship_forward; ?></th>
            <td><?php echo $ship_forward; ?></td>
          </tr>
          <?php } ?>
          <?php if ($city_postal_match) { ?>
          <tr>
            <th><?php echo $text_city_postal_match; ?></th>
            <td><?php echo $city_postal_match; ?></td>
          </tr>
          <?php } ?>
          <?php if ($ship_city_postal_match) { ?>
          <tr>
            <th><?php echo $text_ship_city_postal_match; ?></th>
            <td><?php echo $ship_city_postal_match; ?></td>
          </tr>
          <?php } ?>
          <?php if ($score) { ?>
          <tr>
            <th><?php echo $text_score; ?></th>
            <td><?php echo $score; ?></td>
          </tr>
          <?php } ?>
          <?php if ($explanation) { ?>
          <tr>
            <th><?php echo $text_explanation; ?></th>
            <td><?php echo $explanation; ?></td>
          </tr>
          <?php } ?>
          <?php if ($risk_score) { ?>
          <tr>
            <th><?php echo $text_risk_score; ?></th>
            <td><?php echo $risk_score; ?></td>
          </tr>
          <?php } ?>
          <?php if ($queries_remaining) { ?>
          <tr>
            <th><?php echo $text_queries_remaining; ?></th>
            <td><?php echo $queries_remaining; ?></td>
          </tr>
          <?php } ?>
          <?php if ($maxmind_id) { ?>
          <tr>
            <th><?php echo $text_maxmind_id; ?></th>
            <td><?php echo $maxmind_id; ?></td>
          </tr>
          <?php } ?>
          <?php if ($error) { ?>
          <tr>
            <th><?php echo $text_error; ?></th>
            <td><?php echo $error; ?></td>
          </tr>
          <?php } ?>
        </table>
      </div>
      <?php } ?>

			</div>
    </div>
  </div>
  </div>

</div>

<script>
$('#invoice-generate').live('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/createinvoiceno&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
		dataType: 'json',
		beforeSend: function() {
			$('#invoice').after('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;">');
		},
		complete: function() {
			$('.loading').remove();
		},
		success: function(json) {
			$('.success, .warning').remove();

			if (json['error']) {
				$('#tab-order').prepend('<div class="warning" style="display: none;">' + json['error'] + '</div>');

				$('.warning').fadeIn('slow');
			}

			if (json.invoice_no) {
				$('#invoice').fadeOut('slow', function() {
					$('#invoice').html(json['invoice_no']);

					$('#invoice').fadeIn('slow');
				});
			}
		}
	});
});

$('#credit-add').live('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/addcredit&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
		type: 'post',
		dataType: 'json',
		beforeSend: function() {
			$('#credit').after('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;">');
		},
		complete: function() {
			$('.loading').remove();
		},
		success: function(json) {
			$('.success, .warning').remove();

			if (json['error']) {
				$('.box').before('<div class="warning" style="display: none;">' + json['error'] + '</div>');

				$('.warning').fadeIn('slow');
			}

			if (json['success']) {
                $('.box').before('<div class="success" style="display: none;">' + json['success'] + '</div>');

				$('.success').fadeIn('slow');

				$('#credit').html('<b>[</b> <a id="credit-remove"><?php echo $text_credit_remove; ?></a> <b>]</b>');
			}
		}
	});
});

$('#credit-remove').live('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/removecredit&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
		type: 'post',
		dataType: 'json',
		beforeSend: function() {
			$('#credit').after('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;">');
		},
		complete: function() {
			$('.loading').remove();
		},
		success: function(json) {
			$('.success, .warning').remove();

			if (json['error']) {
				$('.box').before('<div class="warning" style="display: none;">' + json['error'] + '</div>');

				$('.warning').fadeIn('slow');
			}

			if (json['success']) {
                $('.box').before('<div class="success" style="display: none;">' + json['success'] + '</div>');

				$('.success').fadeIn('slow');

				$('#credit').html('<b>[</b> <a id="credit-add"><?php echo $text_credit_add; ?></a> <b>]</b>');
			}
		}
	});
});

$('#reward-add').live('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/addreward&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
		type: 'post',
		dataType: 'json',
		beforeSend: function() {
			$('#reward').after('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;">');
		},
		complete: function() {
			$('.loading').remove();
		},
		success: function(json) {
			$('.success, .warning').remove();

			if (json['error']) {
				$('.box').before('<div class="warning" style="display: none;">' + json['error'] + '</div>');

				$('.warning').fadeIn('slow');
			}

			if (json['success']) {
                $('.box').before('<div class="success" style="display: none;">' + json['success'] + '</div>');

				$('.success').fadeIn('slow');

				$('#reward').html('<b>[</b> <a id="reward-remove"><?php echo $text_reward_remove; ?></a> <b>]</b>');
			}
		}
	});
});

$('#reward-remove').live('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/removereward&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
		type: 'post',
		dataType: 'json',
		beforeSend: function() {
			$('#reward').after('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;">');
		},
		complete: function() {
			$('.loading').remove();
		},
		success: function(json) {
			$('.success, .warning').remove();

			if (json['error']) {
				$('.box').before('<div class="warning" style="display: none;">' + json['error'] + '</div>');

				$('.warning').fadeIn('slow');
			}

			if (json['success']) {
                $('.box').before('<div class="success" style="display: none;">' + json['success'] + '</div>');

				$('.success').fadeIn('slow');

				$('#reward').html('<b>[</b> <a id="reward-add"><?php echo $text_reward_add; ?></a> <b>]</b>');
			}
		}
	});
});

$('#commission-add').live('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/addcommission&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
		type: 'post',
		dataType: 'json',
		beforeSend: function() {
			$('#commission').after('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;">');
		},
		complete: function() {
			$('.loading').remove();
		},
		success: function(json) {
			$('.success, .warning').remove();

			if (json['error']) {
				$('.box').before('<div class="warning" style="display: none;">' + json['error'] + '</div>');

				$('.warning').fadeIn('slow');
			}

			if (json['success']) {
                $('.box').before('<div class="success" style="display: none;">' + json['success'] + '</div>');

				$('.success').fadeIn('slow');

				$('#commission').html('<b>[</b> <a id="commission-remove"><?php echo $text_commission_remove; ?></a> <b>]</b>');
			}
		}
	});
});

$('#commission-remove').live('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/removecommission&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
		type: 'post',
		dataType: 'json',
		beforeSend: function() {
			$('#commission').after('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;">');
		},
		complete: function() {
			$('.loading').remove();
		},
		success: function(json) {
			$('.success, .warning').remove();

			if (json['error']) {
				$('.box').before('<div class="warning" style="display: none;">' + json['error'] + '</div>');

				$('.warning').fadeIn('slow');
			}

			if (json['success']) {
                $('.box').before('<div class="success" style="display: none;">' + json['success'] + '</div>');

				$('.success').fadeIn('slow');

				$('#commission').html('<b>[</b> <a id="commission-add"><?php echo $text_commission_add; ?></a> <b>]</b>');
			}
		}
	});
});

$('#history .pagination a').live('click', function() {
	$('#history').load(this.href);

	return false;
});

$('#history').load('index.php?route=sale/order/history&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>');

$('#button-history').live('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/history&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
		type: 'post',
		dataType: 'html',
		data: 'order_status_id=' + encodeURIComponent($('select[name=\'order_status_id\']').val()) + '&notify=' + encodeURIComponent($('input[name=\'notify\']').attr('checked') ? 1 : 0) + '&append=' + encodeURIComponent($('input[name=\'append\']').attr('checked') ? 1 : 0) + '&comment=' + encodeURIComponent($('textarea[name=\'comment\']').val()) + '&notes=' + encodeURIComponent($('textarea[name=\'notes\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-history').attr('disabled', true);
			$('#history').prepend('<div class="attention"><img src="view/image/loading.gif" alt=""> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-history').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(html) {
			$('#history').html(html);

			$('textarea[name=\'comment\']').val('');
			$('textarea[name=\'notes\']').val('');

			$('#order-status').html($('select[name=\'order_status_id\'] option:selected').text());
		}
	});
});
</script>
<script>
//$('.vtabs a').tabs();
</script>
<?php echo $footer; ?>