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
      <div class="buttons"><!--<a onclick="location = '<?php //echo $insert; ?>'" class="button"><?php //echo $button_insert; ?></a>--><a onclick="document.getElementById('form').submit();" class="button"><?php echo $button_redeem; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $redeemCode; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php if ($sort == 'redeem_id') { ?>
                <a href="<?php echo $sort_code; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_redeem_id; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_code; ?>"><?php echo $column_redeem_id; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'product_id') { ?>
                <a href="<?php echo $sort_from; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_product_id; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_from; ?>"><?php echo $column_product_id; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'order_id') { ?>
                <a href="<?php echo $sort_to; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_order_id; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_to; ?>"><?php echo $column_order_id; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'code') { ?>
                <a href="<?php echo $sort_amount; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_code; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_amount; ?>"><?php echo $column_code; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'status') { ?>
                <a href="<?php echo $sort_theme; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_theme; ?>"><?php echo $column_status; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'redeem') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_redeem; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_redeem; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'date_added') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_date_added; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
              <tr class="filter">
              <td></td>
              <td align="right"><input type="text" name="filter_redeem_id" value="<?php echo $filter_redeem_id; ?>" size="4" style="text-align: right;" /></td>
              <td align="left"><input type="text" name="filter_product_id" value="<?php echo $filter_product_id; ?>" size="4" style="text-align: right;" /></td>
              <td align="right"><input type="text" name="filter_order_id" value="<?php echo $filter_order_id; ?>" size="4" style="text-align: right;" /></td>
              <td align="left"><input type="text" name="filter_code" value="<?php echo $filter_code; ?>" size="10" /></td>
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
              <td><select name="filter_redeem">
                  <option value="*"></option>
                  <?php if ($filter_redeem) { ?>
                  <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_yes; ?></option>
                  <?php } ?>
                  <?php if (!is_null($filter_redeem) && !$filter_redeem) { ?>
                  <option value="0" selected="selected"><?php echo $text_no; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_no; ?></option>
                  <?php } ?>
                </select></td>
              <td><input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" size="12" class="date" /></td>
              <td align="right"><a onclick="filter();" class="button"><?php echo $button_filter; ?></a></td>
            </tr>
            <?php if ($redeems) { ?>
            <?php foreach ($redeems as $redeem) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($redeem['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $redeem['redeem_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $redeem['redeem_id']; ?>" />
                <?php } ?></td>
              <td class="right"><?php echo $redeem['redeem_id']; ?></td>
              <td class="left"><a href="<?php echo $redeem['product_link']; ?>"><?php echo $redeem['product_id']; ?></a> - <?php echo $redeem['product_model']; ?></td>
              <td class="right"><a href="<?php echo $redeem['order_link']; ?>"><?php echo $redeem['order_id']; ?></a></td>
              <td class="left"><?php echo $redeem['code']; ?></td>
              <td class="left">
                  <?php
                    if ($redeem['status']) {
                        echo $text_enabled;
                    } else {
                        echo $text_disabled;
                    }
                  ?>
              </td>
              <td class="left">
                  <?php
                    if ($redeem['redeem']) {
                        echo $text_yes;
                    } else {
                        echo $text_no;
                    }
                  ?>
              </td>
              <td class="left"><?php echo $redeem['date_added']; ?></td>
              <td class="right">
                <?php foreach ($redeem['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="9"><?php echo $text_no_results; ?></td>
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
function filter() {
	url = 'index.php?route=sale/redeem&token=<?php echo $token; ?>';
	
	var filter_redeem_id = $('input[name=\'filter_redeem_id\']').attr('value');
	
	if (filter_redeem_id) {
		url += '&filter_redeem_id=' + encodeURIComponent(filter_redeem_id);
	}
        
	var filter_product_id = $('input[name=\'filter_product_id\']').attr('value');
	
	if (filter_product_id) {
		url += '&filter_product_id=' + encodeURIComponent(filter_product_id);
	}
        
	var filter_order_id = $('input[name=\'filter_order_id\']').attr('value');
	
	if (filter_order_id) {
		url += '&filter_order_id=' + encodeURIComponent(filter_order_id);
        }
        
	var filter_code = $('input[name=\'filter_code\']').attr('value');
	
	if (filter_code) {
		url += '&filter_code=' + encodeURIComponent(filter_code);
	}
        
	var filter_status = $('select[name=\'filter_status\']').attr('value');
	
	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}	
        
	var filter_redeem = $('select[name=\'filter_redeem\']').attr('value');
	
	if (filter_redeem != '*') {
		url += '&filter_redeem=' + encodeURIComponent(filter_redeem);
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