<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/hotmess/stylesheet/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="catalog/view/theme/hotmess/stylesheet/megamenu.css" />
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
<link rel="stylesheet" type="text/css" href="catalog/view/theme/hotmess/stylesheet/stylesheet.css" />
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
<body>
<div id="wrapper">
    <div id="header">
        <div class="visible-xs mobileheader">
            <?php if ($logo) { ?>
            <div id="mobilelogo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
            <?php } ?>
            
            <button type="button" class="navbar-toggle" >
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <span id="mobilesearchicon" class="glyphicon glyphicon-search"></span>
            
            <div class="searchbox" style="display: none;">
                <div id="search" class="inputContainer">
                <div class="button-search" title="<?php echo $text_search; ?>"></div>
                <input type="text" name="search" placeholder="<?php echo $text_search; ?>" value="<?php echo $search; ?>" />
                </div>
            </div>
        </div>
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
                          <form action="index.php?route=module/newsletter" method="get" class="newsletter-form">
                          <input type="hidden" name="route" value="module/newsletter/callback">
                          <div class="button-enter action" title="sign up"></div>
                          <input type="email" name="email" placeholder="enter email for latest news" value="" />
                          </form>
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
                
            </div>
        </div>
        <?php echo $megamenu; ?>
    </div>
    <div id="nav" class="visible-xs">
        <ul>
        <?php foreach ($categories as $category) { ?>
                <li <?php if ($category['children']) echo 'class="parent"'; ?>><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                  <?php if ($category['children']) { ?>

                        <ul>
                          <li><a href="/hot-looks">LOOKBOOKS</a></li>
                        <?php for ($i = 0; $i < count($category['children']);) { ?>
                          <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
                          <?php for (; $i < $j; $i++) { ?>
                          <?php if (isset($category['children'][$i])) { ?>
                          <li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
                          <?php } ?>
                          <?php } ?>
                        <?php } ?>
                        </ul>

                  <?php } ?>
                </li>
        <?php } ?>
        </ul>
    </div>

<div id="header_placeholder"></div>

<div id="notification"></div>
<script>
        $(document).ready(function() {
                $('.navbar-toggle').click(function() {
                    navheight = $('#nav').height();
                    $('#wrapper').toggleClass('navactive');

                    if ($("#wrapper").hasClass("navactive")) {
                        offset_top = $(window).scrollTop();
                       
                        
                        $('#wrapper').height(navheight);

                        $('body').scrollTop(0);
                    }
                    else
                    {
                        $('#wrapper').height('auto');
                        $('body').scrollTop(offset_top);
                    }
                });
                
                $('#mobilesearchicon').click(function(){
                    $(".searchbox").slideToggle();
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
    <div id="bodycontent">