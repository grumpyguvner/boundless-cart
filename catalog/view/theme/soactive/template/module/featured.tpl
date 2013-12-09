<div class="featuredTitle"><h5><?php echo strtoupper($heading_title) ?></h5>&nbsp&nbsp<hr></hr></div>
<ul id="featuredStyles" class="jcarousel-skin-tango">
  <?php foreach ($products as $product) { ?>
      <li>
          <?php if ($product['thumb']) { ?>
          <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
          <?php if ($product['new']) { ?> 
                <img class="newProduct" src="catalog/view/theme/soactive/image/new-icon.png" alt="New Product">
            <?php } ?>
            <?php if ($product['sale']) { ?> 
                <img class="saleProduct" src="catalog/view/theme/soactive/image/sale-icon.png" alt="Sale Product">
            <?php } ?> 
          <?php } ?><br />
          <div class="nameItem">
            <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
          </div>
          <?php if ($product['price']) { ?>
            <div class="priceItem">
                <?php if (!$product['special']) { ?>
                Pay: <span class="price"><?php echo $product['price']; ?></span>
                <?php } else { ?>
                <span class="save"><?php echo $text_save ?> <?php echo $product['saving_percent'] . '%' ?></span>
                <span class="price-old"><?php echo $text_rrp ?> <?php echo $product['price']; ?></span> <?php echo $text_pay ?> <span class="price-new"> <?php echo $product['special']; ?></span>
              <?php } ?>
           </div>
         <?php } ?>
      </li>
    <?php } ?> 
</ul>

<script type="text/javascript">
jQuery(document).ready(function() {
    jQuery('#featuredStyles').jcarousel({
    	wrap: 'circular'
    });
});
</script>