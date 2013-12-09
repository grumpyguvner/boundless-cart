<?php echo $header; ?>

<div id="content">

  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="forgotten" class="form-signin">

		<h1 class="form-heading">
			<?php if ($this->config->get('config_logo')) { ?>
				<img src="<?php echo HTTP_IMAGE.$this->config->get('config_logo'); ?>" alt="<?php echo $this->config->get('config_name'); ?>">
			<?php } else { ?>
				<?php echo $this->config->get('config_name'); ?>
			<?php } ?>
		</h1>

		<h2 class="form-heading"><i class="icon-lock"></i> <?php echo $heading_title; ?></h2>

		<?php if ($error_warning) { ?>
			<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
		<?php } ?>

		<?php echo p3html::tb_alert('warning', $text_email, false, 'warning'); ?>

		<input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo trim($entry_email, ':'); ?>" class="input-block-level">

		<div class="buttons form-actions form-actions-top">
			<?php echo p3html::tb_ajax_button($button_reset, "$('#forgotten').submit();", 'warning'); ?>
			<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
		</div>

  </form>

</div>

<?php echo $footer; ?>