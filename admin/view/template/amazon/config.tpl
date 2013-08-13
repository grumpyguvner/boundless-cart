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
      <h1><img src="view/image/amazon/amazon.gif" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <div id="tabs" class="htabs">
      <?php foreach($languages as $language)
      {
      ?>
          <a href="#amazon-<?php echo $language['code'] ?>" ><?php echo ucfirst($language['name']) ?></a>

      <?php
            }
      ?>
      </div>
      <?php foreach($languages as $language)
      {
        $lng = $language['code'] ;
        $status  = 'status_' . $lng ;

        $marketplace = 'marketplace_' . $lng ;
        $ccurrency = 'currency_' . $lng ;

        $merchant_id = 'merchant_id_' . $lng ;
        $marketplace_id = 'marketplace_id_' . $lng ;
        $aws_key_id = 'aws_key_id_' . $lng ;
        $aws_secret_id = 'aws_secret_id_' . $lng ;

        $adv_key_ = 'adv_key_' . $lng ;
        $adv_secret_key_ = 'adv_secret_key_' . $lng ;

        $out_of_stock = 'out_of_stock_' . $lng ;
        $price_formula = 'price_formula_' . $lng ;
        $price_callback = 'price_callback_' . $lng ;
        $shipping_method = 'shipping_method_' . $lng ;
        $payment_method = 'payment_method_' . $lng ;
        $debug_mode = 'debug_mode_' . $lng ;

        $marketplace_country = 'marketplace_country_' . $lng ;

      ?>
      <div id="amazon-<?php echo $lng ?>" style="display:none;">

        <table class="form">
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="status_<?php echo $lng ?>">
                <?php if ( $$status ) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>

          <tr>
            <td><?php echo $entry_marketplace; ?></td>
            <td><input type="hidden" name="marketplace_country_<?php echo $lng ?>" value="<?php echo $$marketplace_country; ?>" />
                <select name="marketplace_<?php echo $lng ?>">
                <option value="0" disabled=disabled><?php echo $entry_marketplace; ?></option>
                <option value="ca" <?php if ( $$marketplace == 'ca' ) echo 'selected="selected"' ; ?>><?php echo $entry_amazon_ca; ?></option>
                <option value="fr" <?php if ( $$marketplace == 'fr' ) echo 'selected="selected"' ; ?>><?php echo $entry_amazon_fr; ?></option>
                <option value="de" <?php if ( $$marketplace == 'de' ) echo 'selected="selected"' ; ?>><?php echo $entry_amazon_de; ?></option>
                <option value="it" <?php if ( $$marketplace == 'it' ) echo 'selected="selected"' ; ?>><?php echo $entry_amazon_it; ?></option>
                <option value="jp" <?php if ( $$marketplace == 'jp' ) echo 'selected="selected"' ; ?>><?php echo $entry_amazon_jp; ?></option>
                <option value="es" <?php if ( $$marketplace == 'es' ) echo 'selected="selected"' ; ?>><?php echo $entry_amazon_es; ?></option>
                <option value="com" <?php if ( $$marketplace == 'com' ) echo 'selected="selected"' ; ?>><?php echo $entry_amazon_us; ?></option>
                <option value="co_uk" <?php if ( $$marketplace == 'co_uk' ) echo 'selected="selected"' ; ?>><?php echo $entry_amazon_uk; ?></option>
              </select></td>
          </tr>

          <tr>
            <td><?php echo $entry_currency; ?></td>
            <td>

                <select name="currency_<?php echo $lng ?>">
                    <?php
                    foreach($currencies as $currency)
                    {
                        if ( $currency['code'] == $$ccurrency )
                            $selected=' selected="selected"' ;
                        else
                            $selected='' ;
                    ?>
                    <option value="<?php echo $currency['code'] ?>" <?php echo $selected ?>><?php printf('%s (%s)', $currency['title'], $currency['code']) ?></option>
                    <?php } ?>
                </select>&nbsp;<span class="required">*</span>

            </td>
          </tr>

          <tr>
            <td><?php echo $entry_merchant_id; ?></td>
            <td><input type="text" name="merchant_id_<?php echo $lng ?>" value="<?php echo $$merchant_id ?>" />&nbsp;<span class="required">*</span></td>
          </tr>
          <tr>
            <td><?php echo $entry_marketplace_id; ?></td>
            <td><input type="text" name="marketplace_id_<?php echo $lng ?>" value="<?php echo $$marketplace_id; ?>" />&nbsp;<span class="required">*</span></td>
          </tr>
          <tr>
            <td><?php echo $entry_aws_key_id; ?></td>
            <td><input type="text" name="aws_key_id_<?php echo $lng ?>" value="<?php echo $$aws_key_id; ?>" style="width:300px;" />&nbsp;<span class="required">*</span></td>
          </tr>
          <tr>
            <td><?php echo $entry_aws_secret_id; ?></td>
            <td><input type="text" name="aws_secret_id_<?php echo $lng ?>" value="<?php echo $$aws_secret_id; ?>"  style="width:300px;" />&nbsp;<span class="required">*</span></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><span class="help"><?php echo $help_keypairs ?></span></td>
          </tr>

          <tr>
            <td><?php echo $entry_adv_key; ?></td>
            <td><input type="text" name="adv_key_<?php echo $lng ?>" value="<?php echo $$adv_key_; ?>" style="width:300px;" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_adv_secret_key; ?></td>
            <td><input type="text" name="adv_secret_key_<?php echo $lng ?>" value="<?php echo $$adv_secret_key_; ?>"  style="width:300px;" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><span class="help"><?php echo $help_advapi ?></span></td>
          </tr>

          <tr>
            <td><?php echo $entry_out_of_stock; ?></td>
            <td><input type="text" name="out_of_stock_<?php echo $lng ?>" value="<?php echo $$out_of_stock; ?>" />&nbsp;
            <span class="required">*</span>
            <span class="help"><?php echo $help_out_of_stock ?></span>&nbsp;
            </td>
          </tr>

          <tr>
            <td><?php echo $entry_price_formula; ?></td>
            <td><input type="text" name="price_formula_<?php echo $lng ?>" value="<?php echo $$price_formula; ?>" />&nbsp;
                <span class="required">*</span>
                <span class="help"><?php echo $help_price_formula ?></span>&nbsp;
            </td>
          </tr>

          <tr>
            <td><?php echo $entry_price_callback; ?></td>
            <td><input type="text" name="price_callback_<?php echo $lng ?>" value="<?php echo $$price_callback; ?>" style="width:300px;" />&nbsp;
                <span class="required">*</span>
                <span class="help"><?php echo $help_price_callback ?></span>&nbsp;
            </td>
          </tr>

          <tr>
            <td><?php echo $entry_shipping_method; ?></td>
            <td><input type="text" name="shipping_method_<?php echo $lng ?>" value="<?php echo $$shipping_method; ?>" />&nbsp;
                <span class="required">*</span>
                <span class="help"><?php echo $help_shipping_method ?></span>&nbsp;

            </td>
          </tr>

          <tr>
            <td><?php echo $entry_payment_method; ?></td>
            <td><input type="text" name="payment_method_<?php echo $lng ?>" value="<?php echo $$payment_method; ?>" />&nbsp;
                <span class="required">*</span>
                <span class="help"><?php echo $help_payment_method ?></span>&nbsp;

            </td>
          </tr>

          <tr>
            <td><?php echo $entry_debug_mode; ?></td>
            <td><input type="checkbox" name="debug_mode_<?php echo $lng ?>" value="1" <?php echo ($$debug_mode == 1 ? ' checked="checked" ' : '')  ; ?> />&nbsp;
                <span class="help"><?php echo $help_debug_mode ?></span>&nbsp;

            </td>
          </tr>

        </table>
      </div>
      <?php
            }
      ?>

      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script>
<?php echo $footer; ?>