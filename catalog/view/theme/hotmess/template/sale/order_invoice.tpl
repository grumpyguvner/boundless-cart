<?php echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $language; ?>" xml:lang="<?php echo $language; ?>">
<head>
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<link rel="stylesheet" type="text/css" href="/catalog/view/theme/hotmess/stylesheet/invoice.css" />
</head>
<body>
<?php foreach ($orders as $order) { ?>
    <div style="page-break-after:always">
 <div class="page1">
  <table class="store">
    <tr>
        <td width="50%" align="left"><img src="<?php echo $logo; ?>" alt=""></td>
        <td width="50%" style="text-align: center; font-family: courier, serif; font-size: 32px;">A Damn Good Time</td>
    </tr>
  </table>
  <div class="order-detail-wrapper">
  <table class="order-detail">
    <tr>
        <td width="50%" align="center" style="border-right: 2px solid #CCC;">
            <?php echo $order['payment_address']; ?><br/>
            <?php echo $order['email']; ?><br/>
            <?php echo $order['telephone']; ?>
            <?php if ($order['payment_company_id']) { ?>
            <br/>
            <br/>
            <?php echo $text_company_id; ?> <?php echo $order['payment_company_id']; ?>
            <?php } ?>
            <?php if ($order['payment_tax_id']) { ?>
            <br/>
            <?php echo $text_tax_id; ?> <?php echo $order['payment_tax_id']; ?>
            <?php } ?>
        </td>
        <td width="50%">
            <table class="order-detail">
                <tr>
                    <td style="font-size: 12px;"><b><?php echo $text_order_date; ?></b></td>
                    <td style="font-size: 12px;"><?php echo $order['date_added']; ?></td>
                </tr>
                <tr>
                    <td style="font-size: 12px;"><b><?php echo $text_order_id; ?></b></td>
                    <td style="font-size: 12px;"><?php echo $order['order_id']; ?></td>
                </tr>
                <tr>
                    <td style="font-size: 12px;"><b><?php echo $text_payment_method; ?></b></td>
                    <td style="font-size: 12px;"><?php echo $order['payment_method']; ?></td>
                </tr>
                <tr>
                    <td style="font-size: 12px;"><b><?php echo $text_shipping_method; ?></b></td>
                    <td style="font-size: 12px;"><?php echo $order['shipping_method']; ?></td>
                </tr>
                <tr>
                    <td style="font-size: 12px;"></td>
                    <td style="font-size: 12px;"></td>
                </tr>
                <tr>
                    <td style="font-size: 12px;"><b>Hot!MeSS Tel.</b></td>
                    <td style="font-size: 12px;"><?php echo $order['store_telephone']; ?></td>
                </tr>
                <tr>
                    <td style="font-size: 12px;"><b>Hot!MeSS email</b></td>
                    <td style="font-size: 12px;"><?php echo $order['store_email']; ?></td>
                </tr>
            </table>
        </td>
    </tr>
  </table>
  </div>
  <div id="product-wrapper">
  <table class="product">
    <tr class="heading">
      <td><b><?php echo $column_product; ?></b></td>
      <td><b><?php echo $column_model; ?></b></td>
      <td align="right"><b><?php echo $column_quantity; ?></b></td>
      <td align="right"><b><?php echo $column_price; ?></b></td>
      <td align="right"><b><?php echo $column_total; ?></b></td>
    </tr>
    <?php
    $i = 0;
    $j = 0;
    $product_limit = 7;
    $over_limit = false;
    foreach ($order['product'] as $product) {
    $i++;
    $j++;
    if($i <= $product_limit)
    {
    ?>
    <tr>
      <td><?php echo $product['name']; ?>
        <?php foreach ($product['option'] as $option) { ?>
        <br />
        &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
        <?php } ?></td>
      <td><?php echo $product['model']; ?></td>
      <td align="right"><?php echo $product['quantity']; ?></td>
      <td align="right"><?php echo $product['price']; ?></td>
      <td align="right"><?php echo $product['total']; ?></td>
    </tr>
    <?php } ?>
    <?php foreach ($order['voucher'] as $voucher) { ?>
    <tr>
      <td align="left"><?php echo $voucher['description']; ?></td>
      <td align="left"></td>
      <td align="right">1</td>
      <td align="right"><?php echo $voucher['amount']; ?></td>
      <td align="right"><?php echo $voucher['amount']; ?></td>
    </tr>
    <?php } ?>
    <?php }
    if($j > $product_limit)
    {
        $over_limit = true;
    }
    ?>
    <?php if($j <= $product_limit) { ?>
    <?php foreach ($order['total'] as $total) { ?>
    <tr>
      <td align="right" colspan="4"><b><?php echo $total['title']; ?>:</b></td>
      <td align="right"><?php echo $total['text']; ?></td>
    </tr>
    <?php } ?>
    <?php } ?>
  </table>
  <div style="text-align: center"><small>“Hot!Mess” is a brand licensed to Kamani Design Limited. VAT Registration Number 941 0524 54</small></div>
  <?php if($j <= $product_limit) { ?>
  <?php if ($order['comment']) { ?>
  <table class="comment">
    <tr class="heading">
      <td><b><?php echo $column_comment; ?></b></td>
    </tr>
    <tr>
      <td><?php echo $order['comment']; ?></td>
    </tr>
  </table>
  <?php } ?>
  <?php } ?>
  </div>
  <div id="bottom">
  <table class="labels">
    <tr>
      <td rowspan="2" style="vertical-align: central; padding: 5px; text-align: center;">
          <div style="width: 387px; display: block; overflow: hidden; font-size: 18px;">
            <?php echo $order['shipping_address']; ?>
          </div>
      </td>
      <td style="vertical-align: central; padding: 2px; text-align: center;">
          <div style="width: 386px; display: block; overflow: hidden;">
            <p style="font-size: 12px;"><b><?php echo $order['firstname']; ?> <?php echo $order['lastname']; ?> (<?php echo $order['order_id']; ?>)</b></p>
          </div>
      </td>
    </tr>
    <tr>
      <td style="vertical-align: central; padding: 5px; text-align: center;">
          <div style="width: 386px; display: block; overflow: hidden;">
            <div style="padding-left: 20px;"><?php echo $order['store_name']; ?><br/><?php echo $order['store_address']; ?></div
          </div>
      </td>
    </tr>
  </table>
  </div>
  </div>
  
  
    
    

 <?php if ($over_limit == true) { ?>
 <div class="page2">
 <div style="height: 60px;"></div>
  <table class="store">
    <tr>
        <td width="50%" align="left"><img src="<?php echo $logo; ?>" alt=""></td>
        <td width="50%" style="text-align: center; font-family: courier, serif; font-size: 32px;">A Damn Good Time</td>
    </tr>
  </table>
  <div class="order-detail-wrapper">
  <table class="order-detail">
    <tr>
        <td width="50%" align="center" style="border-right: 2px solid #CCC;">
            <?php echo $order['payment_address']; ?><br/>
            <?php echo $order['email']; ?><br/>
            <?php echo $order['telephone']; ?>
            <?php if ($order['payment_company_id']) { ?>
            <br/>
            <br/>
            <?php echo $text_company_id; ?> <?php echo $order['payment_company_id']; ?>
            <?php } ?>
            <?php if ($order['payment_tax_id']) { ?>
            <br/>
            <?php echo $text_tax_id; ?> <?php echo $order['payment_tax_id']; ?>
            <?php } ?>
        </td>
        <td width="50%">
            <table class="order-detail">
                <tr>
                    <td style="font-size: 12px;"><b><?php echo $text_order_date; ?></b></td>
                    <td style="font-size: 12px;"><?php echo $order['date_added']; ?></td>
                </tr>
                <tr>
                    <td style="font-size: 12px;"><b><?php echo $text_order_id; ?></b></td>
                    <td style="font-size: 12px;"><?php echo $order['order_id']; ?></td>
                </tr>
                <tr>
                    <td style="font-size: 12px;"><b><?php echo $text_payment_method; ?></b></td>
                    <td style="font-size: 12px;"><?php echo $order['payment_method']; ?></td>
                </tr>
                <tr>
                    <td style="font-size: 12px;"><b><?php echo $text_shipping_method; ?></b></td>
                    <td style="font-size: 12px;"><?php echo $order['shipping_method']; ?></td>
                </tr>
                <tr>
                    <td style="font-size: 12px;"></td>
                    <td style="font-size: 12px;"></td>
                </tr>
                <tr>
                    <td style="font-size: 12px;"><b>Hot!MeSS Tel.</b></td>
                    <td style="font-size: 12px;"><?php echo $order['store_telephone']; ?></td>
                </tr>
                <tr>
                    <td style="font-size: 12px;"><b>Hot!MeSS email</b></td>
                    <td style="font-size: 12px;"><?php echo $order['store_email']; ?></td>
                </tr>
            </table>
        </td>
    </tr>
  </table>
  </div>
 <div id="product-wrapper">
  <table class="product">
    <tr class="heading">
      <td><b><?php echo $column_product; ?></b></td>
      <td><b><?php echo $column_model; ?></b></td>
      <td align="right"><b><?php echo $column_quantity; ?></b></td>
      <td align="right"><b><?php echo $column_price; ?></b></td>
      <td align="right"><b><?php echo $column_total; ?></b></td>
    </tr>
    <?php
    $i = 0;
    foreach ($order['product'] as $product) {
    $i++;
    if($i > $product_limit)
    {
    ?>
    <tr>
      <td><?php echo $product['name']; ?>
        <?php foreach ($product['option'] as $option) { ?>
        <br />
        &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
        <?php } ?></td>
      <td><?php echo $product['model']; ?></td>
      <td align="right"><?php echo $product['quantity']; ?></td>
      <td align="right"><?php echo $product['price']; ?></td>
      <td align="right"><?php echo $product['total']; ?></td>
    </tr>
    <?php } ?>
    <?php foreach ($order['voucher'] as $voucher) { ?>
    <tr>
      <td align="left"><?php echo $voucher['description']; ?></td>
      <td align="left"></td>
      <td align="right">1</td>
      <td align="right"><?php echo $voucher['amount']; ?></td>
      <td align="right"><?php echo $voucher['amount']; ?></td>
    </tr>
    <?php } ?>
    <?php } ?>
    <?php foreach ($order['total'] as $total) { ?>
    <tr>
      <td align="right" colspan="4"><b><?php echo $total['title']; ?>:</b></td>
      <td align="right"><?php echo $total['text']; ?></td>
    </tr>
    <?php } ?>
  </table>
  <div style="text-align: center"><small>“Hot!Mess” is a brand licensed to Kamani Design Limited. VAT Registration Number 941 0524 54</small></div>
  <?php if ($order['comment']) { ?>
  <table class="comment">
    <tr class="heading">
      <td><b><?php echo $column_comment; ?></b></td>
    </tr>
    <tr>
      <td><?php echo $order['comment']; ?></td>
    </tr>
  </table>
  <?php } ?>
  </div>
  </div>
  <?php } ?>
    </div>
<?php } ?>
</body>
</html>