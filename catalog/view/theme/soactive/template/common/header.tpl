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
        <meta name="viewport" content="width=1020; initial-scale=1.0">
        <link href="catalog/view/theme/soactive/stylesheet/bootstrap/bootstrap.min.css" rel="stylesheet" media="screen">
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/soactive/stylesheet/stylesheet.css" />
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/soactive/stylesheet/megamenu.css" />
        <link type="text/css" rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans+Condensed:300normal,300italic,700normal|Open+Sans:400normal|Abel:400normal|Oswald:400normal|BenchNine:400normal|Unica+One:400normal|PT+Sans+Narrow:400normal|Droid+Sans:400normal|Droid+Serif:400normal|Cuprum:400normal|Ubuntu+Condensed:400normal&amp;subset=all">
        <?php foreach ($styles as $style) { ?>
            <link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
        <?php } ?>
        <script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/jquery/jquery.jcarousel.min.js"></script>
        <link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
        <script type="text/javascript" src="catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>
        <link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
        <script type="text/javascript" src="catalog/view/javascript/jquery/tabs.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/common.js"></script>
        <script src="catalog/view/javascript/bootstrap/bootstrap.min.js"></script>
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
    </head>
    <body>
        <?php echo $google_analytics; ?>
        <div id="fb-root"></div>
        <script>(function(d, s, id) {
          var js, fjs = d.getElementsByTagName(s)[0];
          if (d.getElementById(id)) return;
          js = d.createElement(s); js.id = id;
          js.src = "//connect.facebook.net/en_GB/all.js#xfbml=1";
          fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));</script>
        <div class="container">
            <div id="header">
                
            <?php if ($logo) { ?>
                <div id="logo">
                    <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
                </div>
            <?php } ?>
                <div class="links">
                    <div class="top">
                        
                        <?php echo $localisation; ?>
                       
                        <div id="welcome">
                            <?php if (!$logged) { ?>
                                <?php echo $text_welcome; ?>
                            <?php } else { ?>
                                <?php echo $text_logged; ?>
                            <?php } ?>
                        </div>
                        <a href="<?php echo $wishlist; ?>" id="wishlist-total"><?php echo $text_wishlist; ?></a>
                        <div style="display: inline-block;"><?php echo $cart; ?></div>
                    </div>
                    <div id="search">
                        <div class="button-search"></div>
                        <?php if ($filter_name) { ?>
                            <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" />
                        <?php } else { ?>
                            <input type="text" name="filter_name" placeholder="<?php echo $text_search; ?>" onclick="this.value = '';" onkeydown="this.style.color = '#000000';" />
                        <?php } ?>
                    </div>
                </div>
            </div>
            <?php 
            if ($megamenu)
            {
                $search = '>home<';
                $replace = '><img src="catalog/view/theme/soactive/image/home-button.png" alt="Home" class="home" /><';
                $mega_menu = str_replace($search, $replace, $megamenu);
                
                echo $mega_menu;
                
            } elseif ($categories) { ?>
                <div id="menu">
                    <ul>
                        <li><a href='<?php echo $home; ?>'><img src="catalog/view/theme/soactive/image/home-button.png" alt="Home"/></a></li>
                        <?php foreach ($categories as $category) { ?>
                        <li><a href="<?php echo $category['href']; ?>"><?php echo strtoupper($category['name']); ?></a>
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
                                            </ul>
                                        <?php } ?>
                                    </div>
                                <?php } ?>
                            </li>
                        <?php } ?>
                        <li><a href='index.php?route=information/event/events'>EVENTS</a></li>
                    </ul>
                </div>
            <?php } ?>
            <?php foreach ($blocks as $block) { ?>
                <?php echo $block['description']; ?>
            <?php } ?>
            <div id="notification"></div>
    
