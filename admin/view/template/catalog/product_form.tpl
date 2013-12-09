<?php echo $header; ?>

<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <div class="box">

        <div class="heading">
            <h1><i class="icon-archive"></i> <?php echo $heading_title; ?></h1>
            <?php if ($error_warning) { ?>
                <?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
            <?php } ?>
            <div class="buttons form-actions form-actions-top">
                <?php echo p3html::tb_form_button_save($button_save); ?>
                <?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
            </div>
        </div>

        <div class="content">

            <ul id="tabs" class="htabs nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#tab-general"><i class="icon-cog"></i> <?php echo $tab_general; ?></a></li>
                <li><a data-toggle="tab" href="#tab-data"><i class="icon-database"></i> <?php echo $tab_data; ?></a></li>
                <li><a data-toggle="tab" href="#tab-links"><i class="icon-link"></i> <?php echo $tab_links; ?></a></li>
                <li><a data-toggle="tab" href="#tab-attribute"><i class="icon-star"></i> <?php echo $tab_attribute; ?></a></li>
                <li><a data-toggle="tab" href="#tab-option"><i class="icon-list"></i> <?php echo $tab_option; ?></a></li>
                <li><a data-toggle="tab" href="#tab-discount"><i class="icon-dollar"></i> <?php echo $tab_discount; ?></a></li>
                <li><a data-toggle="tab" href="#tab-special"><i class="icon-star-empty"></i> <?php echo $tab_special; ?></a></li>
                <li><a data-toggle="tab" href="#tab-image"><i class="icon-picture"></i> <?php echo $tab_image; ?></a></li>
                <li><a data-toggle="tab" href="#tab-reward"><i class="icon-reply"></i> <?php echo $tab_reward; ?></a></li>
                <li><a data-toggle="tab" href="#tab-design"><i class="icon-compass"></i> <?php echo $tab_design; ?></a></li>
            </ul>

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">

                <div class="tab-content">
                    <div class="tab-pane active" id="tab-general">

                        <ul id="languages" class="htabs nav nav-tabs">
                            <?php $langIndex = 0; ?>
                            <?php foreach ($languages as $language) { ?>
                                <li<?php if ($langIndex == 0) { ?> class="active"<?php } ?>>
                                    <a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab">
                                        <i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i> <?php echo $language['name']; ?>
                                    </a>
                                <li>
                                    <?php $langIndex++; ?>
                                <?php } ?>
                        </ul>

                        <div class="tab-content">
                            <?php $langIndex = 0; ?>
                            <?php foreach ($languages as $language) { ?>
                                <div class="tab-pane<?php if ($langIndex == 0) { ?> active<?php } ?>" id="language<?php echo $language['language_id']; ?>">
                                    <div class="form">
                                        <div class="control-group<?php if (isset($error_name[$language['language_id']])) { ?> error<?php } ?>">
                                            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
                                            <div class="controls">
                                                <input type="text" name="product_description[<?php echo $language['language_id']; ?>][name]" class="span6 i-xxlarge" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['name'] : ''; ?>">
                                                <?php if (isset($error_name[$language['language_id']])) { ?>
                                                    <span class="error help-block"><?php echo $error_name[$language['language_id']]; ?></span>
                                                <?php } ?>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_meta_title; ?></label>
                                            <div class="controls">
                                                <input type="text" name="product_description[<?php echo $language['language_id']; ?>][meta_title]" class="span6 i-xxlarge" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['meta_title'] : ''; ?>">                                                
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_meta_description; ?></label>
                                            <div class="controls">
                                                <textarea name="product_description[<?php echo $language['language_id']; ?>][meta_description]" class="span6 i-xxlarge" rows="5"><?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_meta_keyword; ?></label>
                                            <div class="controls">
                                                <textarea name="product_description[<?php echo $language['language_id']; ?>][meta_keyword]" class="span6 i-xxlarge" rows="5"><?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_brief_summary; ?></label>
                                            <div class="controls">
                                                <input type="text" name="product_description[<?php echo $language['language_id']; ?>][brief_summary]" class="span6 i-xxlarge" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['brief_summary'] : ''; ?>">                                                                                                
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_description; ?></label>
                                            <div class="controls">
                                                <textarea name="product_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>" class="input-block-level"><?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['description'] : ''; ?></textarea>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_keyword; ?></label>
                                            <div class="controls">
                                                <input type="text" name="product_description[<?php echo $language['language_id']; ?>][keyword]" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['keyword'] : ''; ?>" class="span6 i-xxlarge">
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_tag; ?></label>
                                            <div class="controls">
                                                <?php if (VERSION >= '1.5.4') { ?>
                                                    <input type="text" name="product_description[<?php echo $language['language_id']; ?>][tag]" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['tag'] : ''; ?>" class="input-block-level i-xxlarge">
                                                <?php } else { ?>
                                                    <input type="text" name="product_tag[<?php echo $language['language_id']; ?>]" value="<?php echo isset($product_tag[$language['language_id']]) ? $product_tag[$language['language_id']] : ''; ?>" class="input-block-level i-xxlarge">
                                                <?php } ?>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <?php $langIndex++; ?>
                            <?php } ?>
                        </div>
                    </div>

                    <div class="tab-pane" id="tab-data">
                        <div class="form">
                            <div class="control-group<?php if ($error_model) { ?> error<?php } ?>">
                                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_model; ?></label>
                                <div class="controls">
                                    <input type="text" name="model" value="<?php echo $model; ?>" class="span4 i-xlarge">
                                    <?php if ($error_model) { ?>
                                        <span class="error help-block"><?php echo $error_model; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_sku; ?></label>
                                <div class="controls"><input type="text" name="sku" value="<?php echo $sku; ?>" class="span4 i-xlarge"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_upc; ?></label>
                                <div class="controls"><input type="text" name="upc" value="<?php echo $upc; ?>" class="span4 i-xlarge"></div>
                            </div>
                            <?php if (VERSION >= '1.5.4') { ?>
                                <div class="control-group">
                                    <label class="control-label"><?php echo $entry_ean; ?></label>
                                    <div class="controls"><input type="text" name="ean" value="<?php echo $ean; ?>" class="span4 i-xlarge"></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><?php echo $entry_jan; ?></label>
                                    <div class="controls"><input type="text" name="jan" value="<?php echo $jan; ?>" class="span4 i-xlarge"></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><?php echo $entry_isbn; ?></label>
                                    <div class="controls"><input type="text" name="isbn" value="<?php echo $isbn; ?>" class="span4 i-xlarge"></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><?php echo $entry_mpn; ?></label>
                                    <div class="controls"><input type="text" name="mpn" value="<?php echo $mpn; ?>" class="span4 i-xlarge"></div>
                                </div>
                            <?php } ?>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_location; ?></label>
                                <div class="controls"><input type="text" name="location" value="<?php echo $location; ?>" class="span6 i-xxlarge"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_price; ?></label>
                                <div class="controls"><input type="text" name="price" value="<?php echo $price; ?>" class="input-small"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_tax_class; ?></label>
                                <div class="controls">
                                    <select name="tax_class_id" class="span3">
                                        <option value="0"><?php echo $text_none; ?></option>
                                        <?php foreach ($tax_classes as $tax_class) { ?>
                                            <option value="<?php echo $tax_class['tax_class_id']; ?>"<?php if ($tax_class['tax_class_id'] == $tax_class_id) { ?> selected="selected"<?php } ?>><?php echo $tax_class['title']; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_quantity; ?></label>
                                <div class="controls"><input type="text" name="quantity" value="<?php echo $quantity; ?>" class="input-mini"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_minimum; ?></label>
                                <div class="controls"><input type="text" name="minimum" value="<?php echo $minimum; ?>" class="input-mini"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_subtract; ?></label>
                                <div class="controls">
                                    <select name="subtract" class="input-small">
                                        <?php echo p3html::oc_bool_options($this->language, $subtract, 'subtract'); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_stock_status; ?></label>
                                <div class="controls">
                                    <select name="stock_status_id" class="input-medium">
                                        <?php echo p3html::oc_stock_status_options($stock_statuses, $stock_status_id); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_shipping; ?></label>
                                <div class="controls">
                                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'shipping', $shipping); ?>
                                    <?php } else { ?>
                                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'shipping', $shipping); ?>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_keyword; ?></label>
                                <div class="controls"><input type="text" name="keyword" value="<?php echo $keyword; ?>" class="span6 i-xxlarge"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_image; ?></label>
                                <div class="controls">
                                    <div class="image">
                                        <img src="<?php echo $thumb; ?>" alt="" id="thumb">
                                        <input type="hidden" name="image" value="<?php echo $image; ?>" id="image">
                                        <br><br>
                                        <a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('image', 'thumb');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>
                                        <a class="btn" title="<?php echo $text_clear; ?>" onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_date_available; ?></label>
                                <div class="controls">
                                    <input type="text" name="date_available" value="<?php echo $date_available; ?>" class="date input-small">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_dimension; ?></label>
                                <div class="controls">
                                    <input type="text" name="length" value="<?php echo $length; ?>" class="input-small">
                                    <input type="text" name="width" value="<?php echo $width; ?>" class="input-small">
                                    <input type="text" name="height" value="<?php echo $height; ?>" class="input-small">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_length; ?></label>
                                <div class="controls">
                                    <select name="length_class_id" class="input-medium">
                                        <?php echo p3html::oc_length_class_options($length_classes, $length_class_id); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_weight; ?></label>
                                <div class="controls">
                                    <input type="text" name="weight" value="<?php echo $weight; ?>" class="input-small">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_weight_class; ?></label>
                                <div class="controls">
                                    <select name="weight_class_id" class="input-medium">
                                        <?php echo p3html::oc_weight_class_options($weight_classes, $weight_class_id); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_status; ?></label>
                                <div class="controls">
                                    <select name="status" class="input-medium">
                                        <option value="1"<?php if ($status) { ?> selected="selected"<?php } ?>><?php echo $text_enabled; ?></option>
                                        <option value="0"<?php if (!$status) { ?> selected="selected"<?php } ?>><?php echo $text_disabled; ?></option>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_sort_order; ?></label>
                                <div class="controls"><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" class="input-mini"></div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tab-links">
                        <div class="form">
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_manufacturer; ?></label>
                                <div class="controls">
                                    <select name="manufacturer_id" class="span3 i-large">
                                        <option value="0" selected="selected"><?php echo $text_none; ?></option>
                                        <?php echo p3html::oc_manufacturer_options($manufacturers, $manufacturer_id); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_category; ?></label>
                                <div class="controls">
                                    <div class="scrollbox">
                                        <?php $class = 'odd'; ?>
                                        <?php foreach ($categories as $category) { ?>
                                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                            <div class="<?php echo $class; ?>">
                                                <?php $checked = (in_array($category['category_id'], $product_category)); ?>
                                                <label class="checkbox inline">
                                                    <input type="checkbox" name="product_category[]" value="<?php echo $category['category_id']; ?>"<?php if ($checked) { ?> checked="checked"<?php } ?>>
                                                    <?php echo $category['name']; ?>
                                                </label>
                                            </div>
                                        <?php } ?>
                                    </div>
                                    <br>
                                    <a class="btn btn-small" onclick="$(this).parent().find(':checkbox').attr('checked', true);"><i class="icon-cb-checked"></i> <?php echo $text_select_all; ?></a>
                                    <a class="btn btn-small" onclick="$(this).parent().find(':checkbox').attr('checked', false);"><i class="icon-cb-unchecked"></i> <?php echo $text_unselect_all; ?></a>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_filter; ?></label>
                                <div class="controls">
                                    <div class="scrollbox">
                                        <?php $class = 'odd'; ?>
                                        <?php foreach ($product_filters as $product_filter) { ?>
                                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                            <div class="<?php echo $class; ?>">
                                                <?php $checked = (in_array($product_filter['filter_id'], $product_filter_selected)); ?>
                                                <label class="checkbox inline">
                                                    <input type="checkbox" name="product_filter[]" value="<?php echo $product_filter['filter_id']; ?>"<?php if ($checked) { ?> checked="checked"<?php } ?>>
                                                    <?php echo $product_filter['name']; ?>
                                                </label>
                                            </div>
                                        <?php } ?>
                                    </div>
                                    <br>
                                    <a class="btn btn-small" onclick="$(this).parent().find(':checkbox').attr('checked', true);"><i class="icon-cb-checked"></i> <?php echo $text_select_all; ?></a>
                                    <a class="btn btn-small" onclick="$(this).parent().find(':checkbox').attr('checked', false);"><i class="icon-cb-unchecked"></i> <?php echo $text_unselect_all; ?></a>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_store; ?></label>
                                <div class="controls">
                                    <div class="scrollbox">
                                        <?php $class = 'even'; ?>
                                        <div class="<?php echo $class; ?>">
                                            <?php $checked = (in_array(0, $product_store)); ?>
                                            <label class="checkbox inline">
                                                <input type="checkbox" name="product_store[]" value="0"<?php if ($checked) { ?> checked="checked"<?php } ?>>
                                                <?php echo $text_default; ?>
                                            </label>
                                        </div>
                                        <?php foreach ($stores as $store) { ?>
                                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                            <div class="<?php echo $class; ?>">
                                                <?php $checked = (in_array($store['store_id'], $product_store)); ?>
                                                <label class="checkbox inline">
                                                    <input type="checkbox" name="product_store[]" value="<?php echo $store['store_id']; ?>"<?php if ($checked) { ?> checked="checked"<?php } ?>>
                                                    <?php echo $store['name']; ?>
                                                </label>
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_download; ?></label>
                                <div class="controls">
                                    <div class="scrollbox">
                                        <?php $class = 'odd'; ?>
                                        <?php foreach ($downloads as $download) { ?>
                                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                            <div class="<?php echo $class; ?>">
                                                <?php $checked = (in_array($download['download_id'], $product_download)); ?>
                                                <label class="checkbox inline">
                                                    <input type="checkbox" name="product_download[]" value="<?php echo $download['download_id']; ?>"<?php if ($checked) { ?> checked="checked"<?php } ?>>
                                                    <?php echo $download['name']; ?>
                                                </label>
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_related; ?></label>
                                <div class="controls"><input type="text" name="related" value="" class="span-3 i-large"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">&nbsp;</label>
                                <div class="controls">
                                    <div id="product-related" class="scrollbox">
                                        <?php $class = 'odd'; ?>
                                        <?php foreach ($product_related as $product_related) { ?>
                                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                            <div id="product-related<?php echo $product_related['product_id']; ?>" class="<?php echo $class; ?>">
                                                <i class="btn btn-small icon-trash ims remove" title="<?php echo $button_remove; ?>"></i> <?php echo $product_related['name']; ?>
                                                <input type="hidden" name="product_related[]" value="<?php echo $product_related['product_id']; ?>">
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tab-attribute">
                        <table id="attribute" class="list table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="column-name"><?php echo $entry_attribute; ?></th>
                                    <th class="column-name"><?php echo $entry_text; ?></th>
                                    <th class="column-action"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $attribute_row = 0; ?>
                                <?php foreach ($product_attributes as $product_attribute) { ?>
                                    <tr id="attribute-row<?php echo $attribute_row; ?>">
                                        <td class="column-name">
                                            <input type="text" name="product_attribute[<?php echo $attribute_row; ?>][name]" value="<?php echo $product_attribute['name']; ?>" class="span3">
                                            <input type="hidden" name="product_attribute[<?php echo $attribute_row; ?>][attribute_id]" value="<?php echo $product_attribute['attribute_id']; ?>">
                                        </td>
                                        <td class="column-name">
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="language-row">
                                                    <textarea name="product_attribute[<?php echo $attribute_row; ?>][product_attribute_description][<?php echo $language['language_id']; ?>][text]" class="span6 i-xxlarge" rows="5"><?php echo isset($product_attribute['product_attribute_description'][$language['language_id']]) ? $product_attribute['product_attribute_description'][$language['language_id']]['text'] : ''; ?></textarea>
                                                    &nbsp;<i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i>
                                                </div>
                                            <?php } ?>
                                        </td>
                                        <td class="column-action">
                                            <a onclick="$('#attribute-row<?php echo $attribute_row; ?>').remove();" class="btn btn-small"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
                                        </td>
                                    </tr>
                                    <?php $attribute_row++; ?>
                                <?php } ?>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="2"></td>
                                    <td class="column-action">
                                        <a onclick="addAttribute();" class="btn"><i class="icon-plus-squared"></i> <?php echo $button_add_attribute; ?></a>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <div class="tab-pane" id="tab-option">

                        <div class="tabbable tabs-left">
                            <ul id="vtab-option" class="vtabs nav nav-tabs">
                                <?php $option_row = 0; ?>
                                <?php foreach ($product_options as $product_option) { ?>
                                    <li<?php if ($option_row == 0) { ?> class="active"<?php } ?>>
                                        <a data-toggle="tab" href="#tab-option-<?php echo $option_row; ?>" id="option-<?php echo $option_row; ?>">
                                            <i class="icon-trash" onclick="$('#vtabs a:first').trigger('click'); $('#option-<?php echo $option_row; ?>').remove(); $('#tab-option-<?php echo $option_row; ?>').remove(); return false;"></i>
                                            <?php echo $product_option['name']; ?>
                                        </a>
                                    </li>
                                    <?php $option_row++; ?>
                                <?php } ?>
                                <li id="option-add">
                                    <input type="text" name="option" value="" class="input-small">
                                    &nbsp;<i class="icon-plus-squared" title="<?php echo $button_add_option; ?>"></i>
                                </li>
                            </ul>

                            <?php $option_row = 0; ?>
                            <?php $option_value_row = 0; ?>
                            <div class="tab-content" id="product-options">
                                <?php foreach ($product_options as $product_option) { ?>
                                    <div class="vtabs-content tab-pane<?php if ($option_row == 0) { ?> active<?php } ?>" id="tab-option-<?php echo $option_row; ?>">
                                        <input type="hidden" name="product_option[<?php echo $option_row; ?>][product_option_id]" value="<?php echo $product_option['product_option_id']; ?>">
                                        <input type="hidden" name="product_option[<?php echo $option_row; ?>][name]" value="<?php echo $product_option['name']; ?>">
                                        <input type="hidden" name="product_option[<?php echo $option_row; ?>][option_id]" value="<?php echo $product_option['option_id']; ?>">
                                        <input type="hidden" name="product_option[<?php echo $option_row; ?>][type]" value="<?php echo $product_option['type']; ?>">
                                        <div class="form" style="overflow:visible;">
                                            <div class="control-group" style="overflow:visible;">
                                                <label class="control-label"><?php echo $entry_required; ?></label>
                                                <div class="controls" style="overflow:visible;">
                                                    <select name="product_option[<?php echo $option_row; ?>][required]" class="input-small">
                                                        <?php echo p3html::oc_bool_options($this->language, $product_option, 'required'); ?>
                                                    </select>
                                                </div>
                                            </div>
                                            <?php if ($product_option['type'] == 'text') { ?>
                                                <div class="control-group">
                                                    <label class="control-label"><?php echo $entry_option_value; ?></label>
                                                    <div class="controls">
                                                        <input type="text" name="product_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['option_value']; ?>" class="span4 i-xlarge">
                                                    </div>
                                                </div>
                                            <?php } elseif ($product_option['type'] == 'textarea') { ?>
                                                <div class="control-group">
                                                    <label class="control-label"><?php echo $entry_option_value; ?></label>
                                                    <div class="controls">
                                                        <textarea name="product_option[<?php echo $option_row; ?>][option_value]" class="span6 i-xxlarge" rows="5"><?php echo $product_option['option_value']; ?></textarea>
                                                    </div>
                                                </div>
                                            <?php } elseif ($product_option['type'] == 'file') { ?>
                                                <div class="control-group" style="display: none;">
                                                    <label class="control-label"><?php echo $entry_option_value; ?></label>
                                                    <div class="controls">
                                                        <input type="text" name="product_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['option_value']; ?>">
                                                    </div>
                                                </div>
                                            <?php } elseif ($product_option['type'] == 'date') { ?>
                                                <div class="control-group">
                                                    <label class="control-label"><?php echo $entry_option_value; ?></label>
                                                    <div class="controls">
                                                                                                            <!--<input type="text" name="product_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['option_value']; ?>" class="date input-append input-small">-->
                                                        <?php echo p3html::tb_date_input("product_option[$option_row][option_value]", $product_option['option_value'], null, 'calendar'); ?>
                                                    </div>
                                                </div>
                                            <?php } elseif ($product_option['type'] == 'datetime') { ?>
                                                <div class="control-group">
                                                    <label class="control-label"><?php echo $entry_option_value; ?></label>
                                                    <div class="controls">
                                                        <?php echo p3html::tb_datetimecombo_input("product_option[$option_row][option_value]", $product_option['option_value'], null, array('date' => 'calendar', 'time' => 'clock')); ?>
                                                    </div>
                                                </div>
                                            <?php } elseif ($product_option['type'] == 'time') { ?>
                                                <div class="control-group">
                                                    <label class="control-label"><?php echo $entry_option_value; ?></label>
                                                    <div class="controls">
                                                                                                            <!--<input type="text" name="product_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['option_value']; ?>" class="time input-mini">-->
                                                        <?php echo p3html::tb_time_input("product_option[$option_row][option_value]", $product_option['option_value'], null, 'clock'); ?>
                                                    </div>
                                                </div>
                                            <?php } ?>
                                        </div>

                                        <?php if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') { ?>
                                            <table id="option-value<?php echo $option_row; ?>" class="list table table-striped table-hover product-options">
                                                <thead>
                                                    <tr>
                                                        <th class="column-name"><?php echo $entry_option_value; ?></th>
                                                        <th class="column-name"><?php echo $entry_sku; ?></th>
                                                        <th class="column-name"><?php echo $entry_ean; ?></th>
                                                        <th class="column-number"><?php echo $entry_quantity; ?></th>
                                                        <th class="column-number"><?php echo $entry_subtract; ?></th>
                                                        <th class="column-number"><?php echo $entry_price; ?></th>
                                                        <th class="column-number"><?php echo $entry_option_points; ?></th>
                                                        <th class="column-number"><?php echo $entry_weight; ?></th>
                                                        <th class="column-action"></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <?php foreach ($product_option['product_option_value'] as $product_option_value) { ?>
                                                        <tr id="option-value-row<?php echo $option_value_row; ?>">
                                                            <td class="column-name">
                                                                <label class="visible-480"><?php echo $entry_option_value; ?></label>
                                                                <select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][option_value_id]" class="span2 i-medium">
                                                                    <?php if (isset($option_values[$product_option['option_id']])) { ?>
                                                                        <?php echo p3html::options($option_values[$product_option['option_id']], $product_option_value, 'option_value_id', 'name'); ?>
                                                                    <?php } ?>
                                                                </select>
                                                                <input type="hidden" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][product_option_value_id]" value="<?php echo $product_option_value['product_option_value_id']; ?>">
                                                            </td>
                                                            <td class="column-number">
                                                                <label class="visible-480"><?php echo $entry_sku; ?></label>
                                                                <input type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][sku]" value="<?php echo $product_option_value['sku']; ?>" class="span1 i-mini">
                                                            </td>
                                                            <td class="column-number">
                                                                <label class="visible-480"><?php echo $entry_ean; ?></label>
                                                                <input type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][ean]" value="<?php echo $product_option_value['ean']; ?>" class="span1 i-mini">
                                                            </td>
                                                            <td class="column-number">
                                                                <label class="visible-480"><?php echo $entry_quantity; ?></label>
                                                                <input type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][quantity]" value="<?php echo $product_option_value['quantity']; ?>" class="span1 i-mini">
                                                            </td>
                                                            <td class="column-number">
                                                                <label class="visible-480"><?php echo $entry_subtract; ?></label>
                                                                <select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][subtract]" class="input-mini">
                                                                    <?php echo p3html::oc_bool_options($this->language, $product_option_value, 'subtract'); ?>
                                                                </select>
                                                            </td>
                                                            <td class="column-number nowrap">
                                                                <label class="visible-480"><?php echo $entry_price; ?></label>
                                                                <select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][price_prefix]" class="input-mini">
                                                                    <?php echo p3html::oc_sign_prefix_options($product_option_value, 'price_prefix'); ?>
                                                                </select>
                                                                <input type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][price]" value="<?php echo $product_option_value['price']; ?>" class="input-mini">
                                                            </td>
                                                            <td class="column-number nowrap">
                                                                <label class="visible-480"><?php echo $entry_option_points; ?></label>
                                                                <select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][points_prefix]" class="input-mini">
                                                                    <?php echo p3html::oc_sign_prefix_options($product_option_value, 'points_prefix'); ?>
                                                                </select>
                                                                <input type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][points]" value="<?php echo $product_option_value['points']; ?>" class="input-mini">
                                                            </td>
                                                            <td class="column-number nowrap">
                                                                <label class="visible-480"><?php echo $entry_weight; ?></label>
                                                                <select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][weight_prefix]" class="input-mini">
                                                                    <?php echo p3html::oc_sign_prefix_options($product_option_value, 'weight_prefix'); ?>
                                                                </select>
                                                                <input type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][weight]" value="<?php echo $product_option_value['weight']; ?>" class="input-mini">
                                                            </td>
                                                            <td class="column-action">
                                                                <a onclick="$('#option-value-row<?php echo $option_value_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
                                                            </td>
                                                        </tr>
                                                        <?php $option_value_row++; ?>
                                                    <?php } ?>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="7"></td>
                                                        <td class="column-action">
                                                            <a onclick="addOptionValue('<?php echo $option_row; ?>');" class="btn btn-small" title="<?php echo $button_add_option_value; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_option_value; ?></a>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>

                                            <select id="option-values<?php echo $option_row; ?>" style="display: none;" class="hide">
                                                <?php if (isset($option_values[$product_option['option_id']])) { ?>
                                                    <?php foreach ($option_values[$product_option['option_id']] as $option_value) { ?>
                                                        <option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
                                                    <?php } ?>
                                                <?php } ?>
                                            </select>

                                        <?php } ?>
                                    </div>
                                    <?php $option_row++; ?>
                                <?php } ?>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tab-discount">
                        <table id="discount" class="list table table-striped table-hover product-discounts">
                            <thead>
                                <tr>
                                    <th class="column-name"><?php echo $entry_customer_group; ?></th>
                                    <th class="column-quantity"><?php echo $entry_quantity; ?></th>
                                    <th class="column-sort"><?php echo $entry_priority; ?></th>
                                    <th class="column-price"><?php echo $entry_price; ?></th>
                                    <th class="column-date"><?php echo $entry_date_start; ?></th>
                                    <th class="column-date"><?php echo $entry_date_end; ?></th>
                                    <th class="column-action"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $discount_row = 0; ?>
                                <?php foreach ($product_discounts as $product_discount) { ?>
                                    <tr id="discount-row<?php echo $discount_row; ?>">
                                        <td class="column-name">
                                            <label class="visible-480"><?php echo $entry_customer_group; ?></label>
                                            <select name="product_discount[<?php echo $discount_row; ?>][customer_group_id]" class="input-large">
                                                <?php echo p3html::oc_customer_group_options($customer_groups, $product_discount); ?>
                                            </select>
                                        </td>
                                        <td class="column-quantity">
                                            <label class="visible-480"><?php echo $entry_quantity; ?></label>
                                            <input type="text" name="product_discount[<?php echo $discount_row; ?>][quantity]" value="<?php echo $product_discount['quantity']; ?>" class="span1 i-mini">
                                        </td>
                                        <td class="column-sort">
                                            <label class="visible-480"><?php echo $entry_priority; ?></label>
                                            <input type="text" name="product_discount[<?php echo $discount_row; ?>][priority]" value="<?php echo $product_discount['priority']; ?>" class="span1 i-mini">
                                        </td>
                                        <td class="column-price">
                                            <label class="visible-480"><?php echo $entry_price; ?></label>
                                            <input type="text" name="product_discount[<?php echo $discount_row; ?>][price]" value="<?php echo $product_discount['price']; ?>" class="input-small">
                                        </td>
                                        <td class="column-date">
                                            <label class="visible-480"><?php echo $entry_date_start; ?></label>
                                            <input type="text" name="product_discount[<?php echo $discount_row; ?>][date_start]" value="<?php echo $product_discount['date_start']; ?>" class="date input-small">
                                        </td>
                                        <td class="column-date">
                                            <label class="visible-480"><?php echo $entry_date_end; ?></label>
                                            <input type="text" name="product_discount[<?php echo $discount_row; ?>][date_end]" value="<?php echo $product_discount['date_end']; ?>" class="date input-small">
                                        </td>
                                        <td class="column-action">
                                            <a onclick="$('#discount-row<?php echo $discount_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
                                        </td>
                                    </tr>
                                    <?php $discount_row++; ?>
                                <?php } ?>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="6"></td>
                                    <td class="column-action">
                                        <a onclick="addDiscount();" class="btn btn-small" title="<?php echo $button_add_discount; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_discount; ?></a>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <div class="tab-pane" id="tab-special">
                        <table id="special" class="list table table-striped table-hover product-specials">
                            <thead>
                                <tr>
                                    <th class="column-name"><?php echo $entry_customer_group; ?></th>
                                    <th class="column-number"><?php echo $entry_priority; ?></th>
                                    <th class="column-number"><?php echo $entry_price; ?></th>
                                    <th class="column-number"><?php echo $entry_date_start; ?></th>
                                    <th class="column-number"><?php echo $entry_date_end; ?></th>
                                    <th class="column-action"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $special_row = 0; ?>
                                <?php foreach ($product_specials as $product_special) { ?>
                                    <tr id="special-row<?php echo $special_row; ?>">
                                        <td class="column-name">
                                            <label class="visible-480"><?php echo $entry_customer_group; ?></label>
                                            <select name="product_special[<?php echo $special_row; ?>][customer_group_id]" class="input-large">
                                                <?php echo p3html::oc_customer_group_options($customer_groups, $product_special); ?>
                                            </select>
                                        </td>
                                        <td class="column-sort">
                                            <label class="visible-480"><?php echo $entry_priority; ?></label>
                                            <input type="text" name="product_special[<?php echo $special_row; ?>][priority]" value="<?php echo $product_special['priority']; ?>" class="span1 i-mini">
                                        </td>
                                        <td class="column-price">
                                            <label class="visible-480"><?php echo $entry_price; ?></label>
                                            <input type="text" name="product_special[<?php echo $special_row; ?>][price]" value="<?php echo $product_special['price']; ?>" class="input-small">
                                        </td>
                                        <td class="column-date">
                                            <label class="visible-480"><?php echo $entry_date_start; ?></label>
                                            <input type="text" name="product_special[<?php echo $special_row; ?>][date_start]" value="<?php echo $product_special['date_start']; ?>" class="date input-small">
                                        </td>
                                        <td class="column-date">
                                            <label class="visible-480"><?php echo $entry_date_end; ?></label>
                                            <input type="text" name="product_special[<?php echo $special_row; ?>][date_end]" value="<?php echo $product_special['date_end']; ?>" class="date input-small">
                                        </td>
                                        <td class="column-action">
                                            <a onclick="$('#special-row<?php echo $special_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
                                        </td>
                                    </tr>
                                    <?php $special_row++; ?>
                                <?php } ?>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="5"></td>
                                    <td class="column-action"><a onclick="addSpecial();" class="btn btn-small" title="<?php echo $button_add_special; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_special; ?></a></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <div class="tab-pane" id="tab-image">
                        <table id="images" class="list table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="column-image"><?php echo $entry_image; ?></th>
                                    <!--th class="column-image"><?php /* echo $entry_youtube_url; */ ?></th-->
                                    <th class="column-sort"><?php echo $entry_sort_order; ?></th>
                                    <th class="column-action"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $image_row = 0; ?>
                                <?php foreach ($product_images_videos as $product_image) { ?>
                                <tbody id="image-row<?php echo $image_row; ?>">
                                    <tr>
                                        <td class="column-image">
                                            <?php if (!empty($product_image['image']) && !empty($product_image['video'])) { ?>
                                                <span class="image" style="text-align: center; width: 150px;">
                                                    <img src="<?php echo $product_image['image']; ?>" alt="" id="video_image<?php echo $image_row; ?>" height:="133px" width="133px" />
                                                    <input type="hidden" name="product_image[<?php echo $image_row; ?>][image]" value="<?php echo $product_image['image']; ?>" id="image<?php echo $image_row; ?>" />
                                                </span>
                                                <span class="video">
                                                    <?php echo $text_link_youtube; ?><input type="text" name="product_image[<?php echo $image_row; ?>][video]" value='<?php echo $product_image['reference_number']; ?>' />
                                                </span>
                                            <?php } elseif (!empty($product_image['image']) && empty($product_image['video'])) { ?>

                                                <div class="image"><img src="<?php echo $product_image['thumb']; ?>" alt="" id="thumb<?php echo $image_row; ?>" />
                                                    <input type="hidden" name="product_image[<?php echo $image_row; ?>][image]" value="<?php echo $product_image['image']; ?>" id="image<?php echo $image_row; ?>" />

                                                    <br />
                                                    <a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('image<?php echo $image_row; ?>', 'thumb<?php echo $image_row; ?>');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>
                                                <a class="btn" title="<?php echo $text_clear; ?>" onclick="$('#thumb<?php echo $image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $image_row; ?>').attr('value', '');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>
                                                </div>
                                            <?php } ?>

                                        </td>
                                        <td class="column-sort"><input type="text" name="product_image[<?php echo $image_row; ?>][sort_order]" value="<?php echo $product_image['sort_order']; ?>" class="input-mini"></td>
                                        <td class="column-action"><a onclick="$('#image-row<?php echo $image_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>
                                    </tr>
                                </tbody>
                                <?php $image_row++; ?>
                            <?php } ?>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="2"></td>
                                    <td class="column-action"><a onclick="addImage();" class="btn btn-small" title="<?php echo $button_add_image; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_image; ?></a></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <div class="tab-pane" id="tab-reward">
                        <div class="form">
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_points; ?></label>
                                <div class="controls"><input type="text" name="points" value="<?php echo $points; ?>" class="input-mini"></div>
                            </div>
                        </div>
                        <table class="list table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="column-name"><?php echo $entry_customer_group; ?></th>
                                    <th class="column-number"><?php echo $entry_reward; ?></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($customer_groups as $customer_group) { ?>
                                    <tr>
                                        <td class="column-name"><?php echo $customer_group['name']; ?></td>
                                        <td class="column-number"><input type="text" name="product_reward[<?php echo $customer_group['customer_group_id']; ?>][points]" value="<?php echo isset($product_reward[$customer_group['customer_group_id']]) ? $product_reward[$customer_group['customer_group_id']]['points'] : ''; ?>" class="input-mini"></td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>

                    <div class="tab-pane" id="tab-design">
                        <table class="list table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="column-name"><?php echo $entry_store; ?></th>
                                    <th class="column-layout"><?php echo $entry_layout; ?></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="column-name"><?php echo $text_default; ?></td>
                                    <td class="column-layout">
                                        <select name="product_layout[0][layout_id]" class="span2 i-large">
                                            <option value="">&nbsp;</option>
                                            <?php $current = isset($product_layout[0]) ? $product_layout[0] : null; ?>
                                            <?php echo p3html::oc_layout_options($layouts, $current); ?>
                                        </select>
                                    </td>
                                </tr>
                                <?php foreach ($stores as $store) { ?>
                                    <tr>
                                        <td class="column-name"><?php echo $store['name']; ?></td>
                                        <td class="column-layout">
                                            <select name="product_layout[<?php echo $store['store_id']; ?>][layout_id]" class="span2 i-large">
                                                <option value="">&nbsp;</option>
                                                <?php $current = isset($product_layout[$store['store_id']]) ? $product_layout[$store['store_id']] : null; ?>
                                                <?php echo p3html::oc_layout_options($layouts, $current); ?>
                                            </select>
                                        </td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
            </form>
        </div>
    </div>
</div>

<!--FILEMANAGER-->
<?php include_once DIR_TEMPLATE . 'javascript/filemanager_dialog.tpl'; ?>
<!--FILEMANAGER-->

<!--CKEDITOR-->
<script src="<?php echo P3_CKEDITOR_DIR; ?>/ckeditor.js"></script>
<script>
<?php foreach ($languages as $language) { ?>
    <?php echo p3html::oc_ckeditor_replace('description' . $language['language_id'], $token); ?>
    <?php echo p3html::oc_ckeditor_replace('brief_summary' . $language['language_id'], $token); ?>
<?php } ?>
</script>
<!--CKEDITOR-->

<script>
    $('input[name="related"]').autocomplete({
        delay: 0,
        source: function(request, response) {
            $.ajax({
                url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
                dataType: 'json',
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            label: item.name,
                            value: item.product_id
                        }
                    }));
                }
            });

        },
        select: function(event, ui) {
            $('#product-related' + ui.item.value).remove();

            $('#product-related').append('<div id="product-related' + ui.item.value + '"><i class="btn btn-small icon-trash ims remove" title="<?php echo addslashes($button_remove); ?>"></i> ' + ui.item.label + '<input type="hidden" name="product_related[]" value="' + ui.item.value + '"></div>');


            return false;
        },
        focus: function(event, ui) {
            return false;
        }
    });

    $('form').on('click', '#product-related div i.remove', function() {
        $(this).parent().remove();
    });
