<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>
  <div class="box">

    <div class="heading">
      <h1><i class="icon-clipboard"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_save($button_save); ?>
				<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
			</div>
    </div>

    <div class="content">
		<div class="tabbable tabs-left">

      <ul id="vtabs" class="vtabs nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#tab-customer"><i class="icon-user"></i> <?php echo $tab_customer; ?></a></li>
				<li><a data-toggle="tab" href="#tab-payment"><i class="icon-dollar"></i> <?php echo $tab_payment; ?></a></li>
				<li><a data-toggle="tab" href="#tab-shipping"><i class="icon-truck"></i> <?php echo $tab_shipping; ?></a></li>
				<li><a data-toggle="tab" href="#tab-product"><i class="icon-list"></i> <?php echo $tab_product; ?></a></li>
				<li><a data-toggle="tab" href="#tab-voucher"><i class="icon-gift"></i> <?php echo $tab_voucher; ?></a></li>
				<li><a data-toggle="tab" href="#tab-total"><i class="icon-keyboard"></i> <?php echo $tab_total; ?></a></li>
			</ul>

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
			<div class="tab-content">

        <div class="tab-pane active" id="tab-customer" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_store; ?></label>
              <div class="controls">
								<select name="store_id" class="span3 i-large">
                  <option value="0"><?php echo $text_default; ?></option>
									<?php echo p3html::oc_store_options($stores, $store_id) ?>
                </select>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_customer; ?></label>
              <div class="controls">
								<input type="text" name="customer" value="<?php echo $customer; ?>" class="span3 i-large">
                <input type="hidden" name="customer_id" value="<?php echo $customer_id; ?>">
                <input type="hidden" name="customer_group_id" value="<?php echo $customer_group_id; ?>">
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_customer_group; ?></label>
              <div class="controls">
								<select id="customer_group_id" <?php echo ($customer_id ? 'disabled="disabled"' : ''); ?> class="span3 i-large">
									<?php echo p3html::oc_customer_group_options($customer_groups, $customer_group_id) ?>
                </select>
							</div>
            </div>
            <div class="control-group<?php if ($error_firstname) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_firstname; ?></label>
              <div class="controls">
								<input type="text" name="firstname" value="<?php echo $firstname; ?>" class="span3 i-large">
                <?php if ($error_firstname) { ?>
                <span class="error help-block"><?php echo $error_firstname; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_lastname) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_lastname; ?></label>
              <div class="controls">
								<input type="text" name="lastname" value="<?php echo $lastname; ?>" class="span3 i-large">
                <?php if ($error_lastname) { ?>
                <span class="error help-block"><?php echo $error_lastname; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_email) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_email; ?></label>
              <div class="controls">
								<input type="text" name="email" value="<?php echo $email; ?>" class="span4 i-xlarge">
                <?php if ($error_email) { ?>
                <span class="error help-block"><?php echo $error_email; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_telephone) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_telephone; ?></label>
              <div class="controls">
								<input type="text" name="telephone" value="<?php echo $telephone; ?>" class="span3 i-large">
                <?php if ($error_telephone) { ?>
                <span class="error help-block"><?php echo $error_telephone; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_fax; ?></label>
              <div class="controls"><input type="text" name="fax" value="<?php echo $fax; ?>" class="span3 i-large"></div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-payment" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_address; ?></label>
              <div class="controls">
								<select name="payment_address" class="span5 i-xxlarge">
                  <option value="0" selected="selected"><?php echo $text_none; ?></option>
									<?php echo p3html::oc_addresses_options($addresses); ?>
                </select>
							</div>
            </div>
            <div class="control-group<?php if ($error_payment_firstname) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_firstname; ?></label>
              <div class="controls">
								<input type="text" name="payment_firstname" value="<?php echo $payment_firstname; ?>" class="span3 i-large">
                <?php if ($error_payment_firstname) { ?>
                <span class="error help-block"><?php echo $error_payment_firstname; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_payment_lastname) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_lastname; ?></label>
              <div class="controls">
								<input type="text" name="payment_lastname" value="<?php echo $payment_lastname; ?>" class="span3 i-large">
                <?php if ($error_payment_lastname) { ?>
                <span class="error help-block"><?php echo $error_payment_lastname; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_company; ?></label>
              <div class="controls">
								<input type="text" name="payment_company" value="<?php echo $payment_company; ?>" class="span4 i-xlarge">
							</div>
            </div>
            <div class="control-group" id="company-id-display">
              <label class="control-label">
								<span id="company-id-required" class="required">*</span> <?php echo $entry_company_id; ?>
							</label>
              <div class="controls"><input type="text" name="payment_company_id" value="<?php echo $payment_company_id; ?>" class="span2 i-medium"></div>
            </div>
            <div id="tax-id-display" class="control-group<?php if ($error_payment_tax_id) { ?> error<?php } ?>">
              <label class="control-label">
								<span id="tax-id-required" class="required">*</span> <?php echo $entry_tax_id; ?>
							</label>
              <div class="controls">
								<input type="text" name="payment_tax_id" value="<?php echo $payment_tax_id; ?>" class="span2 i-medium">
                <?php if ($error_payment_tax_id) { ?>
                <span class="error help-block"><?php echo $error_payment_tax_id; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_payment_address_1) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_address_1; ?></label>
              <div class="controls">
								<input type="text" name="payment_address_1" value="<?php echo $payment_address_1; ?>" class="span4 i-xlarge">
                <?php if ($error_payment_address_1) { ?>
                <span class="error help-block"><?php echo $error_payment_address_1; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_address_2; ?></label>
              <div class="controls">
								<input type="text" name="payment_address_2" value="<?php echo $payment_address_2; ?>" class="span4 i-xlarge">
							</div>
            </div>
            <div class="control-group<?php if ($error_payment_city) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_city; ?></label>
              <div class="controls">
								<input type="text" name="payment_city" value="<?php echo $payment_city; ?>" class="span3 i-large">
                <?php if ($error_payment_city) { ?>
                <span class="error help-block"><?php echo $error_payment_city; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_payment_postcode) { ?> error<?php } ?>">
              <label class="control-label">
								<span id="payment-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?>
							</label>
              <div class="controls">
								<input type="text" name="payment_postcode" value="<?php echo $payment_postcode; ?>" class="span2 i-medium">
                <?php if ($error_payment_postcode) { ?>
                <span class="error help-block"><?php echo $error_payment_postcode; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_payment_country) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_country; ?></label>
              <div class="controls">
								<select name="payment_country_id" class="span4 i-xlarge">
                  <option value=""><?php echo $text_select; ?></option>
									<?php echo p3html::oc_country_options($countries, $payment_country_id); ?>
                </select>
                <?php if ($error_payment_country) { ?>
                <span class="error help-block"><?php echo $error_payment_country; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_payment_zone) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_zone; ?></label>
              <div class="controls">
								<select name="payment_zone_id" class="span4 i-xlarge">
                </select>
                <?php if ($error_payment_zone) { ?>
                <span class="error help-block"><?php echo $error_payment_zone; ?></span>
                <?php } ?>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-shipping" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_address; ?></label>
              <div class="controls">
								<select name="shipping_address" class="span5 i-xxlarge">
                  <option value="0" selected="selected"><?php echo $text_none; ?></option>
									<?php echo p3html::oc_addresses_options($addresses); ?>
                </select>
							</div>
            </div>
            <div class="control-group<?php if ($error_shipping_firstname) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_firstname; ?></label>
              <div class="controls">
								<input type="text" name="shipping_firstname" value="<?php echo $shipping_firstname; ?>" class="span3 i-large">
                <?php if ($error_shipping_firstname) { ?>
                <span class="error help-block"><?php echo $error_shipping_firstname; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_shipping_lastname) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_lastname; ?></label>
              <div class="controls">
								<input type="text" name="shipping_lastname" value="<?php echo $shipping_lastname; ?>" class="span3 i-large">
                <?php if ($error_shipping_lastname) { ?>
                <span class="error help-block"><?php echo $error_shipping_lastname; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_company; ?></label>
              <div class="controls">
								<input type="text" name="shipping_company" value="<?php echo $shipping_company; ?>" class="span4 i-xlarge">
							</div>
            </div>
            <div class="control-group<?php if ($error_shipping_address_1) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_address_1; ?></label>
              <div class="controls">
								<input type="text" name="shipping_address_1" value="<?php echo $shipping_address_1; ?>" class="span4 i-xlarge">
                <?php if ($error_shipping_address_1) { ?>
                <span class="error help-block"><?php echo $error_shipping_address_1; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_address_2; ?></label>
              <div class="controls">
								<input type="text" name="shipping_address_2" value="<?php echo $shipping_address_2; ?>" class="span4 i-xlarge">
							</div>
            </div>
            <div class="control-group<?php if ($error_shipping_city) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_city; ?></label>
              <div class="controls">
								<input type="text" name="shipping_city" value="<?php echo $shipping_city; ?>" class="span3 i-large">
                <?php if ($error_shipping_city) { ?>
                <span class="error help-block"><?php echo $error_shipping_city; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_shipping_postcode) { ?> error<?php } ?>">
              <label class="control-label"><span id="shipping-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?></label>
              <div class="controls">
								<input type="text" name="shipping_postcode" value="<?php echo $shipping_postcode; ?>" class="span2 i-medium">
                <?php if ($error_shipping_postcode) { ?>
                <span class="error help-block"><?php echo $error_shipping_postcode; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_shipping_country) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_country; ?></label>
              <div class="controls">
								<select name="shipping_country_id" class="span4 i-xlarge">
                  <option value=""><?php echo $text_select; ?></option>
									<?php echo p3html::oc_country_options($countries, $shipping_country_id); ?>
                </select>
                <?php if ($error_shipping_country) { ?>
                <span class="error help-block"><?php echo $error_shipping_country; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_shipping_zone) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_zone; ?></label>
              <div class="controls">
								<select name="shipping_zone_id" class="span4 i-xlarge">
                </select>
                <?php if ($error_shipping_zone) { ?>
                <span class="error help-block"><?php echo $error_shipping_zone; ?></span>
                <?php } ?>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-product" class="vtabs-content">
          <table class="list table table-striped table-hover table-condensed">
            <thead>
              <tr>
                <th class="column-action"></th>
                <th class="column-name"><?php echo $column_product; ?></th>
                <th class="column-model"><?php echo $column_model; ?></th>
                <th class="column-quantity"><?php echo $column_quantity; ?></th>
                <th class="column-price"><?php echo $column_price; ?></th>
                <th class="column-price"><?php echo $column_total; ?></th>
              </tr>
            </thead>
            <?php $product_row = 0; ?>
            <?php $option_row = 0; ?>
            <?php $download_row = 0; ?>
            <tbody id="product">
              <?php if ($order_products) { ?>
              <?php foreach ($order_products as $order_product) { ?>
              <tr id="product-row<?php echo $product_row; ?>">
                <td class="column-action">
									<button class="btn btn-small icon-trash" title="<?php echo $button_remove; ?>" alt="<?php echo $button_remove; ?>" style="cursor: pointer;" onclick="$('#product-row<?php echo $product_row; ?>').remove(); $('#button-update').trigger('click');"></button>
								</td>
                <td class="column-name"><?php echo $order_product['name']; ?><br>
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_product_id]" value="<?php echo $order_product['order_product_id']; ?>">
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][product_id]" value="<?php echo $order_product['product_id']; ?>">
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][name]" value="<?php echo $order_product['name']; ?>">
                  <?php foreach ($order_product['option'] as $option) { ?>
                  - <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br>
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_option][<?php echo $option_row; ?>][order_option_id]" value="<?php echo $option['order_option_id']; ?>">
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_option][<?php echo $option_row; ?>][product_option_id]" value="<?php echo $option['product_option_id']; ?>">
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_option][<?php echo $option_row; ?>][product_option_value_id]" value="<?php echo $option['product_option_value_id']; ?>">
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_option][<?php echo $option_row; ?>][name]" value="<?php echo $option['name']; ?>">
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_option][<?php echo $option_row; ?>][value]" value="<?php echo $option['value']; ?>">
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_option][<?php echo $option_row; ?>][type]" value="<?php echo $option['type']; ?>">
                  <?php $option_row++; ?>
                  <?php } ?>
                  <?php foreach ($order_product['download'] as $download) { ?>
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_download][<?php echo $download_row; ?>][order_download_id]" value="<?php echo $download['order_download_id']; ?>">
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_download][<?php echo $download_row; ?>][name]" value="<?php echo $download['name']; ?>">
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_download][<?php echo $download_row; ?>][filename]" value="<?php echo $download['filename']; ?>">
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_download][<?php echo $download_row; ?>][mask]" value="<?php echo $download['mask']; ?>">
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_download][<?php echo $download_row; ?>][remaining]" value="<?php echo $download['remaining']; ?>">
                  <?php $download_row++; ?>
                  <?php } ?>
								</td>
                <td class="column-model"><?php echo $order_product['model']; ?>
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][model]" value="<?php echo $order_product['model']; ?>">
								</td>
                <td class="column-quantity"><?php echo $order_product['quantity']; ?>
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][quantity]" value="<?php echo $order_product['quantity']; ?>">
								</td>
                <td class="column-price"><?php echo $order_product['price']; ?>
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][price]" value="<?php echo $order_product['price']; ?>">
								</td>
                <td class="column-price"><?php echo $order_product['total']; ?>
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][total]" value="<?php echo $order_product['total']; ?>">
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][tax]" value="<?php echo $order_product['tax']; ?>">
                  <input type="hidden" name="order_product[<?php echo $product_row; ?>][reward]" value="<?php echo $order_product['reward']; ?>">
								</td>
              </tr>
              <?php $product_row++; ?>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="column-results" colspan="6"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>

					<br>

          <div class="form form-horizontal form-condensed form-bordered form-hover">
						<legend><i class="icon-plus-squared"></i> <?php echo $text_product; ?></legend>
            <fieldset>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_product; ?></label>
                <div class="controls">
									<input type="text" name="product" value="" class="span3 i-large">
                  <input type="hidden" name="product_id" value="">
								</div>
              </div>
              <div class="control-group" id="option">
								<label class="control-label"><?php echo $entry_option; ?></label>
								<div class="controls"></div>
							</div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_quantity; ?></label>
                <div class="controls">
									<input type="text" name="quantity" value="1" class="input-small">
								</div>
              </div>
						</fieldset>
						<div class="form-actions">
							<a id="button-product" class="btn"><i class="icon-plus-squared"></i> <?php echo $button_add_product; ?></a>
						</div>
          </div>

        </div>

        <div class="tab-pane" id="tab-voucher" class="vtabs-content">
          <table class="list table table-striped table-hover table-condensed">
            <thead>
              <tr>
                <th class="column-checkbox"></th>
                <th class="column-name"><?php echo $column_product; ?></th>
                <th class="column-model"><?php echo $column_model; ?></th>
                <th class="column-quantity"><?php echo $column_quantity; ?></th>
                <th class="column-price"><?php echo $column_price; ?></th>
                <th class="column-price"><?php echo $column_total; ?></th>
              </tr>
            </thead>
            <tbody id="voucher">
              <?php $voucher_row = 0; ?>
              <?php if ($order_vouchers) { ?>
              <?php foreach ($order_vouchers as $order_voucher) { ?>
              <tr id="voucher-row<?php echo $voucher_row; ?>">
                <td class="column-checkbox">
									<button class="btn btn-small icon-trash" title="<?php echo $button_remove; ?>" alt="<?php echo $button_remove; ?>" style="cursor: pointer;" onclick="$('#voucher-row<?php echo $voucher_row; ?>').remove(); $('#button-update').trigger('click');"></button>
								</td>
                <td class="column-name"><?php echo $order_voucher['description']; ?>
                  <input type="hidden" name="order_voucher[<?php echo $voucher_row; ?>][order_voucher_id]" value="<?php echo $order_voucher['order_voucher_id']; ?>">
                  <input type="hidden" name="order_voucher[<?php echo $voucher_row; ?>][voucher_id]" value="<?php echo $order_voucher['voucher_id']; ?>">
                  <input type="hidden" name="order_voucher[<?php echo $voucher_row; ?>][description]" value="<?php echo $order_voucher['description']; ?>">
                  <input type="hidden" name="order_voucher[<?php echo $voucher_row; ?>][code]" value="<?php echo $order_voucher['code']; ?>">
                  <input type="hidden" name="order_voucher[<?php echo $voucher_row; ?>][from_name]" value="<?php echo $order_voucher['from_name']; ?>">
                  <input type="hidden" name="order_voucher[<?php echo $voucher_row; ?>][from_email]" value="<?php echo $order_voucher['from_email']; ?>">
                  <input type="hidden" name="order_voucher[<?php echo $voucher_row; ?>][to_name]" value="<?php echo $order_voucher['to_name']; ?>">
                  <input type="hidden" name="order_voucher[<?php echo $voucher_row; ?>][to_email]" value="<?php echo $order_voucher['to_email']; ?>">
                  <input type="hidden" name="order_voucher[<?php echo $voucher_row; ?>][voucher_theme_id]" value="<?php echo $order_voucher['voucher_theme_id']; ?>">
                  <input type="hidden" name="order_voucher[<?php echo $voucher_row; ?>][message]" value="<?php echo $order_voucher['message']; ?>">
                  <input type="hidden" name="order_voucher[<?php echo $voucher_row; ?>][amount]" value="<?php echo $order_voucher['amount']; ?>"></td>
                <td class="column-model"></td>
                <td class="column-quantity">1</td>
                <td class="column-price"><?php echo $order_voucher['amount']; ?></td>
                <td class="column-price"><?php echo $order_voucher['amount']; ?></td>
              </tr>
              <?php $voucher_row++; ?>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="column-results" colspan="6"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>

					<br>

          <div class="form form-horizontal form-condensed form-bordered form-hover">
						<legend><i class="icon-plus-squared"></i> <?php echo $text_voucher; ?></legend>
            <fieldset>
              <div class="control-group">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_to_name; ?></label>
                <div class="controls">
									<input type="text" name="to_name" value="" value="" class="span3 i-large">
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_to_email; ?></label>
                <div class="controls">
									<input type="text" name="to_email" value="" class="span3 i-large">
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_from_name; ?></label>
                <div class="controls">
									<input type="text" name="from_name" value="" class="span3 i-large">
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_from_email; ?></label>
                <div class="controls">
									<input type="text" name="from_email" value="" class="span3 i-large">
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_theme; ?></label>
                <div class="controls">
									<select name="voucher_theme_id" class="span3 i-large">
										<?php echo p3html::options($voucher_themes, null, 'voucher_theme_id', 'name', true); ?>
                  </select>
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_message; ?></label>
                <div class="controls"><textarea name="message" class="span6 i-xxlarge" rows="5"></textarea></div>
              </div>
              <div class="control-group">
                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_amount; ?></label>
                <div class="controls">
									<input type="text" name="amount" value="25.00" class="span2 i-medium">
								</div>
              </div>
						</fieldset>
						<div class="form-actions">
							<a id="button-voucher" class="btn"><?php echo $button_add_voucher; ?></a>
						</div>
	        </div>

        </div>

        <div class="tab-pane" id="tab-total" class="vtabs-content">
          <table class="list table table-striped table-hover table-condensed">
            <thead>
              <tr>
                <th class="column-name"><?php echo $column_product; ?></th>
                <th class="column-model"><?php echo $column_model; ?></th>
                <th class="column-quantity"><?php echo $column_quantity; ?></th>
                <th class="column-price"><?php echo $column_price; ?></th>
                <th class="column-price"><?php echo $column_total; ?></th>
              </tr>
            </thead>
            <tbody id="total">
              <?php $total_row = 0; ?>
              <?php if ($order_products || $order_vouchers || $order_totals) { ?>
              <?php foreach ($order_products as $order_product) { ?>
              <tr>
                <td class="column-name"><?php echo $order_product['name']; ?><br>
                  <?php foreach ($order_product['option'] as $option) { ?>
                  - <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br>
                  <?php } ?>
								</td>
                <td class="column-model"><?php echo $order_product['model']; ?></td>
                <td class="column-quantity"><?php echo $order_product['quantity']; ?></td>
                <td class="column-price"><?php echo $order_product['price']; ?></td>
                <td class="column-price"><?php echo $order_product['total']; ?></td>
              </tr>
              <?php } ?>
              <?php foreach ($order_vouchers as $order_voucher) { ?>
              <tr>
                <td class="column-name"><?php echo $order_voucher['description']; ?></td>
                <td class="column-model"></td>
                <td class="column-quantity">1</td>
                <td class="column-price"><?php echo $order_voucher['amount']; ?></td>
                <td class="column-price"><?php echo $order_voucher['amount']; ?></td>
              </tr>
              <?php } ?>
              <?php foreach ($order_totals as $order_total) { ?>
              <tr id="total-row<?php echo $total_row; ?>">
                <th class="column-total" colspan="4">
									<?php echo $order_total['title']; ?>:
                  <input type="hidden" name="order_total[<?php echo $total_row; ?>][order_total_id]" value="<?php echo $order_total['order_total_id']; ?>">
                  <input type="hidden" name="order_total[<?php echo $total_row; ?>][code]" value="<?php echo $order_total['code']; ?>">
                  <input type="hidden" name="order_total[<?php echo $total_row; ?>][title]" value="<?php echo $order_total['title']; ?>">
                  <input type="hidden" name="order_total[<?php echo $total_row; ?>][text]" value="<?php echo $order_total['text']; ?>">
                  <input type="hidden" name="order_total[<?php echo $total_row; ?>][value]" value="<?php echo $order_total['value']; ?>">
                  <input type="hidden" name="order_total[<?php echo $total_row; ?>][sort_order]" value="<?php echo $order_total['sort_order']; ?>">
									</th>
                <td class="column-price"><?php echo $order_total['value']; ?></td>
              </tr>
              <?php $total_row++; ?>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="column-results" colspan="5"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>

          <div class="form form-horizontal form-condensed form-bordered form-hover">
            <fieldset>
	            <legend><?php echo $text_order; ?></legend>
              <div class="control-group<?php if ($error_shipping_method) { ?> error<?php } ?>">
                <label class="control-label"><?php echo $entry_shipping; ?></label>
                <div class="controls">
									<select name="shipping" class="span3 i-large">
                    <option value=""><?php echo $text_select; ?></option>
                    <?php if ($shipping_code) { ?>
                    <option value="<?php echo $shipping_code; ?>" selected="selected"><?php echo $shipping_method; ?></option>
                    <?php } ?>
                  </select>
                  <input type="hidden" name="shipping_method" value="<?php echo $shipping_method; ?>">
                  <input type="hidden" name="shipping_code" value="<?php echo $shipping_code; ?>">
                  <?php if ($error_shipping_method) { ?>
                  <span class="error help-block"><?php echo $error_shipping_method; ?></span>
                  <?php } ?>
								</div>
              </div>
              <div class="control-group<?php if ($error_payment_method) { ?> error<?php } ?>">
                <label class="control-label"><?php echo $entry_payment; ?></label>
                <div class="controls">
									<select name="payment" class="span3 i-large">
                    <option value=""><?php echo $text_select; ?></option>
                    <?php if ($payment_code) { ?>
                    <option value="<?php echo $payment_code; ?>" selected="selected"><?php echo $payment_method; ?></option>
                    <?php } ?>
                  </select>
                  <input type="hidden" name="payment_method" value="<?php echo $payment_method; ?>">
                  <input type="hidden" name="payment_code" value="<?php echo $payment_code; ?>">
                  <?php if ($error_payment_method) { ?>
                  <span class="error help-block"><?php echo $error_payment_method; ?></span>
                  <?php } ?>
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_coupon; ?></label>
                <div class="controls">
									<input type="text" name="coupon" value="" class="span3 i-large">
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_voucher; ?></label>
                <div class="controls">
									<input type="text" name="voucher" value="" class="span3 i-large">
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_reward; ?></label>
                <div class="controls">
									<input type="text" name="reward" value="" class="span3 i-large">
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_order_status; ?></label>
                <div class="controls">
									<select name="order_status_id" class="span3 i-large">
										<?php echo p3html::oc_order_status_options($order_statuses, $order_status_id); ?>
                  </select>
								</div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_comment; ?></label>
                <div class="controls"><textarea name="comment" class="span6 i-xxlarge" rows="5"><?php echo $comment; ?></textarea></div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_affiliate; ?></label>
                <div class="controls">
									<input type="text" name="affiliate" value="<?php echo $affiliate; ?>" class="span3 i-large">
                  <input type="hidden" name="affiliate_id" value="<?php echo $affiliate_id; ?>"></div>
              </div>
            </fieldset>
						<div class="form-actions">
							<a id="button-update" class="btn"><i class="icon-refresh"></i> <?php echo $button_update_total; ?></a>
						</div>
          </div>

        </div>
				</div>
      </form>
    </div>
  </div>
  </div>
</div>

<script>
$.widget('custom.catcomplete', $.ui.autocomplete, {
	_renderMenu: function(ul, items) {
		var self = this, currentCategory = '';

		$.each(items, function(index, item) {
			if (item['category'] != currentCategory) {
				ul.append('<li class="ui-autocomplete-category">' + item['category'] + '</li>');

				currentCategory = item['category'];
			}

			self._renderItem(ul, item);
		});
	}
});

$('input[name="customer"]').catcomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/customer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						category: item['customer_group'],
						label: item['name'],
						value: item['customer_id'],
						customer_group_id: item['customer_group_id'],
						firstname: item['firstname'],
						lastname: item['lastname'],
						email: item['email'],
						telephone: item['telephone'],
						fax: item['fax'],
						address: item['address']
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name="customer"]').attr('value', ui.item['label']);
		$('input[name="customer_id"]').attr('value', ui.item['value']);
		$('input[name="firstname"]').attr('value', ui.item['firstname']);
		$('input[name="lastname"]').attr('value', ui.item['lastname']);
		$('input[name="email"]').attr('value', ui.item['email']);
		$('input[name="telephone"]').attr('value', ui.item['telephone']);
		$('input[name="fax"]').attr('value', ui.item['fax']);

		html = '<option value="0"><?php echo $text_none; ?></option>';

		for (i in  ui.item['address']) {
			html += '<option value="' + ui.item['address'][i]['address_id'] + '">' + ui.item['address'][i]['firstname'] + ' ' + ui.item['address'][i]['lastname'] + ', ' + ui.item['address'][i]['address_1'] + ', ' + ui.item['address'][i]['city'] + ', ' + ui.item['address'][i]['country'] + '</option>';
		}

		$('select[name="shipping_address"]').html(html);
		$('select[name="payment_address"]').html(html);

		$('select[id="customer_group_id"]').attr('disabled', false);
		$('select[id="customer_group_id"]').attr('value', ui.item['customer_group_id']);
		$('select[id="customer_group_id"]').trigger('change');
		$('select[id="customer_group_id"]').attr('disabled', true);

		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

$('select[id="customer_group_id"]').live('change', function() {
	$('input[name="customer_group_id"]').attr('value', this.value);

	var customer_group = [];

<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
<?php } ?>

	if (customer_group[this.value]) {
		if (customer_group[this.value]['company_id_display'] == '1') {
			$('#company-id-display').show();
		} else {
			$('#company-id-display').hide();
		}

		if (customer_group[this.value]['company_id_required'] == '1') {
			$('#company-id-required').show();
		} else {
			$('#company-id-required').hide();
		}

		if (customer_group[this.value]['tax_id_display'] == '1') {
			$('#tax-id-display').show();
		} else {
			$('#tax-id-display').hide();
		}

		if (customer_group[this.value]['tax_id_required'] == '1') {
			$('#tax-id-required').show();
		} else {
			$('#tax-id-required').hide();
		}
	}
});

$('select[id="customer_group_id"]').trigger('change');

$('input[name="affiliate"]').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/affiliate/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['affiliate_id'],
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name="affiliate"]').attr('value', ui.item['label']);
		$('input[name="affiliate_id"]').attr('value', ui.item['value']);

		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

var payment_zone_id = '<?php echo $payment_zone_id; ?>';

$('select[name="payment_country_id"]').on('change', function() {

	var select_payment_country = $(this);
	var select_payment_zone = $('select[name="payment_zone_id"]');

	$.ajax({
		url: 'index.php?route=sale/order/country&token=<?php echo $token; ?>&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			select_payment_zone.after('<span class="wait">&nbsp;<img src="view/image/loading.gif" alt=""></span>');
		},
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#payment-postcode-required').show();
			} else {
				$('#payment-postcode-required').hide();
			}

			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json != '' && json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';

					if (json['zone'][i]['zone_id'] == payment_zone_id) {
	      				html += ' selected="selected"';
	    			}

	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}

			select_payment_zone.html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name="payment_country_id"]').trigger('change');

$('select[name="payment_address"]').on('change', function() {
	$.ajax({
		url: 'index.php?route=sale/customer/address&token=<?php echo $token; ?>&address_id=' + this.value,
		dataType: 'json',
		success: function(json) {
			if (json != '') {
				$('input[name="payment_firstname"]').attr('value', json['firstname']);
				$('input[name="payment_lastname"]').attr('value', json['lastname']);
				$('input[name="payment_company"]').attr('value', json['company']);
				$('input[name="payment_company_id"]').attr('value', json['company_id']);
				$('input[name="payment_tax_id"]').attr('value', json['tax_id']);
				$('input[name="payment_address_1"]').attr('value', json['address_1']);
				$('input[name="payment_address_2"]').attr('value', json['address_2']);
				$('input[name="payment_city"]').attr('value', json['city']);
				$('input[name="payment_postcode"]').attr('value', json['postcode']);
				$('select[name="payment_country_id"]').attr('value', json['country_id']);

				payment_zone_id = json['zone_id'];

				$('select[name="payment_country_id"]').trigger('change');
			}
		}
	});
});

var shipping_zone_id = '<?php echo $shipping_zone_id; ?>';

$('select[name="shipping_country_id"]').on('change', function() {

	var select_shipping_country = $(this);
	var select_shipping_zone = $('select[name="shipping_zone_id"]');

	$.ajax({
		url: 'index.php?route=sale/order/country&token=<?php echo $token; ?>&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			select_shipping_zone.after('<span class="wait">&nbsp;<img src="view/image/loading.gif" alt=""></span>');
		},
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#shipping-postcode-required').show();
			} else {
				$('#shipping-postcode-required').hide();
			}

			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json != '' && json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';

					if (json['zone'][i]['zone_id'] == shipping_zone_id) {
	      				html += ' selected="selected"';
	    			}

	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}

			select_shipping_zone.html(html);

			//select2
			select_shipping_zone.trigger('change');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name="shipping_country_id"]').trigger('change');

$('select[name="shipping_address"]').bind('change', function() {
	$.ajax({
		url: 'index.php?route=sale/customer/address&token=<?php echo $token; ?>&address_id=' + this.value,
		dataType: 'json',
		success: function(json) {
			if (json != '') {
				$('input[name="shipping_firstname"]').attr('value', json['firstname']);
				$('input[name="shipping_lastname"]').attr('value', json['lastname']);
				$('input[name="shipping_company"]').attr('value', json['company']);
				$('input[name="shipping_address_1"]').attr('value', json['address_1']);
				$('input[name="shipping_address_2"]').attr('value', json['address_2']);
				$('input[name="shipping_city"]').attr('value', json['city']);
				$('input[name="shipping_postcode"]').attr('value', json['postcode']);
				$('select[name="shipping_country_id"]').attr('value', json['country_id']);

				shipping_zone_id = json['zone_id'];

				$('select[name="shipping_country_id"]').trigger('change');
			}
		}
	});
});
</script>
<script>
$('input[name="product"]').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id,
						model: item.model,
						option: item.option,
						price: item.price
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name="product"]').attr('value', ui.item['label']);
		$('input[name="product_id"]').attr('value', ui.item['value']);

		if (ui.item['option'] != '') {
			html = '<div class="form">';

			for (i = 0; i < ui.item['option'].length; i++) {
				option = ui.item['option'][i];

				if (option['type'] == 'select') {
					html += '<div id="option-' + option['product_option_id'] + '" class="control-group">';

					if (option['required']) {
						html += '<label><i class="required text-error icon-asterisk"></i> ';
					}

					html += option['name'] + '</label>';
					html += '<select name="option[' + option['product_option_id'] + ']" class="span3 i-large">';
					html += '<option value=""><?php echo $text_select; ?></option>';

					for (j = 0; j < option['option_value'].length; j++) {
						option_value = option['option_value'][j];

						html += '<option value="' + option_value['product_option_value_id'] + '">' + option_value['name'];

						if (option_value['price']) {
							html += ' (' + option_value['price_prefix'] + option_value['price'] + ')';
						}

						html += '</option>';
					}

					html += '</select>';
					html += '</div>';
					//html += '<br>';
				}

				if (option['type'] == 'radio') {
					html += '<div id="option-' + option['product_option_id'] + '" class="control-group">';

					if (option['required']) {
						html += '<label><i class="required text-error icon-asterisk"></i> ';
					}

					html += option['name'] + '</label>';
					html += '<select name="option[' + option['product_option_id'] + ']" class="span3 i-large">';
					html += '<option value=""><?php echo $text_select; ?></option>';

					for (j = 0; j < option['option_value'].length; j++) {
						option_value = option['option_value'][j];

						html += '<option value="' + option_value['product_option_value_id'] + '">' + option_value['name'];

						if (option_value['price']) {
							html += ' (' + option_value['price_prefix'] + option_value['price'] + ')';
						}

						html += '</option>';
					}

					html += '</select>';
					html += '</div>';
					//html += '<br>';
				}

				if (option['type'] == 'checkbox') {
					html += '<div id="option-' + option['product_option_id'] + '" class="control-group">';

					if (option['required']) {
						html += '<label><i class="required text-error icon-asterisk"></i> ';
					}

					html += option['name'] + '</label>';

					for (j = 0; j < option['option_value'].length; j++) {
						option_value = option['option_value'][j];

						html += '<label class="checkbox" for="option-value-' + option_value['product_option_value_id'] + '">';
						html += '<input type="checkbox" name="option[' + option['product_option_id'] + '][]" value="' + option_value['product_option_value_id'] + '" id="option-value-' + option_value['product_option_value_id'] + '">';
						html += option_value['name'];

						if (option_value['price']) {
							html += ' (' + option_value['price_prefix'] + option_value['price'] + ')';
						}

						html += '</label>';
						//html += '<br>';
					}

					html += '</div>';
					//html += '<br>';
				}

				if (option['type'] == 'image') {
					html += '<div id="option-' + option['product_option_id'] + '" class="control-group">';

					if (option['required']) {
						html += '<label><i class="required text-error icon-asterisk"></i> ';
					}

					html += option['name'] + '</label>';
					html += '<select name="option[' + option['product_option_id'] + ']" class="span3 i-large">';
					html += '<option value=""><?php echo $text_select; ?></option>';

					for (j = 0; j < option['option_value'].length; j++) {
						option_value = option['option_value'][j];

						html += '<option value="' + option_value['product_option_value_id'] + '">' + option_value['name'];

						if (option_value['price']) {
							html += ' (' + option_value['price_prefix'] + option_value['price'] + ')';
						}

						html += '</option>';
					}

					html += '</select>';
					html += '</div>';
					//html += '<br>';
				}

				if (option['type'] == 'text') {
					html += '<div id="option-' + option['product_option_id'] + '" class="control-group">';

					if (option['required']) {
						html += '<label><i class="required text-error icon-asterisk"></i> ';
					}

					html += option['name'] + '</label>';
					html += '<input type="text" name="option[' + option['product_option_id'] + ']" value="' + option['option_value'] + '" class="span4 i-xlarge">';
					html += '</div>';
					//html += '<br>';
				}

				if (option['type'] == 'textarea') {
					html += '<div id="option-' + option['product_option_id'] + '" class="control-group">';

					if (option['required']) {
						html += '<i class="required text-error icon-asterisk"></i> ';
					}

					html += option['name'] + '<br>';
					html += '<textarea name="option[' + option['product_option_id'] + ']" class="span5 i-xxlarge" rows="5">' + option['option_value'] + '</textarea>';
					html += '</div>';
					//html += '<br>';
				}

				if (option['type'] == 'file') {
					html += '<div id="option-' + option['product_option_id'] + '" class="control-group">';

					if (option['required']) {
						html += '<label><i class="required text-error icon-asterisk"></i> ';
					}

					html += option['name'] + '</label>';
					html += '<a id="button-option-' + option['product_option_id'] + '" class="btn btn-small"><i class="icon-upload"></i> <?php echo $button_upload; ?></a>';
					html += '<input type="hidden" name="option[' + option['product_option_id'] + ']" value="' + option['option_value'] + '">';
					html += '</div>';
					//html += '<br>';
				}

				if (option['type'] == 'date') {
					html += '<div id="option-' + option['product_option_id'] + '" class="control-group">';

					if (option['required']) {
						html += '<label><i class="required text-error icon-asterisk"></i> ';
					}

					html += option['name'] + '</label>';
					html += '<input type="text" name="option[' + option['product_option_id'] + ']" value="' + option['option_value'] + '" class="date input-small">';
					html += '</div>';
					//html += '<br>';
				}

				if (option['type'] == 'datetime') {
					html += '<div id="option-' + option['product_option_id'] + '" class="control-group">';

					if (option['required']) {
						html += '	<label><i class="required text-error icon-asterisk"></i> ';
					}

					html += option['name'] + '</label>';
					var date = option['option_value'];
					html += '	<div class="datetime-combo">';
					html += '		<input type="hidden" name="option[' + option['product_option_id'] + ']" value="' + option['option_value'] + '" class="datetime ">';
					html += '		<input type="text" value="' + date.substring(0,10) + '" class="date input-small"> ';
					html += '		<input type="text" value="' + date.substring(11) + '" class="time input-mini">';
					html += '	</div>';
					html += '</div>';
					//html += '<br>';
				}

				if (option['type'] == 'time') {
					html += '<div id="option-' + option['product_option_id'] + '" class="control-group">';

					if (option['required']) {
						html += '<label><i class="required text-error icon-asterisk"></i> ';
					}

					html += option['name'] + '</label>';
					html += '<input type="text" name="option[' + option['product_option_id'] + ']" value="' + option['option_value'] + '" class="time input-mini">';
					html += '</div>';
					//html += '<br>';
				}
			}
			html += '</div>';

			$('#option .controls').html(html);

			for (i = 0; i < ui.item.option.length; i++) {
				option = ui.item.option[i];

				if (option['type'] == 'file') {
					new AjaxUpload('#button-option-' + option['product_option_id'], {
						action: 'index.php?route=sale/order/upload&token=<?php echo $token; ?>',
						name: 'file',
						autoSubmit: true,
						responseType: 'json',
						data: option,
						onSubmit: function(file, extension) {
							$('#button-option-' + (this._settings.data['product_option_id'] + '-' + this._settings.data['product_option_id'])).after('<img src="view/image/loading.gif" class="loading">');
						},
						onComplete: function(file, json) {

							//$('.error').remove();
							$('.error').each(function(index){
								if(!$(this).hasClass('control-group')) {
									$(this).remove();
								}
							});

							if (json['success']) {
								alert(json['success']);

								$('input[name="option[' + this._settings.data['product_option_id'] + ']"]').attr('value', json['file']);
							}

							if (json.error) {
								$('#option-' + this._settings.data['product_option_id']).append('<span class="error help-block text-error">' + json['error'] + '</span>');
							}

							$('.loading').remove();
						}
					});
				}
			}

			<?php if ($this->config->get('p3adminrebooted_select2')) { ?>
			$('#option select').select2();
			<?php } ?>

//			$('.date').datepicker({dateFormat: 'yy-mm-dd'});
//			$('.datetime').datetime({
//				dateFormat: 'yy-mm-dd',
//				timeFormat: 'h:m'
//			});
//			$('.time').timepicker({timeFormat: 'h:m'});
		} else {
			$('#option td').remove();
		}

		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});
