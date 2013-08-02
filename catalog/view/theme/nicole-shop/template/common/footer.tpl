<?php 
if (isset($_SERVER['SCRIPT_FILENAME']))
{
	$_theme_include_path = dirname($_SERVER['SCRIPT_FILENAME']) . '/catalog/view/theme/nicole-shop/';
} else if (isset($_SERVER['DOCUMENT_ROOT']))
{
	$_theme_include_path = $_SERVER['DOCUMENT_ROOT'] . '/catalog/view/theme/nicole-shop/';
}
else $_theme_include_path = dirname(__FILE__) . '/../../';

include($_theme_include_path . 'nico_theme_editor/settings.inc');


if (isset($_nico_settings['settings']['first_visit_message']) && !empty($_nico_settings['settings']['first_visit_message'])) { ?>
<div id="first_visit_message"><?php echo html_entity_decode($_nico_settings['settings']['first_visit_message']);?><a id="first_message_close" href="#close">Close</a></div>
<?php } ?>	
<?php if (!isset($_nico_settings['settings']['responsive_css']) || $_nico_settings['settings']['responsive_css'] != 'true') { ?>
<link rel="stylesheet" id="responsive_css" type="text/css" href="catalog/view/theme/nicole-shop/stylesheet/responsive.css" />
<?php } ?>
<div id="social_band">
	<div id="social_about">
		<h3>Newsletter</h3>
		<div>
			<p><?php if (isset($_nico_settings['settings']['newsletter_text']) && !empty($_nico_settings['settings']['newsletter_text'])) echo $_nico_settings['settings']['newsletter_text']; else echo 'You can change this text from the panel settings. Theme settings > Newsletter text<br/><br/>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';?></p>
            <div id="newsletter_wrapper">
                <form action="/index.php" method="get" id="newsletter_form" class="newsletter-form" target="_blank">
                    <input type="hidden" name="route" value="module/newsletter/callback">
                    <input type="hidden" name="subscribe" value="1">
                	<div class="newsletter_input">
                    <input type="email" id="newsletter_email" name="email" placeholder="Email newsletter signup"><a class="action" href="#">GO</a>
                	</div>
                </form>
            </div>
		</div>
		<h3>About</h3>
		<div>
			<?php if (isset($_nico_settings['settings']['about_text']) && !empty($_nico_settings['settings']['about_text'])) echo $_nico_settings['settings']['about_text']; else echo 'You can change this text from the panel settings. Theme settings > About text<br/><br/>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';?>
		</div>
	</div>
	<div id="social_twitter">
		<h3>twitter</h3>
		<div>
			<ul id="twitter_update_list"><li>Twitter feed loading</li></ul>			
			<script type="text/javascript" src="http://twitter.com/javascripts/blogger.js"></script>
			<script type="text/javascript" src="http://api.twitter.com/1/statuses/user_timeline/<?php if (isset($_nico_settings['settings']['twitter_profile_id']) && !empty($_nico_settings['settings']['twitter_profile_id'])) echo $_nico_settings['settings']['twitter_profile_id']; else echo 'NicoleThemes';?>.json?callback=twitterCallback2&amp;count=<?php if (isset($_nico_settings['settings']['twitter_count']) && !empty($_nico_settings['settings']['twitter_count'])) echo $_nico_settings['settings']['twitter_count']; else echo '3';?>"></script>			
			<a href="http://twitter.com/#!/<?php if (isset($_nico_settings['settings']['twitter_profile_id']) && !empty($_nico_settings['settings']['twitter_profile_id'])) echo $_nico_settings['settings']['twitter_profile_id']; else echo 'NicoleThemes';?>" id="twitter_follow">Follow us on twitter</a>
		</div>
	</div>
	<div id="social_facebook">
		<h3>facebook</h3>
		<div>
		<script type="text/javascript" src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php/en_US"></script>
		<script type="text/javascript">if(typeof(FB) !== 'undefined' && FB != null) FB.init("1690883eb733618b294e98cb1dfba95a");</script>
		<fb:fan 
			profile_id="<?php if (isset($_nico_settings['settings']['fb_profile_id']) && !empty($_nico_settings['settings']['fb_profile_id'])) echo $_nico_settings['settings']['fb_profile_id']; else echo '201498429982413';?>" 
			stream="0" 
			connections="6" 
			logobar="0" 
			width="300"
			height="220"
			css="http://nicole-shop.nicolette.ro/catalog/view/theme/nicole-shop/stylesheet/facebook.css">
		</fb:fan>
		</div>
	</div>
