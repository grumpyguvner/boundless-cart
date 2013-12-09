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
<link rel="stylesheet" type="text/css" href="catalog/view/theme/bootstrap/stylesheet/stylesheet.css" />
<!-- Bootstrap css -->
<link href="catalog/view/theme/bootstrap/stylesheet/bootstrap/bootstrap.css" rel="stylesheet" media="screen">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="catalog/view/theme/bootstrap/stylesheet/bootstrap/bootstrap-responsive.css" rel="stylesheet">
<!-- End css Bootstrap css -->
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
<?php if (isset($data_layer)) echo "<script>dataLayer =[" . json_encode($data_layer) . "];</script>"; ?>
<?php echo $google_analytics; ?>
</head>
<body>
<?php if ($error_environment) { ?>
<div id="environment"><div class="warning"><button type="button" class="close" data-dismiss="alert">×</button><?php echo $error_environment; ?></div></div>
<?php } ?>
<div class="container"> 
    
    <div class="row" >
        <div id="headerb">
	  <div  class="span4">
	   <div id="logo">
            <?php if ($logo) { ?>
            <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
        <?php } ?>
        </div>
	  </div>
	
	  <div class="span8">
	   <div class="row">
	    <div class="span2"> 
                <?php echo $language; ?>
                <?php echo $currency; ?> 
            </div>
	    <div class="span2">
                <?php echo $cart; ?>
            </div>
	    <div class="span4"> 
            <div class="row">
            <div class="span4" id="search">
            <form class="navbar-search">
            <div class="button-search"></div>
            <?php if ($filter_name) { ?>
    
            <input type="text" class="search-query" placeholder="Search" name="filter_name" value="<?php echo $filter_name; ?>" />
    
            <?php } else { ?>
    
            <input type="text" class="search-query" placeholder="Search" name="filter_name" value="<?php echo $text_search; ?>" onclick="this.value = '';" onkeydown="this.style.color = '#000000';" />
    
            <?php } ?>
            </form>
            </div>
          </div>
          <div class="row">
            <div class="span4">
            <div id="welcome">
            <?php if (!$logged) { ?>
            <?php echo $text_welcome; ?>
            <?php } else { ?>
            <?php echo $text_logged; ?>
            <?php } ?>
            </div>
            </div>
          </div>
            </div>
	   </div> 
	    
	  </div>
    </div>
	 </div>
    
    
    
    <!--div class="row">
    <div id="header">
        <div class="span3" id="logo">
            <?php if ($logo) { ?>
            <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
        <?php } ?>
        </div>
        
        
             
            <?php echo $language; ?>
            <?php echo $currency; ?>
             
             <div class="span2">
            <?php echo $cart; ?>
             </div>
             
        <div class="span4">
          <div class="row">
            <div class="span4" id="search">
            <form class="navbar-search pull-left">
            <div class="button-search"></div>
            <?php if ($filter_name) { ?>
    
            <input type="text" class="search-query" placeholder="Search" name="filter_name" value="<?php echo $filter_name; ?>" />
    
            <?php } else { ?>
    
            <input type="text" class="search-query" placeholder="Search" name="filter_name" value="<?php echo $text_search; ?>" onclick="this.value = '';" onkeydown="this.style.color = '#000000';" />
    
            <?php } ?>
            </form>
            </div>
          </div>
          <div class="row">
            <div class="span4">
            <div id="welcome">
            <?php if (!$logged) { ?>
            <?php echo $text_welcome; ?>
            <?php } else { ?>
            <?php echo $text_logged; ?>
            <?php } ?>
            </div>
            </div>
          </div>
        </div>
        
       
        
</div>
    </div-->
   <div class="row"> 
       <div class="span12">
<?php if ($categories) { ?>
    <div class="navbar">
              <div class="navbar-inner">
                <div class="container">
                  <a data-target=".navbar-responsive-collapse" data-toggle="collapse" class="btn btn-navbar">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                  </a>
                  
                  <div class="nav-collapse collapse navbar-responsive-collapse">
                    <ul class="nav">
                      <li class="active"><a href="<?php echo $home; ?>"><?php echo $text_home; ?></a></li>
                      <?php foreach ($categories as $category) { ?>
    <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
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
                      
                    </ul>
                    
                    <ul class="nav pull-right">
                      
                      <li class="divider-vertical"></li>
                      <li class="dropdown">
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">Account <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                          <li><a href="<?php echo $wishlist; ?>" id="wishlist-total"><?php echo $text_wishlist; ?></a></li>
                          <li class="divider"></li>
                          <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
                          <li class="divider"></li>
                          <li><a href="<?php echo $shopping_cart; ?>"><?php echo $text_shopping_cart; ?></a></li>
                          <li class="divider"></li>
                          <li><a href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></li>
                          
                          
                        </ul>
                      </li>
                    </ul>
                  </div><!-- /.nav-collapse -->
                </div>
              </div><!-- /navbar-inner -->
            </div>
    
    

<?php } ?>
   </div>
</div>
<div id="notification"></div>
