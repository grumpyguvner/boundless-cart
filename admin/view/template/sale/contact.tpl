<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">
    <div class="heading">
      <h1><i class="icon-email"></i> <?php echo $heading_title; ?></h1>
      <div class="buttons form-actions form-actions-top">
				<a id="button-send" onclick="send('index.php?route=sale/contact/send&token=<?php echo $token; ?>');" class="btn btn-primary"><i class="icon-mail"></i> <?php echo $button_send; ?></a>
				<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
			</div>
    </div>

    <div class="content">

			<div id="mail" class="form form-horizontal">

				<div class="control-group">
					<label class="control-label"><?php echo $entry_store; ?></label>
					<div class="controls">
						<select name="store_id" class="span3 i-large">
							<option value="0"><?php echo $text_default; ?></option>
							<?php echo p3html::oc_store_options($stores); ?>
						</select>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label"><?php echo $entry_to; ?></label>
					<div class="controls">
						<select name="to" class="span4 i-xlarge">
							<option value="newsletter"><?php echo $text_newsletter; ?></option>
							<option value="customer_all"><?php echo $text_customer_all; ?></option>
							<option value="customer_group"><?php echo $text_customer_group; ?></option>
							<option value="customer"><?php echo $text_customer; ?></option>
							<option value="affiliate_all"><?php echo $text_affiliate_all; ?></option>
							<option value="affiliate"><?php echo $text_affiliate; ?></option>
							<option value="product"><?php echo $text_product; ?></option>
						</select>
					</div>
				</div>

				<div id="to-customer-group" class="to control-group">
					<label class="control-label"><?php echo $entry_customer_group; ?></label>
					<div class="controls">
						<select name="customer_group_id" class="span3">
							<?php echo p3html::oc_customer_group_options($customer_groups); ?>
						</select>
					</div>
				</div>

				<div id="to-customer" class="to control-group">
					<label class="control-label"><?php echo $entry_customer; ?></label>
					<div class="controls control-row">
						<input type="text" name="customers" value="" class="span3"><br><br>
						<div id="customer" class="scrollbox"></div>
					</div>
				</div>

				<div id="to-affiliate" class="to control-group">
					<label class="control-label"><?php echo $entry_affiliate; ?></label>
					<div class="controls control-row">
						<input type="text" name="affiliates" value="" class="span3"><br><br>
						<div id="affiliate" class="scrollbox"></div>
					</div>
				</div>

				<div id="to-product" class="to control-group">
					<label class="control-label"><?php echo $entry_product; ?></label>
					<div class="controls control-row">
						<input type="text" name="products" value="" class="span3"><br><br>
						<div id="product" class="scrollbox"></div>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_subject; ?></label>
					<div class="controls">
						<input type="text" name="subject" value="" class="span6 i-xxlarge">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_message; ?></label>
					<div class="controls">
						<textarea name="message" class="input-block-level" rows="8">

						</textarea></div>
				</div>

			</div>

    </div>
  </div>
</div>

<script src="<?php echo P3_CKEDITOR_DIR; ?>/ckeditor.js"></script>
<script>
<?php echo p3html::oc_ckeditor_replace('message', $token); ?>
</script>

<script>
$('select[name="to"]').bind('change', function() {
	$('#mail .to').hide();

	$('#mail #to-' + $(this).attr('value').replace('_', '-')).show();
});

$('select[name="to"]').trigger('change');
</script>

<script>
$.widget('custom.catcomplete', $.ui.autocomplete, {
	_renderMenu: function(ul, items) {
		var self = this, currentCategory = '';

		$.each(items, function(index, item) {
			if (item.category != currentCategory) {
				ul.append('<li class="ui-autocomplete-category">' + item.category + '</li>');

				currentCategory = item.category;
			}

			self._renderItem(ul, item);
		});
	}
});

$('input[name="customers"]').catcomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/customer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						category: item.customer_group,
						label: item.name,
						value: item.customer_id
					}
				}));
			}
		});

	},
	select: function(event, ui) {
		$('#customer' + ui.item.value).remove();

		$('#customer').append('<div id="customer' + ui.item.value + '"><i class="btn btn-mini icon-trash"></i> ' + ui.item.label + '<input type="hidden" name="customer[]" value="' + ui.item.value + '"></div>');

		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

$('#customer div i').live('click', function() {
	$(this).parent().remove();

});
</script>

<script>
$('input[name="affiliates"]').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/affiliate/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.affiliate_id
					}
				}));
			}
		});

	},
	select: function(event, ui) {
		$('#affiliate' + ui.item.value).remove();

		$('#affiliate').append('<div id="affiliate' + ui.item.value + '"><i class="btn btn-mini icon-trash"></i> ' + ui.item.label + '<input type="hidden" name="affiliate[]" value="' + ui.item.value + '"></div>');

		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

$('#affiliate div i').live('click', function() {
	$(this).parent().remove();
});

$('input[name="products"]').autocomplete({
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
		$('#product' + ui.item.value).remove();

		$('#product').append('<div id="product' + ui.item.value + '"><i class="btn btn-mini icon-trash"></i> ' + ui.item.label + '<input type="hidden" name="product[]" value="' + ui.item.value + '"></div>');

		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

$('#product div i').live('click', function() {
	$(this).parent().remove();
});

function send(url) {
	$('textarea[name="message"]').html($('textarea[name="message"]').val());

	$.ajax({
		url: url,
		type: 'post',
		data: $('select, input, textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-send').attr('disabled', true);
			$('#button-send').before('<span class="wait"><img src="view/image/loading.gif" alt="">&nbsp;</span>');
		},
		complete: function() {
			$('#button-send').attr('disabled', false);
			$('.wait').remove();
		},
		success: function(json) {
			$('.success, .warning, .error').remove();

			if (json['error']) {
				if (json['error']['warning']) {
					$('.box').before('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');

					$('.warning').fadeIn('slow');
				}

				if (json['error']['subject']) {
					$('input[name="subject"]').after('<span class="error">' + json['error']['subject'] + '</span>');
				}

				if (json['error']['message']) {
					$('textarea[name="message"]').parent().append('<span class="error">' + json['error']['message'] + '</span>');
				}
			}

			if (json['next']) {
				if (json['success']) {
					$('.box').before('<div class="success">' + json['success'] + '</div>');

					send(json['next']);
				}
			} else {
				if (json['success']) {
					$('.box').before('<div class="success" style="display: none;">' + json['success'] + '</div>');

					$('.success').fadeIn('slow');
				}
			}
		}
	});
}
</script>

<?php echo $footer; ?>