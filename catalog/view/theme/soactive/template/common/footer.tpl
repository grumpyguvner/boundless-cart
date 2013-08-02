<div id="footer">
            <div class="column">
                <h4><?php echo $text_categories; ?></h4>
                <div id="left">
                    <ul>
                        <?php foreach ($categories[0]['children'] as $category) { ?>
                            <?php if ($category['name'] != 'Activity') { ?>
                                <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                            <?php } ?>
                        <?php } ?>
                    </ul>
                </div>
                <div id="right">
                    <ul>
                        <?php foreach ($categories[1]['children'] as $category) { ?>
                            <?php if ($category['name'] != 'Activity') { ?>
                                <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                            <?php } ?>
                        <?php } ?>
                    </ul>
                </div>
            </div>
            
                        
            <div class="column">
                <div>
                        <?php 
                        $displayTitle = true;
                        foreach ($informations as $key => $information) {
                            if (strtolower($text_customerservice) == strtolower($information['category'])) {
                                if ($displayTitle) {
                                    echo '<h4>' . strtoupper($information['category']) . '</h4><ul>';
                                    echo '<li><a href="' . $contact . '">' . $text_contact . '</a></li>';
                                    $displayTitle = false;
                                }
                                echo '<li><a href="' . $information['href'] . '">' . $information['title'] . '</a></li>';
                            }
                        }
                        echo '</ul></ul>';
                        ?>
                    </div>
                <div>
                        
                        <?php
                        $displayTitle = true;
                        foreach ($informations as $key => $information) {
                            if (strtolower($text_information) == strtolower($information['category'])) {
                                if ($displayTitle) {
                                echo '<h4>' . strtoupper($information['category']) . '</h4><ul>';
                                $displayTitle = false;
                                }
                                echo '<li><a href="' . $information['href'] . '">' . $information['title'] . '</a></li>';
                            }
                        }
                        echo '</ul>';
                        ?>
                        
                        </ul>
                    </div>
            </div>
    
            <div class="column" id="lastColumn">
                <div>
                    <h4><?php echo strtoupper($text_newsletter); ?></h4>
                        <ul>
                            <li style="font-weight: normal"><?php echo $text_description_newsletter ?></li>
                            <br />
                            <li>
                                <form action="/index.php" method="get" class="newsletter-form" target="_blank">
                                    <input type="hidden" name="route" value="module/newsletter/callback">
                                    <input type="hidden" name="subscribe" value="1">
                                    <div class="newsletter_input">
                                        <input type="email" name="email" placeholder="Email Address"><a class="submit" href="#"><img src="catalog/view/theme/soactive/image/submit_newsletter.png" alt="Go Button" /></a>
                                    </div>
                                </form>
                            </li>
                        </ul>
                    </div>
                <!----------------------------- It has to be a cms block ------------------------------------>
                    <div class="followUs">
                        <h4>FOLLOW SOACTIVE</h4>
                        <p>If you like to stay social, then make sure you follow soactive. Facebook, Twitter, Pinterest & Instagram will always be up to date with offers & news</p>
                        <div class="social">
                            <span><a target="_blank" href="https://www.facebook.com/sheactivefans"><img alt="facebook" src="catalog/view/theme/soactive/image/facebook.png"></a></span><span><a target="_blank" href="https://twitter.com/sheactive"><img alt="twitter" src="catalog/view/theme/soactive/image/twitter.png"></a></span><span><a target="_blank" href="https://pinterest.com/source/sheactive.co.uk/‎"><img alt="Pinterest" src="catalog/view/theme/soactive/image/p.png"></a></span><span><a target="_blank" href=""><img alt="Instagram" src="catalog/view/theme/soactive/image/instagram_icon.png"></a></span>
                        </div>
                    </div>
                <!---------------------------------- End cms block ------------------------------------------>
            </div> 
            <div class="underFooter">
                <div class="weAreSoactive">
                    <h4>WE ARE SOACTIVE</h4>
                    <div class="wsRow">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea</div>
                    <div class="wsRow">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea</div>
                </div>
                <div class="securePayment">
                    <h4>SECURE PAYMENT</h4>
                    <p>We accept paypal and most major credit cards. All payments are processed securely for your peace of mind.</p>
                    <img src="catalog/view/theme/soactive/image/footer/credit-cards.png" alt="Credit Cards" />
                </div>
            </div> 
        </div>
</div>
</div>
<?php echo $welcome_popup; ?>
</body></html>