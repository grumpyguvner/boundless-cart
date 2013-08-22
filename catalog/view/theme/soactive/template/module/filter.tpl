<?php
if ($filter_groups || $options) {
    ?>
    <div class="aFilterbox box">
        <div class="afilterContent">
            <form action="<?php echo $action; ?>" method="get" name="afilter" id="afilter">
                <div class="accordion">
                    <?php
                    if ($filter_groups) {
                        foreach ($filter_groups as $filter_group) {
                            if ($filter_group['count'])
                            {
                            ?>
                            <div class="filter_category accordion-group" id="<?php echo 'accordion' . ++$cnt; ?>">
                                <div class="accordion-heading">
                                    <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle"><?php echo $filter_group['name']; ?></a>
                                </div>
                                <div class="accordion-body in collapse" id="<?php echo 'collapse' . $cnt; ?>">
                                    <div class="accordion-inner">
                                        <div class="box-content">
                                            <div class="box-category">
                                                <div class="reset"><a href="#">clear</a></div>
                                                <ul>
                                                    <?php foreach ($filter_group['filter'] as $filter) {
                                                        if ($filter['count'])
                                                        {
                                                          if (in_array($filter['filter_id'], $filter_category)) { ?>
                                                            <li><label class="checkbox"><input type="checkbox" value="<?php echo $filter['filter_id']; ?>" id="filter<?php echo $filter['filter_id']; ?>" checked="checked" /> <?php echo $filter['name']; ?></label></li>
                                                        <?php } else { ?>
                                                            <li><label class="checkbox"><input type="checkbox" value="<?php echo $filter['filter_id']; ?>" id="filter<?php echo $filter['filter_id']; ?>" /> <?php echo $filter['name']; ?></label></li>
                                                        <?php } 
                                                        }
                                                        } ?>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <?php
                            }
                        }
                    }
                    if ($options) {
                        foreach ($options as $option) {
                            if ($option['count'])
                            {
                            ?>
                            <div class="filter_option accordion-group" id="<?php echo 'accordion' . ++$cnt; ?>">
                                <div class="accordion-heading">
                                    <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle"><?php echo $option['name']; ?></a>
                                </div>
                                <div class="accordion-body in collapse" id="<?php echo 'collapse' . $cnt; ?>">
                                    <div class="accordion-inner">
                                        <div class="box-content">
                                            <div class="box-category">
                                                <div class="reset"><a href="#">clear</a></div>
                                                <ul>
                                                    <?php foreach ($option['option_value'] as $option_value) {
                                                        if ($option_value['count'])
                                                        {
                                                            if (in_array($option_value['option_value_id'], $filter_option)) { ?>
                                                            <li><label class="checkbox"><input type="checkbox" value="<?php echo $option_value['option_value_id']; ?>" id="option<?php echo $option_value['option_value_id']; ?>" checked="checked" /> <?php echo $option_value['name']; ?></label></li>
                                                        <?php } else { ?>
                                                            <li><label class="checkbox"><input type="checkbox" value="<?php echo $option_value['option_value_id']; ?>" id="option<?php echo $option_value['option_value_id']; ?>" /> <?php echo $option_value['name']; ?></label></li>
                                                        <?php } 
                                                        }
                                                    } ?>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <?php
                            }
                        }
                    }
                    if ($filter_product_max_range || $has_sale || $has_new)
                    {
                    ?>
                    <div class="filter_product accordion-group" id="<?php echo 'accordion' . ++$cnt; ?>">
                        <div class="accordion-heading">
                            <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle">PRICE RANGE</a>
                        </div>
                        <div class="accordion-body in collapse" id="<?php echo 'collapse' . $cnt; ?>">
                            <div class="accordion-inner">
                                <div class="box-content">
                                    <div class="box-category">
                                        <div class="reset"><a href="#">clear</a></div>
                                        <ul>
                                            <?php
                                            if ($filter_product_max_range) {
                                            ?>
                                            <li>
                                                <div id="slider-range">
                                                    <div class="slider"></div>

                                                    <div class="from"><?php echo $this->currency->getSymbolLeft() . $filter_product_min_price . $this->currency->getSymbolRight() ?></div>
                                                    <div class="to"><?php echo $this->currency->getSymbolLeft() . $filter_product_max_price . $this->currency->getSymbolRight() ?></div>
                                                </div>
                                            </li>
                                            <?php
                                            }
                                            if ($has_sale) {
                                                if (in_array('sale', $filter_product)) {
                                                    ?>
                                                    <li class="filterSale"><label class="checkbox"><input type="checkbox" value="sale" checked="checked" /> Sale items only</label></li>
                                                <?php } else { ?>
                                                    <li class="filterSale"><label class="checkbox"><input type="checkbox" value="sale" /> Sale items only</label></li>
                                                    <?php
                                                }
                                            }
                                            if ($has_new) {
                                                if (in_array('new', $filter_product)) {
                                                    ?>
                                                    <li class="filterNew"><label class="checkbox"><input type="checkbox" value="new" checked="checked" /> New items only</label></li>
                                                <?php } else { ?>
                                                    <li class="filterNew"><label class="checkbox"><input type="checkbox" value="new" /> New items only</label></li>
                                                <?php
                                                }
                                            }
                                            ?>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <?php
                    }
                    ?>
                </div>
                <input type="hidden" name="filter" value="">
                <input type="hidden" name="option" value="">
                <input type="hidden" id="filter_product" name="product" value="">
            </form>

        </div>
    </div>
<?php } ?>
<script>
    $(function() {
        $( "#slider-range .slider" ).slider({
            range: true,
            min: <?php echo $filter_product_min_range ?>,
            max: <?php echo $filter_product_max_range ?>,
            step: 5,
            values: [ <?php echo $filter_product_min_price ?>, <?php echo $filter_product_max_price ?> ],
            slide: function( event, ui ) {
                if (Number(ui.values[ 0 ]) == <?php echo $filter_product_min_range ?> && Number(ui.values[ 1 ]) == <?php echo $filter_product_max_range ?>)
                {
                     $( "#filter_product" ).val('');
                } else {
                    $( "#filter_product" ).val( "range:" + ui.values[ 0 ] + ":" + ui.values[ 1 ] );
                }
                $( "#slider-range .from" ).html( '<?php echo  $this->currency->getSymbolLeft() ?>' + ui.values[ 0 ] + '<?php echo  $this->currency->getSymbolRight() ?>');
                $( "#slider-range .to" ).html( '<?php echo  $this->currency->getSymbolLeft() ?>' + ui.values[ 1 ] + '<?php echo  $this->currency->getSymbolRight() ?>');
            },
            change: function( event, ui ) {
                if (Number(ui.values[ 0 ]) == <?php echo $filter_product_min_range ?> && Number(ui.values[ 1 ]) == <?php echo $filter_product_max_range ?>)
                {
                     $( "#filter_product" ).val('');
                } else {
                    $( "#filter_product" ).val( "range:" + ui.values[ 0 ] + ":" + ui.values[ 1 ] );
                }
                $( "#slider-range .from" ).html( '<?php echo  $this->currency->getSymbolLeft() ?>' + Number(ui.values[ 0 ]) + '<?php echo  $this->currency->getSymbolRight() ?>');
                $( "#slider-range .to" ).html( '<?php echo  $this->currency->getSymbolLeft() ?>' + Number(ui.values[ 1 ]) + '<?php echo  $this->currency->getSymbolRight() ?>');

                $('#afilter').trigger('submit');
            }
        });
        
        if (<?php echo $filter_product_min_price ?> != <?php echo $filter_product_min_range ?> || <?php echo $filter_product_max_price ?> != <?php echo $filter_product_max_range ?>)
        {
            $( "#filter_product" ).val( "range:" + <?php echo $filter_product_min_price ?> + ":" + <?php echo $filter_product_max_price ?> );
        }
    });
