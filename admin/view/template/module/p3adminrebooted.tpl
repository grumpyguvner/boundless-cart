<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-wrench"></i> <?php echo $this->language->get('heading_title'); ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
			<?php if ($success) { ?>
				<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_save($this->language->get('button_save')); ?>
				<?php //echo p3html::tb_form_button_apply($this->language->get('button_apply')); ?>
				<?php echo p3html::tb_form_button_cancel($this->language->get('button_cancel'), $cancel); ?>
			</div>
    </div>

    <div class="content">

			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
				<input type="hidden" id="action_apply" name="action_apply" value="0" />

				<div class="form row">

					<div class="span6">

					<div class="control-group">
						<label class="control-label">
							<?php echo $this->language->get('entry_flavour'); ?>
						</label>
						<div class="controls">
							<select name="p3adminrebooted_flavour" class="span3">
								<?php echo p3html::options($p3adminrebooted_flavour_options, $p3adminrebooted_flavour, 'value', 'label'); ?>
							</select>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<?php echo $this->language->get('entry_jui_full'); ?>
						</label>
						<div class="controls">
							<select name="p3adminrebooted_jui_full" class="span3">
								<?php echo p3html::options($p3adminrebooted_jui_full_options, $p3adminrebooted_jui_full, 'value', 'label'); ?>
							</select>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<?php echo $this->language->get('entry_select2'); ?>
						</label>
						<div class="controls">
							<select name="p3adminrebooted_select2" class="span2">
								<?php echo p3html::oc_status_options($this->language, $p3adminrebooted_select2); ?>
							</select>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<?php echo $this->language->get('entry_toggle_buttons'); ?>
						</label>
						<div class="controls">
							<select name="p3adminrebooted_toggle_buttons" class="span2">
								<?php echo p3html::oc_status_options($this->language, $p3adminrebooted_toggle_buttons); ?>
							</select>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<?php echo $this->language->get('entry_ckeditor4'); ?>
						</label>
						<div class="controls">
							<select name="p3adminrebooted_ckeditor4" class="span3">
								<?php echo p3html::options($p3adminrebooted_ckeditor4_options, $p3adminrebooted_ckeditor4, 'value', 'label'); ?>
							</select>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<?php echo $this->language->get('entry_menu_highlight'); ?>
						</label>
						<div class="controls">
							<select name="p3adminrebooted_menu_highlight" class="span2">
								<?php echo p3html::oc_status_options($this->language, $p3adminrebooted_menu_highlight); ?>
							</select>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<?php echo $this->language->get('entry_hide_helpmenu'); ?>
						</label>
						<div class="controls">
							<select name="p3adminrebooted_hide_helpmenu" class="span2">
								<?php echo p3html::oc_status_options($this->language, $p3adminrebooted_hide_helpmenu); ?>
							</select>
						</div>
					</div>

				</div><!--end span6-->

				<div class="span6">
					<div class="form well">
						<h5>ORDER STATUS LABELS</h5>
						<?php if ($osl_installed) { ?>
						<div class="alert alert-success">
							<i class="icon-ok"></i> THIS FEATURE IS INSTALLED!
						</div>
						<?php } else { ?>
						<?php echo p3html::tb_alert('error', $error_db_permission, true, 'warning'); ?>
						<div class="alert alert-info">
							<p><strong><i class="icon-attention"></i> This add-on is not installed yet.</strong><p>
							<p>Before installing make sure your opencart database user has <strong>CREATE PERMISSION</strong>
								granted and press the following button!
							<p>
						</div>
						<?php echo p3html::tb_form_button('INSTALL', "location = '$installosl'", 'primary', 'cog'); ?>
						<?php } ?>
					</div>
				</div><!--end span6-->

				</div>

			</form>

			</div>

		</div>

	</div>

</div>

<?php echo $footer; ?>