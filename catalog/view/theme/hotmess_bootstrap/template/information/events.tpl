<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>

<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
    <?php 
if(count($available_events)>0){
	foreach($available_events as $v){
	
		$q_no_sub = "select null from ".DB_PREFIX."event_subscribers where event_id='".$v['event_id']."'";
		$query_no_sub = $this->db->query($q_no_sub);
		$results_no_sub = $query_no_sub->rows;
		$no_sub = count($query_no_sub->rows);
		
		if ($v['image']) {
            $thumb = $this->model_tool_image->resize($v['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
        } else {
            $thumb = '';
        }
		
?>
    <div class="manufacturer-list">
    
    <div class="manufacturer-heading"><a href="<?php echo $this->url->link('information/event', 'event_id='.$v['event_id']);?>"><?php echo $v['title'];?></a></div>
	<?php if($thumb){?><div class="image" style="float:left; margin:3px;"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div><?php }?>
      <div style="float:right; color:#990033"><img src="catalog/view/theme/default/image/latest.png" />&nbsp;<?php echo date('M d, Y',strtotime($v['event_date']));?></div>
      <div class="manufacturer-content">
      <?php echo substr(strip_tags(html_entity_decode($v['description'])),0,200)."...";?>
      </div>
	  <?php if($v['allow_subscribe']=='y' && ($no_sub < $v['no_of_sub'] || $v['no_of_sub'] <= 0)){?><a href="<?php echo HTTP_SERVER;?>index.php?route=information/event/subscribe&event_id=<?php echo $v['event_id'];?>" class="button fancybox1"><span><?php echo $button_sub;?></span></a><?php }?>
      <?php 
	  if(isset($v['products'])){
	  ?><div style="float:right">
	  <strong><?php echo $entry_products;?></strong>
		  <?php foreach($v['products'] as $k1=>$v1){?>
		  	<a href="<?php echo $v1['href']?>"><?php echo $v1['name'];?></a>&nbsp;
		  <?php }?></div>
	  <?php 
	  }
	  ?>
	  </div>
	  
    <?php 
	}
}else{
	echo $text_error;
}
?>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
  </div>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript">
$('.fancybox1').fancybox({'type'	: 'iframe',
'width'				: '55%',
'height'			: '62%',
cyclic			: false
});

/*$("#various5").fancybox({
		'width'				: '75%',
		'height'			: '75%',
        'autoScale'     	: false,
        'transitionIn'		: 'none',
		'transitionOut'		: 'none',
		'type'				: 'iframe'
	});*/
</script>  
<?php echo $footer; ?>