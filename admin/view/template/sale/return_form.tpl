<?php echo $header; ?>

<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <div class="box">

        <div class="heading">
            <h1><i class="icon-back"></i> <?php echo $heading_title; ?></h1>
            <?php if ($error_warning) { ?>
                <?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
            <?php } ?>
            <div class="buttons form-actions form-actions-top">
                <?php echo p3html::tb_form_button_save($button_save); ?>
                <?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
            </div>
        </div>

        <div class="content">

            <ul class="htabs nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#tab-return"><i class="icon-eye"></i> <?php echo $tab_return; ?></a></li>
                <li><a data-toggle="tab" href="#tab-product"><i class="icon-list"></i> <?php echo $tab_product; ?></a></li>
            </ul>

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
                <div class="tab-content">

                    <div class="tab-pane active" id="tab-return">
                        <table class="form">
                            <div class="control-group<?php if ($error_order_id) { ?> error<?php } ?>">
                                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_order_id; ?></label>
                                <div class="controls">
                                    <input type="text" name="order_id" value="<?php echo $order_id; ?>" class="span2">
                                    <?php if ($error_order_id) { ?>
                                        <span class="error help-block"><?php echo $error_order_id; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_date_ordered; ?></label>
                                <div class="controls">
                                    <input type="text" name="date_ordered" value="<?php echo $date_ordered; ?>" class="date input-small">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_customer; ?></label>
                                <div class="controls">
                                    <input type="text" name="customer" value="<?php echo $customer; ?>" class="span3">
                                    <input type="hidden" name="customer_id" value="<?php echo $customer_id; ?>">
                                </div>
                            </div>
                            <div class="control-group<?php if ($error_firstname) { ?> error<?php } ?>">
                                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_firstname; ?></label>
                                <div class="controls">
                                    <input type="text" name="firstname" value="<?php echo $firstname; ?>" class="span4">
                                    <?php if ($error_firstname) { ?>
                                        <span class="error help-block"><?php echo $error_firstname; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group<?php if ($error_lastname) { ?> error<?php } ?>">
                                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_lastname; ?></label>
                                <div class="controls">
                                    <input type="text" name="lastname" value="<?php echo $lastname; ?>" class="span3">
                                    <?php if ($error_lastname) { ?>
                                        <span class="error help-block"><?php echo $error_lastname; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group<?php if ($error_email) { ?> error<?php } ?>">
                                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_email; ?></label>
                                <div class="controls">
                                    <input type="text" name="email" value="<?php echo $email; ?>" class="span4">
                                    <?php if ($error_email) { ?>
                                        <span class="error help-block"><?php echo $error_email; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group<?php if ($error_telephone) { ?> error<?php } ?>">
                                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_telephone; ?></label>
                                <div class="controls">
                                    <input type="text" name="telephone" value="<?php echo $telephone; ?>" class="span2">
                                    <?php if ($error_telephone) { ?>
                                        <span class="error help-block"><?php echo $error_telephone; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                        </table>
                    </div>

                    <div class="tab-pane" id="tab-product">
                        <div class="form">
                            <div class="control-group<?php if ($error_product) { ?> error<?php } ?>">
                                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_product; ?></label>
                                <div class="controls">
                                    <input type="text" name="product" value="<?php echo $product; ?>" class="span4">
                                    <input type="hidden" name="product_id" value="<?php echo $product_id; ?>">
                                    <?php if ($error_product) { ?>
                                        <span class="error help-block"><?php echo $error_product; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_model; ?></label>
                                <div class="controls">
                                    <input type="text" name="model" value="<?php echo $model; ?>" class="span2">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_quantity; ?></label>
                                <div class="controls">
                                    <input type="text" name="quantity" value="<?php echo $quantity; ?>" class="span1 i-mini">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_reason; ?></label>
                                <div class="controls">
                                    <select name="return_reason_id" class="span3">

                                        <?php echo p3html::oc_return_reason_options($return_reasons, $return_reason_id); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_opened; ?></label>
                                <div class="controls">
                                    <select name="opened" class="span2">
                                        <?php echo p3html::oc_opened_options($this->language, $opened, "opened"); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_comment; ?></label>
                                <div class="controls">
                                    <textarea name="comment" class="input-block-level" rows="6"><?php echo $comment; ?></textarea>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_action; ?></label>
                                <div class="controls">
                                    <select name="return_action_id" class="span2">
                                        <option value="0">&nbsp;</option>
                                        <?php echo p3html::oc_return_action_options($return_actions, $return_action_id); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_return_status; ?></label>
                                <div class="controls">
                                    <select name="return_status_id" class="span2">
                                        <?php echo p3html::oc_return_status_options($return_statuses, $return_status_id); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </form>

        </div>

    </div>
</div>

<script>
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

    $('input[name=\'customer\']').catcomplete({
        delay: 0,
        source: function(request, response) {
            $.ajax({
                url: 'index.php?route=sale/customer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
                dataType: 'json',
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            category: item.customer_group,
                            label: item.name,
                            value: item.customer_id,
                            firstname: item.firstname,
                            lastname: item.lastname,
                            email: item.email,
                            telephone: item.telephone
                        }
                    }));
                }
            });

        },
        select: function(event, ui) {
            $('input[name=\'customer\']').attr('value', ui.item.label);
            $('input[name=\'customer_id\']').attr('value', ui.item.value);
            $('input[name=\'firstname\']').attr('value', ui.item.firstname);
            $('input[name=\'lastname\']').attr('value', ui.item.lastname);
            $('input[name=\'email\']').attr('value', ui.item.email);
            $('input[name=\'telephone\']').attr('value', ui.item.telephone);

            return false;
        },
        focus: function(event, ui) {
            return false;
        }
    });
</script>
<script>
    $('input[name=\'product\']').autocomplete({
        delay: 0,
        source: function(request, response) {
            $.ajax({
                url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
                dataType: 'json',
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            label: item.name,
                            value: item.product_id,
                            model: item.model
                        }
                    }));
                }
            });
        },
        select: function(event, ui) {
            $('input[name=\'product_id\']').attr('value', ui.item.value);
            $('input[name=\'product\']').attr('value', ui.item.label);
            $('input[name=\'model\']').attr('value', ui.item.model);

            return false;
        },
        focus: function(event, ui) {
            return false;
        }
    });
</script>

<script>
    //$(document).ready(function() {
    //	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
    //});
</script>

<?php echo $footer; ?>