<?php
$nico_colors = 
array(
    'Header',
	'Header background'=> array ('#header', 'background-color'), 
	'Logo text' => array('#header #logo a', 'color'),
	'Cart text'=>array('#cart-total','color'),
	'Welcome text'=>array('#header #welcome','color'),
	'Welcome text a'=>array('#header #welcome a','color'),
	'Search text color'=>array('#header #search input','color'),
	'Language & currency text'=>array('.dk_toggle','color'),
	'Menu',
	'Menu text' => array('#menu > div > ul > li > a', 'color'),
	'Menu background' => array('#menu > div', 'background'),
	'Menu border' => array('#menu > div', 'border-color'),
	'Menu border-left'=> array('#menu > div > ul > li','border-left-color'),
	'Menu background hover'=>array ('#menu > div > ul > li:hover > a','background'),
	'Submenu background'=>array ('#menu > div > ul > li > div', 'background'),
	'Submenu background hover'=>array ('#menu > div > ul > li ul > li > a:hover','background'), 
	'Submenu text'=>array ('#menu > div > ul > li > div > ul > li > a','color'),

	'Homepage',
	'Content background' => array('#content', 'background-color'),
	'Border featured & latest'=>array('.box .box-heading','border-color'),
	'Products',
	'Products title'=>array('.box-product .name a, .product-grid .name a', 'color'),
	'Products title hover'=>array('.box-product .name a:hover, .product-grid .name a:hover','color'),
	'Products background'=>array ('.box-product > div, .product-grid > div', 'background-color'),
	'Products price' =>array('.box-product .price, .product-grid .price', 'color'),
	'Products new price'=>array('.box-product .price-new, .product-grid .price-new','color'), 
	'Products old price'=>array('.box-product .price-old, .product-grid .price-old','color'),	
	'Product page',
	'Product border'=>array ('.product-info .description','border-color'), 
	'Product title'=>array ('.product-info h1','color'),
	'Product price'=>array ('.product-info > .right > .price > .price-p', 'color'),
	'Product tax price'=>array ('.product-info > .right > .price > .price-tax', 'color'),
	'Product old price'=>array ('.product-info > .right > .price > .price-old', 'color'),
	'Product new price'=>array ('.product-info > .right > .price > .price-new', 'color'),
	'Category page',
	'Page title'=>array ('.cat_heading','color'),
	'Border header'=>array('.cat-header','border-color'),
	'Border products grid'=>array('.product-grid','border-color'),
	'Border products list'=>array('.product-list > div','border-color'),
	'Products list title'=>array('.product-list .name a','color'),
	'Products list title hover'=>array('.product-list .name a:hover','color'),
	'Products list new price'=>array('.product-list .price','color'),
	'Products list old price'=>array('.product-list .price-old','color'),
	'Products list tax price'=>array('.product-list .price-tax','color'),
	'Carousel',
	'Carousel background'=>array ('.jcarousel-skin-opencart .jcarousel-container','background-color'),
	'Arrows background'=>array ('.jcarousel-skin-opencart .jcarousel-next-horizontal, .jcarousel-skin-opencart .jcarousel-prev-horizontal','background'),
	'Footer',
	'Border social band'=>array('#social_band,#social_band > div','border-color'),
	'Footer border' => array('#footer', 'border-color'),
	'Footer background'=>array('#footer,ul.payment-icons,#powered', 'background'),
	'Follow us background'=>array('.column span','background'),	
	'Footer border'=>array('#footer', 'border-color'),
	'Footer column text'=>array ('#footer h3','color'),
	'Footer text'=> array ('#footer .column a', 'color'), 
	'Powered background'=>array('div#powered', 'background-color'), 
	'Powered text'=>array('#powered','color'),
	'Powered text a'=>array('#powered a','color'),
	'Elastic slider',
	'Band elastic slider'=>array('ul.ei-slider-thumbs li.ei-slider-element','background'),
	'Band hover elastic slider'=>array('ul.ei-slider-thumbs li a:hover','background-color'),
	'Title elastic slider'=>array('div.ei-title h2','color'),
	'Subtitle elastic slider'=>array('div.ei-title h3','color'),
	'Text elastic slider'=>array('div.ei-title p','color'),
	'Nivo slider',
	'Arrows nivo slider'=>array('.slideshow .nivo-directionNav a','background-color'),
	'Band nivo slider'=>array('.slideshow .nivo-controlNav a','background'),
	'Band active nivo slider'=>array('.slideshow .nivo-controlNav a.active','background'),
	'Band hover nivo slider'=>array('.slideshow .nivo-controlNav a:hover','background'),
	'Flexslider',
	'Arrows flexslider'=>array('#slideshow0  .flex-direction-nav li a','background-color'),
	'Arrows hover flexslider'=>array('#slideshow0  .flex-direction-nav li a:hover','background-color'),
	'Band flexslider'=>array('.flex-control-nav.flex-control-paging li a','background-color'),
	'Band active flexslider'=>array('.flex-control-nav.flex-control-paging li a.flex-active','background-color'),
	'Band hover flexslider'=>array('.flex-control-nav.flex-control-paging li a:hover','background-color'),
	'Camera slider',
	'Arrows camera slider'=>array('div.camera_prevThumbs, .camera_nextThumbs, .camera_prev, .camera_next, .camera_commands, .camera_thumbs_cont','background-color'),
	'Band camera slider'=>array('.camera-caption','background'),
	'Text camera slider'=>array('.camera-caption','color'),
);