</script>
<script>
$('select[name="payment"]').bind('change', function() {
	if (this.value) {
		$('input[name="payment_method"]').attr('value', $('select[name="payment"] option:selected').text());
	} else {
		$('input[name="payment_method"]').attr('value', '');
	}

	$('input[name="payment_code"]').attr('value', this.value);
});

$('select[name="shipping"]').bind('change', function() {
	if (this.value) {
		$('input[name="shipping_method"]').attr('value', $('select[name="shipping"] option:selected').text());
	} else {
		$('input[name="shipping_method"]').attr('value', '');
	}

	$('input[name="shipping_code"]').attr('value', this.value);
});
</script>

<script>
$('#button-product, #button-voucher, #button-update').live('click', function() {
	data  = '#tab-customer input[type="text"], #tab-customer input[type="hidden"], #tab-customer input[type="radio"]:checked, #tab-customer input[type="checkbox"]:checked, #tab-customer select, #tab-customer textarea, ';
	data += '#tab-payment input[type="text"], #tab-payment input[type="hidden"], #tab-payment input[type="radio"]:checked, #tab-payment input[type="checkbox"]:checked, #tab-payment select, #tab-payment textarea, ';
	data += '#tab-shipping input[type="text"], #tab-shipping input[type="hidden"], #tab-shipping input[type="radio"]:checked, #tab-shipping input[type="checkbox"]:checked, #tab-shipping select, #tab-shipping textarea, ';

	if ($(this).attr('id') == 'button-product') {
		data += '#tab-product input[type="text"], #tab-product input[type="hidden"], #tab-product input[type="radio"]:checked, #tab-product input[type="checkbox"]:checked, #tab-product select, #tab-product textarea, ';
	} else {
		data += '#product input[type="text"], #product input[type="hidden"], #product input[type="radio"]:checked, #product input[type="checkbox"]:checked, #product select, #product textarea, ';
	}

	if ($(this).attr('id') == 'button-voucher') {
		data += '#tab-voucher input[type="text"], #tab-voucher input[type="hidden"], #tab-voucher input[type="radio"]:checked, #tab-voucher input[type="checkbox"]:checked, #tab-voucher select, #tab-voucher textarea, ';
	} else {
		data += '#voucher input[type="text"], #voucher input[type="hidden"], #voucher input[type="radio"]:checked, #voucher input[type="checkbox"]:checked, #voucher select, #voucher textarea, ';
	}

	data += '#tab-total input[type="text"], #tab-total input[type="hidden"], #tab-total input[type="radio"]:checked, #tab-total input[type="checkbox"]:checked, #tab-total select, #tab-total textarea';

	$.ajax({
		url: '<?php echo $store_url; ?>index.php?route=checkout/manual&token=<?php echo $token; ?>',
		type: 'post',
		data: $(data),
		dataType: 'json',
		beforeSend: function() {
			//$('.success, .warning, .attention, .error').remove();
//			$('.control-group').removeClass('error')
//			$('.success, .warning, .attention, .error').each(function(index){
//				if(!$(this).hasClass('control-group')) {
//					$(this).remove();
//				}
//			});
			$('.box').before('<div class="attention"><img src="view/image/loading.gif" alt=""> <?php echo $text_wait; ?></div>');
		},
		success: function(json) {
			//$('.success, .warning, .attention, .error').remove();
			$('.control-group').removeClass('error')
			$('.success, .warning, .attention, .error').each(function(index){
				if(!$(this).hasClass('control-group')) {
					$(this).remove();
				}
			});


			// Check for errors
			if (json['error']) {
				if (json['error']['warning']) {
					$('.box .heading .buttons').before('<div class="warning alert alert-warning"><button type="button" class="close" data-dismiss="alert">×</button>' + json['error']['warning'] + '</div>');
				}

				// Order Details
				if (json['error']['customer']) {
					$('.box .heading .buttons').before('<div class="error alert alert-error"><button type="button" class="close" data-dismiss="alert">×</button>' + json['error']['customer'] + '</div>');
				}

				if (json['error']['firstname']) {
					alert(json['error']['firstname']);
					$('input[name="firstname"]').closest('.control-group').addClass('error');
					$('input[name="firstname"]').after('<span class="error help-block text-error">' + json['error']['firstname'] + '</span>');
				}

				if (json['error']['lastname']) {
					$('input[name="lastname"]').closest('.control-group').addClass('error');
					$('input[name="lastname"]').after('<span class="error help-block text-error">' + json['error']['lastname'] + '</span>');
				}

				if (json['error']['email']) {
					$('input[name="email"]').closest('.control-group').addClass('error');
					$('input[name="email"]').after('<span class="error help-block text-error">' + json['error']['email'] + '</span>');
				}

				if (json['error']['telephone']) {
					$('input[name="telephone"]').closest('.control-group').addClass('error');
					$('input[name="telephone"]').after('<span class="error help-block text-error">' + json['error']['telephone'] + '</span>');
				}

				// Payment Address
				if (json['error']['payment']) {
					if (json['error']['payment']['firstname']) {
						$('input[name="payment_firstname"]').closest('.control-group').addClass('error');
						$('input[name="payment_firstname"]').after('<span class="error help-block text-error">' + json['error']['payment']['firstname'] + '</span>');
					}

					if (json['error']['payment']['lastname']) {
						$('input[name="payment_lastname"]').closest('.control-group').addClass('error');
						$('input[name="payment_lastname"]').after('<span class="error help-block text-error">' + json['error']['payment']['lastname'] + '</span>');
					}

					if (json['error']['payment']['address_1']) {
						$('input[name="payment_address_1"]').closest('.control-group').addClass('error');
						$('input[name="payment_address_1"]').after('<span class="error help-block text-error">' + json['error']['payment']['address_1'] + '</span>');
					}

					if (json['error']['payment']['city']) {
						$('input[name="payment_city"]').closest('.control-group').addClass('error');
						$('input[name="payment_city"]').after('<span class="error help-block text-error">' + json['error']['payment']['city'] + '</span>');
					}

					if (json['error']['payment']['country']) {
						$('input[name="payment_country_id"]').closest('.control-group').addClass('error');
						$('select[name="payment_country_id"]').after('<span class="error help-block text-error">' + json['error']['payment']['country'] + '</span>');
					}

					if (json['error']['payment']['zone']) {
						$('input[name="payment_zone_id"]').closest('.control-group').addClass('error');
						$('select[name="payment_zone_id"]').after('<span class="error help-block text-error">' + json['error']['payment']['zone'] + '</span>');
					}

					if (json['error']['payment']['postcode']) {
						$('input[name="payment_postcode"]').closest('.control-group').addClass('error');
						$('input[name="payment_postcode"]').after('<span class="error help-block text-error">' + json['error']['payment']['postcode'] + '</span>');
					}
				}

				// Shipping	Address
				if (json['error']['shipping']) {
					if (json['error']['shipping']['firstname']) {
						$('input[name="shipping_firstname"]').closest('.control-group').addClass('error');
						$('input[name="shipping_firstname"]').after('<span class="error help-block text-error">' + json['error']['shipping']['firstname'] + '</span>');
					}

					if (json['error']['shipping']['lastname']) {
						$('input[name="shipping_lastname"]').closest('.control-group').addClass('error');
						$('input[name="shipping_lastname"]').after('<span class="error help-block text-error">' + json['error']['shipping']['lastname'] + '</span>');
					}

					if (json['error']['shipping']['address_1']) {
						$('input[name="shipping_address_1"]').closest('.control-group').addClass('error');
						$('input[name="shipping_address_1"]').after('<span class="error help-block text-error">' + json['error']['shipping']['address_1'] + '</span>');
					}

					if (json['error']['shipping']['city']) {
						$('input[name="shipping_city"]').closest('.control-group').addClass('error');
						$('input[name="shipping_city"]').after('<span class="error help-block text-error">' + json['error']['shipping']['city'] + '</span>');
					}

					if (json['error']['shipping']['country']) {
						$('input[name="shipping_country_id"]').closest('.control-group').addClass('error');
						$('select[name="shipping_country_id"]').after('<span class="error help-block text-error">' + json['error']['shipping']['country'] + '</span>');
					}

					if (json['error']['shipping_zone']) {
						$('input[name="shipping_zone_id"]').closest('.control-group').addClass('error');
						$('select[name="shipping_zone_id"]').after('<span class="error help-block text-error">' + json['error']['shipping']['zone'] + '</span>');
					}

					if (json['error']['shipping']['postcode']) {
						$('input[name="shipping_postcode"]').closest('.control-group').addClass('error');
						$('input[name="shipping_postcode"]').after('<span class="error help-block text-error">' + json['error']['shipping']['postcode'] + '</span>');
					}
				}

				// Products
				if (json['error']['product']) {
					if (json['error']['product']['option']) {
						for (i in json['error']['product']['option']) {
							$('#option-' + i).addClass('error');
							$('#option-' + i).append('<span class="error help-block text-error">' + json['error']['product']['option'][i] + '</span>');
						}
					}

					if (json['error']['product']['stock']) {
						$('.box .heading .buttons').before('<div class="warning alert alert-warning"><button type="button" class="close" data-dismiss="alert">×</button>' + json['error']['product']['stock'] + '</div>');
					}

					if (json['error']['product']['minimum']) {
						for (i in json['error']['product']['minimum']) {
							$('.box .heading .buttons').before('<div class="warning alert alert-warning"><button type="button" class="close" data-dismiss="alert">×</button>' + json['error']['product']['minimum'][i] + '</div>');
						}
					}
				} else {
					$('input[name="product"]').attr('value', '');
					$('input[name="product_id"]').attr('value', '');
					$('#option td').remove();
					$('input[name="quantity"]').attr('value', '1');
				}

				// Voucher
				if (json['error']['vouchers']) {
					if (json['error']['vouchers']['from_name']) {
						$('input[name="from_name"]').after('<span class="error help-block text-error">' + json['error']['vouchers']['from_name'] + '</span>');
					}

					if (json['error']['vouchers']['from_email']) {
						$('input[name="from_email"]').after('<span class="error help-block text-error">' + json['error']['vouchers']['from_email'] + '</span>');
					}

					if (json['error']['vouchers']['to_name']) {
						$('input[name="to_name"]').after('<span class="error help-block text-error">' + json['error']['vouchers']['to_name'] + '</span>');
					}

					if (json['error']['vouchers']['to_email']) {
						$('input[name="to_email"]').after('<span class="error help-block text-error">' + json['error']['vouchers']['to_email'] + '</span>');
					}

					if (json['error']['vouchers']['amount']) {
						$('input[name="amount"]').after('<span class="error help-block text-error">' + json['error']['vouchers']['amount'] + '</span>');
					}
				} else {
					$('input[name="from_name"]').attr('value', '');
					$('input[name="from_email"]').attr('value', '');
					$('input[name="to_name"]').attr('value', '');
					$('input[name="to_email"]').attr('value', '');
					$('textarea[name="message"]').attr('value', '');
					$('input[name="amount"]').attr('value', '25.00');
				}

				// Shipping Method
				if (json['error']['shipping_method']) {
					$('.box .heading .buttons').before('<div class="warning"><button type="button" class="close" data-dismiss="alert">×</button>' + json['error']['shipping_method'] + '</div>');
				}

				// Payment Method
				if (json['error']['payment_method']) {
					$('.box .heading .buttons').before('<div class="warning"><button type="button" class="close" data-dismiss="alert">×</button>' + json['error']['payment_method'] + '</div>');
				}

				// Coupon
				if (json['error']['coupon']) {
					$('.box .heading .buttons').before('<div class="warning"><button type="button" class="close" data-dismiss="alert">×</button>' + json['error']['coupon'] + '</div>');
				}

				// Voucher
				if (json['error']['voucher']) {
					$('.box .heading .buttons').before('<div class="warning"><button type="button" class="close" data-dismiss="alert">×</button>' + json['error']['voucher'] + '</div>');
				}

				// Reward Points
				if (json['error']['reward']) {
					$('.box .heading .buttons').before('<div class="warning"><button type="button" class="close" data-dismiss="alert">×</button>' + json['error']['reward'] + '</div>');
				}
			} else {
				$('input[name="product"]').attr('value', '');
				$('input[name="product_id"]').attr('value', '');
				$('#option td').remove();
				$('input[name="quantity"]').attr('value', '1');

				$('input[name="from_name"]').attr('value', '');
				$('input[name="from_email"]').attr('value', '');
				$('input[name="to_name"]').attr('value', '');
				$('input[name="to_email"]').attr('value', '');
				$('textarea[name="message"]').attr('value', '');
				$('input[name="amount"]').attr('value', '25.00');
			}

			if (json['success']) {
				$('.box .heading .buttons').before('<div class="success" style="display: none;"><button type="button" class="close" data-dismiss="alert">×</button>' + json['success'] + '</div>');

				$('.success').fadeIn('slow');
			}

			if (json['order_product'] != '') {
				var product_row = 0;
				var option_row = 0;
				var download_row = 0;

				html = '';

				for (i = 0; i < json['order_product'].length; i++) {
					product = json['order_product'][i];

					html += '<tr id="product-row' + product_row + '">';
					html += '  <td class="column-checkbox"><button class="btn btn-small icon-trash" title="<?php echo $button_remove; ?>" alt="<?php echo $button_remove; ?>" style="cursor: pointer;" onclick="$(\'#product-row' + product_row + '\').remove(); $(\'#button-update\').trigger(\'click\');"></button></td>';
					html += '  <td class="column-name">' + product['name'] + '<br><input type="hidden" name="order_product[' + product_row + '][order_product_id]" value=""><input type="hidden" name="order_product[' + product_row + '][product_id]" value="' + product['product_id'] + '"><input type="hidden" name="order_product[' + product_row + '][name]" value="' + product['name'] + '">';

					if (product['option']) {
						for (j = 0; j < product['option'].length; j++) {
							option = product['option'][j];

							html += '  - <small>' + option['name'] + ': ' + option['value'] + '</small><br>';
							html += '  <input type="hidden" name="order_product[' + product_row + '][order_option][' + option_row + '][order_option_id]" value="' + option['order_option_id'] + '">';
							html += '  <input type="hidden" name="order_product[' + product_row + '][order_option][' + option_row + '][product_option_id]" value="' + option['product_option_id'] + '">';
							html += '  <input type="hidden" name="order_product[' + product_row + '][order_option][' + option_row + '][product_option_value_id]" value="' + option['product_option_value_id'] + '">';
							html += '  <input type="hidden" name="order_product[' + product_row + '][order_option][' + option_row + '][name]" value="' + option['name'] + '">';
							html += '  <input type="hidden" name="order_product[' + product_row + '][order_option][' + option_row + '][value]" value="' + option['value'] + '">';
							html += '  <input type="hidden" name="order_product[' + product_row + '][order_option][' + option_row + '][type]" value="' + option['type'] + '">';

							option_row++;
						}
					}

					if (product['download']) {
						for (j = 0; j < product['download'].length; j++) {
							download = product['download'][j];

							html += '  <input type="hidden" name="order_product[' + product_row + '][order_download][' + download_row + '][order_download_id]" value="' + download['order_download_id'] + '">';
							html += '  <input type="hidden" name="order_product[' + product_row + '][order_download][' + download_row + '][name]" value="' + download['name'] + '">';
							html += '  <input type="hidden" name="order_product[' + product_row + '][order_download][' + download_row + '][filename]" value="' + download['filename'] + '">';
							html += '  <input type="hidden" name="order_product[' + product_row + '][order_download][' + download_row + '][mask]" value="' + download['mask'] + '">';
							html += '  <input type="hidden" name="order_product[' + product_row + '][order_download][' + download_row + '][remaining]" value="' + download['remaining'] + '">';

							download_row++;
						}
					}

					html += '  </td>';
					html += '  <td class="column-model">' + product['model'] + '<input type="hidden" name="order_product[' + product_row + '][model]" value="' + product['model'] + '"></td>';
					html += '  <td class="column-quantity">' + product['quantity'] + '<input type="hidden" name="order_product[' + product_row + '][quantity]" value="' + product['quantity'] + '"></td>';
					html += '  <td class="column-price">' + product['price'] + '<input type="hidden" name="order_product[' + product_row + '][price]" value="' + product['price'] + '"></td>';
					html += '  <td class="column-price">' + product['total'] + '<input type="hidden" name="order_product[' + product_row + '][total]" value="' + product['total'] + '"><input type="hidden" name="order_product[' + product_row + '][tax]" value="' + product['tax'] + '"><input type="hidden" name="order_product[' + product_row + '][reward]" value="' + product['reward'] + '"></td>';
					html += '</tr>';

					product_row++;
				}

				$('#product').html(html);
			} else {
				html  = '</tr>';
				html += '  <td colspan="6" class="column-results"><?php echo $text_no_results; ?></td>';
				html += '</tr>';

				$('#product').html(html);
			}

			// Vouchers
			if (json['order_voucher'] != '') {
				var voucher_row = 0;

				 html = '';

				 for (i in json['order_voucher']) {
					voucher = json['order_voucher'][i];

					html += '<tr id="voucher-row' + voucher_row + '">';
					html += '  <td class="column-checkbox"><button class="btn btn-small icon-trash" title="<?php echo $button_remove; ?>" alt="<?php echo $button_remove; ?>" style="cursor: pointer;" onclick="$(\'#voucher-row' + voucher_row + '\').remove(); $(\'#button-update\').trigger(\'click\');"></button></td>';
					html += '  <td class="column-name">' + voucher['description'];
					html += '  <input type="hidden" name="order_voucher[' + voucher_row + '][order_voucher_id]" value="">';
					html += '  <input type="hidden" name="order_voucher[' + voucher_row + '][voucher_id]" value="' + voucher['voucher_id'] + '">';
					html += '  <input type="hidden" name="order_voucher[' + voucher_row + '][description]" value="' + voucher['description'] + '">';
					html += '  <input type="hidden" name="order_voucher[' + voucher_row + '][code]" value="' + voucher['code'] + '">';
					html += '  <input type="hidden" name="order_voucher[' + voucher_row + '][from_name]" value="' + voucher['from_name'] + '">';
					html += '  <input type="hidden" name="order_voucher[' + voucher_row + '][from_email]" value="' + voucher['from_email'] + '">';
					html += '  <input type="hidden" name="order_voucher[' + voucher_row + '][to_name]" value="' + voucher['to_name'] + '">';
					html += '  <input type="hidden" name="order_voucher[' + voucher_row + '][to_email]" value="' + voucher['to_email'] + '">';
					html += '  <input type="hidden" name="order_voucher[' + voucher_row + '][voucher_theme_id]" value="' + voucher['voucher_theme_id'] + '">';
					html += '  <input type="hidden" name="order_voucher[' + voucher_row + '][message]" value="' + voucher['message'] + '">';
					html += '  <input type="hidden" name="order_voucher[' + voucher_row + '][amount]" value="' + voucher['amount'] + '">';
					html += '  </td>';
					html += '  <td class="column-model"></td>';
					html += '  <td class="column-quantity">1</td>';
					html += '  <td class="column-price">' + voucher['amount'] + '</td>';
					html += '  <td class="column-price">' + voucher['amount'] + '</td>';
					html += '</tr>';

					voucher_row++;
				}

				$('#voucher').html(html);
			} else {
				html  = '</tr>';
				html += '  <td colspan="6" class="column-results"><?php echo $text_no_results; ?></td>';
				html += '</tr>';

				$('#voucher').html(html);
			}

			// Totals
			if (json['order_product'] != '' || json['order_voucher'] != '' || json['order_total'] != '') {
				html = '';

				if (json['order_product'] != '') {
					for (i = 0; i < json['order_product'].length; i++) {
						product = json['order_product'][i];

						html += '<tr>';
						html += '  <td class="column-name">' + product['name'] + '<br>';

						if (product['option']) {
							for (j = 0; j < product['option'].length; j++) {
								option = product['option'][j];

								html += '  - <small>' + option['name'] + ': ' + option['value'] + '</small><br>';
							}
						}

						html += '  </td>';
						html += '  <td class="column-model">' + product['model'] + '</td>';
						html += '  <td class="column-quantity">' + product['quantity'] + '</td>';
						html += '  <td class="column-price">' + product['price'] + '</td>';
						html += '  <td class="column-price">' + product['total'] + '</td>';
						html += '</tr>';
					}
				}

				if (json['order_voucher'] != '') {
					for (i in json['order_voucher']) {
						voucher = json['order_voucher'][i];

						html += '<tr>';
						html += '  <td class="column-name">' + voucher['description'] + '</td>';
						html += '  <td class="column-model"></td>';
						html += '  <td class="column-quantity">1</td>';
						html += '  <td class="column-price">' + voucher['amount'] + '</td>';
						html += '  <td class="column-price">' + voucher['amount'] + '</td>';
						html += '</tr>';
					}
				}

				var total_row = 0;

				for (i in json['order_total']) {
					total = json['order_total'][i];

					html += '<tr id="total-row' + total_row + '">';
					html += '  <th class="column-total" colspan="4"><input type="hidden" name="order_total[' + total_row + '][order_total_id]" value=""><input type="hidden" name="order_total[' + total_row + '][code]" value="' + total['code'] + '"><input type="hidden" name="order_total[' + total_row + '][title]" value="' + total['title'] + '"><input type="hidden" name="order_total[' + total_row + '][text]" value="' + total['text'] + '"><input type="hidden" name="order_total[' + total_row + '][value]" value="' + total['value'] + '"><input type="hidden" name="order_total[' + total_row + '][sort_order]" value="' + total['sort_order'] + '">' + total['title'] + ':</th>';
					html += '  <td class="column-price">' + total['value'] + '</td>';
					html += '</tr>';

					total_row++;
				}

				$('#total').html(html);
			} else {
				html  = '</tr>';
				html += '  <td colspan="6" class="column-results"><?php echo $text_no_results; ?></td>';
				html += '</tr>';

				$('#total').html(html);
			}

			// Shipping Methods
			if (json['shipping_method']) {
				html = '<option value=""><?php echo $text_select; ?></option>';

				for (i in json['shipping_method']) {
					html += '<optgroup label="' + json['shipping_method'][i]['title'] + '">';

					if (!json['shipping_method'][i]['error']) {
						for (j in json['shipping_method'][i]['quote']) {
							if (json['shipping_method'][i]['quote'][j]['code'] == $('input[name="shipping_code"]').attr('value')) {
								html += '<option value="' + json['shipping_method'][i]['quote'][j]['code'] + '" selected="selected">' + json['shipping_method'][i]['quote'][j]['title'] + '</option>';
							} else {
								html += '<option value="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['title'] + '</option>';
							}
						}
					} else {
						html += '<option value="" style="color: #F00;" disabled="disabled">' + json['shipping_method'][i]['error'] + '</option>';
					}

					html += '</optgroup>';
				}

				$('select[name="shipping"]').html(html);

				if ($('select[name="shipping"] option:selected').attr('value')) {
					$('input[name="shipping_method"]').attr('value', $('select[name="shipping"] option:selected').text());
				} else {
					$('input[name="shipping_method"]').attr('value', '');
				}

				$('input[name="shipping_code"]').attr('value', $('select[name="shipping"] option:selected').attr('value'));
			}

			// Payment Methods
			if (json['payment_method']) {
				html = '<option value=""><?php echo $text_select; ?></option>';

				for (i in json['payment_method']) {
					if (json['payment_method'][i]['code'] == $('input[name="payment_code"]').attr('value')) {
						html += '<option value="' + json['payment_method'][i]['code'] + '" selected="selected">' + json['payment_method'][i]['title'] + '</option>';
					} else {
						html += '<option value="' + json['payment_method'][i]['code'] + '">' + json['payment_method'][i]['title'] + '</option>';
					}
				}

				$('select[name="payment"]').html(html);

				if ($('select[name="payment"] option:selected').attr('value')) {
					$('input[name="payment_method"]').attr('value', $('select[name="payment"] option:selected').text());
				} else {
					$('input[name="payment_method"]').attr('value', '');
				}

				$('input[name="payment_code"]').attr('value', $('select[name="payment"] option:selected').attr('value'));
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});
</script>

<?php echo $footer; ?>