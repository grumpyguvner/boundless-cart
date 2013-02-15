<?php echo $header; ?>
<div class="breadline">
    <div class="container">
      <div class="row"> 
          <div class="span12">
           
                <div class="breadcrumb">
                    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
                    <?php } ?>
                </div>
            </div>
      </div>
    </div>
  </div>

<div id="line-opacity">
<?php if ($products) { ?>
  <div class="container">
    <div class="row">
        <div class="span2">
            <div style="padding: 15px; min-width: 148px; border-right: 1px solid #CCCCCC">Filter</div>
        </div>
        <div class="span10">
            <div class="product-filter">
                
              <div class="display"><b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display('grid');"><?php echo $text_grid; ?></a></div>
              <div class="limit"><?php echo $text_limit; ?>
                <select onchange="location = this.value;">
                  <?php foreach ($limits as $limits) { ?>
                  <?php if ($limits['value'] == $limit) { ?>
                  <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
              <div class="sort"><?php echo $text_sort; ?>
                <select onchange="location = this.value;">
                  <?php foreach ($sorts as $sorts) { ?>
                  <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                  <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            
            </div>
        </div>
    </div>
  </div>
 <?php } ?>
</div>
<div id="content-back">
  <div class="container" id="content-in">  
    <?php echo $column_left; ?><?php echo $column_right; ?>
    <div id="content"><?php echo $content_top; ?>
      <?php if ($thumb || $description) { ?>
      <div class="category-info">
          <div class="row"> 
              <div class="span12">
                  <?php if ($thumb) { ?>
                      <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
                  <?php } ?>
                  <?php if ($description) { ?>
                  <?php echo $description; ?>
                  <?php } ?>
              </div>
        </div>
      </div>
      <?php } ?>
      <?php if ($categories) { ?>
      <h2><?php echo $text_refine; ?></h2>
      <div class="category-list">
          <div class="row"> 
                <div class="span12">
        <?php if (count($categories) <= 5) { ?>
        <ul>
          <?php foreach ($categories as $category) { ?>
          <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
          <?php } ?>
        </ul>
        <?php } else { ?>
        <?php for ($i = 0; $i < count($categories);) { ?>
        <ul>
          <?php $j = $i + ceil(count($categories) / 4); ?>
          <?php for (; $i < $j; $i++) { ?>
          <?php if (isset($categories[$i])) { ?>
          <li><a href="<?php echo $categories[$i]['href']; ?>"><?php echo $categories[$i]['name']; ?></a></li>
          <?php } ?>
          <?php } ?>
        </ul>
        <?php } ?>
        <?php } ?>
      </div>
    </div>
      </div>
      <?php } ?>
      <?php if ($products) { ?>
      <!--div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div-->
      <div class="product-list">
        <?php foreach ($products as $product) { ?>
        <div>
          <?php if ($product['thumb']) { ?>
          <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
          <?php } ?>
          <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
          <!--div class="description"><?php /* echo $product['description']; */ ?></div-->
          <?php if ($product['price']) { ?>
          <div class="price">
            <?php if (!$product['special']) { ?>
            <?php echo $product['price']; ?>
            <?php } else { ?>
            <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
            <?php } ?>
            <?php if ($product['tax']) { ?>
            <br />
            <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
            <?php } ?>
          </div>
          <?php } ?>
          <?php /* if ($product['rating']) { */ ?>
          <!--div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div-->
          <?php /* } */ ?>
          <!--div class="cart">
            <input type="button" value="<?php /*echo $button_cart; */ ?>" onclick="addToCart('<?php /* echo $product['product_id']; */ ?>');" class="btn" />
          </div>
          <div class="wishlist"><a onclick="addToWishList('<?php /* echo $product['product_id']; */ ?>');"><?php /* echo $button_wishlist; */?></a></div>
          <div class="compare"><a onclick="addToCompare('<?php /* echo $product['product_id']; */ ?>');"><?php /* echo $button_compare; */ ?></a></div-->
        </div>
        <?php } ?>
      </div>
      <div class="pagination"><?php echo $pagination; ?></div>
      <?php } ?>
      <?php if (!$categories && !$products) { ?>
      <div class="content"><?php echo $text_empty; ?></div>
      <!--div class="buttons">
        <div class="right"><a href="<?php /* echo $continue; */ ?>" class="btn"><?php /* echo $button_continue; */ ?></a></div>
      </div-->
      <?php } ?>
      <?php echo $content_bottom; ?>
    </div>
  </div>   
</div>
<script type="text/javascript"><!--
function display(view) {
	if (view == 'list') {
		$('.product-grid').attr('class', 'product-list');
		
		$('.product-list > div').each(function(index, element) {
			html  = '<div class="right" style="display: none;">';
			html += '  <div class="cart">' + $(element).find('.cart').html() + '</div>';
			html += '  <div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '  <div class="compare">' + $(element).find('.compare').html() + '</div>';
			html += '</div>';			
			
			html += '<div class="left">';
			
			var image = $(element).find('.image').html();
			
			if (image != null) { 
				html += '<div class="image">' + image + '</div>';
			}
			
			var price = $(element).find('.price').html();
			
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
					
			html += '  <div class="name">' + $(element).find('.name').html() + '</div>';
			html += '  <div class="description" style="display: none;">' + $(element).find('.description').html() + '</div>';
			
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
				
			html += '</div>';

						
			$(element).html(html);
		});		
		
		$('.display').html('<b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display(\'grid\');"><?php echo $text_grid; ?></a>');
		
		$.cookie('display', 'list'); 
	} else {
		$('.product-list').attr('class', 'product-grid');
		
		$('.product-grid > div').each(function(index, element) {
			html = '';
			
			var image = $(element).find('.image').html();
			
			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}
			
			html += '<div class="name">' + $(element).find('.name').html() + '</div>';
			html += '<div class="description">' + $(element).find('.description').html() + '</div>';
			
			var price = $(element).find('.price').html();
			
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
			
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating" style="display: none;">' + rating + '</div>';
			}
						
			html += '<div class="cart" style="display: none;">' + $(element).find('.cart').html() + '</div>';
			html += '<div class="wishlist" style="display: none;">' + $(element).find('.wishlist').html() + '</div>';
			html += '<div class="compare" style="display: none;">' + $(element).find('.compare').html() + '</div>';
			
			$(element).html(html);
		});	
					
		$('.display').html('<b><?php echo $text_display; ?></b> <a onclick="display(\'list\');"><?php echo $text_list; ?></a> <b>/</b> <?php echo $text_grid; ?>');
		
		$.cookie('display', 'grid');
	}
}

view = $.cookie('display');

if (view) {
	display(view);
} else {
	display('list');
}
//--></script> 
<?php echo $footer; ?>