$nico_fonts = 
array(
    'Header'=> '',
	'Logo ' => '#header #logo a',
	'Welcome text'=>'#header #welcome',
	'Cart text'=>'#cart-total',
	'Search text'=>'#header #search input',
	'Language & currency text'=>'.dk_toggle',
	'Menu'=> '',
	'Menu text ' => '#menu a',
	'Submenu text'=> '#menu > ul > li > div > ul > li > a',
	'Elastic slider'=>'',
	'Title'=>'.ei-title h2',
	'Subtitle'=>'.ei-title h3',
	'Global' => '',
	'Body text ' => 'body',
	'Social band title'=>'#social_band h3',
	'Social band text'=>'#twitter_update_list li',
	'Products' => '',
	'Products heading' => '.box .box-heading',
	'Products title' => '.box-product .name a, .product-grid .name a',
	'Products price'=> '.box-product .price, .product-grid .price',
	'Products new price'=>'.box-product .price-new, .product-grid .price-new',
	'Products old price'=>'.box-product .price-old, .product-grid .price-old',
	'Products description'=>'#tab-description p',
	'Product page'=> '',
	'Product title' => '.product-info h1',
	'Product price'=> '.product-info .price',
	'Product price-tax'=> '.product-info .price-tax',
	'Product tab-description'=>'#tab-description',
	'Category page'=>'',
	'Title text'=>'.cat_heading',
	'Subcategory text'=>'.category-list ul li a',
	'Product compare text'=>'.product-compare',
	'List & Grid'=>'.product-filter .display',
	'Products grid title'=>'.box-product .name a, .product-grid .name a',
	'Products list title'=>'.product-list .name a',
	'Products list description'=>'.product-list .description',
	'Wishlist text'=>'.product-list .wishlist a',
	'Compare text'=>'.product-list .compare a',

	
	
);

