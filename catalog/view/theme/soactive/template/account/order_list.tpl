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
    <div id="accountNoImage"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content"> 
            <?php echo $content_top; ?>
            <div class="content-account">
                <h1><?php echo $heading_title; ?></h1>

                <?php if ($orders) { ?>
                    <?php foreach ($orders as $order) { ?>

                        <div class="order-list">
                            <div class="order-id"><b><?php echo $text_order_id; ?></b> #<?php echo $order['order_id']; ?></div>
                            <div class="order-status"><b><?php echo $text_status; ?></b> <?php echo $order['status']; ?></div>
                            <div class="order-content">
                                <div><b><?php echo $text_date_added; ?></b> <?php echo $order['date_added']; ?><br />
                                    <b><?php echo $text_products; ?></b> <?php echo $order['products']; ?></div>
                                <div><b><?php echo $text_customer; ?></b> <?php echo $order['name']; ?><br />
                                    <b><?php echo $text_total; ?></b> <?php echo $order['total']; ?></div>
                                <div class="order-info"><a href="<?php echo $order['href']; ?>"><img src="catalog/view/theme/default/image/info.png" alt="<?php echo $button_view; ?>" title="<?php echo $button_view; ?>" /></a>&nbsp;&nbsp;<a href="<?php echo $order['reorder']; ?>"><img src="catalog/view/theme/default/image/reorder.png" alt="<?php echo $button_reorder; ?>" title="<?php echo $button_reorder; ?>" /></a></div>
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