<?php echo $header; ?>
<div id="breadcrumb">
    <div class="container">
        <?php
        foreach ($breadcrumbs as $breadcrumb) {
            echo $breadcrumb['separator'] . '<a href="' . $breadcrumb['href'] . '">' . $breadcrumb['text'] . '</a>';
        }
        ?>
    </div>
</div>
<div id="notification" class="alert-success">
    <?php if (isset($success) && $success) { ?>
        <div class="success"><?php echo $success; ?></div>
        <?php
    }
    if (isset($error_warning) && $error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
        <?php
    }
    if (isset($attention) && $attention) {
        ?>
        <div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
        <?php
    }
    ?>
</div>
<div id="content-back">
    <div class="green-bar">  
        <div id="mainContainer" class="container"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content">
                <?php echo $content_top; ?>
                <div class="product-info"><div class="product-img">
                        <?php if ($thumb || $images) { ?>
                            <div class="image" id="wrap-image">
                                <?php if ($thumb) { ?>
                                    <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" data-colorbox="" />
                                <?php } ?>
                            </div>
                            <?php if ($images) { ?>
                                <div class="image-additional">
                                    <?php
                                    if ($additional) {
                                        ?><a href="<?php echo $popup; ?>" target="_blank" class="colorbox imageAdditional" rel="colorbox" data-main="<?php echo $thumb; ?>"><img src="<?php echo $additional; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="imageAdditional"/><?php
                        }
                        foreach ($images as $image) {
                            if (empty($image['video'])) {
                                            ?><a href="<?php echo $image['popup']; ?>" target="_blank" class="colorbox imageAdditional" rel="colorbox" data-main="<?php echo $image['main']; ?>"><img src="<?php echo $image['thumb']; ?>" alt="" /></a><?php
                            } else {
                                            ?><a href="http://www.youtube.com/watch?v=<?php echo $image['video']; ?>" class="videoAdditional" data-video="<?php echo $image['video']; ?>" target="_blank" style="line-height:<?php echo $additionalHeight; ?>px;height:<?php echo $additionalHeight; ?>px;width:<?php echo $additionalWidth; ?>px;"><img src="http://img.youtube.com/vi/<?php echo $image['video']; ?>/0.jpg" alt="" /><span class="play-button" style="height:<?php echo $additionalHeight; ?>px;width:<?php echo $additionalWidth; ?>px;"></span></a><?php
                                }
                            }
                                    ?>
                                </div>
                            <?php } ?>
                        <?php } ?>

                    </div><div class="product-details">
                        <h1><?php echo $heading_title; ?></h1>
                        <?php if ($price) { ?>
                            <div class="price"><span class="text-label"><?php echo $text_price; ?></span>
                                <?php if (!$special) { ?>
                                    <span class="product-price"><?php echo $price; ?></span>
                                <?php } else { ?>
                                    <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
                                <?php } ?>
                                <br />
                                <?php if ($tax) { ?>
                                    <span class="price-tax" style="display: none"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
                                <?php } ?>
                                <?php if ($points) { ?>
                                    <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
                                <?php } ?>
                                <?php if ($discounts) { ?>
                                    <br />
                                    <div class="discount">
                                        <?php foreach ($discounts as $discount) { ?>
                                            <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
                                        <?php } ?>
                                    </div>
                                <?php } ?>
                            </div>
                        <?php } ?>
                        <?php if ($model) { ?>
                            <div class="model"><span class="text-label"><?php echo $text_model; ?></span> <span><?php echo $model; ?></span></div>
                        <?php } ?>

                        <?php if ($options || isset($attribute_groups['Filter'])) { ?>
                            <div class="options">
                        <?php if ($options) { ?>
                                <?php foreach ($options as $option) { ?>
                                    <?php if ($option['type'] == 'select') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                            <?php if ($option['required']) { ?>
                                                <span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b><br />
                                            <select name="option[<?php echo $option['product_option_id']; ?>]">
                                                <option value=""><?php echo $text_select; ?></option>
                                                <?php foreach ($option['option_value'] as $option_value) { ?>
                                                    <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                        <?php if ($option_value['price']) { ?>
                                                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                        <?php } ?>
                                                    </option>
                                                <?php } ?>
                                            </select>
                                        </div>
                                        <br />
                                    <?php } ?>
                                    <?php if ($option['type'] == 'radio') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option-buy">
                                            <input type="hidden" name="quantity" size="2" value="<?php echo $minimum; ?>" class="submit-value" />
                                            <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" class="submit-value" />
                                            <?php foreach ($option['option_value'] as $option_value) { ?>
                                                <label><span><?php echo $option_value['name']; ?>
                                                    <?php if ($option_value['price']) { ?>
                                                        (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                    <?php } ?></span>
                                                    <input type="hidden" id="button-cart-<?php echo $option_value['product_option_value_id']; ?>" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                    <a href="#" class="button button-cart"><?php echo $text_buy ?></a>
                                                </label>
                                            <?php } ?>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'checkbox') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                            <?php if ($option['required']) { ?>
                                                <span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b><br />
                                            <?php foreach ($option['option_value'] as $option_value) { ?>
                                                <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
                                                <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                    <?php if ($option_value['price']) { ?>
                                                        (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                    <?php } ?>
                                                </label>
                                                <br />
                                            <?php } ?>
                                        </div>
                                        <br />
                                    <?php } ?>
                                    <?php if ($option['type'] == 'image') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                            <?php if ($option['required']) { ?>
                                                <span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b><br />
                                            <table class="option-image">
                                                <?php foreach ($option['option_value'] as $option_value) { ?>
                                                    <tr>
                                                        <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
                                                        <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
                                                        <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                                <?php if ($option_value['price']) { ?>
                                                                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                                <?php } ?>
                                                            </label></td>
                                                    </tr>
                                                <?php } ?>
                                            </table>
                                        </div>
                                        <br />
                                    <?php } ?>
                                    <?php if ($option['type'] == 'text') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                            <?php if ($option['required']) { ?>
                                                <span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b><br />
                                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
                                        </div>
                                        <br />
                                    <?php } ?>
                                    <?php if ($option['type'] == 'textarea') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                            <?php if ($option['required']) { ?>
                                                <span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b><br />
                                            <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
                                        </div>
                                        <br />
                                    <?php } ?>
                                    <?php if ($option['type'] == 'file') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                            <?php if ($option['required']) { ?>
                                                <span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b><br />
                                            <input type="button" class="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>"  class="button">
                                            <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
                                        </div>
                                        <br />
                                    <?php } ?>
                                    <?php if ($option['type'] == 'date') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                            <?php if ($option['required']) { ?>
                                                <span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b><br />
                                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
                                        </div>
                                        <br />
                                    <?php } ?>
                                    <?php if ($option['type'] == 'datetime') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                            <?php if ($option['required']) { ?>
                                                <span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b><br />
                                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
                                        </div>
                                        <br />
                                    <?php } ?>
                                    <?php if ($option['type'] == 'time') { ?>
                                        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                            <?php if ($option['required']) { ?>
                                                <span class="required">*</span>
                                            <?php } ?>
                                            <b><?php echo $option['name']; ?>:</b><br />
                                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
                                        </div>
                                        <br />
                                    <?php } ?>
                                <?php } ?>
                                <?php } ?>
                                <?php if (isset($attribute_groups['Filter'])) { ?>
                                <div class="rating-top thermal">
                                    <?php
                                    $therm = array();
                                    foreach ($attribute_groups['Filter'] as $attribute_group) {
                                        foreach ($attribute_group['attribute'] as $attribute) {
                                            $therm[] = $attribute['text'];
                                        }
                                    }
                                    for ($i = 1; $i <= 5; $i++) {
                                    ?><div class="therm therm<?php echo $i; if (in_array($i, $therm)) echo ' thermalChecked' ?>"><?php echo $i ?></span></div><?php } ?>
                                </div>
                                <?php } ?>
                            </div>
                        <?php } ?>

                        <?php if ($review_status) { ?>
                            <div class="review">
                                <div class="tools">
                                    <img src="catalog/view/theme/sealskinz/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('#tab-review').trigger('click');">(<?php echo $reviews; ?>)</a><!--&nbsp;&nbsp;|&nbsp;&nbsp;-->
                                    <!-- <a onclick="addToWishList('<?php /* echo $product_id; */ ?>');"><?php /*echo $button_wishlist; */ ?></a>&nbsp;&nbsp;|&nbsp;&nbsp; ><a onclick="addToCompare('<?php /* echo $product_id; */ ?>');"><?php /* echo $button_compare; */ ?></a-->
                                </div>
                                <div class="share"><!-- AddThis Button BEGIN -->
                                    <div class="addthis_default_style"><a class="addthis_button_compact"><?php echo $text_share; ?></a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a></div>
                                    <script type="text/javascript" src="//s7.addthis.com/js/250/addthis_widget.js"></script> 
                                    <!-- AddThis Button END --> 
                                </div>
                            </div>
                        <?php } ?>
                    </div><div class="product-tab<?php if ($news && !empty($news)) echo ' news'?>"> 
                        <ul class="nav nav-tabs" id="productTab">
                            <li class="active"><a href="#productTabDesc"><?php echo $tab_description; ?></a></li>
                            <?php
                            if ($product_tabs) {
                                foreach ($product_tabs as $key => $tab) {
                                        echo '<li><a href="#productTabAttr' . $key . '">' . $tab['name'] . '</a></li>';
                                    }
                            }
                            if ($review_status)
                                echo '<li><a href="#productTabReview" id="tab-review">' . $tab_review . '</a></li>';
                            ?>
                        </ul>
                        <div class="tab-content">
                            <div id="productTabDesc" class="tab-pane active">
                                <p><?php echo $description; ?></p>
                                <p>
                                <?php
                                if ($review_anonymous_status == '1' || $logged) {
                                    ?>
                                    <a class="button-account" onclick="$('#tab-review').trigger('click');"><?php echo $text_write_review ?></a>
                                    <?php
                                } else {
                                    ?>
                                    <p><a class="button-account" href="<?php echo $login ?>"><?php echo $text_write_review ?></a>
                                    <?php
                                }
                                ?>&nbsp; <img src="catalog/view/theme/sealskinz/image/great-british-company.png" alt="Designed by a great British company" style="height:36px"></p>
                            </div>
                            <?php
                            if ($product_tabs) {
                                foreach ($product_tabs as $key => $tab) {
                                        ?>
                                        <div id="productTabAttr<?php echo $key; ?>" class="tab-pane">
                                            <?php echo $tab['text']; ?>
                                        </div>
                                        <?php
                                }
                            }
                            ?>
                            <div id="productTabReview" class="tab-pane">
                                <div id="review"></div>
                                <?php
                                if ($review_anonymous_status == '1' || $logged) {
                                    ?>
                                    <h2 id="review-title"><?php echo $text_write; ?></h2>
                                    <b><?php echo $entry_name; ?></b><br />
                                    <input type="text" name="name" value="" />
                                    <br />
                                    <br />
                                    <b><?php echo $entry_review; ?></b>
                                    <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
                                    <br />
                                    <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
                                    <input type="radio" name="rating" value="1" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="2" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="3" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="4" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="5" />
                                    &nbsp;<span><?php echo $entry_good; ?></span><br />
                                    <br />
                                    <b><?php echo $entry_captcha; ?></b><br />
                                    <input type="text" name="captcha" value="" />
                                    <br />
                                    <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
                                    <br />
                                    <div class="buttons">
                                        <div class="right"><a id="button-review"  class="button"><?php echo $button_continue; ?></a></div>
                                    </div>
                                    <?php
                                }
                                ?>
                            </div>
                        </div>
                    </div>
                    <!----------------------------------------- End Tab ----------------------------------------->

                    <!----------------------------------------- Start Press ----------------------------------------->
                    <?php
                    if ($news && !empty($news)) {
                        ?>
                        <div class="product-press">             
                            <ul class="nav nav-tabs" id="pressTab" style="margin-bottom: 0;">
                                <li class="active"><a data-toggle="tab" href="#productPress" id="press-tab"><?php echo $text_press ?></a></li>
                            </ul>
                            <div class="tab-content-press" id="pressTabContent">
                                <div id="productPress" class="tab-pane active">
                                    <?php if ((count($news) > '1')) { ?>
                                        <div class="slideshow-press">
                                            <ul class="slides">
                                                <?php foreach ($news as $pnews) { ?>
                                                    <?php if ($pnews['status'] == '1') { ?> 
                                                        <li><a href="<?php echo $pnews['href'] ?>"><img src="<?php echo $pnews['thumb']; ?>" alt="Press" /></a></li>
                                                    <?php } ?>
                                                <?php } ?>
                                            </ul>
                                        </div>
                                    <?php } elseif (count($news) == '1') { ?>
                                        <?php foreach ($news as $pnews) { ?>
                                            <?php if ($pnews['status'] == '1') { ?> 
                                                <a href="<?php echo $pnews['href'] ?>"><img src="<?php echo $pnews['thumb']; ?>" alt="Press" /></a>
                                            <?php } ?> 
                                        <?php } ?>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>  
                    <?php } ?>
                    <!----------------------------------------- End Press ----------------------------------------->


                </div>
                <?php if (isset($products) && !empty($products)) { ?> 
                    <div id="relatedProducts">
                        <h3><?php echo $tab_related ?></h3>
                        <div class="product-grid">
                            <?php foreach ($products as $product) {
                                ?><div class="productItem"> 
                                    <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                                    <div class="image"><?php if ($product['thumb']) { ?>
                                            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                                        <?php } ?>
                                    </div>
                                    <div class="bar">
                                        <div class="price"><?php echo $product['price']; ?></div><a href="<?php echo $product['href']; ?>"><?php echo $text_view_product_info ?></a>
                                    </div>
                                </div><?php }
                                    ?>
                        </div>
                    </div>  
                <?php } ?>
            </div>
        </div>
    </div>
</div> 

<script type="text/javascript"><!--
    $('.button-cart').bind('click', function() {
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: $('#' + $(this).siblings('input').attr('id') + ', .product-info .submit-value'),
            dataType: 'json',
            success: function(json) {
                $('.success, .warning, .attention, information, .error').remove();
    			
                if (json['error']) {
                    if (json['error']['option']) {
                        for (i in json['error']['option']) {
                            $('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
                            27		}
                    }
                } 
    			
                if (json['success']) {
                    /* $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
    					
                    $('.success').fadeIn('slow').delay(3000).fadeOut(); */
    					
                    $('#cart-total').html(json['total']);
                    
                    openCart(5000, true);
                 
                }	
            }
        });
        return false;
    });
    //--></script>
<?php if ($options) { ?>
    <script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
    <?php foreach ($options as $option) { ?>
        <?php if ($option['type'] == 'file') { ?>
            <script type="text/javascript"><!--
                new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
                    action: 'index.php?route=product/product/upload',
                    name: 'file',
                    autoSubmit: true,
                    responseType: 'json',
                    onSubmit: function(file, extension) {
                        $('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
                        $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
                    },
                    onComplete: function(file, json) {
                        $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);
                                                                                                                                                                                                                		
                        $('.error').remove();
                                                                                                                                                                                                                		
                        if (json['success']) {
                            alert(json['success']);
                                                                                                                                                                                                                			
                            $('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
                        }
                                                                                                                                                                                                                		
                        if (json['error']) {
                            $('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
                        }
                                                                                                                                                                                                                		
                        $('.loading').remove();	
                    }
                });
                //--></script>
        <?php } ?>
    <?php } ?>
<?php } ?>
<script type="text/javascript"><!--
    $('#review .pagination a').live('click', function() {
        $('#review').fadeOut('slow');
    		
        $('#review').load(this.href);
    	
        $('#review').fadeIn('slow');
    	
        return false;
    });			

    $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

    $('#button-review').bind('click', function() {
        $.ajax({
            url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
            type: 'post',
            dataType: 'json',
            data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
            beforeSend: function() {
                $('.success, .warning').remove();
                $('#button-review').attr('disabled', true);
                $('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
            },
            complete: function() {
                $('#button-review').attr('disabled', false);
                $('.attention').remove();
            },
            success: function(data) {
                if (data['error']) {
                    $('#review-title').after('<div class="warning">' + data['error'] + '</div>');
                }
    			
                if (data['success']) {
                    $('#review-title').after('<div class="success">' + data['success'] + '</div>');
    								
                    $('input[name=\'name\']').val('');
                    $('textarea[name=\'text\']').val('');
                    $('input[name=\'rating\']:checked').attr('checked', '');
                    $('input[name=\'captcha\']').val('');
                }
            }
        });
    });
    //--></script> 
<script type="text/javascript"><!--
    $('#productTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    })
    //--></script> 
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
    if ($.browser.msie && $.browser.version == 6) {
        $('.date, .datetime, .time').bgIframe();
    }

    $('.date').datepicker({dateFormat: 'yy-mm-dd'});
    $('.datetime').datetimepicker({
        dateFormat: 'yy-mm-dd',
        timeFormat: 'h:m'
    });
    $('.time').timepicker({timeFormat: 'h:m'});
    //--></script> 

<script type="text/javascript">
        
    $(document).ready(function () {
            
        $('.image-additional').delegate('a.videoAdditional','click', function(){
            $('.product-img .image').html('<iframe id="playingMovie" width="374" height="374" src="http://www.youtube.com/embed/' + $(this).data('video') + '?autoplay=1&rel=0&theme=light&autohide=1" frameborder="0" allowfullscreen></iframe>');
            return false;
        });
            
        $('.image-additional').delegate('a.imageAdditional','click', function(){
            $('.product-img .image').html('<img src="' + $(this).data('main') + '" alt="" />');
            return false;
        });
            
        $('.product-img .image').delegate('img','click', function(){
            $('.colorbox').colorbox({
                overlayClose: true,
                opacity: 0.5,
                open: true
            });
        });
        
    });
        
</script>
<script type="text/javascript">
    $('.productItem').css('cursor', 'pointer').click(function () {
        window.location = $(this).find('a:first').attr('href');
    });
</script> 
<script type="text/javascript">
    $(document).ready( function(){
        $('.slideshow-press').slidepress({pager: false});
    });
</script>
<?php echo $footer; ?>