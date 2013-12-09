<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-ticket"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_save($button_save); ?>
				<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
			</div>
    </div>

    <div class="content">

      <ul id="tabs" class="htabs nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#tab-general"><i class="icon-eye"></i> <?php echo $tab_general; ?></a></li>
        <?php if ($voucher_id) { ?>
        <li><a data-toggle="tab" href="#tab-history"><i class="icon-clock"></i> <?php echo $tab_voucher_history; ?></a></li>
        <?php } ?>
      </ul>

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
			<div class="tab-content">

        <div class="tab-pane active" id="tab-general">
          <div class="form">
            <div class="control-group<?php if ($error_code) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_code; ?></label>
              <div class="controls">
								<input type="text" name="code" value="<?php echo $code; ?>" class="span2">
                <?php if ($error_code) { ?>
                <span class="error help-block"><?php echo $error_code; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_from_name) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_from_name; ?></label>
              <div class="controls">
								<input type="text" name="from_name" value="<?php echo $from_name; ?>" class="span4">
                <?php if ($error_from_name) { ?>
                <span class="error help-block"><?php echo $error_from_name; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_from_email) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_from_email; ?></label>
              <div class="controls">
								<input type="text" name="from_email" value="<?php echo $from_email; ?>" class="span4">
                <?php if ($error_from_email) { ?>
                <span class="error help-block"><?php echo $error_from_email; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_to_name) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_to_name; ?></label>
              <div class="controls">
								<input type="text" name="to_name" value="<?php echo $to_name; ?>" class="span4">
                <?php if ($error_to_name) { ?>
                <span class="error help-block"><?php echo $error_to_name; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group<?php if ($error_to_email) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_to_email; ?></label>
              <div class="controls">
								<input type="text" name="to_email" value="<?php echo $to_email; ?>" class="span4">
                <?php if ($error_to_email) { ?>
                <span class="error help-block"><?php echo $error_to_email; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_theme; ?></label>
              <div class="controls">
								<select name="voucher_theme_id" class="span3">
									<?php echo p3html::oc_voucher_theme_options($voucher_themes, $voucher_theme_id); ?>
                </select>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_message; ?></label>
              <div class="controls">
								<textarea name="message" class="span6 i-xxlarge" rows="5"><?php echo $message; ?></textarea>
							</div>
            </div>
            <div class="control-group<?php if ($error_amount) { ?> error<?php } ?>">
              <label class="control-label"><?php echo $entry_amount; ?></label>
              <div class="controls">
								<input type="text" name="amount" value="<?php echo $amount; ?>">
                <?php if ($error_amount) { ?>
                <span class="error help-block"><?php echo $error_amount; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
								<select name="status" class="span2">
									<?php echo p3html::oc_status_options($this->language, $status); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <?php if ($voucher_id) { ?>
        <div class="tab-pane" id="tab-history">
          <div id="history"></div>
        </div>
        <?php } ?>

			</div>
      </form>

    </div>
  </div>
</div>

<?php if ($voucher_id) { ?>
<script>
$(document).on('click', '#history .pagination a', function() {
	$('#history').load(this.href);

	return false;
});

$('#history').load('index.php?route=sale/voucher/history&token=<?php echo $token; ?>&voucher_id=<?php echo $voucher_id; ?>');
</script>
<?php } ?>

<?php echo $footer; ?>