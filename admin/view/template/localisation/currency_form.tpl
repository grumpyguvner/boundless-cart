<?php echo $header; ?>

<div id="content">

	<?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">
    <div class="heading">
      <h1><i class="icon-dollar"></i> <?php echo $heading_title; ?></h1>
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
        <table class="form">
          <div class="control-group<?php if ($error_title) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_title; ?></label>
            <div class="controls">
							<input type="text" name="title" value="<?php echo $title; ?>" class="span2">
              <?php if ($error_title) { ?>
              <span class="error help-block"><?php echo $error_title; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_code) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_code; ?></label>
            <div class="controls">
							<input type="text" name="code" value="<?php echo $code; ?>" class="span1">
              <?php if ($error_code) { ?>
              <span class="error help-block"><?php echo $error_code; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_symbol_left; ?></label>
            <div class="controls"><input type="text" name="symbol_left" value="<?php echo $symbol_left; ?>" class="span1"></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_symbol_right; ?></label>
            <div class="controls"><input type="text" name="symbol_right" value="<?php echo $symbol_right; ?>" class="span1"></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_decimal_place; ?></label>
            <div class="controls"><input type="text" name="decimal_place" value="<?php echo $decimal_place; ?>" class="span1"></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_value; ?></label>
            <div class="controls"><input type="text" name="value" value="<?php echo $value; ?>" class="span2"></div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="status" class="span2">
								<?php echo p3html::oc_status_options($this->language, $status);?>
              </select>
						</div>
          </div>
        </table>
      </form>

    </div>
  </div>
</div>
<?php echo $footer; ?>