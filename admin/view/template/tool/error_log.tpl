<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-search"></i> <?php echo $heading_title; ?></h1>
			<?php if ($success) { ?>
				<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<a href="<?php echo $clear; ?>" class="btn"><?php echo $button_clear; ?></a>
			</div>
    </div>

    <div class="content">
      <textarea wrap="off" class="span12" style="height: 300px; overflow: scroll;"><?php echo $log; ?></textarea>
    </div>

  </div>
</div>

<?php echo $footer; ?>