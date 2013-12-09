<!DOCTYPE html>
<!--[if lt IE 7 ]><html lang="en" class="no-js ie6 ie"><![endif]-->
<!--[if IE 7 ]><html lang="en" class="no-js ie7 ie"><![endif]-->
<!--[if IE 8 ]><html lang="en" class="no-js ie8 ie"><![endif]-->
<!--[if IE 9 ]><html lang="en" class="no-js ie9 ie"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> 
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<?php 
if (isset($_SERVER['DOCUMENT_ROOT']))
$_theme_include_path = $_SERVER['DOCUMENT_ROOT'] . '/catalog/view/theme/nicole-shop/';
else $_theme_include_path = dirname(__FILE__) . '/../../';

include($_theme_include_path . '/nico_theme_editor/settings.inc');?>
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
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="apple-touch-icon" href="/apple-touch-icon.png">

  <!--[if lt IE 9]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/nicole-shop/stylesheet/stylesheet.css" />
<link rel="stylesheet" type="text/css" href="catalog/view/theme/nicole-shop/stylesheet/dropkick.css" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<link href='https://fonts.googleapis.com/css?family=Open+Sans:200,300,400,600,700|Open+Sans+Condensed:300|Pontano+Sans:200,300,400,600,700' rel='stylesheet' type='text/css' />
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
<script type="text/javascript" src="catalog/view/theme/nicole-shop/js/jquery.colorbox.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/nicole-shop/js/colorbox.css" media="screen" />
<script type="text/javascript" src="catalog/view/javascript/jquery/tabs.js"></script>
<script type="text/javascript" src="catalog/view/theme/nicole-shop/js/jquery.dropkick-1.0.0.js"></script>
<script type="text/javascript" src="catalog/view/theme/nicole-shop/js/common.js"></script>
<script type="text/javascript" src="catalog/view/theme/nicole-shop/js/nicole-shop.js"></script>
<?php 
if (isset($_nico_settings['styles'])) foreach($_nico_settings['styles'] as $group => $css) if ($css){?>
<link rel="stylesheet" type="text/css" id="_style_css_<?php echo $group;?>" href="<?php echo $css;?>"/>
<?php }?>
<?php foreach ($scripts as $script) { if (strpos($script, 'nivo.slider') == false) {?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } } ?>
<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/nicole-shop/stylesheet/ie7.css" />
<![endif]-->
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/nicole-shop/stylesheet/ie6.css" />
<script type="text/javascript" src="catalog/view/javascript/DD_belatedPNG_0.0.8a-min.js"></script>
<script type="text/javascript">
DD_belatedPNG.fix('#logo img');
</script>
<![endif]-->
<?php echo $google_analytics; ?>
</head>
<body>
<?php include($_theme_include_path . '/nico_theme_editor/editor.inc');?>
<?php if ($error_environment) { ?>
<div id="environment"><div class="warning"><?php echo $error_environment; ?></div></div>
<?php } ?>
<div id="container">
<div id="header">
  <?php if ($logo) { ?>
	<div id="logo">
		<a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
			<span><?php echo $name; ?></span>
		</a>
	</div>
  <?php } ?>
  <?php echo $language; ?>
  <div id="search">
    <div class="button-search"></div>
    <?php if ($filter_name) { ?>
    <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" /> 
    <?php } else { ?>
    <input type="text" name="filter_name" value="<?php echo $text_search;?>" onclick="this.value = '';" onkeydown="this.style.color = '#000000';" />
    <?php } ?>
  </div>
   <?php echo $currency; ?>
  <?php echo $cart; ?>
  <div id="welcome">
    <?php if (!$logged) { ?>
    <?php echo $text_welcome; ?>
    <?php } else { ?>
    <?php echo $text_logged; ?>
    <?php } ?>
  </div>
  <!-- <div class="links"><a href="<?php echo $home; ?>"><?php echo $text_home; ?></a><a href="<?php echo $wishlist; ?>" id="wishlist-total"><?php echo $text_wishlist; ?></a><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a><a href="<?php echo $shopping_cart; ?>"><?php echo $text_shopping_cart; ?></a><a href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></div> -->
</div>
<?php if ($categories) { ?>
<div id="menu" class="clearfix not_mobile">
  <div>
  <ul class="clearfix">
	<li class="home"><a href="/">Home</a></li>
    <?php foreach ($categories as $category) { ?>
    <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
      <?php if ($category['children']) { ?>
      <div>
		<?php if (isset($category['thumb'])) {?><div class="img"><img src="<?php echo $category['thumb'];?>"></div><?php }?>  
        <?php for ($i = 0; $i < count($category['children']);) { ?>
        <ul>
          <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
          <?php for (; $i < $j; $i++) { ?>
          <?php if (isset($category['children'][$i])) { ?>
          <li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
          <?php } ?>
          <?php } ?>
        </ul>
        <?php } ?>
      </div>
      <?php } ?>
    </li>
    <?php } ?>
  </ul>
  </div>
</div>
<div  id="mobile_menu" class="mobile">
	<select onchange="location = this.value">
	<?php foreach ($categories as $category) { ?>
		<option value="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></option>
		<?php if ($category['children']) { ?>
			<?php for ($i = 0; $i < count($category['children']);) { ?>
				<optgroup label="">
				  <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
				  <?php for (; $i < $j; $i++) { ?>
				  <?php if (isset($category['children'][$i])) { ?>
				  <option value="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></option>
				  <?php } ?>
				  <?php } ?>
				 </optgroup>
			 <?php } ?>
		<?php } ?>
		<?php } ?>
</select>
</div>
<?php } ?>

<div id="notification"></div>
