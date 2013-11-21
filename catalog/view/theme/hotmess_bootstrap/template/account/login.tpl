<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div class="col-sm-12">
          <div class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
            <?php } ?>
          </div>
        </div>
    </div>
</div>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="container"><div class="row"><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content" class="<?php if(empty($column_left) && empty($column_right)){echo 'col-sm-12';} else if (empty($column_left) || empty($column_right)){echo 'col-sm-9';}else{echo 'col-sm-6';} ?>"><?php echo $content_top; ?>
  <h1><?php echo $heading_title; ?></h1>
  <div class="login-content row">
    <div class="left col-sm-6">
      <h2><?php echo $text_new_customer; ?></h2>
      <div class="content">
        <p><b><?php echo $text_register; ?></b></p>
        <p><?php echo $text_register_account; ?></p>
        <a href="<?php echo $register; ?>" class="button"><?php echo $button_continue; ?></a></div>
    </div>
    <div class="right col-sm-6">
      <h2><?php echo $text_returning_customer; ?></h2>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <div class="content">
          <p><?php echo $text_i_am_returning_customer; ?></p>
          <?php echo $entry_email; ?><br />
          <input type="text" name="email" value="<?php echo $email; ?>" />
          <br />
          <?php echo $entry_password; ?><br />
          <input type="password" name="password" value="<?php echo $password; ?>" />
          <br /><br />
          <input type="submit" value="<?php echo $button_login; ?>" class="button" />
          <br /><br />
          <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />
          <br />
          <?php if ($redirect) { ?>
          <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
          <?php } ?>
        </div>
      </form>
    </div>
  </div>
  <?php echo $content_bottom; ?></div>
  </div></div>
<script type="text/javascript"><!--
$('#login input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#login').submit();
	}
});
//--></script> 
<?php echo $footer; ?>