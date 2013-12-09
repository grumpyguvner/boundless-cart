<?php echo $header; ?>
<div class="breadcrumb">
    <?php if ($breadcrumbs) { ?>
      <?php $count = count($breadcrumbs) - 1; ?>
      <?php for ($i = 0; $i < $count; $i++) { ?>
        <?php echo '<b>' . $breadcrumbs[$i]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$i]['href']; ?>"><b><?php echo $breadcrumbs[$i]['text']; ?></b></a>
      <?php } ?>
        <?php echo '<b>' .$breadcrumbs[$count]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$count]['href']; ?>"><?php echo $breadcrumbs[$count]['text']; ?></a>
        <div class="back"><a href="<?php echo $breadcrumbs[$count-1]['href']; ?>"><?php echo $text_breadcrumb_back; ?></a></div>    
    <?php } ?>
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

<div id="content-back">
    <div class="green-bar">
        <div id="accountContainer" class="container"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content">
                <?php echo $content_top; ?>
                <div class="content-account">
                    <h1><?php echo $heading_title; ?></h1>
                    <?php if (isset($downloads) && !empty($downloads)) { ?>
                        <?php foreach ($downloads as $download) { ?>
                            <div class="download-list">
                                <div class="download-id"><b><?php echo $text_order; ?></b> <?php echo $download['order_id']; ?></div>
                                <div class="download-status"><b><?php echo $text_size; ?></b> <?php echo $download['size']; ?></div>
                                <div class="download-content">
                                    <div><b><?php echo $text_name; ?></b> <?php echo $download['name']; ?><br />
                                        <b><?php echo $text_date_added; ?></b> <?php echo $download['date_added']; ?></div>
                                    <div><b><?php echo $text_remaining; ?></b> <?php echo $download['remaining']; ?></div>
                                    <div class="download-info">
                                        <?php if ($download['remaining'] > 0) { ?>
                                            <a href="<?php echo $download['href']; ?>"><img src="catalog/view/theme/default/image/download.png" alt="<?php echo $button_download; ?>" title="<?php echo $button_download; ?>" /></a>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                        <?php } ?>

                        <div class="pagination"><?php echo $pagination; ?></div>
                    <?php } else { ?>
                        <div class="content"><?php echo $text_error; ?></div>
                        <div class="buttons">
                            <div class="right"><a href="<?php echo $continue; ?>" class="button-account"><?php echo $button_continue; ?></a></div>
                        </div>
                    <?php } ?>

                </div>
                    <?php echo $content_bottom; ?>
            </div></div>
    </div>
</div>
<?php echo $footer; ?>