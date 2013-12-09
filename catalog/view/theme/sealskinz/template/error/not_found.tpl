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
        <div id="mainContainer" class="container"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content" class="wrong">
                <?php echo $content_top; ?>
                <div class="contentTopBar">
                    <h1><?php echo $text_error; ?></h1>
                </div>
                <div class="buttons-error">
                    <div id="right"><a href="javascript:history.go(-1)" class="button-account"><?php echo $button_error_back; ?></a>&nbsp&nbsp&nbsp<a href="<?php echo $continue; ?>" class="button-account"><?php echo $button_error_home; ?></a></div>
                </div>
        </div></div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<?php echo $footer; ?>