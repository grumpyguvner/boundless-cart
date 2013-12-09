<?php echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $language; ?>" xml:lang="<?php echo $language; ?>">
<head>
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<link rel="stylesheet" type="text/css" href="view/stylesheet/invoice.css" />
</head>
<body>
<?php foreach ($orders as $order) { ?>
    <div style="page-break-after:always">
 <div class="page1">
  <table class="store">
    <tr>
        <td width="33%"><b><?php echo $text_dispatch_note; ?></b> <?php echo $order['order_id']; ?></td>
        <td align="center"><img src="<?php echo $logo; ?>" alt=""></td>
        <td width="33%" style="text-align: right;"><b><?php echo $text_order_date; ?></b> <?php echo $order['date_added']; ?></td>
    </tr>
  </table>
  <div style="height: 80px;"></div>
  <table class="store">
    <tr>
      <td width="33%"><b><?php echo $text_order_id; ?></b> <?php echo $order['order_id']; ?></td>
      <td align="center"><b><?php echo $text_customer; ?></b> <?php echo $order['firstname']; ?> <?php echo $order['lastname']; ?></td>
      <td width="33%" style="text-align: right;"><img src="/barcode/3of9/<?php echo $order['order_id']; ?>.png" alt="<?php echo $order['order_id']; ?>" /></td>
    </tr>
  </table>
  <div id="product-wrapper">
  <table class="product">
    <tr class="heading">
      <td align="center"><b><?php echo $column_item; ?></b></td>
      <td align="center"><b><?php echo $column_description; ?></b></td>
      <td align="center"><b><?php echo $column_quantity; ?></b></td>
      <td align="center"><b><?php echo $column_price; ?></b></td>
      <td align="center"><b><?php echo $column_comments; ?></b></td>
      <td align="center"><b><?php echo $column_return_code; ?></b></td>
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
      <td><?php if (!empty($product['option']) && !empty($product['option'][0]['sku']))?><img src="/barcode/ean/<?php echo $product['option'][0]['sku']; ?>.png" alt="<?php echo $product['option'][0]['sku']; ?>" /></td>
      <td>
        <?php echo $product['name']; ?>
        <?php foreach ($product['option'] as $option) { ?>
        - <?php echo $option['name']; ?>: <?php echo $option['value']; ?>
        <?php } ?>
        <?php if ($product['location']) { ?>
       <br /><small><?php echo $text_location; ?> <?php echo $product['location']; ?></small>
        <?php } ?>
      </td>
      <td align="right"><?php echo $product['quantity']; ?></td>
      <td align="right"><?php echo $product['price']; ?></td>
      <td align="right">
        <?php if ($order['comment'])
        {
          echo $order['comment'];
        }
        ?>
      </td>
      <td align="right"></td>
    </tr>
    <?php } ?>
    <?php foreach ($order['voucher'] as $voucher) { ?>
    <tr>
      <td align="left"><?php echo $voucher['description']; ?></td>
      <td align="left"></td>
      <td align="right">1</td>
      <td align="right"><?php echo $voucher['amount']; ?></td>
      <td align="right"><?php echo $voucher['amount']; ?></td>
      <td align="right"></td>
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
    <?php if ($total['code'] == 'shipping') { ?>
    <tr align="right">
      <td style="border: 0px;" align="right" colspan="3"><b><?php echo $text_pandp; ?></b></td>
      <td style="border: 0px;" align="right"><?php echo $total['text']; ?></td>
      <td style="border: 0px; text-align: left;" colspan="2"><?php echo $total['title']; ?></td>
    </tr>
    <?php } else { ?>
    <tr align="right">
      <td style="border: 0px;" align="right" colspan="3"><b><?php echo $total['title']; ?></b></td>
      <td style="border: 0px;" align="right"><?php echo $total['text']; ?></td>
    </tr>
    <?php } ?>
    <?php } ?>
    <?php } ?>
  </table>
  <?php if($j <= $product_limit) { ?>
  <table class="store">
    <tr align="center">
      <td><?php echo $text_thanks; ?></td>
    </tr>
  </table>
  <?php } ?>
  </div>
  <table class="store">
    <tr>
      <td width="33%"><b><?php echo $text_order_id; ?></b> <?php echo $order['order_id']; ?></td>
      <td align="center"><b><?php echo $text_customer; ?></b> <?php echo $order['firstname']; ?> <?php echo $order['lastname']; ?></td>
      <td width="33%" style="text-align: right;"><img src="/barcode/3of9/<?php echo $order['order_id']; ?>.png" alt="<?php echo $order['order_id']; ?>" /></td>
    </tr>
  </table>
  <div id="bottom">
  <table class="store" style="height: 230px;">
    <tr>
      <td style="padding-left: 30px; width: 50%;">
        <h2><?php echo $text_return; ?></h2>
        <span style="font-size: 11px;"><?php echo $text_return_notice; ?></span>
        <div style="height: 17px;"></div>
        <div style="padding-left: 30px; font-size: 13px;"><?php echo $text_return_address;?></div>
      </td>
      <td style=" padding-left: 30px; width: 50%;">
