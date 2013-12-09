<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-wrench"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
			<?php if ($success) { ?>
				<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_save($button_save); ?>
				<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
			</div>
    </div>

    <div class="content">

      <ul id="tabs" class="htabs nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#tab-general"><i class="icon-cog"></i> <?php echo $tab_general; ?></a></li>
				<li><a data-toggle="tab" href="#tab-store"><i class="icon-shop"></i> <?php echo $tab_store; ?></a></li>
				<li><a data-toggle="tab" href="#tab-local"><i class="icon-flag"></i> <?php echo $tab_local; ?></a></li>
				<li><a data-toggle="tab" href="#tab-option"><i class="icon-list"></i> <?php echo $tab_option; ?></a></li>
				<li><a data-toggle="tab" href="#tab-image"><i class="icon-picture"></i> <?php echo $tab_image; ?></a></li>
				<li><a data-toggle="tab" href="#tab-server"><i class="icon-tools"></i> <?php echo $tab_server; ?></a></li>
			</ul>

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
			<div class="tab-content">

				<div class="tab-pane active" id="tab-general">
          <div class="form">
            <div class="control-group<?php if ($error_url) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_url; ?></label>
              <div class="controls">
								<input type="text" name="config_url" value="<?php echo $config_url; ?>" class="span4 i-xxlarge">
                <?php if ($error_url) { ?>
                <span class="error help-block"><?php echo $error_url; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_ssl; ?></label>
              <div class="controls"><input type="text" name="config_ssl" value="<?php echo $config_ssl; ?>" class="span4 i-xxlarge"></div>
            </div>
            <div class="control-group<?php if ($error_name) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
              <div class="controls">
								<input type="text" name="config_name" value="<?php echo $config_name; ?>" class="span4 i-xxlarge">
                <?php if ($error_name) { ?>
                <span class="error help-block"><?php echo $error_name; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_owner) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_owner; ?></label>
              <div class="controls">
								<input type="text" name="config_owner" value="<?php echo $config_owner; ?>" class="span4 i-xxlarge">
                <?php if ($error_owner) { ?>
                <span class="error help-block"><?php echo $error_owner; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_address) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_address; ?></label>
              <div class="controls">
								<textarea name="config_address" class="span6 i-xxlarge" rows="5"><?php echo $config_address; ?></textarea>
                <?php if ($error_address) { ?>
                <span class="error help-block"><?php echo $error_address; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_email) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_email; ?></label>
              <div class="controls">
								<input type="text" name="config_email" value="<?php echo $config_email; ?>" class="span6 i-xxlarge">
                <?php if ($error_email) { ?>
                <span class="error help-block"><?php echo $error_email; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_telephone) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_telephone; ?></label>
              <div class="controls">
								<input type="text" name="config_telephone" value="<?php echo $config_telephone; ?>" class="span3 i-xlarge">
                <?php if ($error_telephone) { ?>
                <span class="error help-block"><?php echo $error_telephone; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_fax; ?></label>
              <div class="controls"><input type="text" name="config_fax" value="<?php echo $config_fax; ?>" class="span3 i-xlarge"></div>
            </div>
          </div>
        </div>
        <div class="tab-pane" id="tab-store">
          <div class="form">
            <div class="control-group<?php if ($error_title) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_title; ?></label>
              <div class="controls">
								<input type="text" name="config_title" value="<?php echo $config_title; ?>" class="span4 i-xlarge">
                <?php if ($error_title) { ?>
                <span class="error help-block"><?php echo $error_title; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_meta_description; ?></label>
              <div class="controls"><textarea name="config_meta_description" class="span6 i-xxlarge" rows="5"><?php echo $config_meta_description; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_template; ?></label>
              <div class="controls">
								<select name="config_template" class="span3 i-large" onchange="$('#template').load('index.php?route=setting/store/template&token=<?php echo $token; ?>&template=' + encodeURIComponent(this.value));">
									<?php echo p3html::oc_template_options($templates, $config_template); ?>
                </select>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"></label>
              <div class="controls" id="template"></div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_layout; ?></label>
              <div class="controls">
								<select name="config_layout_id" class="span3 i-large">
									<?php echo p3html::oc_layout_options($layouts, $config_layout_id); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-local">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_country; ?></label>
              <div class="controls">
								<select name="config_country_id" class="span4 i-xlarge">
									<?php echo p3html::oc_country_options($countries, $config_country_id); ?>
                </select>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_zone; ?></label>
              <div class="controls"><select name="config_zone_id" class="span4 i-xlarge"></select></div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_language; ?></label>
              <div class="controls">
								<select name="config_language" class="span2 i-medium">
									<?php echo p3html::oc_language_code_options($languages, $config_language); ?>
                </select>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_currency; ?></label>
              <div class="controls">
								<select name="config_currency" class="span2 i-medium">
									<?php echo p3html::oc_currency_code_options($currencies, $config_currency); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-option">
				<div class="row">

					<div class="span6">

          <h2><?php echo $text_items; ?></h2>
          <div class="form well">
            <div class="control-group<?php if ($error_catalog_limit) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_catalog_limit; ?></label>
              <div class="controls"><input type="text" name="config_catalog_limit" value="<?php echo $config_catalog_limit; ?>" class="input-mini">
                <?php if ($error_catalog_limit) { ?>
                <span class="error help-block"><?php echo $error_catalog_limit; ?></span>
                <?php } ?></div>
            </div>
          </div>

          <h2><?php echo $text_tax; ?></h2>
          <div class="form well">
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_tax; ?></label>
              <div class="controls">
								<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
								<?php echo p3html::tb_bool_buttons_radio($this->language, 'config_tax', $config_tax); ?>
								<?php } else { ?>
								<?php echo p3html::tb_bool_radio_buttons($this->language, 'config_tax', $config_tax); ?>
								<?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_tax_default; ?></label>
              <div class="controls">
								<select name="config_tax_default" class="i-medium input-block-level">
                  <option value=""><?php echo $text_none; ?></option>
                  <option value="shipping"<?php  if ($config_tax_default == 'shipping') { ?> selected="selected"<?php } ?>><?php echo $text_shipping; ?></option>
                  <option value="payment"<?php  if ($config_tax_default == 'payment') { ?> selected="selected"<?php } ?>><?php echo $text_payment; ?></option>
                </select>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_tax_customer; ?></label>
              <div class="controls">
								<select name="config_tax_customer" class="i-medium input-block-level">
                  <option value=""><?php echo $text_none; ?></option>
                  <option value="shipping"<?php  if ($config_tax_customer == 'shipping') { ?> selected="selected"<?php } ?>><?php echo $text_shipping; ?></option>
                  <option value="payment"<?php  if ($config_tax_customer == 'payment') { ?> selected="selected"<?php } ?>><?php echo $text_payment; ?></option>
                </select>
							</div>
            </div>
          </div>

          <h2><?php echo $text_account; ?></h2>
          <div class="form well">
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_customer_group; ?></label>
              <div class="controls">
								<select name="config_customer_group_id" class="i-medium input-block-level">
									<?php echo p3html::oc_customer_group_options($customer_groups, $config_customer_group_id); ?>
                </select>
							</div>
            </div>
            <div class="control-group<?php if ($error_customer_group_display) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_customer_group_display; ?></label>
              <div class="controls">
								<div class="scrollbox">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($customer_groups as $customer_group) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
										<label class="checkbox inline">
											<input type="checkbox" name="config_customer_group_display[]" value="<?php echo $customer_group['customer_group_id']; ?>"<?php if (in_array($customer_group['customer_group_id'], $config_customer_group_display)) { ?> checked="checked"<?php } ?>>
											<?php echo $customer_group['name']; ?>
										</label>
                  </div>
                  <?php } ?>
                </div>
                <?php if ($error_customer_group_display) { ?>
                <span class="error help-block"><?php echo $error_customer_group_display; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_customer_price; ?></label>
              <div class="controls">
								<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
								<?php echo p3html::tb_bool_buttons_radio($this->language, 'config_customer_price', $config_customer_price); ?>
								<?php } else { ?>
								<?php echo p3html::tb_bool_radio_buttons($this->language, 'config_customer_price', $config_customer_price); ?>
								<?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_account; ?></label>
              <div class="controls">
								<select name="config_account_id" class="i-medium input-block-level">
                  <option value="0"><?php echo $text_none; ?></option>
									<?php echo p3html::oc_information_options($informations, $config_account_id); ?>
                </select>
							</div>
            </div>
          </div>

					</div>

					<div class="span6">

          <h2><?php echo $text_checkout; ?></h2>
          <div class="form well">
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_cart_weight; ?></label>
              <div class="controls">
								<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
								<?php echo p3html::tb_bool_buttons_radio($this->language, 'config_cart_weight', $config_cart_weight); ?>
								<?php } else { ?>
								<?php echo p3html::tb_bool_radio_buttons($this->language, 'config_cart_weight', $config_cart_weight); ?>
								<?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_guest_checkout; ?></label>
              <div class="controls">
								<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
								<?php echo p3html::tb_bool_buttons_radio($this->language, 'config_guest_checkout', $config_guest_checkout); ?>
								<?php } else { ?>
								<?php echo p3html::tb_bool_radio_buttons($this->language, 'config_guest_checkout', $config_guest_checkout); ?>
								<?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_checkout; ?></label>
              <div class="controls">
								<select name="config_checkout_id" class="i-medium input-block-level">
                  <option value="0"><?php echo $text_none; ?></option>
									<?php echo p3html::oc_information_options($informations, $config_checkout_id); ?>
                </select>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_order_status; ?></label>
              <div class="controls">
								<select name="config_order_status_id" class="i-medium input-block-level">
									<?php echo p3html::oc_order_status_options($order_statuses, $config_order_status_id); ?>
                </select>
							</div>
            </div>
          </div>
          <h2><?php echo $text_stock; ?></h2>
          <div class="form well">
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_stock_display; ?></label>
              <div class="controls">
								<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
								<?php echo p3html::tb_bool_buttons_radio($this->language, 'config_stock_display', $config_stock_display); ?>
								<?php } else { ?>
                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_stock_display', $config_stock_display); ?>
								<?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_stock_checkout; ?></label>
              <div class="controls">
								<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
								<?php echo p3html::tb_bool_buttons_radio($this->language, 'config_stock_checkout', $config_stock_checkout); ?>
								<?php } else { ?>
                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_stock_checkout', $config_stock_checkout); ?>
								<?php } ?>
							</div>
            </div>
          </div>
        </div>

        </div>

        </div>

        <div class="tab-pane" id="tab-image">

					<div class="row">

					<div class="span6">
          <div class="form well">

            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_logo; ?></label>
              <div class="controls">
								<div class="image">
									<img src="<?php echo $logo; ?>" alt="" id="thumb-logo">
                  <input type="hidden" name="config_logo" value="<?php echo $config_logo; ?>" id="logo">
                  <br><br>
									<a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('logo', 'thumb-logo');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>
									<a class="btn" title="<?php echo $text_clear; ?>" onclick="$('#thumb-logo').attr('src', '<?php echo $no_image; ?>'); $('#logo').attr('value', '');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>
								</div>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_icon; ?></label>
              <div class="controls">
								<div class="image">
									<img src="<?php echo $icon; ?>" alt="" id="thumb-icon">
                  <input type="hidden" name="config_icon" value="<?php echo $config_icon; ?>" id="icon">
                  <br><br>
									<a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('icon', 'thumb-icon');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>
									<a class="btn" title="<?php echo $text_clear; ?>" onclick="$('#thumb-icon').attr('src', '<?php echo $no_image; ?>'); $('#icon').attr('value', '');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>
								</div>
							</div>
            </div>

					</div>
					</div>

					<div class="span6">
          <div class="form well">

            <div class="control-group<?php if ($error_image_category) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_image_category; ?></label>
              <div class="controls">
								<input type="text" name="config_image_category_width" value="<?php echo $config_image_category_width; ?>" class="input-mini">
                x
                <input type="text" name="config_image_category_height" value="<?php echo $config_image_category_height; ?>" class="input-mini">
                <?php if ($error_image_category) { ?>
                <span class="error help-block"><?php echo $error_image_category; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_image_information) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_image_information; ?></label>
              <div class="controls">
								<input type="text" name="config_image_information_width" value="<?php echo $config_image_information_width; ?>" class="input-mini">
                x
                <input type="text" name="config_image_information_height" value="<?php echo $config_image_information_height; ?>" class="input-mini">
                <?php if ($error_image_information) { ?>
                <span class="error help-block"><?php echo $error_image_information; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_image_thumb) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_image_thumb; ?></label>
              <div class="controls">
								<input type="text" name="config_image_thumb_width" value="<?php echo $config_image_thumb_width; ?>" class="input-mini">
                x
                <input type="text" name="config_image_thumb_height" value="<?php echo $config_image_thumb_height; ?>" class="input-mini">
                <?php if ($error_image_thumb) { ?>
                <span class="error help-block"><?php echo $error_image_thumb; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_image_popup) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_image_popup; ?></label>
              <div class="controls">
								<input type="text" name="config_image_popup_width" value="<?php echo $config_image_popup_width; ?>" class="input-mini">
                x
                <input type="text" name="config_image_popup_height" value="<?php echo $config_image_popup_height; ?>" class="input-mini">
                <?php if ($error_image_popup) { ?>
                <span class="error help-block"><?php echo $error_image_popup; ?></span>
                <?php } ?></div>
            </div>
            <div class="control-group<?php if ($error_image_product) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_image_product; ?></label>
              <div class="controls">
								<input type="text" name="config_image_product_width" value="<?php echo $config_image_product_width; ?>" class="input-mini">
                x
                <input type="text" name="config_image_product_height" value="<?php echo $config_image_product_height; ?>" class="input-mini">
                <?php if ($error_image_product) { ?>
                <span class="error help-block"><?php echo $error_image_product; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_image_additional) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_image_additional; ?></label>
              <div class="controls">
								<input type="text" name="config_image_additional_width" value="<?php echo $config_image_additional_width; ?>" class="input-mini">
                x
                <input type="text" name="config_image_additional_height" value="<?php echo $config_image_additional_height; ?>" class="input-mini">
                <?php if ($error_image_additional) { ?>
                <span class="error help-block"><?php echo $error_image_additional; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_image_related) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_image_related; ?></label>
              <div class="controls">
								<input type="text" name="config_image_related_width" value="<?php echo $config_image_related_width; ?>" class="input-mini">
                x
                <input type="text" name="config_image_related_height" value="<?php echo $config_image_related_height; ?>" class="input-mini">
                <?php if ($error_image_related) { ?>
                <span class="error help-block"><?php echo $error_image_related; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_image_compare) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_image_compare; ?></label>
              <div class="controls">
								<input type="text" name="config_image_compare_width" value="<?php echo $config_image_compare_width; ?>" class="input-mini">
                x
                <input type="text" name="config_image_compare_height" value="<?php echo $config_image_compare_height; ?>" class="input-mini">
                <?php if ($error_image_compare) { ?>
                <span class="error help-block"><?php echo $error_image_compare; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_image_wishlist) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_image_wishlist; ?></label>
              <div class="controls">
								<input type="text" name="config_image_wishlist_width" value="<?php echo $config_image_wishlist_width; ?>" class="input-mini">
                x
                <input type="text" name="config_image_wishlist_height" value="<?php echo $config_image_wishlist_height; ?>" class="input-mini">
                <?php if ($error_image_wishlist) { ?>
                <span class="error help-block"><?php echo $error_image_wishlist; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_image_cart) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_image_cart; ?></label>
              <div class="controls">
								<input type="text" name="config_image_cart_width" value="<?php echo $config_image_cart_width; ?>" class="input-mini">
                x
                <input type="text" name="config_image_cart_height" value="<?php echo $config_image_cart_height; ?>" class="input-mini">
                <?php if ($error_image_cart) { ?>
                <span class="error help-block"><?php echo $error_image_cart; ?></span>
                <?php } ?>
							</div>
            </div>

          </div>
          </div>

          </div>

				</div>

        <div class="tab-pane" id="tab-server">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i><?php echo $entry_use_ssl; ?></label>
              <div class="controls">
								<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
								<?php echo p3html::tb_bool_buttons_radio($this->language, 'config_use_ssl', $config_use_ssl); ?>
								<?php } else { ?>
                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_use_ssl', $config_use_ssl); ?>
								<?php } ?>
							</div>
            </div>
          </div>
        </div>
			</div>
      </form>
    </div>

  </div>
</div>

<!--FILEMANAGER-->
<?php include_once DIR_TEMPLATE.'javascript/filemanager_dialog.tpl'; ?>
<!--FILEMANAGER-->

<script>
$('#template').load('index.php?route=setting/store/template&token=<?php echo $token; ?>&template=' + encodeURIComponent($('select[name=\'config_template\']').attr('value')));
</script>

<script>
$('select[name="config_country_id"]').on('change', function() {

	var select_country = $(this);
	var select_zone = $('select[name="config_zone_id"]');

	$.ajax({
		url: 'index.php?route=setting/store/country'+'&token=<?php echo $token; ?>'+'&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			select_zone.after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt=""></span>');
		},
		complete: function() {
			$('.wait').remove();
		},
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#postcode-required').show();
			} else {
				$('#postcode-required').hide();
			}

			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';

					if (json['zone'][i]['zone_id'] == '<?php echo $config_zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}

	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected><?php echo $text_none; ?></option>';
			}

			select_zone.html(html);

			//chosen
			//select_zone.trigger("liszt:updated");

			//select2
//			var selected_zone_id = select_zone.val();
//			selected_zone_id  = selected_zone_id ? selected_zone_id : '';
//			select_zone.val(selected_zone_id).trigger('change');
			select_zone.trigger('change');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name="config_country_id"]').trigger('change');
</script>

	<?php echo $footer; ?>