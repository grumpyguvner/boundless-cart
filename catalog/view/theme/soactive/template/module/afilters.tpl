<?php

    $cnt = 0;
    $myCategories = array();
    $myAttributes = array();

    if (isset($filters)) {
        foreach ($filters as $filter) {
            switch ($filter['type']) {
                case "category":
                    $myCategories[$filter['group']][] = $filter['value'];
                    break;
                case "attribute":
                    $myAttributes[$filter['group']][] = $filter['value'];
                    break;
                default:
                    //ignore
                    break;
            }
        }
    }
    
     if ($attributes || $categories) {
    ?>
    <div class="aFilterbox box">
        
        <div class="afilterContent">
            
                <form action="" method="get" name="afilter" id="afilter">
                    <input type="hidden" name="sort" value="<?php echo $sort; ?>" />
                    <input type="hidden" name="order" value="<?php echo $order; ?>" />
                    <input type="hidden" name="limit" value="<?php echo $limit; ?>" />
                    <input type="hidden" name="page" value="<?php echo $page; ?>" />
                    <div class="accordion">
                        <?php
                        $categories = array();
                        
                        $categories[] = array('name' => 'REFINE BY Product',
                                              'children' => array());
                        
                        
                        $categories[] = array('name' => 'REFINE BY Sport',
                                              'children' => array());
                        
                        
                        $categories[] = array('name' => 'REFINE BY Brand',
                                              'children' => array());
                        
                        if ($categories) {
                            foreach ($categories as $category_group) {
                            ?>
                                    <div class="accordion-group" id="<?php echo 'accordion' . ++$cnt; ?>">
                                        <div class="accordion-heading">
                                            <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle collapsed"><?php echo strtoupper($category_group['name']); ?></a>
                                        </div>
                                        <div class="accordion-body collapse" id="<?php echo 'collapse' . $cnt; ?>">
                                            <div class="accordion-inner">
                                                <div class="box-content">
                                                    <div class="box-category">
                                                        <div class="reset"><a href="#">clear</a></div>
                                                        <ul>
                                                            <?php foreach ($category_group['children'] as $category) { ?>
                                                                <?php if ($cat_id != $category['category_id']) { ?>
                                                                    <?php if (isset($myCategories[$category_group['category_id']]) && in_array($category['category_id'], $myCategories[$category_group['category_id']])) { ?> 
                                                                        <li><label class="checkbox"><input type="checkbox" name="cat_filters[<?php echo $category_group['category_id']; ?>][<?php echo $category['category_id']; ?>]" value="<?php echo $category['category_id']; ?>" checked="checked" /> <?php echo $category['name']; ?></label></li>
                                                                    <?php } else { ?>
                                                                        <li><label class="checkbox"><input type="checkbox" name="cat_filters[<?php echo $category_group['category_id']; ?>][<?php echo $category['category_id']; ?>]" value="<?php echo $category['category_id']; ?>" /> <?php echo $category['name']; ?></label></li>
                                                                    <?php } ?>
                                                                <?php } else { ?>
                                                                        <li><label class="checkbox"><input type="checkbox" name="cat_filters[<?php echo $category_group['category_id']; ?>][<?php echo $category['category_id']; ?>]" value="<?php echo $category['category_id']; ?>" checked="checked" disabled /> <?php echo $category['name']; ?></label><input type="hidden" name="cat_filters[<?php echo $category_group['category_id']; ?>][<?php echo $category['category_id']; ?>]" value="<?php echo $category['category_id']; ?>" /></li>
                                                                <?php } ?>
                                                            <?php } ?>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                            <?php
                            }
                        }
                        if ($attributes) {
                            foreach ($attributes as $attribute) {
                                ?>
                                <div class="accordion-group" id="<?php echo 'accordion' . ++$cnt; ?>">
                                    <div class="accordion-heading">
                                        <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle"><?php echo $attribute['name']; ?></a>
                                    </div>
                                    <div class="accordion-body in collapse" id="<?php echo 'collapse' . $cnt; ?>">
                                        <div class="accordion-inner">
                                            <div class="box-content">
                                                <div class="box-category">
                                                    <div class="reset"><a href="#">clear</a></div>
                                                    <ul>
                                                        <?php
                                                        
                                                        foreach ($attribute['values'] as $value) {

                                                            if (isset($myAttributes[$attribute['attribute_id']]) && in_array(urlencode($value), $myAttributes[$attribute['attribute_id']])) {
                                                                ?>
                                                                <li><label class="checkbox"><input type="checkbox" name="<?php echo 'att_filters[' . $attribute['attribute_id'] . '][]' ?>" value="<?php echo $value; ?>" checked="checked" /> <?php echo $value; ?></label></li>
                                                            <?php } else { ?>

                                                                <li><label class="checkbox"><input type="checkbox" name="<?php echo 'att_filters[' . $attribute['attribute_id'] . '][]' ?>" value="<?php echo $value; ?>" /> <?php echo $value ?></label></li>
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
                        }
                        ?>
                        <div class="accordion-group" id="<?php echo 'accordion' . ++$cnt; ?>">
                                    <div class="accordion-heading">
                                        <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle"><?php echo $text_range; ?></a>
                                    </div>
                                    <div class="accordion-body in collapse" id="<?php echo 'collapse' . $cnt; ?>">
                                        <div class="accordion-inner">
                                            <div class="box-content">
                                                <div class="box-category">
                                                    <div class="reset"><a href="#">clear</a></div>
                                                    <ul>
                                                        <li>
  <input type="hidden" id="priceslide" name="item_filters[price][]" style="border: 0; color: #f6931f; font-weight: bold;" />

 <div id="slider-range">
    <div class="slider"></div>

    <div class="from"><?php echo $text_low; ?></div>
    <div class="to"><?php echo $text_max; ?></div>
 </div>

<script>
  $(function() {
    $( "#slider-range .slider" ).slider({
      range: true,
      min: 0,
      max: 500,
      step: 5,
      values: [ 0, 500 ],
      slide: function( event, ui ) {
        $( "#priceslide" ).val( "" + ui.values[ 0 ] + ":" + ui.values[ 1 ] );
        $( "#slider-range .from" ).html( '£' + ui.values[ 0 ]);
        $( "#slider-range .to" ).html( '£' + ui.values[ 1 ]);
      },
      change: function( event, ui ) {
        $( "#priceslide" ).val( "" + ui.values[ 0 ] + ":" + ui.values[ 1 ] );
        $( "#slider-range .from" ).html( '£' + ui.values[ 0 ]);
        $( "#slider-range .to" ).html( '£' + ui.values[ 1 ]);
        
        //$('#afilter').trigger('submit');
      }
    });
  });
  </script>
                                                        </li>
                                                        
                                                        <?php

                                                            if (isset($myAttributes[$attribute['attribute_id']]) && in_array(urlencode($value), $myAttributes[$attribute['attribute_id']])) {
                                                                ?>
                                                                <li class="filterSale"><label class="checkbox"><input type="checkbox" name="<?php echo 'item_filters[sale][]' ?>" value="Sale" checked="checked" /> <?php echo $text_sale_item; ?></label></li>
                                                            <?php } else { ?>

                                                                <li class="filterSale"><label class="checkbox"><input type="checkbox" name="<?php echo 'item_filters[sale][]' ?>" value="Sale" /> <?php echo $text_sale_item; ?></label></li>
                                                                <?php
                                                            }
                                                        ?>
                                                                
                                                        <?php

                                                            if (isset($myAttributes[$attribute['attribute_id']]) && in_array(urlencode($value), $myAttributes[$attribute['attribute_id']])) {
                                                                ?>
                                                                <li class="filterNew"><label class="checkbox"><input type="checkbox" name="<?php echo 'item_filters[new][]' ?>" value="New" checked="checked" /> <?php echo $text_new_item; ?></label></li>
                                                            <?php } else { ?>

                                                                <li class="filterNew"><label class="checkbox"><input type="checkbox" name="<?php echo 'item_filters[new][]' ?>" value="New" /> <?php echo $text_new_item; ?></label></li>
                                                                <?php
                                                            }
                                                        ?>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                    </div>
                </form>
            
        </div>
    </div>
<?php } ?>
<script type="text/javascript">
    $('#afilter input').change(function () {
        //$('#afilter').trigger('submit');
    });
    $('#cfilter input').change(function () {
        //$('#afilter').trigger('submit');
    });
    
    $('.reset a').click(function (e) {
        e.preventDefault();
        $(this).parents('.box-content').find('input:checked').attr('checked', false).trigger('change');
        
        $(this).parents('.box-content').find("#slider-range .slider" ).slider( "option", "values", [ 0, 500 ] );
        
    });
</script>