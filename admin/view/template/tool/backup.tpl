<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

	<div class="box">

    <div class="heading">
      <h1><i class="icon-archive"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
			<?php if ($success) { ?>
				<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<a onclick="$('#restore').submit();" class="btn"><i class="icon-back-in-time"></i> <?php echo $button_restore; ?></a>
				<a onclick="$('#backup').submit();" class="btn"><i class="icon-floppy"></i> <?php echo $button_backup; ?></a>
			</div>
    </div>

    <div class="content">

      <form action="<?php echo $restore; ?>" method="post" enctype="multipart/form-data" id="restore" class="form-horizontal">
        <div class="form">
          <div class="control-group">
            <label class="control-label"><?php echo $entry_restore; ?></label>
            <div class="controls"><input type="file" name="import" class="span3"></div>
          </div>
        </div>
      </form>

      <form action="<?php echo $backup; ?>" method="post" enctype="multipart/form-data" id="backup" class="form-horizontal">
        <div class="form">
          <div class="control-group">
            <label class="control-label"><?php echo $entry_backup; ?></label>
            <div class="controls">
							<div class="scrollbox" style="margin-bottom: 1em">
                <?php $class = 'odd'; $count=0; ?>
                <?php foreach ($tables as $table) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
									<label class="checkbox inline" for="db-table-<?php echo $count; ?>">
										<input id="db-table-<?php echo $count; ?>" type="checkbox" name="backup[]" value="<?php echo $table; ?>" checked="checked">
										<?php echo $table; ?>
									</label>
								</div>
								<?php $count++; ?>
                <?php } ?>
              </div>
              <a class="btn btn-small" onclick="$(this).parent().find(':checkbox').attr('checked', true);"><i class="icon-cb-checked"></i> <?php echo $text_select_all; ?></a>
							<a class="btn btn-small" onclick="$(this).parent().find(':checkbox').attr('checked', false);"><i class="icon-cb-unchecked"></i> <?php echo $text_unselect_all; ?></a>
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>