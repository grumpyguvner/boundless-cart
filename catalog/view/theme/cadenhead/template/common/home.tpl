<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><div id="contentback">
    <div id="contentslide"><?php echo $content_top; ?></div></div>
    <div id="contentbottom" >
<?php echo $content_bottom; ?></div>

    <!--div id="newsletter_wrapper">
        <form action="/index.php" method="get" id="newsletter_form" class="newsletter-form" target="_blank">
            <input type="hidden" name="route" value="module/newsletter/callback">
            <input type="hidden" name="subscribe" value="1">
                <div class="newsletter_input">
            <input type="email" id="newsletter_email" name="email" placeholder="Email newsletter signup"><a class="action" href="#">GO</a>
                </div>
        </form>
   </div-->

</div>
<?php echo $footer; ?>