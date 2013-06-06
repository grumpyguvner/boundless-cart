<?php echo $header; ?><?php echo $column_left; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="product-info">
    <?php if ($thumb || $images) { ?>
    <div class="left">
      <div class="product-img">
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
                                        ?><a href="<?php echo $popup; ?>" target="_blank" class="colorbox imageAdditional" id="mainImage" rel="colorbox" data-main="<?php echo $thumb; ?>"><img src="<?php echo $additional; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="imageAdditional"/><?php
                                        
                                    }
                          
                                    if ($images) {
                                      for ($i = 0; $i < count($images); $i++)  {
                                          
                                          if (empty($images[$i]['video'])) {
                                                        ?><a href="<?php echo $images[$i]['popup']; ?>" target="_blank" class="colorbox imageAdditional" rel="colorbox" data-main="<?php echo $images[$i]['main']; ?>" <?php if ($i > 1) echo 'style="display: none;"' ?>><img src="<?php echo $images[$i]['thumb']; ?>" alt="" /></a><?php
                                        } else {
                                                        ?><a href="http://www.youtube.com/watch?v=<?php echo $images[$i]['video']; ?>" class="videoAdditional" data-video="<?php echo $images[$i]['video']; ?>" target="_blank" style="<?php if ($i > 1) echo "display: none;" ?>line-height:<?php echo $additionalHeight; ?>px;height:<?php echo $additionalHeight; ?>px;width:<?php echo $additionalWidth; ?>px;"><img src="http://img.youtube.com/vi/<?php echo $images[$i]['video']; ?>/0.jpg" alt="" /><span class="play-button" style="height:<?php echo $additionalHeight; ?>px;width:<?php echo $additionalWidth; ?>px;"></span></a><?php
                                            }
                                      }
                                        
                                        }
                                    ?>
                                </div>
                            <?php } ?>
                        <?php } ?>

                    </div>
    </div>
    <?php } ?>
    <div class="right">
      <div class="description">
      <h1><?php echo $heading_title; ?></h1>
        <?php if ($manufacturer) { ?>
        <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
        <?php } ?>
      </div>
      <?php if ($price) { ?>
      <div class="price">
        <?php if (!$special) { ?>
        <?php echo $price; ?>
        <?php } else { ?>
          <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><span>NOW </span><?php echo $special; ?></span>
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
      <?php if ($review_status) { ?>
      <div class="review">
        <div><img src="catalog/view/theme/default/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a></div>
      </div>
      <?php } ?>  
      <?php } ?>
      <?php if ($options) { ?>
      <div class="options">
        <!--h2><?php /* echo $text_option; */ ?></h2-->
        <br />
        <?php foreach ($options as $option) { ?>
        <?php if ($option['type'] == 'select') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
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
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <?php foreach ($option['option_value'] as $option_value) { ?>
          <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
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
          <input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
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
        <?php } ?>
        <?php } ?>
      </div>
      <?php } ?>
      <div class="cart">
        <div>
          <input type="hidden" name="quantity" size="2" value="<?php echo $minimum; ?>" />
          <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
          &nbsp;
          <input type="button" value="<?php echo strtoupper($button_cart); ?>" id="button-cart" class="cartButton" />
        </div>
        <?php if ($minimum > 1) { ?>
        <div class="minimum"><?php echo $text_minimum; ?></div>
        <?php } ?>
      </div>
      <div class="product-tab<?php if ($news && !empty($news)) echo ' news'?>"> 
            <ul class="nav nav-tabs" id="productTab">
                <li class="active"><a href="#productTabDesc"><?php echo strtoupper($tab_description); ?></a></li>
                <?php
                if ($product_tabs) {
                    foreach ($product_tabs as $key => $tab) {
                            echo '<li><a href="#productTabAttr' . $key . '">' . strtoupper($tab['name']) . '</a></li>';
                        }
                }
                if ($review_status)
                    echo '<li><a href="#productTabReview" id="tab-review">' . strtoupper ($tab_review) . '</a></li>';
                ?>
            </ul>
            <div class="tab-content">
                <div id="productTabDesc" class="tab-pane active">
                    <div class="descTab"><?php echo $description; ?></div>
                    
                    <?php if (isset($attribute_groups['Ratings'])) { ?>
                        <div class="rating">
                            <?php
                            $rating = array();
                            foreach ($attribute_groups['Ratings'] as $attribute_group) {
                                foreach ($attribute_group['attribute'] as $attribute) {
                                    $rating = '';
                                    $rating[] = $attribute['text'];
                                    echo '<div class="rating' . $attribute['name'] . '"><p>' . $attribute['name'] . ':</p>';
                                   
                                    for ($i = 1; $i <= 5; $i++) { 
                                        if ($i <= $attribute['text']) { ?>
                                            <img class="rating checked" src="catalog/view/theme/soactive/image/star.png" alt="Star checked" /></span>
                                    <?php
                                        } else { ?>
                                            <img class="rating" src="catalog/view/theme/soactive/image/star_no_checked.png" alt="Star no checked" /></span>
                                        <?php }
                                    }
                                    echo '</div>';
                                }
                            } ?>

                        </div>
                    <?php } ?>
                    
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
    
    </div>
      <?php echo $column_right; ?>
  </div>
  
  <?php if ($products) { ?>
        <div class="featuredTitle" id="featuredProduct"><h5><?php echo strtoupper($tab_related) ?></h5></div>
            <ul id="featuredStyles" class="jcarousel-skin-tango">
              <?php foreach ($products as $product) { ?>
                  <li>
                      <?php if ($product['thumb']) { ?>
                      <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                      <?php } ?><br />
                      <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                      <?php if ($product['price']) { ?>
                          <?php if (!$product['special']) { ?>
                          <span class="price"><?php echo $product['price']; ?></span>
                          <?php } else { ?>
                          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
                          <?php } ?>
                     <?php } ?>
                  </li>
                <?php } ?> 
            </ul>
  <?php } ?>
  
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$('.colorbox').colorbox({
	overlayClose: true,
	opacity: 0.5
});
//--></script> 
<script type="text/javascript"><!--
$('#button-cart').bind('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();
			
			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			} 
			
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
				$('.success').fadeIn('slow');
					
				$('#cart-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
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
jQuery(document).ready(function() {
    jQuery('#featuredStyles').jcarousel({
    	wrap: 'circular'
    });
});
</script>
<script type="text/javascript">
        
    $(document).ready(function () {
            
        $('.image-additional').delegate('a.videoAdditional','click', function(){
            $('.product-img .image').html('<iframe id="playingMovie" width="290" height="370" src="http://www.youtube.com/embed/' + $(this).data('video') + '?autoplay=1&rel=0&theme=light&autohide=1" frameborder="0" allowfullscreen></iframe>');
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
<?php echo $footer; ?>