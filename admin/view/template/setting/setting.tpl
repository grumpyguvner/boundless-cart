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
                <li><a data-toggle="tab" href="#tab-mail"><i class="icon-mail"></i> <?php echo $tab_mail; ?></a></li>
                <li><a data-toggle="tab" href="#tab-fraud"><i class="icon-key"></i> <?php echo $tab_fraud; ?></a></li>
                <li><a data-toggle="tab" href="#tab-server"><i class="icon-tools"></i> <?php echo $tab_server; ?></a></li>
                <li><a data-toggle="tab" href="#tab-email"><i class="icon-email"></i> <?php echo $tab_email; ?></a></li>
                <?php if (!$display) echo '<li><a data-toggle="tab" href="#tab-cron"><i class="icon-calendar"></i>' . $tab_cron . '</a></li>'; ?>
            </ul>

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
                <div class="tab-content">

                    <div class="tab-pane active" id="tab-general">
                        <div class="form">
                            <div class="control-group<?php if ($error_name) { ?> error<?php } ?>">
                                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
                                <div class="controls">
                                    <input type="text" name="config_name" value="<?php echo $config_name; ?>" class="span4 i-xlarge">
                                    <?php if ($error_name) { ?>
                                        <span class="error help-block"><?php echo $error_name; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group<?php if ($error_owner) { ?> error<?php } ?>">
                                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_owner; ?></label>
                                <div class="controls">
                                    <input type="text" name="config_owner" value="<?php echo $config_owner; ?>" class="span4 i-xlarge">
                                    <?php if ($error_owner) { ?>
                                        <span class="error help-block"><?php echo $error_owner; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group<?php if ($error_address) { ?> error<?php } ?>">
                                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_address; ?></label>
                                <div class="controls">
                                    <textarea name="config_address"  class="span6 i-xxlarge" rows="5"><?php echo $config_address; ?></textarea>
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
                                <label class="control-label"><?php echo $entry_fax; ?></label>
                                <div class="controls">
                                    <input type="text" name="config_fax" value="<?php echo $config_fax; ?>" class="span3 i-xlarge">
                                </div>
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
                                <label class="control-label"><?php echo $entry_meta_description; ?></label>
                                <div class="controls">
                                    <textarea name="config_meta_description"  class="span6 i-xxlarge" rows="5"><?php echo $config_meta_description; ?></textarea>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_template; ?></label>
                                <div class="controls">
                                    <select name="config_template" class="span3 i-large" onchange="$('#template').load('index.php?route=setting/setting/template&token=<?php echo $token; ?>&template=' + encodeURIComponent(this.value));">
                                        <?php echo p3html::oc_template_options($templates, $config_template); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"></label>
                                <div class="controls" id="template"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_base_template; ?></label>
                                <div class="controls">
                                    <select name="config_template" class="span3 i-large" onchange="$('#base_template').load('index.php?route=setting/setting/template&token=<?php echo $token; ?>&template=' + encodeURIComponent(this.value));">
                                        <?php echo p3html::oc_template_options($templates, $config_base_template); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"></label>
                                <div class="controls" id="base_template"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_layout; ?></label>
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
                                <label class="control-label"><?php echo $entry_country; ?></label>
                                <div class="controls">
                                    <select name="config_country_id" class="span4 i-xlarge">
                                        <?php echo p3html::oc_country_options($countries, $config_country_id); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_zone; ?></label>
                                <div class="controls">
                                    <select name="config_zone_id" class="span4 i-xlarge"></select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_language; ?></label>
                                <div class="controls">
                                    <select name="config_language" class="span2 i-medium">
                                        <?php echo p3html::oc_language_code_options($languages, $config_language); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_admin_language; ?></label>
                                <div class="controls">
                                    <select name="config_admin_language" class="span2 i-medium">
                                        <?php echo p3html::oc_language_code_options($languages, $config_admin_language); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_currency; ?></label>
                                <div class="controls">
                                    <select name="config_currency" class="span2 i-medium">
                                        <?php echo p3html::oc_currency_code_options($currencies, $config_currency); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_currency_auto; ?></label>
                                <div class="controls">
                                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_currency_auto', $config_currency_auto); ?>
                                    <?php } else { ?>
                                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_currency_auto', $config_currency_auto); ?>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_length_class; ?></label>
                                <div class="controls">
                                    <select name="config_length_class_id" class="span2 i-medium">
                                        <?php echo p3html::oc_length_class_options($length_classes, $config_length_class_id); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_weight_class; ?></label>
                                <div class="controls">
                                    <select name="config_weight_class_id" class="span2 i-medium">
                                        <?php echo p3html::oc_weight_class_options($weight_classes, $config_weight_class_id); ?>
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
                                        <div class="controls">
                                            <input type="text" name="config_catalog_limit" value="<?php echo $config_catalog_limit; ?>" class="input-mini">
                                            <?php if ($error_catalog_limit) { ?>
                                                <span class="error help-block"><?php echo $error_catalog_limit; ?></span>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group<?php if ($error_admin_limit) { ?> error<?php } ?>">
                                        <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_admin_limit; ?></label>
                                        <div class="controls">
                                            <input type="text" name="config_admin_limit" value="<?php echo $config_admin_limit; ?>" class="input-mini">
                                            <?php if ($error_admin_limit) { ?>
                                                <span class="error help-block"><?php echo $error_admin_limit; ?></span>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>
                                <h2><?php echo $text_product; ?></h2>
                                <div class="form well">
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_new_product_age; ?></label>
                                        <div class="controls">
                                            <input type="text" name="config_new_product_age" value="<?php echo $config_new_product_age; ?>" class="input-mini">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_product_count; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_product_count', $config_product_count); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_product_count', $config_product_count); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_review; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_review_status', $config_review_status); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_review_status', $config_review_status); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_anonymous_review; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_anonymous_review_status', $config_anonymous_review_status); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_anonymous_review_status', $config_anonymous_review_status); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_download; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_download', $config_download); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_download', $config_download); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_upload_allowed; ?></label>
                                        <div class="controls">
                                            <textarea name="config_upload_allowed" class="s-pan6 i-xxlarge input-block-level" rows="4"><?php echo $config_upload_allowed; ?></textarea>
                                        </div>
                                    </div>
                                </div>
                                <h2><?php echo $text_voucher; ?></h2>
                                <div class="form well">
                                    <div class="control-group<?php if ($error_voucher_min) { ?> error<?php } ?>">
                                        <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_voucher_min; ?></label>
                                        <div class="controls">
                                            <input type="text" name="config_voucher_min" value="<?php echo $config_voucher_min; ?>" class="input-small">
                                            <?php if ($error_voucher_min) { ?>
                                                <span class="error help-block"><?php echo $error_voucher_min; ?></span>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group<?php if ($error_voucher_max) { ?> error<?php } ?>">
                                        <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_voucher_max; ?></label>
                                        <div class="controls">
                                            <input type="text" name="config_voucher_max" value="<?php echo $config_voucher_max; ?>" class="input-small">
                                            <?php if ($error_voucher_max) { ?>
                                                <span class="error help-block"><?php echo $error_voucher_max; ?></span>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>
                                <h2><?php echo $text_tax; ?></h2>
                                <div class="form well">
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_tax; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_tax', $config_tax); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_tax', $config_tax); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_vat; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_vat', $config_vat); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_vat', $config_vat); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_tax_default; ?></label>
                                        <div class="controls">
                                            <select name="config_tax_default" class="i-medium input-block-level">
                                                <option value=""><?php echo $text_none; ?></option>
                                                <option value="shipping"<?php if ($config_tax_default == 'shipping') { ?> selected="selected"<?php } ?>><?php echo $text_shipping; ?></option>
                                                <option value="payment"<?php if ($config_tax_default == 'payment') { ?> selected="selected"<?php } ?>><?php echo $text_payment; ?></option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_tax_customer; ?></label>
                                        <div class="controls">
                                            <select name="config_tax_customer" class="i-medium input-block-level">
                                                <option value=""><?php echo $text_none; ?></option>
                                                <option value="shipping"<?php if ($config_tax_customer == 'shipping') { ?> selected="selected"<?php } ?>><?php echo $text_shipping; ?></option>
                                                <option value="payment"<?php if ($config_tax_customer == 'payment') { ?> selected="selected"<?php } ?>><?php echo $text_payment; ?></option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <h2><?php echo $text_account; ?></h2>
                                <div class="form well">
                                    <?php if (VERSION >= '1.5.4') { ?>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_customer_online; ?></label>
                                            <div class="controls">
                                                <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                    <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_customer_online', $config_customer_online); ?>
                                                <?php } else { ?>
                                                    <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_customer_online', $config_customer_online); ?>
                                                <?php } ?>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_customer_group; ?></label>
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
                                        <label class="control-label"><?php echo $entry_customer_price; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_customer_price', $config_customer_price); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_customer_price', $config_customer_price); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_block_buy; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_block_buy', $config_block_buy); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_block_buy', $config_block_buy); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_account; ?></label>
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
                                        <label class="control-label"><?php echo $entry_cart_weight; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_cart_weight', $config_cart_weight); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_cart_weight', $config_cart_weight); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_guest_checkout; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_guest_checkout', $config_guest_checkout); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_guest_checkout', $config_guest_checkout); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_coupon_code; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_coupon_code', $config_coupon_code); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_coupon_code', $config_coupon_code); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_gift_voucher; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_gift_voucher', $config_gift_voucher); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_gift_voucher', $config_gift_voucher); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_estimate_shipping; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_estimate_shipping', $config_estimate_shipping); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_estimate_shipping', $config_estimate_shipping); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_checkout; ?></label>
                                        <div class="controls">
                                            <select name="config_checkout_id" class="i-medium input-block-level">
                                                <option value="0"><?php echo $text_none; ?></option>
                                                <?php echo p3html::oc_information_options($informations, $config_checkout_id); ?>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_order_edit; ?></label>
                                        <div class="controls"><input type="text" name="config_order_edit" value="<?php echo $config_order_edit; ?>" class="input-mini"></div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_invoice_prefix; ?></label>
                                        <div class="controls"><input type="text" name="config_invoice_prefix" value="<?php echo $config_invoice_prefix; ?>" class="input-small"></div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_order_status; ?></label>
                                        <div class="controls">
                                            <select name="config_order_status_id" class="i-medium input-block-level">
                                                <?php echo p3html::oc_order_status_options($order_statuses, $config_order_status_id); ?>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_complete_status; ?></label>
                                        <div class="controls">
                                            <select name="config_complete_status_id" class="i-medium input-block-level">
                                                <?php echo p3html::oc_order_status_options($order_statuses, $config_complete_status_id); ?>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <h2><?php echo $text_stock; ?></h2>
                                <div class="form well">
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_stock_display; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_stock_display', $config_stock_display); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_stock_display', $config_stock_display); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_stock_warning; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_stock_warning', $config_stock_warning); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_stock_warning', $config_stock_warning); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_stock_checkout; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_stock_checkout', $config_stock_checkout); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_stock_checkout', $config_stock_checkout); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_stock_status; ?></label>
                                        <div class="controls">
                                            <select name="config_stock_status_id" class="i-medium input-block-level">
                                                <?php echo p3html::oc_stock_status_options($stock_statuses, $config_stock_status_id); ?>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <h2><?php echo $text_affiliate; ?></h2>
                                <div class="form well">
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_affiliate; ?></label>
                                        <div class="controls">
                                            <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                                <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_allow_affiliate', $config_allow_affiliate); ?>
                                            <?php } else { ?>
                                                <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_allow_affiliate', $config_allow_affiliate); ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_affiliate; ?></label>
                                        <div class="controls">
                                            <select name="config_affiliate_id" class="i-medium input-block-level">
                                                <option value="0"><?php echo $text_none; ?></option>
                                                <?php echo p3html::oc_information_options($informations, $config_affiliate_id); ?>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_account_commission; ?></label>
                                        <div class="controls">
                                            <input type="text" name="config_account_commission" value="<?php echo $config_account_commission; ?>" class="input-mini">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_commission; ?></label>
                                        <div class="controls">
                                            <input type="text" name="config_commission" value="<?php echo $config_commission; ?>"  class="input-mini">
                                        </div>
                                    </div>
                                </div>
                                <h2><?php echo $text_return; ?></h2>
                                <div class="form well">
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_return_status; ?></label>
                                        <div class="controls">
                                            <select name="config_return_status_id" class="i-medium input-block-level">
                                                <?php echo p3html::oc_return_status_options($return_statuses, $config_return_status_id); ?>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_return_refund; ?></label>
                                        <div class="controls">
                                            <select name="config_return_refund_action_id" class="i-medium input-block-level">
                                                <?php echo p3html::oc_return_action_options($return_actions, $config_return_refund_action_id); ?>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_return_replacement; ?></label>
                                        <div class="controls">
                                            <select name="config_return_action_id" class="i-medium input-block-level">
                                                <?php echo p3html::oc_return_action_options($return_actions, $config_return_replacement_action_id); ?>
                                            </select>
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
                                        <label class="control-label"><?php echo $entry_logo; ?></label>
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
                                        <label class="control-label"><?php echo $entry_icon; ?></label>
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
                                        <label class="control-label"><?php echo $entry_image_category; ?></label>
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
                                        <label class="control-label"><?php echo $entry_image_information; ?></label>
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
                                        <label class="control-label"><?php echo $entry_image_thumb; ?></label>
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
                                        <label class="control-label"><?php echo $entry_image_popup; ?></label>
                                        <div class="controls">
                                            <input type="text" name="config_image_popup_width" value="<?php echo $config_image_popup_width; ?>" class="input-mini">
                                            x
                                            <input type="text" name="config_image_popup_height" value="<?php echo $config_image_popup_height; ?>" class="input-mini">
                                            <?php if ($error_image_popup) { ?>
                                                <span class="error help-block"><?php echo $error_image_popup; ?></span>
                                            <?php } ?>
                                        </div>
                                    </div>

                                    <div class="control-group<?php if ($error_image_product) { ?> error<?php } ?>">
                                        <label class="control-label"><?php echo $entry_image_product; ?></label>
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
                                        <label class="control-label"><?php echo $entry_image_additional; ?></label>
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
                                        <label class="control-label"><?php echo $entry_image_related; ?></label>
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
                                        <label class="control-label"><?php echo $entry_image_compare; ?></label>
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
                                        <label class="control-label"><?php echo $entry_image_wishlist; ?></label>
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
                                        <label class="control-label"><?php echo $entry_image_cart; ?></label>
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

                    <div class="tab-pane" id="tab-mail">
                        <div class="form">
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_mail_protocol; ?></label>
                                <div class="controls">
                                    <select name="config_mail_protocol" class="span3 i-small i-block-level">
                                        <option value="mail"<?php if ($config_mail_protocol == 'mail') { ?> selected="selected"<?php } ?>><?php echo $text_mail; ?></option>
                                        <option value="smtp"<?php if ($config_mail_protocol == 'smtp') { ?> selected="selected"<?php } ?>><?php echo $text_smtp; ?></option>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_mail_parameter; ?></label>
                                <div class="controls"><input type="text" name="config_mail_parameter" value="<?php echo $config_mail_parameter; ?>" class="span3 i-large"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_smtp_host; ?></label>
                                <div class="controls"><input type="text" name="config_smtp_host" value="<?php echo $config_smtp_host; ?>" class="span3 i-large"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_smtp_username; ?></label>
                                <div class="controls"><input type="text" name="config_smtp_username" value="<?php echo $config_smtp_username; ?>" class="span3 i-large"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_smtp_password; ?></label>
                                <div class="controls"><input type="text" name="config_smtp_password" value="<?php echo $config_smtp_password; ?>" class="span3 i-large"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_smtp_port; ?></label>
                                <div class="controls"><input type="text" name="config_smtp_port" value="<?php echo $config_smtp_port; ?>" class="input-mini"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_smtp_timeout; ?></label>
                                <div class="controls"><input type="text" name="config_smtp_timeout" value="<?php echo $config_smtp_timeout; ?>" class="input-mini"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_alert_mail; ?></label>
                                <div class="controls">
                                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_alert_mail', $config_alert_mail); ?>
                                    <?php } else { ?>
                                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_alert_mail', $config_alert_mail); ?>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_account_mail; ?></label>
                                <div class="controls">
                                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_account_mail', $config_account_mail); ?>
                                    <?php } else { ?>
                                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_account_mail', $config_account_mail); ?>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_alert_emails; ?></label>
                                <div class="controls">
                                    <textarea name="config_alert_emails" class="span6 i-xxlarge" rows="5"><?php echo $config_alert_emails; ?></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tab-fraud">
                        <div class="form">
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_fraud_detection; ?></label>
                                <div class="controls">
                                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_fraud_detection', $config_fraud_detection); ?>
                                    <?php } else { ?>
                                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_fraud_detection', $config_fraud_detection); ?>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_fraud_key; ?></label>
                                <div class="controls"><input type="text" name="config_fraud_key" value="<?php echo $config_fraud_key; ?>" class="span4 i-xlarge"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_fraud_score; ?></label>
                                <div class="controls"><input type="text" name="config_fraud_score" value="<?php echo $config_fraud_score; ?>" class="input-mini"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_fraud_status; ?></label>
                                <div class="controls">
                                    <select name="config_fraud_status_id" class="span2 i-medium">
                                        <?php echo p3html::oc_order_status_options($order_statuses, $config_fraud_status_id); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tab-server">
                        <div class="form">
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_use_ssl; ?></label>
                                <div class="controls">
                                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_use_ssl', $config_use_ssl); ?>
                                    <?php } else { ?>
                                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_use_ssl', $config_use_ssl); ?>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_seo_url; ?></label>
                                <div class="controls">
                                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_seo_url', $config_seo_url); ?>
                                    <?php } else { ?>
                                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_seo_url', $config_seo_url); ?>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_maintenance; ?></label>
                                <div class="controls">
                                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_maintenance', $config_maintenance); ?>
                                    <?php } else { ?>
                                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_maintenance', $config_maintenance); ?>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_encryption; ?></label>
                                <div class="controls"><input type="text" name="config_encryption" value="<?php echo $config_encryption; ?>"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_compression; ?></label>
                                <div class="controls"><input type="text" name="config_compression" value="<?php echo $config_compression; ?>" class="input-mini"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_error_display; ?></label>
                                <div class="controls">
                                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_error_display', $config_error_display); ?>
                                    <?php } else { ?>
                                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_error_display', $config_error_display); ?>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_error_log; ?></label>
                                <div class="controls">
                                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_error_log', $config_error_log); ?>
                                    <?php } else { ?>
                                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_error_log', $config_error_log); ?>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group<?php if ($error_error_filename) { ?> error<?php } ?>">
                                <label class="control-label"><?php echo $entry_error_filename; ?></label>
                                <div class="controls">
                                    <input type="text" name="config_error_filename" value="<?php echo $config_error_filename; ?>">
                                    <?php if ($error_error_filename) { ?>
                                        <span class="error help-block"><?php echo $error_error_filename; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_google_analytics; ?></label>
                                <div class="controls">
                                    <textarea name="config_google_analytics" class="span6 i-xxlarge" rows="5"><?php echo $config_google_analytics; ?></textarea>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="tab-pane" id="tab-email">
                        <div class="form">
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_email_newsletter_subject; ?></label>
                                <div class="controls"><input type="text" name="config_email_newsletter_subject" value="<?php echo $config_email_newsletter_subject; ?>" /></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_email_newsletter_body; ?></label>
                                <div class="controls"><textarea name="config_email_newsletter_body" cols="40" rows="5"><?php echo $config_email_newsletter_body; ?></textarea></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_email_affiliate_subject; ?></label>
                                <div class="controls"><input type="text" name="config_email_affiliate_subject" value="<?php echo $config_email_affiliate_subject; ?>" /></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_email_affiliate_body; ?></label>
                                <div class="controls"><textarea name="config_email_affiliate_body" cols="40" rows="5"><?php echo $config_email_affiliate_body; ?></textarea></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_email_customer_subject; ?></label>
                                <div class="controls"><input type="text" name="config_email_customer_subject" value="<?php echo $config_email_customer_subject; ?>" /></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_email_customer_body; ?></label>
                                <div class="controls"><textarea name="config_email_customer_body" cols="40" rows="5"><?php echo $config_email_customer_body; ?></textarea></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_email_order_subject; ?></label>
                                <div class="controls"><input type="text" name="config_email_order_subject" value="<?php echo $config_email_order_subject; ?>" /></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_email_order_body; ?></label>
                                <div class="controls"><textarea name="config_email_order_body" cols="40" rows="5"><?php echo $config_email_order_body; ?></textarea></div>
                            </div>

                        </div>
                    </div>

                    <div class="tab-pane" id="tab-cron" <?php echo $display; ?>>
                        <div class="form">
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_cron_status; ?></label>
                                <div class="controls">
                                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'config_cron_status', $config_cron_status); ?>
                                    <?php } else { ?>
                                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'config_cron_status', $config_cron_status); ?>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_cron_user; ?></label>
                                <div class="controls">
                                    <select name="config_cron_user_id" class="span2 i-medium">
                                        <?php echo p3html::oc_user_options($users, $config_cron_user_id); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><?php echo $entry_cron_permission; ?></label>
                            <div class="controls">
                                <div class="scrollbox">
                                    <?php $class = 'odd'; ?>
                                    <?php foreach ($permissions as $permission) { ?>
                                        <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                        <div class="<?php echo $class; ?>">
                                            <label class="checkbox inline">
                                                <input type="checkbox" name="config_cron_permission[]" value="<?php echo $permission; ?>"<?php if (in_array($permission, $access)) { ?> checked="checked"<?php } ?>>
                                                <?php echo $permission; ?>
                                            </label>
                                        </div>
                                    <?php } ?>
                                </div>
                                <br>
                                <a class="btn btn-small" href="#" onclick="$(this).parent().find(':checkbox').attr('checked', true);return false;">
                                    <i class="icon-cb-checked"></i>
                                    <?php echo $text_select_all; ?>
                                </a>
                                <a class="btn btn-small" href="#" onclick="$(this).parent().find(':checkbox').attr('checked', false);return false;">
                                    <i class="icon-cb-unchecked"></i>
                                    <?php echo $text_unselect_all; ?>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<!--FILEMANAGER-->
