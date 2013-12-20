<div class="slideshow">
  <div id="slideshow<?php echo $module; ?>"<?php if (count($banners) > 1) { ?> class="nivoSlider"<?php } ?> style="width: <?php echo $width; ?>px; height: <?php echo $height; ?>px;">
    <?php foreach ($banners as $banner) { ?>
    <?php if ($banner['link']) { ?>
    <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /></a>
    <?php } else { ?>
    <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" />
    <?php } ?>
    <?php } ?>
  </div>
</div>
<script type="text/javascript"><!--
<?php if (count($banners) > 1) { ?>
$(document).ready(function() {
	$('#slideshow<?php echo $module; ?>').nivoSlider();
});
<?php } ?>
--></script>