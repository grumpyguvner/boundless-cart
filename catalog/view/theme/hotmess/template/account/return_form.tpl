<?php echo $header; ?>
 <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
	<?php if($breadcrumb == end($breadcrumbs)){ ?>
		<a class="last" href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
	<?php }else{ ?>
		<a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a>
    <?php } ?>
    <?php } ?>
</div>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <h1><?php echo $heading_title; ?></h1>
  <?php echo $text_description; ?>
  <form class="return-form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <h2><?php echo $text_order; ?></h2>
    <div class="content">
      <div class="left six columns alpha">
		<?php echo $entry_firstname; ?><span class="required">*</span> <br />
        <input type="text" name="firstname" value="<?php echo $firstname; ?>" class="large-field" />
        
        <?php if ($error_firstname) { ?>
        <span class="error"><?php echo $error_firstname; ?></span>
        <?php } ?>
        <br />
        <?php echo $entry_lastname; ?><span class="required">*</span> <br />
        <input type="text" name="lastname" value="<?php echo $lastname; ?>" class="large-field" />
        
        <?php if ($error_lastname) { ?>
        <span class="error"><?php echo $error_lastname; ?></span>
        <?php } ?>
        <br />
        <?php echo $entry_email; ?><span class="required">*</span> <br />
        <input type="text" name="email" value="<?php echo $email; ?>" class="large-field" />
       
        <?php if ($error_email) { ?>
        <span class="error"><?php echo $error_email; ?></span>
        <?php } ?>
        <br />
        <?php echo $entry_telephone; ?><span class="required">*</span> <br />
        <input type="text" name="telephone" value="<?php echo $telephone; ?>" class="large-field" />
       <br/>
        <?php if ($error_telephone) { ?>
        <span class="error"><?php echo $error_telephone; ?></span>
        <?php } ?>
        <br />
      </div>
      <div class="right six columns omega">
		<?php echo $entry_order_id; ?><span class="required">*</span> <br />
        <input type="text" name="order_id" value="<?php echo $order_id; ?>" class="large-field" />
        
        <?php if ($error_order_id) { ?>
        <span class="error"><?php echo $error_order_id; ?></span>
        <?php } ?>
        <br />
        <?php echo $entry_date_ordered; ?><br />
        <input type="text" name="date_ordered" value="<?php echo $date_ordered; ?>" class="large-field date" />
       
      </div>
    </div>
    <h2><?php echo $text_product; ?></h2>
    <div id="return-product">
      <div class="content">
        <div class="return-product">
          <div class="return-name four columns alpha">
			<b><?php echo $entry_product; ?></b><span class="required">*</span> <br />
            <input type="text" name="product" value="<?php echo $product; ?>" />
            <br />
            <?php if ($error_product) { ?>
            <span class="error"><?php echo $error_product; ?></span>
            <?php } ?>
          </div>
          <div class="return-model four columns">
			<b><?php echo $entry_model; ?></b><span class="required">*</span> <br />
            <input type="text" name="model" value="<?php echo $model; ?>" />
            <br />
            <?php if ($error_model) { ?>
            <span class="error"><?php echo $error_model; ?></span>
            <?php } ?>
          </div>
          <div class="return-quantity four columns omega">
			<b><?php echo $entry_quantity; ?></b><br />
            <input type="text" name="quantity" value="<?php echo $quantity; ?>" />
          </div>
        </div>
        <div class="return-detail">
          <div class="return-reason four columns alpha">
			<b><?php echo $entry_reason; ?></b><span class="required">*</span> <br />
            <table>
              <?php foreach ($return_reasons as $return_reason) { ?>
              <?php if ($return_reason['return_reason_id'] == $return_reason_id) { ?>
              <tr>
                <td width="1"><input type="radio" name="return_reason_id" value="<?php echo $return_reason['return_reason_id']; ?>" id="return-reason-id<?php echo $return_reason['return_reason_id']; ?>" checked="checked" /></td>
                <td><label for="return-reason-id<?php echo $return_reason['return_reason_id']; ?>"><?php echo $return_reason['name']; ?></label></td>
              </tr>
              <?php } else { ?>
              <tr>
                <td width="1"><input type="radio" name="return_reason_id" value="<?php echo $return_reason['return_reason_id']; ?>" id="return-reason-id<?php echo $return_reason['return_reason_id']; ?>" /></td>
                <td><label for="return-reason-id<?php echo $return_reason['return_reason_id']; ?>"><?php echo $return_reason['name']; ?></label></td>
              </tr>
              <?php  } ?>
              <?php  } ?>
            </table>
            <?php if ($error_reason) { ?>
            <span class="error"><?php echo $error_reason; ?></span>
            <?php } ?>
          </div>
          <div class="return-opened four columns">
			<b><?php echo $entry_opened; ?></b><br />
            <?php if ($opened) { ?>
            <input type="radio" name="opened" value="1" id="opened" checked="checked" />
            <?php } else { ?>
            <input type="radio" name="opened" value="1" id="opened" />
            <?php } ?>
            <label for="opened"><?php echo $text_yes; ?></label>
            <?php if (!$opened) { ?>
            <input type="radio" name="opened" value="0" id="unopened" checked="checked" />
            <?php } else { ?>
            <input type="radio" name="opened" value="0" id="unopened" />
            <?php } ?>
            <label for="unopened"><?php echo $text_no; ?></label>
            <br />
            <br />
            <?php echo $entry_fault_detail; ?><br />
            <textarea name="comment" cols="150" rows="6"><?php echo $comment; ?></textarea>
          </div>
          <div class="return-captcha four columns omega">
			<b><?php echo $entry_captcha; ?></b><br />
            <input type="text" name="captcha" value="<?php echo $captcha; ?>" />
            <br />
            <img src="index.php?route=account/return/captcha" alt="" />
            <?php if ($error_captcha) { ?>
            <span class="error"><?php echo $error_captcha; ?></span>
            <?php } ?>
          </div>
        </div>
      </div>
    </div>
    <div class="buttons">
      <div class="left"><a href="<?php echo $back; ?>" class="button cst"><span class="button_fr"><?php echo $button_back; ?></span></a></div>
      <div class="right">
        <span class="button_fr_ip"><input type="submit" value="<?php echo $button_continue; ?>" class="button cst" /></span>
      </div>
    </div>
  </form>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
});
//--></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.colorbox').colorbox({
		width: '80%', 
		height: '80%',
		maxWidth: 640,
        maxHeight: 480
	});
});
//--></script>  
<?php echo $footer; ?>