</script>

<script>
    var attribute_row = <?php echo $attribute_row; ?>;

    function addAttribute() {
        html  = '<tr id="attribute-row' + attribute_row + '">';
        html += '	<td class="column-name"><input type="text" name="product_attribute[' + attribute_row + '][name]" value="" class="span3"><input type="hidden" name="product_attribute[' + attribute_row + '][attribute_id]" value=""></td>';
        html += '	<td class="column-name">';
<?php foreach ($languages as $language) { ?>
                    html += '		<textarea name="product_attribute[' + attribute_row + '][product_attribute_description][<?php echo $language['language_id']; ?>][text]" class="span6 i-xxlarge" rows="5"></textarea> <i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i><br>';
<?php } ?>
          html += '	</td>';
          html += '	<td class="column-action"><a onclick="$(\'#attribute-row' + attribute_row + '\').remove();" class="btn btn-small"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
          html += '</tr>';

          $('#attribute tbody').append(html);

          attributeautocomplete(attribute_row);

          attribute_row++;
      }

      $.widget('custom.catcomplete', $.ui.autocomplete, {
          _renderMenu: function(ul, items) {
              var self = this, currentCategory = '';

              $.each(items, function(index, item) {
                  if (item.category != currentCategory) {
                      ul.append('<li class="ui-autocomplete-category">' + item.category + '</li>');

                      currentCategory = item.category;
                  }

                  self._renderItem(ul, item);
              });
          }
      });

      function attributeautocomplete(attribute_row) {
          $('input[name=\'product_attribute[' + attribute_row + '][name]\']').catcomplete({
              delay: 0,
              source: function(request, response) {
                  $.ajax({
                      url: 'index.php?route=catalog/attribute/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
                      dataType: 'json',
                      success: function(json) {
                          response($.map(json, function(item) {
                              return {
                                  category: item.attribute_group,
                                  label: item.name,
                                  value: item.attribute_id
                              }
                          }));
                      }
                  });
              },
              select: function(event, ui) {
                  $('input[name=\'product_attribute[' + attribute_row + '][name]\']').attr('value', ui.item.label);
                  $('input[name=\'product_attribute[' + attribute_row + '][attribute_id]\']').attr('value', ui.item.value);

                  return false;
              },
              focus: function(event, ui) {
                  return false;
              }
          });
      }

      $('#attribute tbody').each(function(index, element) {
          attributeautocomplete(index);
      });
