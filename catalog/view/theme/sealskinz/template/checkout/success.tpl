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
    <?php }
    ?>
</div>
<div id="mainContainer" class="container"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content">
        <?php echo $content_top; ?>
        <h1><?php echo $heading_title; ?></h1>
        <?php echo $text_message; ?>
        <div class="buttons">
            <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
        </div>
        <?php echo $content_bottom; ?>
</div></div>
<script type='text/javascript' src='https://platform.cloud-iq.com/cartrecovery/store.js?app_id=17262'></script>
<?php echo $footer; ?>