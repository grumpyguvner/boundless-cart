<h2><?php echo $text_credit_card; ?></h2>
<div class="content">
<div class="content" id="payment">
    <div class="row">
      <label for="cc_owner" class="span2"><?php echo $entry_cc_owner; ?></label>
      <input type="text" name="cc_owner" value="<?php echo $cardholder; ?>" />
    </div>
    <div class="row">
      <label for="cc_type" class="span2"><?php echo $entry_cc_type; ?></label>
      <select name="cc_type">
          <?php foreach ($cards as $card) { ?>
          <option value="<?php echo $card['value']; ?>"><?php echo $card['text']; ?></option>
          <?php } ?>
        </select>
    </div>
    <div class="row">
      <label for="cc_number" class="span2"><?php echo $entry_cc_number; ?></label>
      <input type="text" name="cc_number" value="" />
    </div>
    <div class="row">
      <label for="cc_start_date_month" class="span2"><?php echo $entry_cc_start_date; ?></label>
      <select name="cc_start_date_month" class="span1">
          <?php foreach ($months as $month) { ?>
          <option value="<?php echo $month['value']; ?>"><?php echo $month['value']; ?></option>
          <?php } ?>
        </select>
        /
        <select name="cc_start_date_year" class="span2">
          <?php foreach ($year_valid as $year) { ?>
          <option value="<?php echo $year['value']; ?>"><?php echo $year['text']; ?></option>
          <?php } ?>
        </select>
        <?php echo $text_start_date; ?>
    </div>
    <div class="row">
      <label for="cc_expire_date_month" class="span2"><?php echo $entry_cc_expire_date; ?></label>
      <select name="cc_expire_date_month" class="span1">
          <?php foreach ($months as $month) { ?>
          <option value="<?php echo $month['value']; ?>"><?php echo $month['value']; ?></option>
          <?php } ?>
        </select>
        /
        <select name="cc_expire_date_year" class="span2">
          <?php foreach ($year_expire as $year) { ?>
          <option value="<?php echo $year['value']; ?>"><?php echo $year['text']; ?></option>
          <?php } ?>
        </select>
    </div>
    <div class="row">
      <label for="cc_cvv2" class="span2"><?php echo $entry_cc_cvv2; ?></label>
      <input type="text" name="cc_cvv2" value="" size="3" />
        <?php echo $text_cvv2; ?>
    </div>
    <div class="row">
      <label for="cc_issue" class="span2"><?php echo $entry_cc_issue; ?></label>
      <input type="text" name="cc_issue" value="" size="1" />
        <?php echo $text_issue; ?>
    </div>
</div>
<div class="buttons">
  <div class="right">
    <input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="button" />
  </div>
</div>
</div>
<script type="text/javascript"><!--
$('#button-confirm').bind('click', function() {
	$.ajax({
		url: 'index.php?route=payment/sagepay_direct/send',
		type: 'post',
		data: $('#payment :input'),
		dataType: 'json',		
		beforeSend: function() {
			$('#button-confirm').attr('disabled', true);
                        $('.warning').remove();
			$('#payment').before('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-confirm').attr('disabled', false);
			$('.attention').remove();
		},				
		success: function(json) {
			if (json['ACSURL']) {
				$('#3dauth').remove();
				
				html  = '<form action="' + json['ACSURL'] + '" method="post" id="3dauth">';
				html += '<input type="hidden" name="MD" value="' + json['MD'] + '" />';
				html += '<input type="hidden" name="PaReq" value="' + json['PaReq'] + '" />';
				html += '<input type="hidden" name="TermUrl" value="' + json['TermUrl'] + '" />';
				html += '</form>';
				
				$('#payment').after(html);
				
				$('#3dauth').submit();
			}
			
			if (json['error']) {
                                $('#payment').before('<div class="warning" style="display: none;">' + json['error'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                                $('.warning').fadeIn('slow');
			}
			
			if (json['success']) {
				location = json['success'];
			}
		}
	});
});
//--></script> 
