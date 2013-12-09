<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<meta content="width=device-width, initial-scale=1, maximum-scale=1 user-scalable=no" name="viewport">
<link rel="stylesheet" type="text/css" href="catalog/view/theme/hotmess/stylesheet/bootstrap.css" rel="stylesheet">
<!--<meta name="viewport" content="width=1200, initial-scale=1.0">-->
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/hotmess/stylesheet/stylesheet_20131009.css" />
<link rel="stylesheet" type="text/css" href="catalog/view/theme/hotmess/stylesheet/jquery.selectbox.css" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<script type="text/javascript" src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
<script type="text/javascript" src="catalog/view/javascript/common.js"></script>	
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<!--[if IE 8]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/hotmess/stylesheet/ie8.css" />
<![endif]-->
<!--[if IE 9]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/hotmess/stylesheet/ie9.css" />
<![endif]-->
<!--[if IE 7]> 
<link rel="stylesheet" type="text/css" href="catalog/view/theme/hotmess/stylesheet/ie7.css" />
<![endif]-->
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/hotmess/stylesheet/ie6.css" />
<script type="text/javascript" src="catalog/view/javascript/DD_belatedPNG_0.0.8a-min.js"></script>
<script type="text/javascript">
DD_belatedPNG.fix('#logo img');
</script>
<![endif]-->
<!--[if !IE]><!--><script>  
if (/*@cc_on!@*/false) {  
    document.documentElement.className+=' ie10';  
}  
</script><!--<![endif]-->

<?php if (isset($data_layer)) echo "<script>dataLayer =[" . json_encode($data_layer) . "];</script>"; ?>
</head>

<body>
<?php echo $google_analytics; ?>

<div class="container">

<div id="inner_container">

<div id="header">
    <div class="container">
        <div class="row">
            <div class="col-sm-4">1</div>

            <div class="col-sm-4">
                <?php if ($logo) { ?>
                    <div id="logo"><a href="<?php echo $home; ?>" style="display: inline-block;position: relative; top: -20px;"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
                <?php } ?>
                <div id="tagline"><?php echo $text_tag; ?></div>
            </div>

            <div class="col-sm-4">3</div>
        </div>
    </div>
</div>

<div class="container_24">
<div id="notification"></div>
<script src="catalog/view/javascript/bootstrap-3.0/bootstrap.js"></script>