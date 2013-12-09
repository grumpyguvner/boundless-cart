<?php echo $header; ?>

<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <div class="box">
        <div class="heading">
            <h1><i class="icon-ticket"></i> <?php echo $heading_title; ?></h1>
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
                <li class="active"><a data-toggle="tab" href="#tab-general"><i class=icon-eye></i> <?php echo $tab_general; ?></a></li>
                <?php if ($coupon_id) { ?>
                    <li><a data-toggle="tab" href="#tab-history"><i class=icon-clock></i> <?php echo $tab_coupon_history; ?></a></li>
                <?php } ?>
            </ul>

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
                <div class="tab-content">
                    <div class="tab-pane active" id="tab-general">
                        <div class="form">
                            <div class="control-group<?php if ($error_name) { ?> error<?php } ?>">
                                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
                                <div class="controls">
                                    <input type="text" name="name" value="<?php echo $name; ?>" class="span3">
                                    <?php if ($error_name) { ?>
                                        <span class="error help-block"><?php echo $error_name; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group<?php if ($error_code) { ?> error<?php } ?>">
                                <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_code; ?></label>
                                <div class="controls">
                                    <input type="text" name="code" value="<?php echo $code; ?>" class="span2">
                                    <?php if ($error_code) { ?>
                                        <span class="error help-block"><?php echo $error_code; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_type; ?></label>
                                <div class="controls">
                                    <select name="type" class="span2">
                                        <?php echo p3html::oc_rate_type_options($this->language, $type); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_discount; ?></label>
                                <div class="controls">
                                    <input type="text" name="discount" value="<?php echo $discount; ?>" class="span2">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_total; ?></label>
                                <div class="controls">
                                    <input type="text" name="total" value="<?php echo $total; ?>" class="span2">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_logged; ?></label>
                                <div class="controls">
                                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'logged', $logged); ?>
                                    <?php } else { ?>
                                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'logged', $logged); ?>
                                    <?php } ?>
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
                                <label class="control-label"><?php echo $entry_category; ?></label>
                                <div class="controls">
                                    <div class="scrollbox">
                                        <?php $class = 'odd'; ?>
                                        <?php foreach ($categories as $category) { ?>
                                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                            <div class="<?php echo $class; ?>">
                                                <label class="checkbox inline">
                                                    <input type="checkbox" name="category[]" value="<?php echo $category['category_id']; ?>">
                                                    <?php echo $category['name']; ?>
                                                </label>
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_product; ?></label>
                                <div class="controls">
                                    <input type="text" name="product" value="" class="span3">
                                    <br><br>
                                    <div id="coupon-product" class="scrollbox">
                                        <?php $class = 'odd'; ?>
                                        <?php foreach ($coupon_product as $coupon_product) { ?>
                                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                            <div id="coupon-product<?php echo $coupon_product['product_id']; ?>" class="<?php echo $class; ?>">
                                                <i class="remove btn btn-mini icon-trash" title="remove"></i>
                                                <?php echo $coupon_product['name']; ?>
                                                <input type="hidden" name="coupon_product[]" value="<?php echo $coupon_product['product_id']; ?>">
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_date_start; ?></label>
                                <div class="controls">
                                    <input type="text" name="date_start" value="<?php echo $date_start; ?>" size="12" class="date span2" id="date-start">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_date_end; ?></label>
                                <div class="controls">
                                    <input type="text" name="date_end" value="<?php echo $date_end; ?>" size="12" class="date span2" id="date-end">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_uses_total; ?></label>
                                <div class="controls">
                                    <input type="text" name="uses_total" value="<?php echo $uses_total; ?>" class="span1">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_uses_customer; ?></label>
                                <div class="controls">
                                    <input type="text" name="uses_customer" value="<?php echo $uses_customer; ?>" class="span1">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_status; ?></label>
                                <div class="controls">
                                    <select name="status" class="span2">
                                        <?php echo p3html::oc_status_options($this->language, $status); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <?php if ($coupon_id) { ?>
                        <div class="tab-pane" id="tab-history">
                            <div id="history"></div>
                        </div>
                    <?php } ?>

                </div>
            </form>

        </div>
    </div>
</div>

<script>
    $('input[name=\'category[]\']').on('change', function() {
        var filter_category_id = this;

        $.ajax({
            url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_category_id=' +  filter_category_id.value + '&limit=10000',
            dataType: 'json',
            success: function(json) {
                for (i = 0; i < json.length; i++) {
                    if ($(filter_category_id).attr('checked') == 'checked') {
                        $('#coupon-product' + json[i]['product_id']).remove();

                        $('#coupon-product').append('<div id="coupon-product' + json[i]['product_id'] + '"><i class="remove btn btn-mini icon-trash" title="remove"></i> ' + json[i]['name'] + '<input type="hidden" name="coupon_product[]" value="' + json[i]['product_id'] + '"></div>');
                    } else {
                        $('#coupon-product' + json[i]['product_id']).remove();
                    }
                }

                $('#coupon-product div:odd').attr('class', 'odd');
                $('#coupon-product div:even').attr('class', 'even');
            }
        });
    });

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
                            value: item.product_id
                        }
                    }));
                }
            });
        },
        select: function(event, ui) {
            $('#coupon-product' + ui.item.value).remove();

            $('#coupon-product').append('<div id="coupon-product' + ui.item.value + '"><i class="remove btn btn-mini icon-trash" title="remove"></i> ' + ui.item.label + '<input type="hidden" name="coupon_product[]" value="' + ui.item.value + '"></div>');

            $('#coupon-product div:odd').attr('class', 'odd');
            $('#coupon-product div:even').attr('class', 'even');

            $('input[name=\'product\']').val('');

            return false;
        },
        focus: function(event, ui) {
            return false;
        }
    });

    $('#coupon-product div i').live('click', function() {
        $(this).parent().remove();

        $('#coupon-product div:odd').attr('class', 'odd');
        $('#coupon-product div:even').attr('class', 'even');
    });
</script>

<!--<script>
$('#date-start').datepicker({dateFormat: 'yy-mm-dd'});
$('#date-end').datepicker({dateFormat: 'yy-mm-dd'});
</script>-->

<?php if ($coupon_id) { ?>
    <script>
        $('#history .pagination a').on('click', function() {
            $('#history').load(this.href);
            return false;
        });

        $('#history').load('index.php?route=sale/coupon/history&token=<?php echo $token; ?>&coupon_id=<?php echo $coupon_id; ?>');
    </script>
<?php } ?>

<?php echo $footer; ?>