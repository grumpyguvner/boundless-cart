    </div>    
    <div id="footer">
        <div class="container">
            <div class="row">
                <div class="col-sm-4 hidden-xs">
                    <div class="block-about-us">
                        <div class="block-content"><?php if(isset($blocks[0]['description'])){echo $blocks[0]['description'];} ?></div>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="column_content">
                                <h3><?php echo $text_information; ?></h3>
                                <ul>
                                    <?php 
                                    foreach ($informations as $key => $information) {
                                        if ($information['sort_order'] < 10) {
                                            ?>
                                            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                                            <?php
                                        }
                                    }
                                    ?>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <h3>HELP</h3>
                            <ul>
                                <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                                <?php
                                foreach ($informations as $key => $information) {
                                    if ($information['sort_order'] >= 10 && $information['sort_order'] < 20) {
                                        ?>
                                        <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                                        <?php
                                    }
                                }
                                ?>
                            </ul>
                        </div>
                        <div class="col-sm-3">
                            <h3><?php echo $text_service; ?></h3>
                            <ul>
                                <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
                                <?php
                                foreach ($informations as $key => $information) {
                                    if ($information['sort_order'] >= 20 && $information['sort_order'] < 30) {
                                        ?>
                                        <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                                        <?php
                                    }
                                }
                                ?>
                            </ul>
                        </div>
                        <div class="col-sm-3">
                            <h3>COOL STUFF</h3>
                            <ul>
                                <?php
                                foreach ($informations as $key => $information) {
                                    if ($information['sort_order'] >= 30) {
                                        ?>
                                        <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                                        <?php
                                    }
                                }
                                ?>
                            </ul>
                        </div>
                    </div>

                    <div class="row foot_text">
                        <div class="col-sm-12">
                            <div class="middle-footer">                            
                                <div id="social-footer" style="display: inline-block;margin-top: 20px;float: none">
                                    <div class="media-links">
                                        <a href="http://twitter.com/hotmessclothes" target="_blank"><img src="catalog/view/theme/hotmess/image/footer/Twitter.png" ></a>
                                        <a href="http://www.facebook.com/pages/Hotmess/467402680008369" target="_blank"><img src="/catalog/view/theme/hotmess/image/footer/Facebook.png" ></a>
                                        <a href="http://www.youtube.com/channel/UC_0MRGFFNu7z7GByJwXqnQA" target="_blank"><img src="catalog/view/theme/hotmess/image/footer/youtubeb.png" ></a>
                                        <a href="http://instagram.com/HOTMESSCLOTHING" target="_blank"><img src="catalog/view/theme/hotmess/image/footer/instagramb.png" ></a>
                                    </div>
                                    <div class="youth">
                                    <a href="uk-youth-charity"><img style="width: 100%; max-width: 179px;" src="catalog/view/theme/hotmess/image/footer/UK-Youth.png" ></a>
                                    </div>
                                    <div id="newsletter_footer" class="inputContainer" style="display: inline-block;">
                                      <div style="margin-top: 4px;"class="button-enter" title="sign up"></div>
                                      <input type="email" name="email" placeholder="enter your email here for the latest" value="" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row foot_text">
                        <div class="col-sm-6">
                            <div class="payment">
                                <img style="width: 100%;" src="catalog/view/theme/hotmess/image/footer/payment.png" >
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="powered-1" style="float: right;color: #fff"><?php echo $powered; ?></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php echo $welcome_popup; ?>
<?php if ($error_environment) { ?>
<div id="environment"><div class="warning" style="margin-top: 40px;"><?php echo $error_environment; ?></div>

<?php } ?>
<script src="catalog/view/javascript/bootstrap_3.0/bootstrap.js"></script>
</body></html>