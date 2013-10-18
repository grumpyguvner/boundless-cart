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
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/payment.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-general"><?php echo $tab_general; ?></a></div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <table class="form">
            <!--<tr>
              <td><?php echo $entry_product_id; ?></td>
              <td><input type="text" name="product_id" value="<?php echo $product_id; ?>" />
                <?php if ($error_product_id) { ?>
                <span class="error"><?php echo $error_product_id; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_order_id; ?></td>
              <td><input type="text" name="order_id" value="<?php echo $order_id; ?>" />
                <?php if ($error_order_id) { ?>
                <span class="error"><?php echo $error_order_id; ?></span>
                <?php } ?></td>
            </tr>-->
            <tr>
              <td><?php echo $entry_product_id; ?></td>
              <td><a href="<?php echo $product_link; ?>"><?php echo $product_id ?></a>  - <?php echo $product_model; ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_order_id; ?></td>
              <td><a href="<?php echo $order_link; ?>"><?php echo $order_id; ?></a></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_code; ?></td>
              <td><input type="text" name="code" value="<?php echo $code; ?>" />
                <?php if ($error_code) { ?>
                <span class="error"><?php echo $error_code; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_status; ?></td>
              <td><select name="status">
                  <?php if ($status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_redeem; ?></td>
              <td><select name="redeem">
                  <?php if ($redeem) { ?>
                  <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                  <option value="0"><?php echo $text_no; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_yes; ?></option>
                  <option value="0" selected="selected"><?php echo $text_no; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<?php if ($redeem_id) { ?>
<script type="text/javascript"><!--
$('#history .pagination a').live('click', function() {
	$('#history').load(this.href);
	
	return false;
});			

$('#history').load('index.php?route=sale/redeem/history&token=<?php echo $token; ?>&redeem_id=<?php echo $redeem_id; ?>');
//--></script>
<?php } ?>
<script type="text/javascript"><!--
$('#tabs a').tabs(); 
//--></script> 
<?php echo $footer; ?>