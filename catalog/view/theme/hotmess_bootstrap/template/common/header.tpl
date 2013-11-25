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
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/hotmess_bootstrap/stylesheet/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="catalog/view/theme/hotmess_bootstrap/stylesheet/megamenu.css" />
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
<link rel="stylesheet" type="text/css" href="catalog/view/theme/hotmess_bootstrap/stylesheet/stylesheet.css" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery.jcarousel.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/tabs.js"></script>
<script type="text/javascript" src="catalog/view/javascript/common.js"></script>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie7.css" />
<![endif]-->
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie6.css" />
<script type="text/javascript" src="catalog/view/javascript/DD_belatedPNG_0.0.8a-min.js"></script>
<script type="text/javascript">
DD_belatedPNG.fix('#logo img');
</script>
<![endif]-->
<?php if (isset($data_layer)) echo "<script>dataLayer =[" . json_encode($data_layer) . "];</script>"; ?>
<?php echo $google_analytics; ?>
</head>
<body class="pushmenu-push">
<div id="header">
    <div class="container">
        <div class="row">
            <div class="col-sm-4 text-center col-sm-push-4 hidden-xs">
                <?php if ($logo) { ?>
                    <div id="logo"><a href="<?php echo $home; ?>" style="display: inline-block; position: relative; top: -20px;"><img style="width: 100%; max-width: 290px;" src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
                <?php } ?>
            </div>
            
            <div class="col-sm-4 col-sm-pull-4 hidden-xs">
                <div class="toplinks visible-lg"><?php if(isset($blocks[0]['description'])) {echo $blocks[0]['description'];} ?></div>
                
                <div id="top-inputs">
                    <div id="newsletter" class="inputContainer topEmail">
                      <div class="button-enter" title="sign up"></div>
                      <input type="email" name="email" placeholder="enter email for latest news" value="" />
                    </div>

                    <div id="search" class="inputContainer topSearch">
                      <div class="button-search" title="<?php echo $text_search; ?>"></div>
                      <input type="text" name="search" placeholder="<?php echo $text_search; ?>" value="<?php echo $search; ?>" />
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="tag-line visible-lg" style="text-align: right; margin-top: 5px;"><?php if(isset($blocks[1]['description'])){echo $blocks[1]['description'];} ?></div>

                <div class="madeuk hidden-xs"><span>MADE IN THE UK</span></div>

                <?php echo $cart; ?>

                <div id="welcome" class="purple visible-lg hidden-xs">
                    <?php if (!$logged) { ?>
                    <?php echo $text_welcome; ?>
                    <?php } else { ?>
                    <?php echo $text_logged; ?>
                    <?php } ?>
                </div>
            </div>
            
            <div class="col-xs-12 visible-xs">
                <div class="row top_mobile">
                    <div class="col-xs-1">
                        <div id="nav_list"><span class="glyphicon glyphicon-align-justify"></span></div>
                    </div>
                    <div class="col-xs-4">
                        <?php if ($logo) { ?>
                        <div id="logo"><a href="<?php echo $home; ?>" style="display: inline-block;position: relative; top: -20px;"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
                        <?php } ?>
                    </div>
                    <div class="col-xs-7">
                        <div class="media-links-mobile" style="z-index: 1700;">
                            <span id="searchicon" style="position: absolute; top: 13px; right: 25px; cursor: pointer;"class="glyphicon glyphicon-search"></span>
                            <?php //echo $cart; ?>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-xs-12 visible-xs">
                <div class="email" style="display: none;">
                    <div id="search" class="inputContainer">
                    <div class="button-search" title="<?php echo $text_search; ?>"></div>
                    <input type="text" name="search" placeholder="<?php echo $text_search; ?>" value="<?php echo $search; ?>" />
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-sm-12 pushmenu pushmenu-left">
                <?php echo $megamenu; ?>
            </div>
        </div>
    </div>
</div>
<?php /* <div id="header_placeholder"></div> */ ?>

<div id="notification"></div>
<script>
        $(document).ready(function() {
                $menuLeft = $('.pushmenu-left');
                $nav_list = $('#nav_list');
                 
                $nav_list.click(function() {
                        $(this).toggleClass('active');
                        $('.pushmenu-push').toggleClass('pushmenu-push-toright');
                        $menuLeft.toggleClass('pushmenu-open');
                });
                
                $('#searchicon').click(function(){
                    $(".email").slideToggle();
                });
                
                
                
                /*Resize the youtube video on resize.*/
                $(window).resize(function(){

                    $("iframe").css({

                        width: "100%",
                        height: ($(this).width()) * .58

                    });

                });

                $(window).resize();
                
                
                
        });
</script>