<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">
    <div class="heading">
      <h1><i class="users"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
     <div class="buttons form-actions form-actions-top">
			 <?php echo p3html::tb_form_button_save($button_save); ?>
			 <?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
		 </div>
    </div>

    <div class="content">

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
        <div class="form">
          <div class="control-group<?php if ($error_name) { ?> error<?php  } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
            <div class="controls">
							<input type="text" name="name" value="<?php echo $name; ?>">
              <?php if ($error_name) { ?>
              <span class="error help-block"><?php echo $error_name; ?></span>
              <?php  } ?>
						</div>
          </div>
           <?php if ($this->user->isSuperuser()) { ?>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_superuser; ?></label>
              <div class="controls">
								<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
								<?php echo p3html::tb_bool_buttons_radio($this->language, 'superuser', $superuser); ?>
								<?php } else { ?>
								<?php echo p3html::tb_bool_radio_buttons($this->language, 'superuser', $superuser); ?>
								<?php } ?>
							</div>
            </div>
          <?php } ?>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_access; ?></label>
            <div class="controls">
							<div class="scrollbox">
                <?php $class = 'odd'; ?>
                <?php foreach ($permissions as $permission) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
									<label class="checkbox inline">
										<input type="checkbox" name="permission[access][]" value="<?php echo $permission; ?>"<?php if (in_array($permission, $access)) { ?> checked="checked"<?php } ?>>
										<?php echo $permission; ?>
									</label>
                </div>
                <?php } ?>
              </div>
							<br>
              <a class="btn btn-small" href="#" onclick="$(this).parent().find(':checkbox').attr('checked', true);return false;">
								<i class="icon-cb-checked"></i>
								<?php echo $text_select_all; ?>
							</a>
							<a class="btn btn-small" href="#" onclick="$(this).parent().find(':checkbox').attr('checked', false);return false;">
								<i class="icon-cb-unchecked"></i>
								<?php echo $text_unselect_all; ?>
							</a>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_modify; ?></label>
            <div class="controls">
							<div class="scrollbox">
                <?php $class = 'odd'; ?>
                <?php foreach ($permissions as $permission) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
									<label class="checkbox inline">
										<input type="checkbox" name="permission[modify][]" value="<?php echo $permission; ?>"<?php if (in_array($permission, $modify)) { ?> checked="checked"<?php } ?>>
										<?php echo $permission; ?>
									</label>
                </div>
                <?php } ?>
              </div>
							<br>
              <a class="btn btn-small" href="#" onclick="$(this).parent().find(':checkbox').attr('checked', true);return false;">
								<i class="icon-cb-checked"></i>
								<?php echo $text_select_all; ?>
							</a>
							<a class="btn btn-small" href="#" onclick="$(this).parent().find(':checkbox').attr('checked', false);return false;">
								<i class="icon-cb-unchecked"></i>
								<?php echo $text_unselect_all; ?>
							</a>
						</div>
          </div>
        </div>
      </form>

    </div>
  </div>
</div>

<?php echo $footer; ?>