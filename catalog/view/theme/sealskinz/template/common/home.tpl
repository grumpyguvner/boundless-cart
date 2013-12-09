<?php echo $header; ?>
<div id="notification">
<?php
if (isset($success) && $success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } 
if (isset($error_warning) && $error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php }
if (isset($attention) && $attention) { ?>
<div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php 
}
?>
</div>
<?php echo $content_top; ?>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>