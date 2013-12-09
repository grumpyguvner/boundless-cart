<?php echo $header; ?>

<div id="content">

	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="reset" class="form-reset">

		<h1 class="form-heading">
			<?php if ($this->config->get('config_logo')) { ?>
				<img src="<?php echo HTTP_IMAGE.$this->config->get('config_logo'); ?>" alt="<?php echo $this->config->get('config_name'); ?>">
			<?php } else { ?>
				<?php echo $this->config->get('config_name'); ?>
			<?php } ?>
		</h1>

		<h2 class="form-heading"><i class="icon-lock"></i> <?php echo $heading_title; ?></h2>

		<p class="help-block"><?php echo $text_password; ?></p>

		<div class="control-group<?php if ($error_password) { ?> error<?php } ?>">
			<label class="control-label"><?php echo $entry_password; ?></label>
			<div class="controls">
				<input type="password" name="password" value="<?php echo $password; ?>" class="input-block-level">
				<?php if ($error_password) { ?>
				<span class="error help-block"><?php echo $error_password; ?></span>
				<?php } ?>
			</div>
		</div>

		<div class="control-group<?php if ($error_confirm) { ?> error<?php } ?>">
			<label class="control-label"><?php echo $entry_confirm; ?></label>
			<div class="controls">
				<input type="password" name="confirm" value="<?php echo $confirm; ?>" class="input-block-level">
				<?php if ($error_confirm) { ?>
				<span class="error help-block"><?php echo $error_confirm; ?></span>
				<?php } ?>
			</div>
		</div>

		<div class="buttons form-actions form-actions-top">
			<?php echo p3html::tb_ajax_button($button_save, "$('#reset').submit();", 'success'); ?>
			<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
		</div>

	</form>

</div>

<?php echo $footer; ?>