<!--        <img src="/catalog/view/theme/soactive/image/postage/postage_unknown.png" style="float: right;padding-right: 10px;" />-->
            <?php echo $order['shipping_address']; ?>
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
        <td width="33%"><b><?php echo $text_dispatch_note; ?></b> <?php echo $order['order_id']; ?></td>
        <td align="center"><img src="<?php echo $logo; ?>" alt=""></td>
        <td width="33%" style="text-align: right;"><b><?php echo $text_order_date; ?></b> <?php echo $order['date_added']; ?></td>
    </tr>
  </table>
  <div style="height: 80px;"></div>
  <table class="store">
    <tr>
      <td width="33%"><b><?php echo $text_order_id; ?></b> <?php echo $order['order_id']; ?></td>
      <td><b><?php echo $text_customer; ?></b> <?php echo $order['firstname']; ?> <?php echo $order['lastname']; ?></td>
      <td width="33%" style="text-align: right;"><img src="/barcode/3of9/<?php echo $order['order_id']; ?>.png" alt="<?php echo $order['order_id']; ?>" /></td>
    </tr>
  </table>
 <div id="product-wrapper">
  <table class="product">
    <tr class="heading">
      <td align="center"><b><?php echo $column_item; ?></b></td>
      <td align="center"><b><?php echo $column_description; ?></b></td>
      <td align="center"><b><?php echo $column_quantity; ?></b></td>
      <td align="center"><b><?php echo $column_price; ?></b></td>
      <td align="center"><b><?php echo $column_comments; ?></b></td>
      <td align="center"><b><?php echo $column_return_code; ?></b></td>
    </tr>
    <?php
    $i = 0;
    foreach ($order['product'] as $product) {
    $i++;
    if($i > $product_limit)
    {
    ?>
    <tr>
      <td><?php if (!empty($product['option']) && !empty($product['option'][0]['sku']))?><img src="/barcode/ean/<?php echo $product['option'][0]['sku']; ?>.png" alt="<?php echo $product['option'][0]['sku']; ?>" /></td>
      <td>
        <?php echo $product['name']; ?>
        <?php foreach ($product['option'] as $option) { ?>
        - <?php echo $option['name']; ?>: <?php echo $option['value']; ?>
        <?php } ?>
        <?php if ($product['location']) { ?>
       <br /><small><?php echo $text_location; ?> <?php echo $product['location']; ?></small>
        <?php } ?>
      </td>
      <td align="right"><?php echo $product['quantity']; ?></td>
      <td align="right"><?php echo $product['price']; ?></td>
      <td align="right">
        <?php if ($order['comment'])
        {
          echo $order['comment'];
        }
        ?>
      </td>
      <td align="right"></td>
    </tr>
    <?php } ?>
    <?php foreach ($order['voucher'] as $voucher) { ?>
    <tr>
      <td align="left"><?php echo $voucher['description']; ?></td>
      <td align="left"></td>
      <td align="right">1</td>
      <td align="right"><?php echo $voucher['amount']; ?></td>
      <td align="right"><?php echo $voucher['amount']; ?></td>
      <td align="right"></td>
    </tr>
    <?php } ?>
    <?php } ?>
    <?php foreach ($order['total'] as $total) { ?>
    <?php if ($total['code'] == 'shipping') { ?>
    <tr align="right">
      <td style="border: 0px;" align="right" colspan="3"><b><?php echo $text_pandp; ?></b></td>
      <td style="border: 0px;" align="right"><?php echo $total['text']; ?></td>
      <td style="border: 0px; text-align: left;" colspan="2"><?php echo $total['title']; ?></td>
    </tr>
    <?php } else { ?>
    <tr align="right">
      <td style="border: 0px;" align="right" colspan="3"><b><?php echo $total['title']; ?></b></td>
      <td style="border: 0px;" align="right"><?php echo $total['text']; ?></td>
    </tr>
    <?php } ?>
    <?php } ?>
  </table>
  <table class="store">
    <tr align="center">
      <td><?php echo $text_thanks; ?></td>
    </tr>
  </table>
  </div>
    <table class="store">
    <tr>
      <td width="33%"><b><?php echo $text_order_id; ?></b> <?php echo $order['order_id']; ?></td>
      <td><b><?php echo $text_customer; ?></b> <?php echo $order['firstname']; ?> <?php echo $order['lastname']; ?></td>
      <td width="33%" style="text-align: right;"><img src="/barcode/3of9/<?php echo $order['order_id']; ?>.png" alt="<?php echo $order['order_id']; ?>" /></td>
    </tr>
  </table>
  </div>
  <?php } ?>
    </div>
<?php } ?>
</body>
</html>