<?php //2012-06 Added by MH to display homepage ctas as inline divs instead of slideshow
if ($setting['banner_id']=9) { ?>

<div id="homepagectas" class="ctas">
  <?php $left = true ?>
  <?php foreach ($banners as $banner) { ?>
  <?php if ($banner['link']) { ?>
  <a href="<?php echo $banner['link']; ?>" class="<?php echo $left ? 'column-left' : 'column-right' ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></a>
  <?php } else { ?>
  <div class="<?php echo $left ? 'column-left' : 'column-right' ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></div>
  <?php } ?>
  <?php $left = $left ? false : true ?>
  <?php } ?>
</div>

<?php } else { ?>

<div id="banner<?php echo $module; ?>" class="banner">
  <?php foreach ($banners as $banner) { ?>
  <?php if ($banner['link']) { ?>
  <div><a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></a></div>
  <?php } else { ?>
  <div><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></div>
  <?php } ?>
  <?php } ?>
</div>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('#banner<?php echo $module; ?> div:first-child').css('display', 'block');
});

var banner = function() {
	$('#banner<?php echo $module; ?>').cycle({
		before: function(current, next) {
			$(next).parent().height($(next).outerHeight());
		}
	});
}

setTimeout(banner, 2000);
//--></script>

<?php } ?>
