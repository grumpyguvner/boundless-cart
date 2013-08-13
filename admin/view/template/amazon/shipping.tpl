<?php echo $header; ?>
<script type="text/javascript" src="<?php echo $js . 'shipping.js' ?>" ></script>
<input type="hidden" id="amz-css" name="css" value="<?php echo $css ?>" />

<input type="hidden" id="amz-shipping" value="<?php echo $shipping ?>" />
<input type="hidden" id="amz-update" value="<?php echo $update ?>" />

<input type="hidden" id="entry_submit" value="<?php echo $entry_submit ?>" />
<input type="hidden" id="entry_lookup" value="<?php echo $entry_lookup ?>" />

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
                    <div class="buttons" id="import"><a class="button"><span><?php echo $entry_lookup; ?></span></a></div>
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
                  $shipping_default = 'shipping_default_' . $lng ;

                ?>
                <div id="amazon-<?php echo $lng ?>" style="display:none;">
                    <input type="hidden" name="language" value="<?php echo $lng ?>" />
                    <input type="hidden" name="language_id" value="<?php echo $language_id ?>" />
                    <input type="hidden" name="shipping-defaut" value="<?php echo $$shipping_default ?>" />
                    <img src="view/image/amazon/flag_<?php echo $$marketplace ?>.png" alt="" />

                    <span class="marketplace-url" ><?php echo $$marketplace_url ?></span>


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
                        <td><?php echo $entry_order_name ?></td>
                        <td><?php echo $entry_order_shipping ?></td>
                        <td><?php echo $entry_order_date ?></td>
                        <td><?php echo $entry_order_status ?></td>
<!--                    <td><?php echo $entry_shipping_status ?></td> for future use -->
                        <td><?php echo $entry_shipping_name ?></td>
                        <td><?php echo $entry_shipping_id ?></td>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="9" style="display:none"></td>
                        </tr>
                    </tbody>
                    </table>
                </div>
                <div class="cleaner"></div>
                <div id="some_html"></div>
                <div class="buttons" id="update"><a class="button"><span><?php echo $entry_submit; ?></span></a></div>

            </td>

        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script>
<?php echo $footer; ?>