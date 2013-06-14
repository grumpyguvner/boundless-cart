<?php echo $header; ?>
<div class="breadcrumb">
    <?php if ($breadcrumbs) { ?>
      <?php $count = count($breadcrumbs) - 1; ?>
      <?php for ($i = 0; $i < $count; $i++) { ?>
        <?php echo $breadcrumbs[$i]['separator']; ?><a href="<?php echo $breadcrumbs[$i]['href']; ?>"><b><?php echo $breadcrumbs[$i]['text']; ?></b></a>
      <?php } ?>
        <?php echo $breadcrumbs[$count]['separator']; ?><a href="<?php echo $breadcrumbs[$count]['href']; ?>"><?php echo $breadcrumbs[$count]['text']; ?></a>
       
    <?php } ?>
  </div>
<div id="notification">
    <?php if (isset($success) && $success) { ?>
        <div class="success"><?php echo $success; ?></div>
    <?php }
    if (isset($error_warning) && $error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php }
    ?>
</div>
    <div id="accountNoImage"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content"> 
            <?php echo $content_top; ?>
            <div class="content-account">
                <h1><?php echo $heading_title; ?></h1>
                <?php if ($returns) { ?>
                    <?php foreach ($returns as $return) { ?>
                        <div class="return-list">
                            <div class="return-id"><b><?php echo $text_return_id; ?></b> #<?php echo $return['return_id']; ?></div>
                            <div class="return-status"><b><?php echo $text_status; ?></b> <?php echo $return['status']; ?></div>
                            <div class="return-content">
                                <div><b><?php echo $text_date_added; ?></b> <?php echo $return['date_added']; ?><br />
                                    <b><?php echo $text_order_id; ?></b> <?php echo $return['order_id']; ?></div>
                                <div><b><?php echo $text_customer; ?></b> <?php echo $return['name']; ?></div>
                                <div class="return-info"><a href="<?php echo $return['href']; ?>"><img src="catalog/view/theme/default/image/info.png" alt="<?php echo $button_view; ?>" title="<?php echo $button_view; ?>" /></a></div>
                            </div>
                        </div>
                    <?php } ?>
                    <div class="pagination"><?php echo $pagination; ?></div>
                <?php } else { ?>
                    <div class="content"><?php echo $text_empty; ?></div>
                <?php } ?>
                <div class="buttons">
                    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo strtoupper($button_continue); ?></a></div>
                </div>
            </div>
            <?php echo $content_bottom; ?>
        </div>
    </div>
    
<?php echo $footer; ?>