</script>
<script>
    var option_row = <?php echo $option_row; ?>;

    $('input[name=\'option\']').catcomplete({
        delay: 0,
        source: function(request, response) {
            $.ajax({
                url: 'index.php?route=catalog/option/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
                dataType: 'json',
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            category: item.category,
                            label: item.name,
                            value: item.option_id,
                            type: item.type,
                            option_value: item.option_value
                        }
                    }));
                }
            });
        },
        select: function(event, ui) {
            html  = '<div class="tab-pane" id="tab-option-' + option_row + '" class="vtabs-content">';
            html += '	<input type="hidden" name="product_option[' + option_row + '][product_option_id]" value="">';
            html += '	<input type="hidden" name="product_option[' + option_row + '][name]" value="' + ui.item.label + '">';
            html += '	<input type="hidden" name="product_option[' + option_row + '][option_id]" value="' + ui.item.value + '">';
            html += '	<input type="hidden" name="product_option[' + option_row + '][type]" value="' + ui.item.type + '">';
            html += '	<div class="form">';
            html += '		<div class="control-group">';
            html += '			<label class="control-label"><?php echo $entry_required; ?></label>';
            html += '			<div class="controls"><select name="product_option[' + option_row + '][required]" class="input-small">';
            html +=	'				<?php echo p3html::oc_bool_options($this->language, null, 'required'); ?>';
            html += '	    </select></div>';
            html += '		</div>';

            if (ui.item.type == 'text') {
                html += '	<div class="control-group">';
                html += '		<label class="control-label"><?php echo $entry_option_value; ?></label>';
                html += '		<div class="controls"><input type="text" name="product_option[' + option_row + '][option_value]" value="" class="span4 i-xlarge"></div>';
                html += '	</div>';
            }
            else
                if (ui.item.type == 'textarea') {
                    html += '	<div class="control-group">';
                    html += '		<label class="control-label"><?php echo $entry_option_value; ?></label>';
                    html += '		<div class="controls"><textarea name="product_option[' + option_row + '][option_value]" class="span6 i-xxlarge" rows="5"></textarea></div>';
                    html += '	</div>';
                }
            else
                if (ui.item.type == 'file') {
                    html += '     <div class="control-group" style="display: none;" class="hide">';
                    html += '       <label class="control-label"><?php echo $entry_option_value; ?></label>';
                    html += '       <div class="controls"><input type="text" name="product_option[' + option_row + '][option_value]" value=""></div>';
                    html += '     </div>';
                }
            else
                if (ui.item.type == 'date') {
                    html += '     <div class="control-group">';
                    html += '       <label class="control-label"><?php echo $entry_option_value; ?></label>';
                    html += '       <div class="controls"><?php echo p3html::tb_date_input("product_option[' + option_row + '][option_value]", date('Y-m-d'), null, 'calendar'); ?></div>';
                    html += '     </div>';
                }
            else
                if (ui.item.type == 'datetime') {
                    html += '     <div class="control-group">';
                    html += '       <label class="control-label"><?php echo $entry_option_value; ?></label>';
                    html += '       <div class="controls"><?php echo p3html::tb_datetimecombo_input("product_option[' + option_row + '][option_value]", date('Y-m-d H:i'), null, array('date' => 'calendar', 'time' => 'clock')); ?></div>';
                    html += '     </div>';
                }
            else
                if (ui.item.type == 'time') {
                    html += '     <div class="control-group">';
                    html += '       <label class="control-label"><?php echo $entry_option_value; ?></label>';
                    html += '       <div class="controls"><?php echo p3html::tb_time_input("product_option[' + option_row + '][option_value]", date('H:i'), null, 'clock'); ?></div>';
                    html += '     </div>';
                }

            html += '  </div>';

            if (ui.item.type == 'select' || ui.item.type == 'radio' || ui.item.type == 'checkbox' || ui.item.type == 'image') {
                html += '  <table id="option-value' + option_row + '" class="list table table-hover">';
                html += '  	 <thead>';
                html += '      <tr>';
                html += '        <th class="column-name"><?php echo $entry_option_value; ?></th>';
                html += '        <th class="column-number"><?php echo $entry_quantity; ?></th>';
                html += '        <th class="column-number"><?php echo $entry_subtract; ?></th>';
                html += '        <th class="column-number"><?php echo $entry_price; ?></th>';
                html += '        <th class="column-number"><?php echo $entry_option_points; ?></th>';
                html += '        <th class="column-number"><?php echo $entry_weight; ?></th>';
                html += '        <th class="column-action"></th>';
                html += '      </tr>';
                html += '  	 </thead>';
                html += '  	 <tbody></tbody>';
                html += '    <tfoot>';
                html += '      <tr>';
                html += '        <td colspan="6"></td>';
                html += '        <td class="column-action"><a onclick="addOptionValue(' + option_row + ');" class="btn btn-small" title="<?php echo $button_add_option_value; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_option_value; ?></a></td>';
                html += '      </tr>';
                html += '    </tfoot>';
                html += '  </table>';
                html += '  <select id="option-values' + option_row + '" style="display: none;" class="hide">';

                for (i = 0; i < ui.item.option_value.length; i++) {
                    html += '  <option value="' + ui.item.option_value[i]['option_value_id'] + '">' + ui.item.option_value[i]['name'] + '</option>';
                }

                html += '  </select>';
                html += '</div>';
            }

            $('#tab-option .tab-content').append(html);

            $('#option-add').before('<li><a data-toggle="tab" href="#tab-option-' + option_row + '" id="option-' + option_row + '"><i class="icon-trash" onclick="$(\'#vtab-option a:first\').trigger(\'click\'); $(\'#option-' + option_row + '\').remove(); $(\'#tab-option-' + option_row + '\').remove(); return false;"></i> ' + ui.item.label + '</a></li>');

            $('#option-' + option_row).trigger('click');

<?php if ($this->config->get('p3adminrebooted_select2')) { ?>
                                $('#tab-option-' + option_row + ' select').select2();
<?php } ?>

                            option_row++;

                            return false;
                        },
                        focus: function(event, ui) {
                            return false;
                        }
                    });
