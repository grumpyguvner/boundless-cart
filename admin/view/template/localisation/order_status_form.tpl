<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-clipboard"></i> <?php echo $heading_title; ?></h1>
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
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
            <div class="controls">
							<?php foreach ($languages as $language) { ?>
							<div class="language-row<?php if (isset($error_name[$language['language_id']])) { ?> error<?php } ?>">
								<input type="text" name="order_status[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($order_status[$language['language_id']]) ? $order_status[$language['language_id']]['name'] : ''; ?>" class="span3">
								<i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i>
								<?php if (isset($error_name[$language['language_id']])) { ?>
								<span class="error help-block"><?php echo $error_name[$language['language_id']]; ?></span><br>
								<?php } ?>
							</div>
              <?php } ?>
						</div>
          </div>
        </div>
      </form>

    </div>
  </div>
</div>
<?php echo $footer; ?>