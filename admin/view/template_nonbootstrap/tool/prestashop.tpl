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
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-general"><?php echo $tab_general; ?></a></div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_prestashop_host; ?></td>
              <td><input type="text" name="prestashop_host" value="<?php echo $prestashop_host; ?>" size="100" />
                <?php if ($error_prestashop_host) { ?>
                <span class="error"><?php echo $error_prestashop_host; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_prestashop_user; ?></td>
              <td><input type="text" name="prestashop_user" value="<?php echo $prestashop_user; ?>" size="100" />
                <?php if ($error_prestashop_user) { ?>
                <span class="error"><?php echo $error_prestashop_user; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_prestashop_password; ?></td>
              <td><input type="text" name="prestashop_password" value="<?php echo $prestashop_password; ?>" size="100" />
                <?php if ($error_prestashop_password) { ?>
                <span class="error"><?php echo $error_prestashop_password; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_prestashop_name; ?></td>
              <td><input type="text" name="prestashop_name" value="<?php echo $prestashop_name; ?>" size="100" />
                <?php if ($error_prestashop_name) { ?>
                <span class="error"><?php echo $error_prestashop_name; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_prestashop_products_truncate; ?></td>
              <td><input type="hidden" name="prestashop_products_truncate" value="0" />
                  <input type="checkbox" name="prestashop_products_truncate" value="1" <?php if ($prestashop_products_truncate) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_prestashop_products; ?></td>
              <td><input type="hidden" name="prestashop_products" value="0" />
                  <input type="checkbox" name="prestashop_products" value="1" <?php if ($prestashop_products) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_prestashop_products_store; ?></td>
              <td><div class="scrollbox">
                  <?php $class = 'even'; ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array(0, $prestashop_products_store)) { ?>
                    <input type="checkbox" name="prestashop_products_store[]" value="0" checked="checked" />
                    <?php echo $text_default; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="prestashop_products_store[]" value="0" />
                    <?php echo $text_default; ?>
                    <?php } ?>
                  </div>
                  <?php foreach ($stores as $store) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($store['store_id'], $prestashop_products_store)) { ?>
                    <input type="checkbox" name="prestashop_products_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                    <?php echo $store['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="prestashop_products_store[]" value="<?php echo $store['store_id']; ?>" />
                    <?php echo $store['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div></td>
            </tr>
            <tr>
              <td><?php echo $entry_prestashop_products_debug; ?></td>
              <td><input type="hidden" name="prestashop_products_debug" value="0" />
                  <input type="checkbox" name="prestashop_products_debug" value="1" <?php if ($prestashop_products_debug) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_prestashop_orders_truncate; ?></td>
              <td><input type="hidden" name="prestashop_orders_truncate" value="0" />
                  <input type="checkbox" name="prestashop_orders_truncate" value="1" <?php if ($prestashop_orders_truncate) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_prestashop_customers; ?></td>
              <td><input type="hidden" name="prestashop_customers" value="0" />
                  <input type="checkbox" name="prestashop_customers" value="1"<?php if ($prestashop_customers) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_prestashop_orders; ?></td>
              <td><input type="hidden" name="prestashop_orders" value="0" />
                  <input type="checkbox" name="prestashop_orders" value="1"<?php if ($prestashop_orders) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_prestashop_orders_limit; ?></td>
              <td><input type="text" name="prestashop_orders_limit" value="<?php echo $prestashop_orders_limit; ?>" size="5" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_prestashop_orders_debug; ?></td>
              <td><input type="hidden" name="prestashop_orders_debug" value="0" />
                  <input type="checkbox" name="prestashop_orders_debug" value="1" <?php if ($prestashop_orders_debug) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_prestashop_stockists; ?></td>
              <td><input type="hidden" name="prestashop_stockists" value="0" />
                  <input type="checkbox" name="prestashop_stockists" value="1" <?php if ($prestashop_stockists) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_prestashop_testimonials; ?></td>
              <td><input type="hidden" name="prestashop_testimonials" value="0" />
                  <input type="checkbox" name="prestashop_testimonials" value="1" <?php if ($prestashop_testimonials) echo ' checked="checked"'; ?> /></td>
            </tr>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>
