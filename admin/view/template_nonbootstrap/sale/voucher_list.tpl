<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/payment.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="location = '<?php echo $insert; ?>'" class="button"><?php echo $button_insert; ?></a><a onclick="document.getElementById('form').submit();" class="button"><?php echo $button_delete; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php if ($sort == 'v.code') { ?>
                <a href="<?php echo $sort_code; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_code; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_code; ?>"><?php echo $column_code; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'v.from_name') { ?>
                <a href="<?php echo $sort_from; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_from; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_from; ?>"><?php echo $column_from; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'v.to_name') { ?>
                <a href="<?php echo $sort_to; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_to; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_to; ?>"><?php echo $column_to; ?></a>
                <?php } ?></td>
              <td class="right"><?php if ($sort == 'v.amount') { ?>
                <a href="<?php echo $sort_amount; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_amount; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_amount; ?>"><?php echo $column_amount; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'theme') { ?>
                <a href="<?php echo $sort_theme; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_theme; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_theme; ?>"><?php echo $column_theme; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'v.status') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'used') { ?>
                <a href="<?php echo $sort_used; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_used; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_used; ?>"><?php echo $column_used; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'v.date_added') { ?>
                <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
              <tr class="filter">
              <td></td>
              <td align="left"><input type="text" name="filter_code" value="<?php echo $filter_code; ?>" size="10" /></td>
              <td align="left"><input type="text" name="filter_from" value="<?php echo $filter_from; ?>" size="10" /></td>
              <td align="left"><input type="text" name="filter_to" value="<?php echo $filter_to; ?>" size="10" /></td>
              <td align="right"><input type="text" name="filter_amount" value="<?php echo $filter_amount; ?>" size="4" style="text-align: right;" /></td>
              <td><select name="filter_theme_id">
                  <option value="*"></option>
                  <?php foreach ($voucher_themes as $theme) { ?>
                  <?php if ($theme['voucher_theme_id'] == $filter_theme_id) { ?>
                  <option value="<?php echo $theme['voucher_theme_id']; ?>" selected="selected"><?php echo $theme['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $theme['voucher_theme_id']; ?>"><?php echo $theme['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
              <td><select name="filter_status">
                  <option value="*"></option>
                  <?php if ($filter_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if (!is_null($filter_status) && !$filter_status) { ?>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
              <td><select name="filter_used">
                  <option value="*"></option>
                  <?php if ($filter_used) { ?>
                  <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_yes; ?></option>
                  <?php } ?>
                  <?php if (!is_null($filter_used) && !$filter_used) { ?>
                  <option value="0" selected="selected"><?php echo $text_no; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_no; ?></option>
                  <?php } ?>
                </select></td>
              <td><input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" size="12" class="date" /></td>
              <td align="right"><a onclick="filter();" class="button"><?php echo $button_filter; ?></a></td>
            </tr>
            <?php if ($vouchers) { ?>
            <?php foreach ($vouchers as $voucher) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($voucher['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $voucher['voucher_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $voucher['voucher_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $voucher['code']; ?></td>
              <td class="left"><?php echo $voucher['from']; ?></td>
              <td class="left"><?php echo $voucher['to']; ?></td>
              <td class="right"><?php echo $voucher['amount']; ?><?php if (!empty($voucher['spent'])) echo ' (' . $voucher['spent'] . ')'; ?></td>
              <td class="left"><?php echo $voucher['theme']; ?></td>
              <td class="left"><?php echo $voucher['status']; ?></td>
              <td class="left"><?php echo $voucher['used']; ?></td>
              <td class="left"><?php echo $voucher['date_added']; ?></td>
              <td class="right">[ <a onclick="sendVoucher('<?php echo $voucher['voucher_id']; ?>');"><?php echo $text_send; ?></a> ]
                <?php foreach ($voucher['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="10"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function sendVoucher(voucher_id) {
	$.ajax({
		url: 'index.php?route=sale/voucher/send&token=<?php echo $token; ?>&voucher_id=' + voucher_id,
		type: 'post',
		dataType: 'json',
		beforeSend: function() {
			$('.success, .warning').remove();
			$('.box').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('.attention').remove();
		},
		success: function(json) {
			if (json['error']) {
				$('.box').before('<div class="warning">' + json['error'] + '</div>');
			}
			
			if (json['success']) {
				$('.box').before('<div class="success">' + json['success'] + '</div>');
			}		
		}
	});
}
//--></script>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=sale/voucher&token=<?php echo $token; ?>';
	
	var filter_code = $('input[name=\'filter_code\']').attr('value');
	
	if (filter_code) {
		url += '&filter_code=' + encodeURIComponent(filter_code);
	}
        
	var filter_from = $('input[name=\'filter_from\']').attr('value');
	
	if (filter_from) {
		url += '&filter_from=' + encodeURIComponent(filter_from);
	}
        
	var filter_to = $('input[name=\'filter_to\']').attr('value');
	
	if (filter_to) {
		url += '&filter_to=' + encodeURIComponent(filter_to);
        }
        
	var filter_amount = $('input[name=\'filter_amount\']').attr('value');
	
	if (filter_amount) {
		url += '&filter_amount=' + encodeURIComponent(filter_amount);
	}
        
	var filter_status = $('select[name=\'filter_status\']').attr('value');
	
	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}	
        
	var filter_theme_id = $('select[name=\'filter_theme_id\']').attr('value');
	
	if (filter_theme_id != '*') {
		url += '&filter_theme_id=' + encodeURIComponent(filter_theme_id);
	}	
        
	var filter_status = $('select[name=\'filter_status\']').attr('value');
	
	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}	
        
	var filter_used = $('select[name=\'filter_used\']').attr('value');
	
	if (filter_used != '*') {
		url += '&filter_used=' + encodeURIComponent(filter_used);
	}
	
	var filter_date_added = $('input[name=\'filter_date_added\']').attr('value');
	
	if (filter_date_added) {
		url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
	}
	
				
	location = url;
}
//--></script>  
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
});
//--></script> 
<script type="text/javascript"><!--
$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		filter();
	}
});
//--></script> 
<?php echo $footer; ?>