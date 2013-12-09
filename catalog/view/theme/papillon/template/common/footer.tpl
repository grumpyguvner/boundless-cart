 <div id="footer_wrapper">
 <div id="footer">
  <div id="container4">
   <div id="container3">
    <div id="container2">
     <div id="container1">
        <div id="col1">
            <h3>About Us</h3>
            <p>Papillon was founded the beginning of 2009 with the simple intention of nurturing 'harmonious living'. Our passion is to lovingly present an inspiring and carefully curated selection of interesting products for the home combined with a range of eclectic gift items, all sourced from around the world. When creating such a diverse range of products our criteria is to provide quality and great design combined with the unusual, whilst ensuring excellent value for money. Above all we hope to imbue a feeling of true service and a wonderful shopping experience.</p>
        </div>
        <div id="col2">
            <h3>Stay On Trend</h3>
            <p>At Papillon we like to keep you up to date with the latest and most exciting collections we select, be the first to know by signing up to our newsletter.</p>
            <div id="footer_newsletter_wrapper">
                <form action="/" method="post" id="footer_newsletter" name="footer_newsletter">
                    <input type="text" id="newsletter_email" name="newsletter_email" placeholder="Your Email...">
                    <a onclick="$('div#footer_newsletter_message').load('index.php?route=module/newsletter/callback&amp;subscribe=1&amp;email=' + escape($('input[name=\'newsletter_email\']').val()), function() { $('div#newsletter_message').hide(); $('div#newsletter_message').show('slow'); });">Subscribe</a>
                </form>
            </div>
            <div id="footer_newsletter_message"></div>
            <h3>Social Butterfly</h3>
            <p>Like us on facebook and follow us on twitter for finger on the pulse news.</p>
            <a href="http://www.facebook.com/PapillonRetailUK" style="text-decoration: none;">
                <div id="facebook"><span class="facebook">Like us on facebook</span></div>
            </a>
            <a href="http://www.twitter.com/PapillonRetail" style="text-decoration: none;">
                <div id="twitter"><span class="twitter">Follow us on twitter</span></div>
            </a>
        </div>
        <div id="col3">
            <h3>Contact Us</h3>
            <p>Email:<br/>hello@thepapillonshop.com</p>
            <p>Phone:<br/>01273 720 333</p>
            <p>Mail:<br/>Papillon<br/>8 Union Street<br/>Brighton<br/>East Sussex<br/>BN1 1HA</p>
        </div>
         <div id="col4" class="links">
            <h3>Further Information</h3>
            <ul>
            <?php foreach ($informations as $information) { ?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
            <?php } ?>
<!--            <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
            <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
            <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
            <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
            <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
            <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
            <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li> -->
            </ul>
        </div>
     </div>
    </div>
   </div>
    <div id="payment_methods">
        <span class="payment_methods">We accept the following methods of payment.</span>
    </div>
  </div>
 </div>
 
 </div>
 <div id="powered"><?php echo $powered; ?></div>
 </div>
</div>
<?php echo $welcome_popup; ?>
</body></html>