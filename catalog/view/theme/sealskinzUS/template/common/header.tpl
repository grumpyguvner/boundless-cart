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
        <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:300italic,400italic,700italic,400,300,700' rel='stylesheet' type='text/css'>
        <!-- Bootstrap css -->
        <link href="catalog/view/theme/sealskinz/stylesheet/bootstrap/bootstrap.min.css" rel="stylesheet" media="screen">
        <!--        <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <link href="catalog/view/theme/sealskinz/stylesheet/bootstrap/bootstrap-responsive.min.css" rel="stylesheet">-->
        <!-- End css Bootstrap css -->
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/sealskinz/stylesheet/stylesheet.css" />
        <!-- <link rel="stylesheet" type="text/css" href="catalog/view/theme/sealskinz/stylesheet/stylesheet-480.css" />
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/sealskinz/stylesheet/stylesheet-767.css" />
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/sealskinz/stylesheet/stylesheet-768-979.css" /> -->
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
        <!-- Bootstrap js -->
        <script src="catalog/view/javascript/bootstrap/bootstrap.min.js"></script>
        <!-- End Bootstrap js -->
        <!-- Slidenews press -->
        <script src="catalog/view/javascript/slidepress/jquery.slidepress.js" type="text/javascript"></script>
        <!-- End Slidenews press -->
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
        DD_belatedPNG.fix('#logo img');Senza nomSenza nome 1e 1
        </script>
        <![endif]-->
        
    </head>
    <body>
        <?php if (isset($data_layer)) echo "<script>dataLayer =[" . json_encode($data_layer) . "];</script>"; ?>
        <?php echo $google_analytics; ?>
        <div id="header">
            <div id="background">
                <div class="container">
                    <div id="menuh">
                        <ul id="left">
                            <li><a href="#" class="top_parent" onclick="return false;"><img src="image/flags/gb.png" alt="UK" />&nbsp <?php echo $text_uk ?> </a>
                                <ul>
                                    <li><a href="//<?php echo $_SERVER['HTTP_HOST']; ?>/UK/"><img src="image/flags/gb.png" alt="UK" />&nbsp UK</a></li>
                                    <li><a href="#"><img src="image/flags/us.png" alt="US" />&nbsp US</a></li>
                                </ul>
                            </li>
                            <?php
                            if ($currency) {
                                ?>

                                <?php if ($currency != '') { ?>
                                    <li>
                                        <?php echo $currency; ?>
                                    </li>
                                <?php } ?>

                                <?php
                            }
                            ?>
                        </ul>
                        <ul id="right">
                            <?php if (!$logged) { ?>
                                <li>
                                    <a href="<?php echo $login; ?>"><?php echo $text_login; ?></a>
                                </li>
                            <?php } else { ?>
                                <li>
                                    <?php echo $text_logged; ?>
                                </li>
                            <?php } ?>
                            <li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
                            
                            <?php if ($cart) { ?>
                            <li><?php echo $cart; ?></li>
                            <?php } ?>
                        </ul> 
                    </div> 
                </div>
            </div>
            <div class="gradiente">
                <div class="container">
                    <div id="logo">
                        <?php if ($logo) { ?>
                            <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
                        <?php } ?>
                    </div>
                    <div id="search">
                        <div class="navbar-search">
                        <div class="button-form-search"></div>
                            <div class="wrap-form">
                                <?php if ($filter_name) { ?>
                                    <input type="text" class="search-form" placeholder="Search Store.." name="filter_name" value="<?php echo $filter_name; ?>" />
                                    <input type="hidden" name="filter_sub_category" value="1" />
                                    <input type="hidden" name="filter_description" value="1" />
                                <?php } else { ?>
                                    <input type="text" class="search-form" placeholder="Search Store.." name="filter_name" value="<?php echo $text_search; ?>" onclick="this.value = '';" onkeydown="this.style.color = '#000000';" />
                                    <input type="hidden" name="filter_sub_category" value="1" />
                                    <input type="hidden" name="filter_description" value="1" />

                            <?php } ?>
                        </div>
                    </div>
                </div>
                </div>
            </div>

            <!-- Start Menu inferiore -->
            <div class="menu-gradient">
                <div class="container">

                    <div id='cssmenu'>
                        <div id="socialn">
                            <span><?php echo $text_follow_us ?></span>&nbsp<span><?php echo $fb ?></span><span><?php echo $tw ?></span><span><?php echo $yb ?></span><span><?php echo $pt ?></span><span><?php echo $gp ?></span>
                        </div>
                        <ul>
                            <li><a href='<?php echo $home; ?>'><span><img src="catalog/view/theme/sealskinz/image/home_button.png" alt="Home"/></span></a></li>
                            <li id="activity"><span><?php echo $text_activity ?></span>
                                <?php if ($categories) { ?>
                                    <ul class="wrap-menu">
                                        <div id="left">
                                            <?php $children = $categories[1]['children']; ?>
                                            <?php if ($children) { ?>
                                                <?php for ($i = 0; $i < count($children) && $i < 3; $i++) { ?>
                                                    <a href="<?php echo $children[$i]['href'] ?>" alt="<?php echo $children[$i]['name'] ?>" >
                                                        <div class="<?php echo $children[$i]['name'] ?>"></div>
                                                    </a>
                                                <?php } ?>
                                            <?php } ?>
                                        </div>
                                        <div id="right" class="menu-list">
                                            <div class="activities"><b><?php echo $categories[0]['name'] ?></b></div>
                                            <?php $children = $categories[0]['children']; ?>
                                            <?php if ($children) { ?>
                                            <?php while (count($children) < 16) {
                                                    $children[] = array('name' => "&nbsp;", 'href' => "");
                                                  } 
                                                  $children = array_slice($children, 0, 16); ?>
                                                <div id="left" class="menu-column-left">
                                                    <?php 
                                                    foreach ($children as $key => $child) { ?>
                                                    <?php   if ($key == 8) { ?>
                                                </div>   
                                                <div id="right" class="menu-column-right">
                                                    <?php   } ?>
                                                        <li <?php echo ($key >= 8 ? 'style="border-left: none;"' : '') ?>><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                                                    <?php } ?>
                                                </div>
                                            <?php } ?>
                                        </div>
                                    </ul>
                                <?php } ?>
                            </li>
                            <li><a href="our-history"><span><?php echo $text_brand_story ?></span></a></li>
                            <li><a href="http://www.sealskinz.com/blog/" target="_blank"><span><?php echo $text_blog ?></span></a></li>
                            <li><a href="<?php echo $stockist ?>"><span><?php echo $text_stockist ?></span></a></li>
                            <li><a href="registration"><span><?php echo $text_product_registration ?></span></a></li>
                            
                        </ul>
                    </div>
                </div>
                <!-- Finish Menu inferiore -->
            </div>

        </div>
<script type="text/javascript">
$(document).ready(function () {
   
    $('#activity').hover(
          function () {
              $('ul', this).fadeIn(100);
          },
          function () {
              $('ul', this).fadeOut(100);       
          }
    );
        
    $('.wrap-menu').click(
         function() {
            if( $('#cssmenu > ul > li > ul').is(':hidden') ) {
                $('#cssmenu > ul > li > ul').css('display','inline-block'); 
            }
            else {
                $('#cssmenu > ul > li > ul').css('display', 'none');
            }
         }
    );
        
    $('#activity').mouseover(
        function () {
            $('#cssmenu ul > li#activity > span').css('background','#74964a');
        }
    );
        
    $('#activity').mouseout(
        function () {
            $('#cssmenu ul > li#activity > span').css('background','none');
        }
    );
        
});
</script>