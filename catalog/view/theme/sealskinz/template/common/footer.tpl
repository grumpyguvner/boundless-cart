<div class="footer-wrap">
    <div class="container">
        <div id="footer">
            <div class="column" id="margin-r46">
                <h4><?php echo $text_categories; ?></h4>
                <div id="left">
                    <ul>
                        <?php foreach ($categories[0]['children'] as $category) { ?>
                            <?php if ($category['name'] != 'Shop By Activity') { ?>
                                <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                            <?php } ?>
                        <?php } ?>
                    </ul>
                </div>
                <div id="right">
                    <ul>
                        <?php foreach ($categories[1]['children'] as $category) { ?>
                            <?php if ($category['name'] != 'Shop By Activity') { ?>
                                <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                            <?php } ?>
                        <?php } ?>
                    </ul>
                </div>
            </div>

            <div class="column" id="column2">
                <div class="wrap1">
                    <div id="left" class="wrap1-left">
                        <h4><?php echo $text_newsletter; ?></h4>
                        <ul>
                            <li style="color:gray"><?php echo $text_description_newsletter ?></li>
                            <br />
                            <li>
                                <div id="newsletter-wrapper">
                                    <form action="/index.php" method="get" class="newsletter-form" target="_blank">
                                        <input type="hidden" name="route" value="module/newsletter/callback">
                                        <input type="hidden" name="subscribe" value="1">
                                        <div class="newsletter_input">
                                            <input type="email" name="email" placeholder="Email Address"><a class="submit" href="#"><img src="catalog/view/theme/sealskinz/image/go-button.png" alt="Go Button" /></a>
                                        </div>
                                    </form>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div id="right" class="wrap1-right">
                        <?php 
                        $category = false;

                        foreach ($informations as $key => $information) {
                            if (strtolower($category) !== strtolower($information['category'])) {

                              if ($key > 0)
                              {
                                  echo '<li><a href="faqs">FAQ s</a></li><li><a href="http://storm.sealskinz.com/UK/index.php?route=information/contact">Contact Us</a></li></ul>';
                                  break;
                              }   

                             echo '<h4>' . $information['category'] . '</h4><ul>'; 

                            }

                            echo '<li><a href="' . $information['href'] . '">' . $information['title'] . '</a></li>';

                            if ($key+1 == count($informations)) echo '</ul>';

                             $category = $information['category'];
                        }
                        ?>
                        
                    </div>
                </div>
                <div class="wrap2">
                    <div id="left" class="wrap2-left">
                        <?php 
                        $category = false;
                        echo '<h4>SIZE GUIDES</h4><ul>'; 
                        foreach ($informations as $key => $information) {
                            if (strtolower('Size Guides') == strtolower($information['category'])) {

                              echo '<li><a href="' . $information['href'] . '">' . $information['title'] . '</a></li>';

                            }
                        }
                        echo '</ul>';
                        ?>
                        
                    </div>
                    <div id="right" class="wrap2-right">
                        
                        <?php 
                        $category = false;
                        echo '<h4>MORE INFORMATION</h4><ul>'; 
                        foreach ($informations as $key => $information) {
                            if (strtolower('More Information') == strtolower($information['category'])) {
 
                             echo '<li><a href="' . $information['href'] . '">' . $information['title'] . '</a></li>';

                            }
                        }
                        echo '<li><a href="testimonials">' . $text_testimonials . '</a></li><li><a href="international">' . $text_international . '</a></li><li><a href="' . $stockist . '">' . $text_stockist . '</a></li></ul>';
                        ?>
                        
                        </ul>
                    </div>
                </div>
            </div>

            <div class="column" id="margin-l46">
                <h4><?php echo $text_connect; ?></h4>
                <ul>
                    <li style="padding: 12px 0;"><span><?php echo $fb ?></a></span><?php echo $tw ?><span></span><?php echo $yb ?><span></span><?php echo $pt ?><span></span><span><?php echo $gp ?></span></li>
                    <li style="color:gray"><?php echo $store; ?> <?php echo $text_ltd; ?></li>
                    <li style="color:gray"><?php echo $address; ?></li>
                    <li style="color:gray"><?php echo $text_nation; ?></li>
                </ul>
                <br />
                <span><?php echo $card ?>
                    
                </span>
            </div>
        </div>
    </div> 
</div>
<?php if ($error_environment) echo '<div id="error_environment" class="alert alert-error"><button type="button" class="close" data-dismiss="alert">×</button>' . $error_environment . '</div>'; ?>

<script type="text/javascript">
        $('div#error_environment').delay(3000).fadeOut();
</script>

</body></html>
