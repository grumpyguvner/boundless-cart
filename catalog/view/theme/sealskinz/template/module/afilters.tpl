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
        <div class="box-heading"><?php echo $heading_title; ?></div>
        <div class="box-content">
            <div class="box-category">
                <form action="<?php echo $href_no_filters; ?>" method="get" name="afilter" id="afilter">
                    <input type="hidden" name="sort" value="<?php echo $sort; ?>" />
                    <input type="hidden" name="order" value="<?php echo $order; ?>" />
                    <input type="hidden" name="limit" value="<?php echo $limit; ?>" />
                    <input type="hidden" name="page" value="<?php echo $page; ?>" />
                    <div class="accordion">
                        <?php
                        if ($categories) {
                            foreach ($categories as $category_group) {
                            ?>
                                    <div class="accordion-group" id="<?php echo 'accordion' . ++$cnt; ?>">
                                        <div class="accordion-heading">
                                            <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle"><?php echo $category_group['name']; ?></a>
                                        </div>
                                        <div class="accordion-body in collapse" id="<?php echo 'collapse' . $cnt; ?>">
                                            <div class="accordion-inner">
                                                <div class="box-content">
                                                    <div class="box-category">
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
                                                    <ul>
                                                        <?php
                                                        if ($attribute['name'] == 'Thermal Rating') {
                                                            echo '<li class="thermal">';
                                                            foreach ($attribute['values'] as $value) {
                                                                if (isset($myAttributes[$attribute['attribute_id']]) && in_array(urlencode($value), $myAttributes[$attribute['attribute_id']])) {
                                                                    ?>
                                                                    <label class="<?php echo 'therm' . $value; ?> thermalChecked"><input type="checkbox" name="<?php echo 'att_filters[' . $attribute['attribute_id'] . '][]' ?>" value="<?php echo $value; ?>" checked="checked" /><?php echo $value; ?></label>
                                                                <?php } else { 
                                                                    ?>
                                                                    <label class="<?php echo 'therm' . $value; ?>"><input type="checkbox" name="<?php echo 'att_filters[' . $attribute['attribute_id'] . '][]' ?>" value="<?php echo $value; ?>" /><?php echo $value; ?></label>
                                                                <?php }
                                                            }
                                                            echo '</li>';
                                                        } else {
                                                            foreach ($attribute['values'] as $value) {

                                                                if (isset($myAttributes[$attribute['attribute_id']]) && in_array(urlencode($value), $myAttributes[$attribute['attribute_id']])) {
                                                                    ?>
                                                                    <li><label class="checkbox"><input type="checkbox" name="<?php echo 'att_filters[' . $attribute['attribute_id'] . '][]' ?>" value="<?php echo $value; ?>" checked="checked" /> <?php echo $value; ?></label></li>
                                                                <?php } else { ?>

                                                                    <li><label class="checkbox"><input type="checkbox" name="<?php echo 'att_filters[' . $attribute['attribute_id'] . '][]' ?>" value="<?php echo $value; ?>" /> <?php echo $value ?></label></li>
                                                                    <?php
                                                                }
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
                    </div>
                </form>
            </div>
        </div>
    </div>
<?php } ?>
<script type="text/javascript">
    $('#afilter .thermal input').change(function () {
        if ($(this).is(':checked'))
        {
            $(this).parent('label').addClass('thermalChecked');
        } else {
            $(this).parent('label').removeClass('thermalChecked');
        }
    });
    $('#afilter .thermal label').click(function () {
        if ($(this).find('input').is(':checked'))
        {
            $(this).find('input').attr('checked', false);
        } else {
            $(this).find('input').attr('checked', 'checked');
        }
        $(this).find('input').trigger('change');
    });
    $('#afilter input').change(function () {
        $('#afilter').trigger('submit');
    });
    $('#cfilter input').change(function () {
        $('#afilter').trigger('submit');
    });
</script>