</script>

<script>
    var option_value_row = <?php echo $option_value_row; ?>;

    function addOptionValue(option_row) {
        html  = '<tr id="option-value-row' + option_value_row + '">';
        html += '	<td class="column-name"><label class="visible-480"><?php echo addslashes($entry_option_value); ?></label><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][option_value_id]" class="span2 i-medium">';
        html +=			$('#option-values' + option_row).html();
        html += '	</select><input type="hidden" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][product_option_value_id]" value=""></td>';
        html += '	<td class="column-number"><label class="visible-480"><?php echo addslashes($entry_quantity); ?></label><input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][quantity]" value="" class="span1 i-mini"></td>';
        html += '	<td class="column-number"><label class="visible-480"><?php echo addslashes($entry_subtract); ?></label><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][subtract]" class="input-mini">';
        html +=	'		<?php echo p3html::oc_bool_options($this->language, null, 'subtract'); ?>';
        html += '	</select></td>';
        html += '	<td class="column-number" nowrap><label class="visible-480"><?php echo addslashes($entry_price); ?></label><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][price_prefix]" class="input-mini">';
        html +=	'		<?php echo p3html::oc_sign_prefix_options(null, 'price_prefix'); ?>';
        html += '		</select>';
        html += '		<input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][price]" value="" class="input-mini"></td>';
        html += '	<td class="column-number" nowrap><label class="visible-480"><?php echo addslashes($entry_option_points); ?></label><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][points_prefix]" class="input-mini">';
        html +=	'		<?php echo p3html::oc_sign_prefix_options(null, 'points_prefix'); ?>';
        html += '		</select>';
        html += '		<input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][points]" value="" class="input-mini"></td>';
        html += '	<td class="column-number" nowrap><label class="visible-480"><?php echo addslashes($entry_weight); ?></label><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][weight_prefix]" class="input-mini">';
        html +=	'		<?php echo p3html::oc_sign_prefix_options(null, 'weight_prefix'); ?>';
        html += '		</select>';
        html += '		<input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][weight]" value="" class="input-mini"></td>';
        html += '	<td class="column-action"><a onclick="$(\'#option-value-row' + option_value_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
        html += '</tr>';

        $('#option-value' + option_row + ' tbody').append(html);

<?php if ($this->config->get('p3adminrebooted_select2')) { ?>
                    $('#option-value-row' + option_value_row + ' select').select2();
<?php } ?>

                option_value_row++;
            }
