<?php echo $header; ?><?php echo $content_top; ?>
<div class="breadcrumb">
<?php if ($breadcrumbs) { ?>
  <?php $count = count($breadcrumbs) - 1; ?>
  <?php for ($i = 0; $i < $count; $i++) { ?>
    <?php echo '<b>' . $breadcrumbs[$i]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$i]['href']; ?>"><b><?php echo $breadcrumbs[$i]['text']; ?></b></a>
  <?php } ?>
    <?php echo '<b>' .$breadcrumbs[$count]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$count]['href']; ?>"><?php echo $breadcrumbs[$count]['text']; ?></a>
    <div class="back"><a href="<?php echo $breadcrumbs[$count-1]['href']; ?>"><?php echo $text_breadcrumb_back; ?></a></div>    
<?php } ?>
</div>    
<div class="events"><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
    
  <h1><?php echo $heading_title; ?></h1>
  <?php if($thumb){?><div class="image" style="float:left; margin:3px;"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div><?php }?>
  <div style="float:right;"><img src="catalog/view/theme/default/image/latest.png" />&nbsp;<?php echo $event_date;?></div>
  <?php echo $description; ?>
  
  <?php if ($products && count($products) > 0) { ?>
        <div class="featuredTitle" id="featuredProduct"><h5><?php echo strtoupper($entry_products) ?></h5></div>
            <ul id="featuredStyles" class="jcarousel-skin-tango<?php if (count($products) <= 5) { echo ' completeLook';} ?>">
              <?php foreach ($products as $k1=>$v1) { ?>
                  <li>
                      <?php if ($v1['thumb']) { ?>
                      <a href="<?php echo $v1['href']; ?>"><img src="<?php echo $v1['thumb']; ?>" alt="<?php echo $v1['name']; ?>" /></a>
                      <?php if ($v1['new']) { ?> 
                          <img class="newProduct" src="catalog/view/theme/soactive/image/new-icon.png" alt="New Product">
                      <?php } ?>
                      <?php if ($v1['sale']) { ?> 
                          <img class="saleProduct" src="catalog/view/theme/soactive/image/sale-icon.png" alt="Sale Product">
                      <?php } ?>
                      <?php } ?><br />
                      <div class="nameItem">
                        <a href="<?php echo $v1['href']; ?>"><?php echo $v1['name']; ?></a>
                      </div>
                      <?php if ($v1['price']) { ?>
                        <div class="priceItem">
                          <?php if (!$v1['special']) { ?>
                          Pay: <span class="price"><?php echo $v1['price']; ?></span>
                          <?php } else { ?>
                          <span class="save"><?php echo $text_save; ?> <?php echo $v1['saving_percent'] . '%' ?></span>
                          <span class="price-old"><?php echo $text_rrp; ?> <?php echo $v1['price']; ?></span> <?php echo $text_pay; ?> <span class="price-new"><?php echo $v1['special']; ?></span>
                          <?php } ?>
                        </div>
                     <?php } ?>
                  </li>
                <?php } ?> 
            </ul>
  <?php } ?>
  
  <div class="buttons"><?php if($allow_subscribe=='y' && ($no_sub < $no_of_sub || $no_of_sub <=0)){?><a href="<?php echo HTTP_SERVER;?>index.php?route=information/event/subscribe&event_id=<?php echo $event_id;?>" class="button fancybox1"><span><?php echo $button_sub;?></span></a><?php }?>
  
  <div class="buttonLeft"><a class="button" onClick="javascript:history.back()"><?php echo $button_back;?></a></div>
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
  </div>
  <?php echo $content_bottom; ?>
</div>
</div>
  <script type="text/javascript">
$('.fancybox1').fancybox({
'type'	: 'iframe',
'width'				: '55%',
'height'			: '62%',
'cyclic'			: false
});
</script>
<?php if (count($products) > 4) { ?>
<script type="text/javascript">
jQuery(document).ready(function() {
    jQuery('#featuredStyles').jcarousel({
    	wrap: 'circular'
    });
});
</script>
<?php } else { }?>
<?php echo $footer; ?>