$nico_options = 
array(
    'Header',
	'Show logo text'=> array ('#header #logo a span', 'display', array ('Show'=>'inline', 'Hide'=> 'none')),
	'Show logo image'=> array ('#header #logo a img', 'display',array ('Show'=>'block', 'Hide'=>'none')),
	'Show welcome visitor'=> array('#header #welcome','display', array('Show'=> 'block',  'Hide'=> 'none')),
	'Show language'=> array ('#language', 'display', array('Show'=>'block', 'Hide'=> 'none')),
	'Show cart'=> array('#header #cart', 'display' , array('Show'=> 'block', 'Hide'=> 'none')),
	'Show currency'=> array('#currency', 'display',array ('Show'=> 'block', 'Hide'=> 'none')),
	'Logo vertical align'=> array(' #header #logo a', 'vertical-align',array ('Top'=> 'top','Bottom'=>'bottom', 'Middle'=> 'middle')),
	'Menu',
	'Border top menu' => array('#menu', 'border-top', array('Strong' => '3px solid  ', 'Medium' => '2px solid ', 'Light' => '1px solid ', 'Hide' => 'none')),
	'Border bottom menu' => array('#menu', 'border-bottom', array('Strong' => '3px solid  ', 'Medium' => '2px solid ', 'Light' => '1px solid ', 'Hide' => 'none')),
	'Menu padding' => array('#menu > div > ul > li > a', 'padding', array('Tiny' => '10px 5px', 'Small' => '10px 15px', 'Medium' => '10px 25px','Large'=>'10px 35px')),
	'Homepage',
	'Show page margin' => array('#container', 'margin', array('Large' => '30px auto', 'Medium' => '20px auto', 'Small' => '10px auto', 'Hide' => '0px auto')),
	'Show slideshow'=> array('.slideshow' , 'display' ,array('Show'=> 'block', 'Hide'=> 'none')),
    'Show image description'=> array(' div.image > span.description ' , 'display' ,array('Show'=> 'block', 'Hide'=> 'none')),
	'Show add to cart'=> array (' .product-grid .cart input.button, .box-product .cart input.button','display', array ('Show'=>'block', 'Hide'=> 'none')),
	'Show container shadow' => array('#container', 'box-shadow', array('Show' => '0 0 8px -7px #000000, 0 0 50px -10px #FFFFFF',  'Hide' => 'none')),
	'Show brands carousel'=> array('#carousel0' ,'display' ,array('Show'=> 'block', 'Hide'=> 'none')), 
	'Show social band'=> array('#social_band' ,'display' ,array('Show'=> 'block', 'Hide'=> 'none')),
	'Product page',
	'Description border top'=>array ('.product-info .description' , 'border-top', array( 'Show'=> '1px solid ', 'Hide' => 'none')),
	'Show share'=> array ('.share','display',array ('Show'=> 'block', 'Hide'=> 'none')),
	'Show review'=> array (' .review','display',array('Show'=> 'block', 'Hide'=>'none')),
	'Show wishlist, compare'=> array ('.product-info .product_wish_compare','display',array('Show'=> 'block', 'Hide'=>'none')),
	'Description height'=> array ('#tab-description','height',array('Auto (no scroll)'=> 'auto', 'Small'=>'125px', 'Medium'=>'200px', 'Large'=>'300px', 'Larger'=>'500px')),
	'Category page',
	'Show category info' => array('.category-info', 'display', array('Show' => 'block',  'Hide' => 'none')),
	'Show product wishlist'=>array('.product-list .wishlist a','display',array('Show'=> 'block', 'Hide'=>'none')),
    'Show product compare'=>array('.product-list .compare a','display',array('Show'=> 'block', 'Hide'=>'none')),
	'Footer',
	'Border' => array('#footer', 'border-top', array('Strong' => '3px solid', 'Medium' => '2px solid', 'Light' => '1px solid', 'Hide' => 'none')),
	'Show powered by' => array('#powered > span', 'display', array('Show' => 'block',  'Hide' => 'none')),
	'Show payment icons'=> array('.payment-icons', 'display', array('Show'=> 'block', 'Hide'=> 'none')),
	'Show phone icon'=> array('.column #phone','display', array('Show' => 'block', 'Hide'=> 'none')),
	'Show twitter icon'=> array('.column #twitter','display', array('Show' => 'block', 'Hide'=> 'none')),
	'Show facebook icon'=> array('.column #facebook','display', array('Show' => 'block', 'Hide'=> 'none')),
	'Show google icon'=> array('.column #google','display', array('Show' => 'block', 'Hide'=> 'none')),
	'Show rss icon'=> array('.column #rss','display', array('Show' => 'block', 'Hide'=> 'none')),
    
);