</script>
<script>
    var discount_row = <?php echo $discount_row; ?>;

    function addDiscount() {
        html  = '<tr id="discount-row' + discount_row + '">';
        html += '	<td class="column-name"><label class="visible-480"><?php echo addslashes($entry_customer_group); ?></label><select name="product_discount[' + discount_row + '][customer_group_id]" class="input-large">';
        html += '		<?php echo p3html::oc_customer_group_options($customer_groups, false, true); ?>';
        html += '	</select></td>';
        html += '	<td class="column-quantity"><label class="visible-480"><?php echo addslashes($entry_quantity); ?></label><input type="text" name="product_discount[' + discount_row + '][quantity]" value="" class="span1 i-mini"></td>';
        html += '	<td class="column-sort"><label class="visible-480"><?php echo addslashes($entry_priority); ?></label><input type="text" name="product_discount[' + discount_row + '][priority]" value="" class="span1 i-mini"></td>';
        html += '	<td class="column-price"><label class="visible-480"><?php echo addslashes($entry_price); ?></label><input type="text" name="product_discount[' + discount_row + '][price]" value="" class="input-small"></td>';
        html += '	<td class="column-date"><label class="visible-480"><?php echo addslashes($entry_date_start); ?></label><input type="text" name="product_discount[' + discount_row + '][date_start]" value="" class="date input-small"></td>';
        html += '	<td class="column-date"><label class="visible-480"><?php echo addslashes($entry_date_end); ?></label><input type="text" name="product_discount[' + discount_row + '][date_end]" value="" class="date input-small"></td>';
        html += '	<td class="column-action"><a onclick="$(\'#discount-row' + discount_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
        html += '</tr>';

        $('#discount tbody').append(html);

<?php if ($this->config->get('p3adminrebooted_select2')) { ?>
                    $('#discount-row' + discount_row + ' select').select2();
<?php } ?>

                discount_row++;
            }
