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
              <td><span class="required">*</span> <?php echo $entry_zencart_host; ?></td>
              <td><input type="text" name="zencart_host" value="<?php echo $zencart_host; ?>" size="100" />
                <?php if ($error_zencart_host) { ?>
                <span class="error"><?php echo $error_zencart_host; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_zencart_user; ?></td>
              <td><input type="text" name="zencart_user" value="<?php echo $zencart_user; ?>" size="100" />
                <?php if ($error_zencart_user) { ?>
                <span class="error"><?php echo $error_zencart_user; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_zencart_password; ?></td>
              <td><input type="text" name="zencart_password" value="<?php echo $zencart_password; ?>" size="100" />
                <?php if ($error_zencart_password) { ?>
                <span class="error"><?php echo $error_zencart_password; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_zencart_name; ?></td>
              <td><input type="text" name="zencart_name" value="<?php echo $zencart_name; ?>" size="100" />
                <?php if ($error_zencart_name) { ?>
                <span class="error"><?php echo $error_zencart_name; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_zencart_products_truncate; ?></td>
              <td><input type="hidden" name="zencart_products_truncate" value="0" />
                  <input type="checkbox" name="zencart_products_truncate" value="1" <?php if ($zencart_products_truncate) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_zencart_products; ?></td>
              <td><input type="hidden" name="zencart_products" value="0" />
                  <input type="checkbox" name="zencart_products" value="1" <?php if ($zencart_products) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_zencart_products_store; ?></td>
              <td><div class="scrollbox">
                  <?php $class = 'even'; ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array(0, $zencart_products_store)) { ?>
                    <input type="checkbox" name="zencart_products_store[]" value="0" checked="checked" />
                    <?php echo $text_default; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="zencart_products_store[]" value="0" />
                    <?php echo $text_default; ?>
                    <?php } ?>
                  </div>
                  <?php foreach ($stores as $store) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($store['store_id'], $zencart_products_store)) { ?>
                    <input type="checkbox" name="zencart_products_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                    <?php echo $store['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="zencart_products_store[]" value="<?php echo $store['store_id']; ?>" />
                    <?php echo $store['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div></td>
            </tr>
            <tr>
              <td><?php echo $entry_zencart_products_debug; ?></td>
              <td><input type="hidden" name="zencart_products_debug" value="0" />
                  <input type="checkbox" name="zencart_products_debug" value="1" <?php if ($zencart_products_debug) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_zencart_orders_truncate; ?></td>
              <td><input type="hidden" name="zencart_orders_truncate" value="0" />
                  <input type="checkbox" name="zencart_orders_truncate" value="1" <?php if ($zencart_orders_truncate) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_zencart_customers; ?></td>
              <td><input type="hidden" name="zencart_customers" value="0" />
                  <input type="checkbox" name="zencart_customers" value="1"<?php if ($zencart_customers) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_zencart_orders; ?></td>
              <td><input type="hidden" name="zencart_orders" value="0" />
                  <input type="checkbox" name="zencart_orders" value="1"<?php if ($zencart_orders) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_zencart_orders_limit; ?></td>
              <td><input type="text" name="zencart_orders_limit" value="<?php echo $zencart_orders_limit; ?>" size="5" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_zencart_orders_debug; ?></td>
              <td><input type="hidden" name="zencart_orders_debug" value="0" />
                  <input type="checkbox" name="zencart_orders_debug" value="1" <?php if ($zencart_orders_debug) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_zencart_stockists; ?></td>
              <td><input type="hidden" name="zencart_stockists" value="0" />
                  <input type="checkbox" name="zencart_stockists" value="1" <?php if ($zencart_stockists) echo ' checked="checked"'; ?> /></td>
            </tr>
            <tr>
              <td><?php echo $entry_zencart_testimonials; ?></td>
              <td><input type="hidden" name="zencart_testimonials" value="0" />
                  <input type="checkbox" name="zencart_testimonials" value="1" <?php if ($zencart_testimonials) echo ' checked="checked"'; ?> /></td>
            </tr>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>