$nico_settings = 
array(
	'Footer',
	'Follow us'=> array('#follow_us', 'follow_us', 'text'), 
	'Phone number'=> array('#phone', 'phone_number', 'text'), 
	'Twitter url'=> array('#twitter', 'twitter', 'href'),
	'Facebook url'=> array('#facebook', 'facebook', 'href'),
	'Google url'=> array('#google', 'google_number', 'href'),
	'Rss url'=> array('#rss', 'rss', 'href'),
	'First visit message (useful for European Union cookie law)',
	'Message'=> array('#first_visit_message', 'first_visit_message', 'textarea'),
	'Social band',
	'Twitter profile'=> array('#twitter_profile_id ', 'twitter_profile_id', 'text'),
	'Facebook profile id'=> array('#fb_profile_id', 'fb_profile_id', 'text'),
	'About us'=> array('#social_about > div', 'about_text', 'textarea'),
	'Newsletter'=> array('#social_about > div', 'newsletter_text', 'textarea'),
	'Product page',
	'Show related products'=> array('#product_page_related_products', 'product_page_related', 'select', array('Under product details' => 'under', 'As a tab' => 'tab', 'Under photo gallery' => 'gallery')),
	'Misc',
	'Disable responsive resize'=> array('#responsive_css', 'responsive_css', 'checkbox'),
	'Sale text'=> array('.product_sale', 'sale_text', 'text'),
);