</script>
<script>
    var special_row = <?php echo $special_row; ?>;

    function addSpecial() {
        html  = '<tr id="special-row' + special_row + '">';
        html += '	<td class="column-name"><label class="visible-480"><?php echo addslashes($entry_customer_group); ?></label><select name="product_special[' + special_row + '][customer_group_id]" class="input-large">';
        html += '		<?php echo p3html::oc_customer_group_options($customer_groups, false, true); ?>';
        html += '	</select></td>';
        html += '	<td class="column-sort"><label class="visible-480"><?php echo addslashes($entry_priority); ?></label><input type="text" name="product_special[' + special_row + '][priority]" value="" class="span1 i-mini"></td>';
        html += '	<td class="column-price"><label class="visible-480"><?php echo addslashes($entry_price); ?></label><input type="text" name="product_special[' + special_row + '][price]" value="" class="input-small"></td>';
        html += '	<td class="column-date"><label class="visible-480"><?php echo addslashes($entry_date_start); ?></label><input type="text" name="product_special[' + special_row + '][date_start]" value="" class="date input-small"></td>';
        html += '	<td class="column-date"><label class="visible-480"><?php echo addslashes($entry_date_end); ?></label><input type="text" name="product_special[' + special_row + '][date_end]" value="" class="date input-small"></td>';
        html += '	<td class="column-action"><a onclick="$(\'#special-row' + special_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
        html += '</tr>';

        $('#special tbody').append(html);

<?php if ($this->config->get('p3adminrebooted_select2')) { ?>
                    $('#special-row' + special_row + ' select').select2();
<?php } ?>

                special_row++;
            }
