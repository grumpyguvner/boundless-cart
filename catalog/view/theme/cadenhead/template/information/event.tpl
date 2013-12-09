<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content" style="margin-left: 14px; margin-right: 14px;"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <?php if($thumb){?><div class="image" style="float:left; margin:3px;"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div><?php }?>
  <div style="float:right; color:#990033"><img src="catalog/view/theme/default/image/latest.png" />&nbsp;<?php echo $event_date;?></div>
  <?php echo $description; ?>
  
  <?php 
	  if(isset($products)){
	  ?><div>
	  <strong><?php echo $entry_products;?></strong>
		  <?php foreach($products as $k1=>$v1){?>
		  	<a href="<?php echo $v1['href']?>"><?php echo $v1['name'];?></a>&nbsp;
		  <?php }?></div>
	  <?php 
	  }
	  ?>
  <div class="buttons"><?php if($allow_subscribe=='y' && ($no_sub < $no_of_sub || $no_of_sub <=0)){?><a href="<?php echo HTTP_SERVER;?>index.php?route=information/event/subscribe&event_id=<?php echo $event_id;?>" class="button fancybox1"><span><?php echo $button_sub;?></span></a><?php }?>
  
  
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
  </div>
  <?php echo $content_bottom; ?></div>
  <script type="text/javascript">
$('.fancybox1').fancybox({
'type'	: 'iframe',
'width'				: '55%',
'height'			: '62%',
'cyclic'			: false
});
</script>  
<?php echo $footer; ?>