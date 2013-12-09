<div class="recentlyViewedTitle"><h5><?php echo strtoupper($heading_title) ?></h5></div>
<ul id="recentlyViewedStyles" class="jcarousel-skin-tango">
  <?php foreach ($products as $product) { ?>
      <li>
          <?php if ($product['thumb']) { ?>
          <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
          <?php } ?><br />
          <div class="nameItem">
                <a href="<?php echo $product['href']; ?>"><?php echo $product['shortname']; ?></a>
          </div>
          <?php if ($product['price']) { ?>
              <div class="priceItem">
                <?php if (!$product['special']) { ?>
                <span class="price"><?php echo $product['price']; ?></span>
                <?php } else { ?>
                <!--span class="price-old"><?php /* echo $product['price']; */?></span--> <span>Pay: </span><span class="price-new"><?php echo $product['special']; ?></span>
                <?php } ?>
              </div>
         <?php } ?>
      </li>
    <?php } ?> 
</ul>

<script type="text/javascript">
jQuery(document).ready(function() {
    jQuery('#recentlyViewedStyles').jcarousel({
    	 vertical: true,
         scroll: 3
    });
});
</script>
