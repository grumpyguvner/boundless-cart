<?php echo $header; ?>
<script type="text/javascript" src="<?php echo $js . 'orders.js' ?>" ></script>
<input type="hidden" id="amz-css" name="css" value="<?php echo $css ?>" />

<input type="hidden" id="amz-orders" value="<?php echo $orders ?>" />
<input type="hidden" id="amz-retrieve" value="<?php echo $retrieve ?>" />
<input type="hidden" id="amz-import" value="<?php echo $import ?>" />
<input type="hidden" id="amz-delete" value="<?php echo $delete ?>" />

<input type="hidden" id="entry_submit" value="<?php echo $entry_submit ?>" />
<input type="hidden" id="entry_lookup" value="<?php echo $entry_lookup ?>" />
<input type="hidden" id="entry_delete_order" value="<?php echo $entry_delete_order ?>" />

<div style="display:none;">
<img src="view/image/amazon/error_add.png" class="entry_add_stock_error" alt="<?php echo $entry_add_stock_error ?>" />
<img src="view/image/amazon/error_delete.png" class="entry_add_not_exists" alt="<?php echo $entry_add_not_exists ?>" />
<img src="view/image/amazon/add.png" class="entry_add_imported" alt="<?php echo $entry_add_imported ?>" />
<img src="view/image/amazon/exclamation.png" class="entry_add_unkwnown_error" alt="<?php echo $entry_add_unkwnown_error ?>" />
</div>

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
      <h1><img src="view/image/amazon/amazon.gif" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_back; ?></span></a></div>
    </div>
    <div class="content">
      <form action="#" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><?php echo $entry_title; ?></td>
          </tr>
          <tr>
            <td>
                    <div class="buttons opacity" id="import"><a class="button"><span><?php echo $entry_import; ?></span></a></div>
                    <div class="buttons opacity" id="retrieve"><a class="button"><span><?php echo $entry_retrieve; ?></span></a></div>
                    <div class="buttons" id="valid"><a class="button"><span class="action"><?php echo $entry_orders; ?></span></a></div>
            </td>
          </tr>
          <tr>
            <td>
                <div id="tabs" class="htabs">
                <?php foreach($languages as $language)
                {
                ?>
                    <a href="#amazon-<?php echo $language['code'] ?>" class="amazon-tab" ><?php echo ucfirst($language['name']) ?></a>


                <?php
                }
                ?>
                </div>
                <?php foreach($languages as $language)
                {
                  $lng = $language['code'] ;
                  $language_id = $language['language_id'] ;

                  $status  = 'status_' . $lng ;

                  $marketplace = 'marketplace_' . $lng ;
                  $marketplace_url = 'marketplace_url_' . $lng ;

                  $last_import = 'last_import_' . $lng ;

                ?>
                <div id="amazon-<?php echo $lng ?>" style="display:none;">
                    <input type="hidden" name="language" value="<?php echo $lng ?>" />
                    <input type="hidden" name="language_id" value="<?php echo $language_id ?>" />

                    <img src="view/image/amazon/flag_<?php echo $$marketplace ?>.png" alt="" />

                    <span class="marketplace-url" ><?php echo $$marketplace_url ?></span>

                    <span class="last-import"><?php echo $$last_import ?></span>

                    <div class="cleaner"></div>
                    <span class="import-status">
                        <?php echo $entry_status ?> :<br />
                        <select name="status" >
                        <?php foreach($statuses as $status => $title)
                        {
                        ?>
                        <option value="<?php echo $status ?>"><?php echo $title ?></option>
                        <?php
                        }
                        ?>
                        </select>

                    </span>

                    <span class="import-to-field">
                        <?php echo $entry_import_to ?> :<br />
                        <input type="text" name="import-to" class="import-to" />
                    </span>

                    <span class="import-from-field">
                        <?php echo $entry_import_from ?> :<br />
                        <input type="text" name="import-from" class="import-from" />
                    </span>

                    <span class="options" style="display:none"><?php echo $entry_options ?>
                        <input type="checkbox" class="lookup" name="lookup" value="1" checked="checked" />&nbsp;<label for="lookup"><?php echo $entry_lookup_orders ?></label>
                    </span>

                </div>

                <?php
                }
                ?>
            </td>
          </tr>
            <td>
                <div id="amz-error" class="warning" style="display:none">
                </div>
                <div id="amz-result">
                </div>

                <div id="amz-table">
                    <table id="order-table">
                    <thead>
                        <td><input type="checkbox" id="select-all" /></td>
                        <td><b></b>&nbsp;<?php echo $entry_orders ?></td>
                        <td align="center"><?php echo $entry_order_id ?></td>
                        <td><?php echo $entry_order_name ?></td>
                        <td><?php echo $entry_order_shipping ?></td>
                        <td><?php echo $entry_order_date ?></td>
                        <td><?php echo $entry_order_quantity ?></td>
                        <td><?php echo $entry_order_amount ?></td>
                        <td><?php echo $entry_order_currency ?></td>
                        <td><?php echo $entry_order_status ?></td>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="9" style="display:none"></td>
                        </tr>
                    </tbody>
                    </table>

                    <table id="product-table" class="product-table">
                    <thead>
                     <tr class="heading">
                        <td></td>
                        <td><?php echo $entry_product_status ?></td>
                        <td><?php echo $entry_product_asin ?></td>
                        <td><?php echo $entry_product_sku ?></td>
                        <td><?php echo $entry_product_quantity ?></td>
                        <td><?php echo $entry_product_name ?></td>
                        <td><?php echo $entry_product_shipping ?></td>
                        <td><?php echo $entry_product_currency ?></td>
                        <td><?php echo $entry_product_price ?></td>
                        <td><?php echo $entry_product_currency ?></td>
                     </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="8" style="display:none"></td>
                        </tr>
                    </tbody>
                    </table>

                </div>
                <div class="cleaner"></div>
                <div id="some_html"></div>

            </td>
          <tr>
          <td>
            <span class="legend"><?php echo $entry_legend ?> :</span>
            <img src="view/image/amazon/error_add.png" class="entry_add_stock_error" alt="<?php echo $entry_add_stock_error ?>" /><span class="legend"><?php echo $entry_add_stock_error ?></span>
            <img src="view/image/amazon/error_delete.png" class="entry_add_not_exists" alt="<?php echo $entry_add_not_exists ?>" /><span class="legend"><?php echo $entry_add_not_exists ?></span>
            <img src="view/image/amazon/add.png" class="entry_add_imported" alt="<?php echo $entry_add_imported ?>" /><span class="legend"><?php echo $entry_add_imported ?></span>
            <img src="view/image/amazon/exclamation.png" class="entry_add_unkwnown_error" alt="<?php echo $entry_add_unkwnown_error ?>" /><span class="legend"><?php echo $entry_add_unkwnown_error ?></span>
</td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script>
<?php echo $footer; ?>