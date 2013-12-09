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
              <td><span class="required">*</span> <?php echo $entry_sage_server; ?></td>
              <td><input type="text" name="sage_server" value="<?php echo $sage_server; ?>" size="100" />
                <?php if ($error_sage_server) { ?>
                <span class="error"><?php echo $error_sage_server; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_sage_port; ?></td>
              <td><input type="text" name="sage_port" value="<?php echo $sage_port; ?>" size="100" />
                <?php if ($error_sage_port) { ?>
                <span class="error"><?php echo $error_sage_port; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_sage_warehouse; ?></td>
              <td><input type="text" name="sage_warehouse" value="<?php echo $sage_warehouse; ?>" size="100" />
                <?php if ($error_sage_warehouse) { ?>
                <span class="error"><?php echo $error_sage_warehouse; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_sage_create_products; ?></td>
              <td>
                  <input type="radio" name="sage_create_products" value="1" <?php if ($sage_create_products) echo 'checked="checked"'; ?> >Yes
                  <input type="radio" name="sage_create_products" value="0" <?php if (!$sage_create_products) echo 'checked="checked"'; ?> >No
              </td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_sage_default_priceband; ?></td>
              <td><input type="text" name="sage_default_priceband" value="<?php echo $sage_default_priceband; ?>" size="100" />
                <?php if ($error_sage_default_priceband) { ?>
                <span class="error"><?php echo $error_sage_default_priceband; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required"></span>Import Products?</td>
              <td><input type="checkbox" name="sage_import_products" value="sage_import_products" /><input type="text" name="sage_selected_products" value="" size="60" /></td>
            </tr>
            <tr>
              <td><span class="required"></span>Export Orders?</td>
              <td><input type="checkbox" name="sage_import_orders" value="sage_import_orders" /></td>
            </tr>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>