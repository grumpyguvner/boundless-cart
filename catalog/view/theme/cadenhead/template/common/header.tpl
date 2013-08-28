<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/cadenhead/stylesheet/stylesheet.css" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
<script type="text/javascript" src="catalog/view/javascript/jquery/tabs.js"></script>
<script type="text/javascript" src="catalog/view/javascript/common.js"></script>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/cadenhead/stylesheet/ie7.css" />
<![endif]-->
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/cadenhead/stylesheet/ie6.css" />
<script type="text/javascript" src="catalog/view/javascript/DD_belatedPNG_0.0.8a-min.js"></script>
<script type="text/javascript">
DD_belatedPNG.fix('#logo img');
</script>
<![endif]-->
<?php if (isset($data_layer)) echo "<script>dataLayer =[" . json_encode($data_layer) . "];</script>"; ?>
<?php echo $google_analytics; ?>
</head>
<body>
<div id="page">    
<div id="container">
<?php if ($error_environment) { ?>
<div id="environment"><div class="warning"><?php echo $error_environment; ?></div></div>
<?php } ?>

<div id="header">
 
  <!--?php echo $language; ?-->
  
  <?php echo $cart; ?>
   <?php if ($logo) { ?>
  <div id="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
  <?php } ?>
  <?php echo $currency; ?>
  <div id="search">
    <div class="button-search"></div>
    <?php if ($filter_name) { ?>
    <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" />
    <?php } else { ?>
    <input type="text" name="filter_name" value="<?php echo $text_search; ?>" onclick="this.value = '';" onkeydown="this.style.color = '#000000';" />
    <?php } ?>
  </div>
  <div id="welcome">
    <?php if (!$logged) { ?>
    <?php echo $text_welcome; ?>
    <?php } else { ?>
    <?php echo $text_logged; ?>
    <?php } ?>
  </div>
  <div id="newsletter_wrapper">
        <form action="/index.php" method="get" id="newsletter_form" class="newsletter-form" target="_blank">
            <input type="hidden" name="route" value="module/newsletter/callback">
            <input type="hidden" name="subscribe" value="1">
            <div class="newsletter_input">
                <input type="text" id="newsletter_email" name="email" onfocus="this.placeholder = ''" placeholder="Email newsletter signup">
                <input class="gobutton" type="submit" value="GO">
            </div>
        </form>
   </div>
  <!--div class="links"><a href="<?php echo $home; ?>"><?php echo $text_home; ?></a><a href="index.php?route=information/information&information_id=7" id="wishlist-total">Whisky Tasting</a><a href="index.php?route=information/information&information_id=8">Cadenheads</a><a href="">Products</a><a href="">Event Calendar</a><a href="index.php?route=information/information&information_id=9">Location</a><a href="index.php?route=information/contact">Contact us</a></div-->
</div>
    
<?php if ($categories){ ?>
<div id="menu">
  <ul>
      
      <li><a href="<?php echo $home; ?>"><img id="img_home" src="catalog/view/theme/cadenhead/image/home.png" alt="Home" style="margin-top: -10px;"/></a></li>
      <li><a href="index.php?route=information/information&information_id=7" id="wishlist-total">Whisky Tasting</a></li>
      <li><a href="index.php?route=information/information&information_id=8">Cadenheads</a></li>
      <?php foreach ($categories as $category) { ?>
    <li><a><?php echo $category['name']; ?></a>
      <?php if ($category['children']) { ?>
      <div>
        <?php for ($i = 0; $i < count($category['children']);) { ?>
        <ul>
          <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
          <?php for (; $i < $j; $i++) { ?>
          <?php if (isset($category['children'][$i])) { ?>
          <li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
          <?php } ?>
          <?php } ?>
           <li><a href="index.php?route=account/voucher">Voucher Gift</a></li>
            <li><a href="">Voucher Tasting</a></li>
        </ul>
        <?php } ?>
         
      </div>
      <?php } ?>
    </li>
    <?php } ?>
    <li><a href="index.php?route=information/event/events&event_id=2">Event Calendar</a></li>
    <li><a href="index.php?route=information/information&information_id=9">Location</a></li>
    <li><a href="index.php?route=information/contact">Contact us</a></li>
    
  </ul>
</div>
<?php } ?>
    
<div id="notification"></div>
