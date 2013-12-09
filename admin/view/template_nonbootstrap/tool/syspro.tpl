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
              <td><span class="required">*</span> <?php echo $entry_syspro_input_folder; ?></td>
              <td><input type="text" name="syspro_input_folder" value="<?php echo $syspro_input_folder; ?>" size="100" />
                <?php if ($error_syspro_input_folder) { ?>
                <span class="error"><?php echo $error_syspro_input_folder; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_syspro_output_folder; ?></td>
              <td><input type="text" name="syspro_output_folder" value="<?php echo $syspro_output_folder; ?>" size="100" />
                <?php if ($error_syspro_output_folder) { ?>
                <span class="error"><?php echo $error_syspro_output_folder; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_syspro_processed_folder; ?></td>
              <td><input type="text" name="syspro_processed_folder" value="<?php echo $syspro_processed_folder; ?>" size="100" />
                <?php if ($error_syspro_processed_folder) { ?>
                <span class="error"><?php echo $error_syspro_processed_folder; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_syspro_warehouse; ?></td>
              <td><input type="text" name="syspro_warehouse" value="<?php echo $syspro_warehouse; ?>" size="100" />
                <?php if ($error_syspro_warehouse) { ?>
                <span class="error"><?php echo $error_syspro_warehouse; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_syspro_create_products; ?></td>
              <td>
                  <input type="radio" name="syspro_create_products" value="1" <?php if ($syspro_create_products) echo 'checked="checked"'; ?> >Yes
                  <input type="radio" name="syspro_create_products" value="0" <?php if (!$syspro_create_products) echo 'checked="checked"'; ?> >No
              </td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_syspro_default_priceband; ?></td>
              <td><input type="text" name="syspro_default_priceband" value="<?php echo $syspro_default_priceband; ?>" size="100" />
                <?php if ($error_syspro_default_priceband) { ?>
                <span class="error"><?php echo $error_syspro_default_priceband; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required"></span>Import Products?</td>
              <td><input type="checkbox" name="syspro_import_products" value="syspro_import_products" /><input type="text" name="syspro_selected_products" value="" size="60" /></td>
            </tr>
            <tr>
              <td><span class="required"></span>Import Customers?</td>
              <td><input type="checkbox" name="syspro_import_customers" value="syspro_import_customers" /><input type="text" name="syspro_selected_customers" value="" size="60" /></td>
            </tr>
            <tr>
              <td><span class="required"></span>Export Orders?</td>
              <td><input type="checkbox" name="syspro_import_orders" value="syspro_import_orders" /></td>
            </tr>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>