<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-back"></i> <?php echo $heading_title; ?></h1>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
			</div>
    </div>

    <div class="content">
		<div class="tabbable tabs-left">

      <ul class="vtabs nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#tab-return"><i class="icon-eye"></i> <?php echo $tab_return; ?></a></li>
				<li><a data-toggle="tab" href="#tab-product"><i class="icon-list"></i> <?php echo $tab_product; ?></a></li>
				<li><a data-toggle="tab" href="#tab-history"><i class="icon-clock"></i> <?php echo $tab_return_history; ?></a></li>
			</ul>

			<div class="tab-content">

      <div class="tab-pane active" id="tab-return" class="vtabs-content">
        <table class="form table table-hover">
          <tr>
            <th class="span3"><?php echo $text_return_id; ?></th>
            <td class="span9"><?php echo $return_id; ?></td>
          </tr>
          <?php if ($order) { ?>
          <tr>
            <th><?php echo $text_order_id; ?></th>
            <td><a href="<?php echo $order; ?>"><?php echo $order_id; ?></a></td>
          </tr>
          <?php } else { ?>
          <tr>
            <th><?php echo $text_order_id; ?></th>
            <td><?php echo $order_id; ?></td>
          </tr>
          <?php } ?>
          <tr>
            <th><?php echo $text_date_ordered; ?></th>
            <td><?php echo $date_ordered; ?></td>
          </tr>
          <?php if ($customer) { ?>
          <tr>
            <th><?php echo $text_customer; ?></th>
            <td><a href="<?php echo $customer; ?>"><?php echo $firstname; ?> <?php echo $lastname; ?></a></td>
          </tr>
          <?php } else { ?>
          <tr>
            <th><?php echo $text_customer; ?></th>
            <td><?php echo $firstname; ?> <?php echo $lastname; ?></td>
          </tr>
          <?php } ?>
          <tr>
            <th><?php echo $text_email; ?></th>
            <td><?php echo $email; ?></td>
          </tr>
          <tr>
            <th><?php echo $text_telephone; ?></th>
            <td><?php echo $telephone; ?></td>
          </tr>
          <?php if ($return_status) { ?>
          <tr>
            <th><?php echo $text_return_status; ?></th>
            <td id="return-status"><?php echo $return_status; ?></td>
          </tr>
          <?php } ?>
          <tr>
            <th><?php echo $text_date_added; ?></th>
            <td><?php echo $date_added; ?></td>
          </tr>
          <tr>
            <th><?php echo $text_date_modified; ?></th>
            <td><?php echo $date_modified; ?></td>
          </tr>
        </table>
      </div>

      <div class="tab-pane" id="tab-product" class="vtabs-content">
        <table class="form table table-hover">
          <tr>
            <th class="span3"><?php echo $text_product; ?></th>
            <td class="span9"><?php echo $product; ?></td>
          </tr>
          <tr>
            <th><?php echo $text_model; ?></th>
            <td><?php echo $model; ?></td>
          </tr>
          <tr>
            <th><?php echo $text_price; ?></th>
            <td><?php echo $price; ?></td>
          </tr>
          <tr>
            <th><?php echo $text_quantity; ?></th>
            <td><?php echo $quantity; ?></td>
          </tr>
          <tr>
            <th><?php echo $text_return_reason; ?></th>
            <td><?php echo $return_reason; ?></td>
          </tr>
          <tr>
            <th><?php echo $text_opened; ?></th>
            <td><?php echo $opened; ?></td>
          </tr>
          <tr>
            <th><?php echo $text_return_action; ?></th>
            <td>
							<select name="return_action_id" class="span3">
                <option value="0">&nbsp;</option>
								<?php echo p3html::oc_return_action_options($return_actions, $return_action_id); ?>
              </select>
						</td>
          </tr>
          <?php if ($comment) { ?>
          <tr>
            <th><?php echo $text_comment; ?></th>
            <td><?php echo $comment; ?></td>
          </tr>
          <?php } ?>
        </table>
      </div>

      <div class="tab-pane" id="tab-history" class="vtabs-content">
        <div id="history"></div>
        <table class="form table table-hover">
          <tr>
            <th class="span3"><?php echo $entry_return_status; ?></th>
            <td class="span9">
							<select name="return_status_id" class="span3">
								<?php echo p3html::oc_return_status_options($return_statuses, $return_status_id); ?>
              </select>
						</td>
          </tr>
          <tr>
            <th></th>
            <td>
							<label class="checkbox inline">
								<input type="checkbox" name="notify" value="1">
								<?php echo $entry_notify; ?>
							</label>
						</td>
          </tr>
          <tr>
            <th><?php echo $entry_comment; ?></th>
            <td>
							<textarea name="comment" rows="8" class="input-block-level"></textarea>
              <div style="margin-top: 10px; text-align: right;">
								<a onclick="history();" id="button-history" class="btn"><i class="icon-plus-squared"></i> <?php echo $button_add_history; ?></a>
							</div>
						</td>
          </tr>
        </table>
      </div>

			</div>

    </div>
		</div>

	</div>

</div>

<script>
$('select[name=\'return_action_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=sale/return/action&token=<?php echo $token; ?>&return_id=<?php echo $return_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'return_action_id=' + this.value,
		beforeSend: function() {
			$('.success, .warning, .attention').remove();

			$('.box .heading .buttons').before('<div class="attention"><img src="view/image/loading.gif" alt=""> <?php echo $text_wait; ?></div>');
		},
		success: function(json) {
			$('.success, .warning, .attention').remove();

			if (json['error']) {
				$('.box .heading .buttons').before('<div class="warning alert alert-error" style="display: none;"><button type="button" class="close" data-dismiss="alert">&times;</button>' + json['error'] + '</div>');

				$('.warning').fadeIn('slow');
			}

			if (json['success']) {
				$('.box .heading .buttons').before('<div class="success alert alert-success" style="display: none;"><button type="button" class="close" data-dismiss="alert">&times;</button>' + json['success'] + '</div>');

				$('.success').fadeIn('slow');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#history .pagination a').on('click', function() {
	$('#history').load(this.href);

	return false;
});

$('#history').load('index.php?route=sale/return/history&token=<?php echo $token; ?>&return_id=<?php echo $return_id; ?>');

function history() {
	$.ajax({
		url: 'index.php?route=sale/return/history&token=<?php echo $token; ?>&return_id=<?php echo $return_id; ?>',
		type: 'post',
		dataType: 'html',
		data: 'return_status_id=' + encodeURIComponent($('select[name=\'return_status_id\']').val()) + '&notify=' + encodeURIComponent($('input[name=\'notify\']').attr('checked') ? 1 : 0) + '&append=' + encodeURIComponent($('input[name=\'append\']').attr('checked') ? 1 : 0) + '&comment=' + encodeURIComponent($('textarea[name=\'comment\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-history').attr('disabled', true);
			$('#history').prepend('<div class="attention"><img src="view/image/loading.gif" alt=""> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-history').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(html) {
			$('#history').html(html);

			$('textarea[name=\'comment\']').val('');

			$('#return-status').html($('select[name=\'return_status_id\'] option:selected').text());
		}
	});
}
</script>

<?php echo $footer; ?>