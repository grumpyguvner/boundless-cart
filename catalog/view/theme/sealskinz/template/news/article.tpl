<?php echo $header; ?>
<div id="breadcrumb">
    <div class="container">
        <?php
        foreach ($breadcrumbs as $breadcrumb) {
            echo $breadcrumb['separator'] . '<a href="' . $breadcrumb['href'] . '">' . $breadcrumb['text'] . '</a>';
        }
        ?>
    </div>
</div>
<div id="notification">
    <?php if (isset($success) && $success) { ?>
        <div class="success"><?php echo $success; ?></div>
        <?php
    }
    if (isset($error_warning) && $error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
        <?php
    }
    if (isset($attention) && $attention) {
        ?>
        <div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
        <?php
    }
    ?>
</div>
<div id="content-back">
    <div class="green-bar">
        <div id="mainContainer" class="container"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content"> 
                <?php echo $content_top; ?>
                <?php if (isset($news_info)) { ?>

                    <div class="wrap-news">   
                        <h1><?php echo $heading_title; ?></h1>
                        <div style="display: table; width: 100%">
                            <?php if ($thumb) { ?>
                                <div id="left" style="width: 25%">
                                    <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img align="left" src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a>
                                    <div class="share-press">
                                        <!-- AddThis Button BEGIN -->
                                        <div class="addthis_toolbox addthis_default_style addthis_20x20_style">
                                            <a class="addthis_button_preferred_1"></a>
                                            <a class="addthis_button_preferred_2"></a>
                                            <a class="addthis_button_preferred_3"></a>
                                            <a class="addthis_button_preferred_4"></a>
                                            <a class="addthis_button_compact"></a>
                                            <a class="addthis_counter addthis_bubble_style"></a>
                                        </div>
                                        <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=xa-4f6a758d24474e98"></script>
                                        <!-- AddThis Button END -->
                                    </div>
                                </div>  
                            <?php } ?>
                            <div id="right" style="width: 74%">
                                <p style="color: #9cca68;"><?php echo $date_added; ?></p>
                                <?php echo $description; ?>
                            </div>
                            <br />

                        </div>
                    </div>
                    <?php if ($products) { ?>
                       <div id="relatedProducts">
                        <h3><?php echo $news_prelated; ?></h3>
                       <div id="relatedProducts">
                        <h3><?php echo $tab_related ?></h3>
                        <div class="product-grid">
                            <?php foreach ($products as $product) {
                                ?><div class="productItem"> 
                                    <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                                    <div class="image"><?php if ($product['thumb']) { ?>
                                            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                                        <?php } ?>
                                    </div>
                                    <div class="bar">
                                        <div class="price"><?php echo $product['price']; ?></div><a href="<?php echo $product['href']; ?>"><?php echo $text_view_product_info ?></a>
                                    </div>
                                </div><?php }
                                    ?>
                        </div>
                    </div>
                        <div class="tab-content-pnews">
                            
                        <?php } ?>
                        <?php if ($acom != 0) { ?>
                            <div style="font-size: 16px; font-weight: bold; text-decoration: none; font-style: italic; margin-bottom: 7px; margin-left: 5px;">
                                <?php echo $title_comments; ?> <?php echo $text_coms; ?> "<?php echo $heading_title; ?>"</div>
                            <?php if ($comment) { ?>
                                <?php foreach ($comment as $comment) { ?>
                                    <div class="content"><div  style="background: #eee; padding: 5px;"><b><?php echo $comment['author']; ?></b> - 
                                            <?php echo $comment['date_added']; ?></div>
                                        <br />
                                        <?php echo $comment['text']; ?></div>
                                <?php } ?>
                                <div class="pagination"><?php echo $pagination; ?></div>
                            <?php } ?>
                            <div class="tab-content" style="border-top: 1px solid #ddd;">
                                <h2 id="review-title"><?php echo $writec; ?></h2>
                                <b><?php echo $entry_name; ?></b><br />
                                <input type="text" name="name" value="" />
                                <br />
                                <br />
                                <b><?php echo $entry_review; ?></b>
                                <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
                                <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
                                <br />
                                <b><?php echo $entry_captcha; ?></b><br />
                                <input type="text" name="captcha" value="" />
                                <br />
                                <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
                                <br />
                                <div class="buttons">
                                    <div class="right"><a id="button-comment" class="button"><span><?php echo $text_send; ?></span></a></div>
                                </div>
                            </div>
                        <?php } ?>

                        <?php if ($rarticles) { ?>
                            <div class="wrapper-rnews"> 
                                    <h3><?php echo $news_recent; ?></h3>
                                <div class="wrap-rarticles">
                                    <?php for ($i = 0; $i < count($rarticles) && $i < 4; $i++) { ?>
                                        <div class="rarticles">
                                            <div class="image"><a href="<?php echo $rarticles[$i]['href'] ?>"><img src="<?php echo $rarticles[$i]['thumb'] ?>" alt="<?php echo $rarticles[$i]['name'] ?>" width="136" height="136" /></a></div>
                                            <div class="name"><a href="<?php echo $rarticles[$i]['href'] ?>"><?php echo $rarticles[$i]['name'] ?></a></div>
                                            <div class="description"><p><?php echo $rarticles[$i]['description']; ?></p></div>
                                            <div class="readmore"><a class="button" href="<?php echo $rarticles[$i]['href']; ?>"><span><?php echo $button_more; ?></span></a></div>
                                        </div>
                                    <?php } ?>
                                </div>
                            </div>   
                        <?php } ?>   

                        <div class="buttons" style="width: 98%;">   
                            <div id="margin-r20" class="margin-20"> 
                                <div id="left">
                                    <a href="javascript:history.go(-1)" class="button-account"><?php echo $button_back; ?></a>
                                </div>
                                <div id="right">
                                    <table>
                                        <tr>
                                            <td align="right"><a href="press" class="button-account"><span><?php echo $button_news; ?></span></a></td>
                                        </tr>
                                    </table>
                                </div>
                            </div> 
                        </div>     

                    </div>
                       </div>
                        
                    <script type="text/javascript"><!--
                        $('.colorbox').colorbox({
                            overlayClose: true,
                            opacity: 0.5
                        });
                        //--></script> 
                    <script type="text/javascript"><!--
                        $('#button-comment').bind('click', function() {
                            $.ajax({
                                type: 'POST',
                                url: 'index.php?route=news/article/writecomment&news_id=<?php echo $news_id; ?>',
                                dataType: 'json',
                                data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
                                beforeSend: function() {
                                    $('.success, .warning').remove();
                                    $('#button-comment').attr('disabled', true);
                                    $('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
                                },
                                complete: function() {
                                    $('#button-comment').attr('disabled', false);
                                    $('.attention').remove();
                                },
                                success: function(data) {
                                    if (data.error) {
                                        $('#review-title').after('<div class="warning">' + data.error + '</div>');
                                    }
                                			
                                    if (data.success) {
                                        $('#review-title').after('<div class="success">' + data.success + '</div>');
                                								
                                        $('input[name=\'name\']').val('');
                                        $('textarea[name=\'text\']').val('');
                                        $('input[name=\'captcha\']').val('');
                                    }
                                }
                            });
                        });
                        //--></script> 
                <?php } ?>
                <?php echo $content_bottom; ?>
        </div></div>
    </div>
</div>


<?php echo $footer; ?> 