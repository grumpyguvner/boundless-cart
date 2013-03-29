<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/log.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location='<?php echo $import; ?>'" class="button"><span><?php echo $button_import; ?></span></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-general"><?php echo $tab_general; ?></a></div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_zencart_server; ?></td>
              <td><input type="text" name="zencart_server" value="<?php echo $zencart_server; ?>" size="100" />
                <?php if ($error_zencart_server) { ?>
                <span class="error"><?php echo $error_zencart_server; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_zencart_port; ?></td>
              <td><input type="text" name="zencart_port" value="<?php echo $zencart_port; ?>" size="100" />
                <?php if ($error_zencart_port) { ?>
                <span class="error"><?php echo $error_zencart_port; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_zencart_warehouse; ?></td>
              <td><input type="text" name="zencart_warehouse" value="<?php echo $zencart_warehouse; ?>" size="100" />
                <?php if ($error_zencart_warehouse) { ?>
                <span class="error"><?php echo $error_zencart_warehouse; ?></span>
                <?php } ?></td>
            </tr>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>