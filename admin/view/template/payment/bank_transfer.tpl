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
        <div class="form">
          <div class="control-group">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_bank; ?></label>
            <div class="controls">
	          <?php foreach ($languages as $language) { ?>
							<?php $error = isset(${'error_bank_' . $language['language_id']}) ? ${'error_bank_' . $language['language_id']} : null; ?>
							<div class="language-row<?php if ($error) { ?> error<?php } ?>">
								<textarea name="bank_transfer_bank_<?php echo $language['language_id']; ?>" class="span8" rows="10"><?php echo isset(${'bank_transfer_bank_' . $language['language_id']}) ? ${'bank_transfer_bank_' . $language['language_id']} : ''; ?></textarea>
								&nbsp;<i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i>
								<?php if ($error) { ?>
								<span class="error help-block"><?php echo ${'error_bank_' . $language['language_id']}; ?></span>
								<?php } ?>
							</div>
		          <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_total; ?></label>
            <div class="controls">
							<input type="text" name="bank_transfer_total" value="<?php echo $bank_transfer_total; ?>" class="span2">
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_order_status; ?></label>
            <div class="controls">
							<select name="bank_transfer_order_status_id" class="span3">
								<?php echo p3html::oc_order_status_options($order_statuses, $bank_transfer_order_status_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_geo_zone; ?></label>
            <div class="controls">
							<select name="bank_transfer_geo_zone_id" class="span3">
                <option value="0"><?php echo $text_all_zones; ?></option>
								<?php echo p3html::oc_geo_zone_options($geo_zones, $bank_transfer_geo_zone_id); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="bank_transfer_status" class="span2">
								<?php echo p3html::oc_status_options($this->language, (int)$bank_transfer_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
							<input type="text" name="bank_transfer_sort_order" value="<?php echo $bank_transfer_sort_order; ?>" class="span1 i-mini">
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>