<?php include_once DIR_TEMPLATE . 'javascript/filemanager_dialog.tpl'; ?>
<!--FILEMANAGER-->

<script>
    $('#template').load('index.php?route=setting/setting/template&token=<?php echo $token; ?>&template=' + encodeURIComponent($('select[name="config_template"]').attr('value')));
    $('#base_template').load('index.php?route=setting/setting/template&token=<?php echo $token; ?>&template=' + encodeURIComponent($('select[name="config_base_template"]').attr('value')));

</script>
<script type="text/javascript">
    $(document).ready(function(){
        $("#config_review_status0").click(function(){

            $("#config_anonymous_review_status1").attr("disabled",true);
            $("#config_anonymous_review_status0").attr("disabled",true);
        });
        $("#config_review_status1").click(function(){

            $("#config_anonymous_review_status1").attr("disabled",false);
            $("#config_anonymous_review_status0").attr("disabled",false);
        });
    });
</script>
<script>
    $('select[name="config_country_id"]').on('change', function() {

        var select_zone = $('select[name="config_zone_id"]');

        $.ajax({
            url: 'index.php?route=setting/setting/country&token=<?php echo $token; ?>&country_id=' + this.value,
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
                //			select_zone.trigger("liszt:updated");

                //select2
                //			var selected_zone_id = select_zone.val();
                //			selected_zone_id  = selected_zone_id ? selected_zone_id : '';
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
