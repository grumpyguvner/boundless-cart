<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-keyboard"></i> <?php echo $heading_title; ?></h1>
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
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="credit_status" class="span2 i-small">
								<?php echo p3html::oc_status_options($this->language, (int)$credit_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="credit_sort_order" value="<?php echo $credit_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>