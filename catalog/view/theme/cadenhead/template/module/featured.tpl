<div class="box">
  <div class="box-heading">Latest Arrival's</div>
  <div class="box-content">
    <div class="box-product">
      <?php foreach ($products as $product) { ?>
      <div>
        <?php if ($product['thumb']) { ?>
        <div class="caption_featured"><div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a><span <?php if($product['quantity'] > 10){ echo 'style="display: none"';} ?>><strong><?php if($product['quantity'] <= 10){ echo $product['quantity'] . ' ' . 'left!';} ?></strong></span></div></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        
      </div>
      <?php } ?>
    </div>
  </div>
</div>