</div>




<div id="footer">
 <?php if ($informations) { ?>
  <div class="column first">
    <h3><?php echo $text_information; ?></h3>
    <ul>
      <?php foreach ($informations as $information) { ?>
      <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
      <?php } ?>
    </ul>
  </div>
  <?php } ?>
  <div class="column">
    <h3 id="follow_us"><?php if (isset($_nico_settings['settings']['follow_us'])) echo $_nico_settings['settings']['follow_us']; 
    else echo 'Follow us';?></h3> 
    <ul>
      <li><a href="#phone" id="phone"><span><img src="catalog/view/theme/nicole-shop/image/phone.png" alt="Phone"/></span>
		<?php if (isset($_nico_settings['settings']['phone_number'])) echo $_nico_settings['settings']['phone_number'];?></a>
	  </li>
      <li><a href="<?php if (isset($_nico_settings['settings']['twitter'])) 
		echo $_nico_settings['settings']['twitter'];?>" id="twitter">
      <span><img src="catalog/view/theme/nicole-shop/image/twitter.png" alt="Twitter"/></span>Twitter</a></li>
      <li><a href="<?php if (isset($_nico_settings['settings']['facebook'])) 
		echo $_nico_settings['settings']['facebook'];?>" id="facebook">
      <span><img src="catalog/view/theme/nicole-shop/image/facebook.png" alt="Facebook"/></span>Facebook</a></li>
      <li><a href="<?php if (isset($_nico_settings['settings']['google']))
		echo $_nico_settings['settings']['google'];?>" id="google">
      <span><img src="catalog/view/theme/nicole-shop/image/google.png" alt="Google"/></span>Google</a></li>
      <li><a href="<?php if (isset($_nico_settings['settings']['rss'])) 
		echo $_nico_settings['settings']['rss'];?>" id="rss">
      <span><img src="catalog/view/theme/nicole-shop/image/rss.png" alt="Rss"/></span>Rss</a></li>
    </ul>
  </div>
  <div class="column">
    <h3><?php echo $text_extra; ?></h3>
    <ul>
      <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
      <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
      <?php if ($allow_affiliate) { ?><li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li><?php } ?>
      <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
    </ul>
  </div>
  <div class="column">
    <h3><?php echo $text_service; ?></h3>
    <ul>
      <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
      <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
      <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
    </ul>
  </div>
  <div class="column last">
    <h3><?php echo $text_account; ?></h3>
    <ul>
      <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
      <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
      <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
      <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
    </ul>
  </div>
  
	<div id="powered" class="clearfix">
		<span>
			<?php echo $powered; ?>
		</span>

		<ul class="payment-icons">
			<li><img src="catalog/view/theme/nicole-shop/image/visa.png" alt="Visa"/></li>
			<li><img src="catalog/view/theme/nicole-shop/image/paypal.png" alt="Paypal"/></li>
			<li><img src="catalog/view/theme/nicole-shop/image/cirrus.png" alt="Cirrus"/></li>
			<li><img src="catalog/view/theme/nicole-shop/image/mastercard.png" alt="Mastercard"/></li>
			<li><img src="catalog/view/theme/nicole-shop/image/american_express.png" alt="American Express"/></li>
		</ul>
	</div>  
</div>
<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->

<div id="scroll_top"><a href="/"></a></div>

<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->
</div>
<?php echo $welcome_popup; ?>
</body></html>