</script>
<script type="text/javascript"><!--
    var image_row = <?php echo $image_row; ?>;

    function addImage() {
        html  = '<tbody id="image-row' + image_row + '">';
        html += '  <tr>';
        html += '    <td class="column-image"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="thumb' + image_row + '" /><input type="hidden" name="product_image[' + image_row + '][image]" value="" id="image' + image_row + '" /><br /><a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a><a class="btn" title="<?php echo $text_clear; ?>" onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a></div><div style="float: right; width: 76%; padding-top: 64px;"><span style="color: #666666;">or upload a video from youtube: <span style="color: #000000;"><?php echo $text_link_youtube; ?></span><input type="text" id="video' + image_row + '" name="product_image[' + image_row + '][video]" /></span></div></td>';
        
        html += '    <td class="column-sort"><input type="text" name="product_image[' + image_row + '][sort_order]" value="" class="input-mini"></td>';
        html += '    <td class="column-action"><a onclick="$(\'#image-row' + image_row  + '\').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
        html += '  </tr>';
        html += '</tbody>';
	
        $('#images tfoot').before(html);
	
        image_row++;
    }
    //--></script> 
<!--script>
var image_row = <?php /* echo $image_row; ?>;

  function addImage() {
  html  = '<tr id="image-row' + image_row + '">';
  html += '	<td class="column-image"><div class="image">';
  html += '		<img src="<?php echo $no_image; ?>" alt="" id="thumb' + image_row + '"><input type="hidden" name="product_image[' + image_row + '][image]" value="" id="image' + image_row + '"><br><br>';
  html += '		<a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>';
  html += '		<a class="btn" title="<?php echo $text_clear; ?>" onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>';
  html += '	</div></td>';
  html += '	<td class="column-sort"><input type="text" name="product_image[' + image_row + '][sort_order]" value="" class="input-mini"></td>';
  html += '	<td class="column-action"><a onclick="$(\'#image-row' + image_row  + '\').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; */ ?></span></a></td>';
        html += '</tr>';

        $('#images tbody').append(html);

        image_row++;
}
</script-->

<?php echo $footer; ?>