</script>
<script type="text/javascript">
    $('#afilter input').change(function () {
        $('#afilter').trigger('submit');
    });
    
    $('.reset a').click(function (e) {
        e.preventDefault();
        $(this).parents('.box-content').find('input:checked').attr('checked', false).trigger('change');
        
        $(this).parents('.box-content').find("#slider-range .slider" ).slider( "option", "values", [ <?php echo $filter_product_min_range ?>, <?php echo $filter_product_max_range ?> ] );
        
    });
</script>
<script type="text/javascript"><!--
    $('#afilter').submit(function() {
        filter = [];
        option = [];
        product = [];
	
        $('.filter_category input[type=\'checkbox\']:checked').each(function(element) {
            filter.push(this.value);
        });
        
        $('.filter_option input[type=\'checkbox\']:checked').each(function(element) {
            option.push(this.value);
        });
        
        if ($('#filter_product').val() != '')
        {
            product[0] = $('#filter_product').val();
        }
        $('.filter_product input[type=\'checkbox\']:checked').each(function(element) {
            product.push(this.value);
        });
        
        if (filter.length)
        {
            $('#afilter input[name=\'filter\']').attr('disabled', false).val(filter.join(','));
        } else {
            $('#afilter input[name=\'filter\']').attr('disabled', 'disabled').val();
        }
        
        if (option.length)
        {
            $('#afilter input[name=\'option\']').attr('disabled', false).val(option.join(','));
        } else {
            $('#afilter input[name=\'option\']').attr('disabled', 'disabled').val();
        }
        
        if (product.length)
        {
            $('#afilter input[name=\'product\']').attr('disabled', false).val(product.join(','));
        } else {
            $('#afilter input[name=\'product\']').attr('disabled', 'disabled').val();
        }
	
        return true;
    });
    //--></script> 