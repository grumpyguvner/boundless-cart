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
    <?php if ($success) { ?>
        <div class="success"><?php echo $success; ?></div>
    <?php }
    if ($error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php }
    if ($attention) {
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
            <div class="content" id="description-info">
                <?php if ($thumb || $description) { ?>
                    <div> 
                        <?php if ($thumb) { ?>
                            <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
                        <?php } ?>
                        <?php if ($description) { ?>
                            <?php echo $description; ?>
                        <?php } ?>
                    </div>
                <?php } ?>
            </div>
        </div></div>
    </div>
</div>  
<?php echo $footer; ?>