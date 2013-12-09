<div class="box clearfix">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <div class="box-product">
      <?php $_counter = 0;foreach ($products as $product) { ?>
      <div<?php 
			  if (isset($_SERVER['DOCUMENT_ROOT']))
			  $_theme_include_path = $_SERVER['DOCUMENT_ROOT'] . '/catalog/view/theme/nicole-shop/';
			  else $_theme_include_path = dirname(__FILE__) . '/../../';

			  include($_theme_include_path . '/nico_theme_editor/settings.inc');
		  
		  		$_counter++;
				$_mod = $_counter % 5;
				if ($_mod == 0) echo ' class="last"';
				if ($_mod == 1) echo ' class="first"';
		?>>
		<div class="description"><?php if (isset($product['description'])) {?><div><?php echo $product['description']; ?></div><?php } ?>
			<a href="#" onclick="addToCart('<?php echo $product['product_id']; ?>');return false" class="desc_cart"><?php echo $button_cart; ?></a>
			<a href="<?php echo $product['href']; ?>"  class="desc_view">Details</a>
		</div>
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <?php if ($product['price']) { ?>
        <div class="price<?php if ($product['special']) { ?> price_sale<?php }?>">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
		<?php /*if ($product['special']) { ?><div class="product_sale">
			<?php if (isset($_nico_settings['settings']['sale_text'])) echo $_nico_settings['settings']['sale_text']; 
			else echo 'Sale';?>
		</div><?php } */?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/nicole-shop/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
        <div class="cart"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" /></div>
      </div>
      <?php } ?>
    </div>
  </div>
</div>
