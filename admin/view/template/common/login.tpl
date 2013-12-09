<?php $body_css_class = 'login'; ?>
<?php echo $header; ?>

<div id="content">

	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-signin">

		<h1 class="form-heading">
			<?php if ($this->config->get('config_logo')) { ?>
				<img src="<?php echo HTTP_IMAGE.$this->config->get('config_logo'); ?>" alt="<?php echo $this->config->get('config_name'); ?>">
			<?php } else { ?>
				<?php echo $this->config->get('config_name'); ?>
			<?php } ?>
		</h1>

		<h2 class="form-heading"><i class="icon-lock"></i> <?php echo $text_login; ?></h2>

		<?php if ($success) { ?>
			<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
		<?php } ?>
		<?php if ($error_warning) { ?>
			<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
		<?php } ?>

		<input type="text" name="username" value="<?php echo $username; ?>" placeholder="<?php echo trim($entry_username, ':'); ?>" class="input-block-level">
		<input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo trim($entry_password, ':'); ?>" class="input-block-level">

		<a href="<?php echo $forgotten; ?>" class="input-block-level"><i class="icon-help-circled"></i> <?php echo $text_forgotten; ?></a>

		<a onclick="$('#form').submit();" class="btn btn-large btn-block btn-primary"><?php echo $button_login; ?></a>

		<?php if ($redirect) { ?>
		<input type="hidden" name="redirect" value="<?php echo $redirect; ?>">
		<?php } ?>

	</form>

</div>

<script>
$('body').addClass('login');
$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#form').submit();
	}
});
</script>

<?php echo $footer; ?>