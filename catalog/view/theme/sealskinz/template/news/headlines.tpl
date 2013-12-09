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
                <div class="content">
                    <h1><?php echo $heading_title; ?></h1>
                    <?php if ($article) { ?>
                        <div class="product-list">
                            <?php foreach ($article as $articles) { ?>
                                <div class="headlines"> 
                                    <div id="left" style="width: 10%;">
                                        <?php if ($articles['thumb']) { ?>
                                            <div class="image" id="left"><a href="<?php echo $articles['href']; ?>"><img src="<?php echo $articles['thumb']; ?>" title="<?php echo $articles['name']; ?>" alt="<?php echo $articles['name']; ?>" /></a></div>
                                        <?php } ?>
                                    </div>
                                    <div id="left" style="width: 73%;">     
                                        <div class="name">
                                            <a href="<?php echo $articles['href']; ?>"><?php echo $articles['name']; ?></a> 
                                            <p><?php echo $articles['date_added']; ?></p>
                                        </div>
                                        <div class="description"><?php echo $articles['description']; ?></div>
                                        <?php if ($articles['acom']) { ?>
                                            <span style="font-style: italic; color: #777;"><?php echo $articles['total_comments']; ?> <?php echo $text_comments; ?></span>
                                        <?php } ?>
                                    </div>    
                                    <div class="readmore"><a class="button" href="<?php echo $articles['href']; ?>"><span><?php echo $button_more; ?></span></a></div>
                                </div>
                            <?php } ?>
                        </div>
                        <div class="pagination"><?php echo $pagination; ?></div>
                    <?php } ?>
                    <?php if (!$article) { ?>
                        <div class="content"><?php echo $text_empty; ?></div>
                        <div class="buttons">
                            <div class="right"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
                        </div>
                    <?php } ?>
                </div>
                <?php echo $content_bottom; ?>
            </div></div>
    </div>
</div>
<?php echo $footer; ?>