$nico_sliders = 
array(
	'Homepage' => array( 
		'Flexslider'=> 
			array(
			'Animation type' => array('name' => 'animation', 'type' => 'select', 'options' => array('slide', 'fade'), 
								'default' => 'slide'), 
			'Easing animation' => array('name' => 'easing', 'type' => 'select', 
								'options' => array('jswing','def','easeInQuad','easeOutQuad','easeInOutQuad','easeInCubic','easeOutCubic','easeInOutCubic','easeInQuart','easeOutQuart','easeInOutQuart','easeInQuint','easeOutQuint','easeInOutQuint','easeInSine','easeOutSine','easeInOutSine','easeInExpo','easeOutExpo','easeInOutExpo','easeInCirc','easeOutCirc','easeInOutCirc','easeInElastic','easeOutElastic','easeInOutElastic','easeInBack','easeOutBack','easeInOutBack','easeInBounce','easeOutBounce','easeInOutBounce','jswing','def','easeInQuad','easeOutQuad','easeInOutQuad','easeInCubic','easeOutCubic','easeInOutCubic','easeInQuart','easeOutQuart','easeInOutQuart','easeInQuint','easeOutQuint','easeInOutQuint','easeInSine','easeOutSine','easeInOutSine','easeInExpo','easeOutExpo','easeInOutExpo','easeInCirc','easeOutCirc','easeInOutCirc','easeInElastic','easeOutElastic','easeInOutElastic','easeInBack','easeOutBack','easeInOutBack','easeInBounce','easeOutBounce','easeInOutBounce'), 
								'default' => ''), 
			'Direction' => array('name' => 'direction', 'type' => 'select', 'options' => array('horizontal', 'vertical'), 
								'default' => 'horizontal'),											
			'Start at' => array('name' => 'startAt',  'type' => 'text', 'default' => '0'),
			'Initial delay (miliseconds)' => array('name' => 'initDelay',  'type' => 'text', 'default' => '0'),
			'Slideshow speed' => array('name' => 'slideshowSpeed', 'type' => 'text', 'default' => '7000'), 
			'Animation speed' => array('name' => 'animationSpeed', 'type' => 'text', 'default' => '600'), 
			'Previous text' => array('name' => 'prevText', 'type' => 'text', 'default' => 'Previous'), 
			'Next text' => array('name' => 'nextText', 'type' => 'text', 'default' => 'Next'), 
			'Pause text' => array('name' => 'pauseText', 'type' => 'text', 'default' => 'Pause'), 
			'Play text' => array('name' => 'playText', 'type' => 'text', 'default' => 'Play'), 

			'Show pause/play' => array('name' => 'pausePlay', 'type' => 'bool', 'default' => 'false'), 
			'Show navigation control' => array('name' => 'controlNav', 'type' => 'bool', 'default' => 'true'), 
			'Slideshow' => array('name' => 'slideshow', 'type' => 'bool', 'default' => 'true'), 
			'Animation loop' => array('name' => 'animationLoop', 'type' => 'bool', 'default' => 'true'), 
			'Randomize' => array('name' => 'randomize', 'type' => 'bool', 'default' => 'false'), 
			'Smooth height' => array('name' => 'smoothHeight', 'type' => 'bool', 'default' => 'true', 
										'Description' => 'Allow height of the slider to animate smoothly in horizontal mode'),
			'Use CSS3 transitions if available' => array('name' => 'useCSS',  'type' => 'bool', 'default' => 'true'), 
			'Pause on hover' => array('name' => 'pauseOnHover',  'type' => 'bool', 'default' => 'true'),
			'Pause on action' => array('name' => 'pauseOnAction',  'type' => 'bool', 'default' => 'true'),
			'Touch support' => array('name' => 'touch',  'type' => 'bool', 'default' => 'true'), 
			'Video support' => array('name' => 'video',  'type' => 'bool', 'default' => 'false'), 
			'Mousewheel support' => array('name' => 'mousewheel',  'type' => 'bool', 'default' => 'false'), 
			'Keyboard support' => array('name' => 'keyboard',  'type' => 'bool', 'default' => 'false'), 
			),
			
		'Nivo slider'=> array(
			'Effect' => array('name' => 'effect', 'type' => 'select', 
							  'options' => array('Random', 'sliceDownRight','sliceDownLeft','sliceUpRight','sliceUpLeft','sliceUpDown','sliceUpDownLeft','fold','fade',
							  'boxRandom','boxRain','boxRainReverse','boxRainGrow','boxRainGrowReverse'),
							  'default' => 'random'), 
			'Slices'=> array('name' => 'slices', 'type' => 'text', 'default' => '15'), 
			'Box columns'=> array('name' => 'boxCols', 'type' => 'text', 'default' => '8'), 
			'Box rows'=> array('name' => 'boxRows', 'type' => 'text', 'default' => '4'), 
			'Animation speed' => array('name' => 'animSpeed', 'type' => 'text', 'default' => '500'), 
			'Pause time'=> array('name' => 'pauseTime', 'type' => 'text', 'default' => '3000'), 
			'Start slide number'=> array('name' => 'startSlide', 'type' => 'text', 'default' => '0'), 
			'Prev text' => array('name' => 'prevText', 'type' => 'text', 'default' => 'Prev'),	
			'Next text' => array('name' => 'nextText', 'type' => 'text', 'default' => 'Next'),	

			'Next & Prev navigation' => array('name' => 'directionNav', 'type' => 'bool', 'default' => 'true'),
			'Show pagination control' => array('name' => 'controlNav', 'type' => 'bool', 'default' => 'true'),
			'Use thumbnails for navigation'  => array('name' => 'controlNavThumbs', 'type' => 'bool', 'default' => 'false'),
			'Stop animation while hovering' => array('name' => 'pauseOnHover', 'type' => 'bool', 'default' => 'true'),
			'Force manual transitions'  => array('name' => 'manualAdvance', 'type' => 'bool', 'default' => 'false'),
			'Start on a random slide'  => array('name' => 'randomStart', 'type' => 'bool', 'default' => 'true'),
        ),
        
   		'Elastic slider'=> array(
   		
			'Animation' => array('name' => 'animation', 'type' => 'select', 
								  'options' => array('sides', 'center'), 'default' => 'sides'),
			'Autoplay' => array('name' => 'autoplay', 'type' => 'bool', 'default' => 'true'),								  
			'Slideshow interval' => array('name' => 'slideshow_interval', 'type' => 'text', 'default' => '3000'), 
			'Speed' => array('name' => 'speed', 'type' => 'text', 'default' => '800'), 
		    'Easing animation' => array('name' => 'easing', 'type' => 'select', 
								'options' => array('jswing','def','easeInQuad','easeOutQuad','easeInOutQuad','easeInCubic','easeOutCubic','easeInOutCubic','easeInQuart','easeOutQuart','easeInOutQuart','easeInQuint','easeOutQuint','easeInOutQuint','easeInSine','easeOutSine','easeInOutSine','easeInExpo','easeOutExpo','easeInOutExpo','easeInCirc','easeOutCirc','easeInOutCirc','easeInElastic','easeOutElastic','easeInOutElastic','easeInBack','easeOutBack','easeInOutBack','easeInBounce','easeOutBounce','easeInOutBounce','jswing','def','easeInQuad','easeOutQuad','easeInOutQuad','easeInCubic','easeOutCubic','easeInOutCubic','easeInQuart','easeOutQuart','easeInOutQuart','easeInQuint','easeOutQuint','easeInOutQuint','easeInSine','easeOutSine','easeInOutSine','easeInExpo','easeOutExpo','easeInOutExpo','easeInCirc','easeOutCirc','easeInOutCirc','easeInElastic','easeOutElastic','easeInOutElastic','easeInBack','easeOutBack','easeInOutBack','easeInBounce','easeOutBounce','easeInOutBounce'), 
								'default' => ''), 
			'Title factor' => array('name' => 'titleFactor', 'type' => 'text', 'default' => '0.60'), 
			'Title speed' => array('name' => 'titlespeed', 'type' => 'text', 'default' => '800'), 
		    'Title easing animation' => array('name' => 'titleeasing', 'type' => 'select', 
								'options' => array('jswing','def','easeInQuad','easeOutQuad','easeInOutQuad','easeInCubic','easeOutCubic','easeInOutCubic','easeInQuart','easeOutQuart','easeInOutQuart','easeInQuint','easeOutQuint','easeInOutQuint','easeInSine','easeOutSine','easeInOutSine','easeInExpo','easeOutExpo','easeInOutExpo','easeInCirc','easeOutCirc','easeInOutCirc','easeInElastic','easeOutElastic','easeInOutElastic','easeInBack','easeOutBack','easeInOutBack','easeInBounce','easeOutBounce','easeInOutBounce','jswing','def','easeInQuad','easeOutQuad','easeInOutQuad','easeInCubic','easeOutCubic','easeInOutCubic','easeInQuart','easeOutQuart','easeInOutQuart','easeInQuint','easeOutQuint','easeInOutQuint','easeInSine','easeOutSine','easeInOutSine','easeInExpo','easeOutExpo','easeInOutExpo','easeInCirc','easeOutCirc','easeInOutCirc','easeInElastic','easeOutElastic','easeInOutElastic','easeInBack','easeOutBack','easeInOutBack','easeInBounce','easeOutBounce','easeInOutBounce'), 
								'default' => ''), 
			'Thumb max width' => array('name' => 'thumbMaxWidth', 'type' => 'text', 'default' => '150')), 
   		'Camera slider'=> array(
			'Alignment' => array('name' => 'alignment', 'type' => 'select', 
								  'options' => array('topLeft', 'topCenter', 'topRight', 'centerLeft', 'center', 'centerRight', 'bottomLeft', 'bottomCenter', 'bottomRight'), 'default' => 'center'),
			'Auto advance' => array('name' => 'autoAdvance', 'type' => 'bool', 'default' => 'true'),								  
			'Mobile auto advance' => array('name' => 'mobileAutoAdvance', 'type' => 'bool', 'default' => 'true'),								  
			'Bar direction' => array('name' => 'barDirection', 'type' => 'select', 
								  'options' => array('leftToRight', 'rightToLeft', 'topToBottom', 'bottomToTop'), 'default' => 'leftToRight'),
			'Bar position' => array('name' => 'barPosition', 'type' => 'select', 
								  'options' => array('bottom', 'left', 'top', 'right'), 'default' => 'bottom'),
			'Columns' => array('name' => 'cols', 'type' => 'text', 'default' => '6'), 								
		    'Easing animation' => array('name' => 'easing', 'type' => 'select', 
								'options' => array('jswing','def','easeInQuad','easeOutQuad','easeInOutQuad','easeInCubic','easeOutCubic','easeInOutCubic','easeInQuart','easeOutQuart','easeInOutQuart','easeInQuint','easeOutQuint','easeInOutQuint','easeInSine','easeOutSine','easeInOutSine','easeInExpo','easeOutExpo','easeInOutExpo','easeInCirc','easeOutCirc','easeInOutCirc','easeInElastic','easeOutElastic','easeInOutElastic','easeInBack','easeOutBack','easeInOutBack','easeInBounce','easeOutBounce','easeInOutBounce','jswing','def','easeInQuad','easeOutQuad','easeInOutQuad','easeInCubic','easeOutCubic','easeInOutCubic','easeInQuart','easeOutQuart','easeInOutQuart','easeInQuint','easeOutQuint','easeInOutQuint','easeInSine','easeOutSine','easeInOutSine','easeInExpo','easeOutExpo','easeInOutExpo','easeInCirc','easeOutCirc','easeInOutCirc','easeInElastic','easeOutElastic','easeInOutElastic','easeInBack','easeOutBack','easeInOutBack','easeInBounce','easeOutBounce','easeInOutBounce'), 
								'default' => 'easeInOutExpo'), 
		    'Mobile easing animation' => array('name' => 'mobileEasing', 'type' => 'select', 
								'options' => array('jswing','def','easeInQuad','easeOutQuad','easeInOutQuad','easeInCubic','easeOutCubic','easeInOutCubic','easeInQuart','easeOutQuart','easeInOutQuart','easeInQuint','easeOutQuint','easeInOutQuint','easeInSine','easeOutSine','easeInOutSine','easeInExpo','easeOutExpo','easeInOutExpo','easeInCirc','easeOutCirc','easeInOutCirc','easeInElastic','easeOutElastic','easeInOutElastic','easeInBack','easeOutBack','easeInOutBack','easeInBounce','easeOutBounce','easeInOutBounce','jswing','def','easeInQuad','easeOutQuad','easeInOutQuad','easeInCubic','easeOutCubic','easeInOutCubic','easeInQuart','easeOutQuart','easeInOutQuart','easeInQuint','easeOutQuint','easeInOutQuint','easeInSine','easeOutSine','easeInOutSine','easeInExpo','easeOutExpo','easeInOutExpo','easeInCirc','easeOutCirc','easeInOutCirc','easeInElastic','easeOutElastic','easeInOutElastic','easeInBack','easeOutBack','easeInOutBack','easeInBounce','easeOutBounce','easeInOutBounce'), 
								'default' => 'easeInOutExpo'), 
			'Animation type' => array('name' => 'animation', 'type' => 'select', 'options' => array('random','simpleFade', 'curtainTopLeft', 'curtainTopRight', 'curtainBottomLeft', 'curtainBottomRight', 'curtainSliceLeft', 'curtainSliceRight', 'blindCurtainTopLeft', 'blindCurtainTopRight', 'blindCurtainBottomLeft', 'blindCurtainBottomRight', 'blindCurtainSliceBottom', 'blindCurtainSliceTop', 'stampede', 'mosaic', 'mosaicReverse', 'mosaicRandom', 'mosaicSpiral', 'mosaicSpiralReverse', 'topLeftBottomRight', 'bottomRightTopLeft', 'bottomLeftTopRight', 'bottomLeftTopRight'), 
								'default' => 'random'), 
			'Mobile animation type' => array('name' => 'animation', 'type' => 'select', 'options' => array('random','simpleFade', 'curtainTopLeft', 'curtainTopRight', 'curtainBottomLeft', 'curtainBottomRight', 'curtainSliceLeft', 'curtainSliceRight', 'blindCurtainTopLeft', 'blindCurtainTopRight', 'blindCurtainBottomLeft', 'blindCurtainBottomRight', 'blindCurtainSliceBottom', 'blindCurtainSliceTop', 'stampede', 'mosaic', 'mosaicReverse', 'mosaicRandom', 'mosaicSpiral', 'mosaicSpiralReverse', 'topLeftBottomRight', 'bottomRightTopLeft', 'bottomLeftTopRight', 'bottomLeftTopRight'), 
								'default' => 'random'), 
			'Grid difference' => array('name' => 'gridDifference', 'type' => 'text', 'default' => '250'), 								
			'Height' => array('name' => 'height', 'type' => 'text', 'default' => '50%'), 		
			'Pause on hover' => array('name' => 'hover', 'type' => 'bool', 'default' => 'true'),								  						
			'Loader' => array('name' => 'loader', 'type' => 'select', 
								  'options' => array('pie', 'bar', 'none'), 'default' => 'pie'),
			'Loader color' => array('name' => 'loaderColor', 'type' => 'color', 'default' => '#eeeeee'),									  
			'Loader background color' => array('name' => 'loaderBgColor', 'type' => 'color', 'default' => '#222222'),									  
			'Loader opacity' => array('name' => 'loaderOpacity', 'type' => 'text', 'default' => '0.8'), 		
			'Loader padding' => array('name' => 'loaderPadding', 'type' => 'text', 'default' => '2'), 		
			'Loader stroke' => array('name' => 'loaderStroke', 'type' => 'text', 'default' => '7'), 		
			'Min height' => array('name' => 'minHeight', 'type' => 'text', 'default' => '200px'), 		
			'Navigation' => array('name' => 'navigation', 'type' => 'bool', 'default' => 'true'),								  
			'Navigation hover' => array('name' => 'navigationHover', 'type' => 'bool', 'default' => 'true'),								  
			'Mobile navigation hover' => array('name' => 'mobileNavHover', 'type' => 'bool', 'default' => 'true'),								  
			'Opacity on grid' => array('name' => 'opacityOnGrid', 'type' => 'bool', 'default' => 'false'),								  
			'Overlayer' => array('name' => 'overlayer', 'type' => 'bool', 'default' => 'true'),								  
			'Pagination' => array('name' => 'pagination', 'type' => 'bool', 'default' => 'true'),								  
			'Pause on click' => array('name' => 'pauseOnClick', 'type' => 'bool', 'default' => 'true'),								  
			'Play pause' => array('name' => 'playPause', 'type' => 'bool', 'default' => 'true'),								  
			'Pie diameter' => array('name' => 'pieDiameter', 'type' => 'text', 'default' => '38'), 		
			'Pie position' => array('name' => 'piePosition', 'type' => 'select', 
								  'options' => array('rightTop', 'leftTop', 'leftBottom', 'rightBottom'), 'default' => 'rightTop'),
			'Portrait' => array('name' => 'portrait', 'type' => 'bool', 'default' => 'false'),								  
			'Rows' => array('name' => 'rows', 'type' => 'text', 'default' => '4'),
			'Sliced cols' => array('name' => 'slicedCols', 'type' => 'text', 'default' => '12'),
			'Sliced rows' => array('name' => 'slicedRows', 'type' => 'text', 'default' => '8'),
			'Slide on' => array('name' => 'slideOn', 'type' => 'select', 
								  'options' => array('next', 'prev', 'random'), 'default' => 'random'),
			'Thumbnails' => array('name' => 'thumbnails', 'type' => 'bool', 'default' => 'false'),		
			'Time' => array('name' => 'time', 'type' => 'text', 'default' => '7000'),						  
			'Trans period' => array('name' => 'transPeriod', 'type' => 'text', 'default' => '1500')
		)
	), 
	'Product page' => array(
		'Cloud zoom'=> array(
			'Width of the zoom window' => array('name' => 'zoomWidth', 'type' => 'text', 'default' => 'auto'),	
			'Height of the zoom window' => array('name' => 'zoomHeight', 'type' => 'text', 'default' => 'auto'),	
			'Position' => array('name' => 'position', 'type' => 'select', 
								  'options' => array('left', 'right', 'top', 'bottom', 'inside'),
								  'default' => 'right'), 		
			'X position' => array('name' => 'adjustX', 'type' => 'text', 'default' => '0'),	
			'Y position' => array('name' => 'adjustY', 'type' => 'text', 'default' => '0'),	
			'Tint color' => array('name' => 'adjustY', 'type' => 'color', 'default' => ''),	
			'Tint opacity' => array('name' => 'tintOpacity', 'type' => 'text', 'default' => '0.5'),	
			'Lens opacity' => array('name' => 'lensOpacity', 'type' => 'text', 'default' => '0.5'),	
			'Soft focus' => array('name' => 'lensOpacity', 'type' => 'bool', 'default' => 'false'),	
			'Smooth move' => array('name' => 'smoothMove', 'type' => 'text', 'default' => '3'),	
			'Show title' => array('name' => 'showTitle', 'type' => 'bool', 'default' => 'true'),	
			'Soft focus' => array('name' => 'titleOpacity', 'type' => 'text', 'default' => '0.5'),	
			),
	),
);

$nico_sliders['Product page']['Flexslider'] = $nico_sliders['Homepage']['Flexslider'];
