<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-newspaper"></i> <?php echo $heading_title; ?></h1>

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
          <div class="control-group<?php if ($error_author) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_author; ?></label>
            <div class="controls">
							<input type="text" name="author" value="<?php echo $author; ?>" class="span3">
              <?php if ($error_author) { ?>
              <span class="error help-block"><?php echo $error_author; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_product) { ?> error<?php } ?>">
            <label class="control-label"><?php echo $entry_product; ?></label>
            <div class="controls">
							<input type="text" name="product" value="<?php echo $product; ?>" class="span4">
              <input type="hidden" name="product_id" value="<?php echo $product_id; ?>">
              <?php if ($error_product) { ?>
              <span class="error help-block"><?php echo $error_product; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_text) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_text; ?></label>
            <div class="controls">
							<textarea name="text" class="input-block-level" rows="8"><?php echo $text; ?></textarea>
              <?php if ($error_text) { ?>
              <span class="error help-block"><?php echo $error_text; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_rating) { ?> error<?php } ?>">
            <label class="control-label"><?php echo $entry_rating; ?></label>
            <div class="controls">
							<b class="rating"><?php echo $entry_bad; ?></b>
							&nbsp;
              <input type="radio" name="rating" value="1"<?php if ($rating == 1) { ?> checked="checked"<?php } ?>>
              &nbsp;
              <input type="radio" name="rating" value="2"<?php if ($rating == 2) { ?> checked="checked"<?php } ?>>
              &nbsp;
              <input type="radio" name="rating" value="3"<?php if ($rating == 3) { ?> checked="checked"<?php } ?>>
              &nbsp;
              <input type="radio" name="rating" value="4"<?php if ($rating == 4) { ?> checked="checked"<?php } ?>>
              &nbsp;
              <input type="radio" name="rating" value="5"<?php if ($rating == 5) { ?> checked="checked"<?php } ?>>
              &nbsp;
							<b class="rating"><?php echo $entry_good; ?></b>
              <?php if ($error_rating) { ?>
              <span class="error help-block"><?php echo $error_rating; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_reply; ?></label>
            <div class="controls">
		<textarea name="reply" class="input-block-level" rows="8"><?php echo $reply; ?></textarea>					
            </div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="status" class="span2">
                <option value="1"<?php if ($status) { ?> selected="selected"<?php } ?>><?php echo $text_enabled; ?></option>
                <option value="0"<?php if(!$status) { ?> selected="selected"<?php } ?>><?php echo $text_disabled; ?></option>
              </select>
						</div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
$('input[name=\'product\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'product\']').val(ui.item.label);
		$('input[name=\'product_id\']').val(ui.item.value);

		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});
</script>
<?php echo $footer; ?>