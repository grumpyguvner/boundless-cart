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
    <?php }
    if (isset($error_warning) && $error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php }
    if (isset($attention) && $attention) {
        ?>
        <div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
        <?php
    }
    ?>
</div>
<div id="content-back">
    <div class="green-bar">  
        <div id="infoContainer" class="container<?php if ($catClass) echo ' cat' . $catClass ?><?php if ($seoClass) echo ' seo' . $seoClass ?>"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content">
            <?php echo $content_top; ?>
            <div class="<?php if ($thumb) echo ' infoHasImage';?>" id="description-info">
                <?php if ($thumb || $description) { ?>
                    <?php if ($thumb) { ?>
                        <div class="infoImage"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
                    <?php } ?>
                    <?php if ($description) { ?>
                        <div class="infoDescription">
                            <?php echo $description; ?>
                        </div>
                    <?php } ?>
                <?php } ?>
            </div>
        </div></div>
    </div>
</div>  
<?php echo $footer; ?>