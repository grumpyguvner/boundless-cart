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
                <p><?php echo $text_total; ?><b> <?php echo $total; ?></b>.</p>
                <table class="list">
                    <thead>
                        <tr>
                            <td class="left"><?php echo $column_date_added; ?></td>
                            <td class="left"><?php echo $column_description; ?></td>
                            <td class="right"><?php echo $column_amount; ?></td>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if ($transactions) { ?>
                            <?php foreach ($transactions as $transaction) { ?>
                                <tr>
                                    <td class="left"><?php echo $transaction['date_added']; ?></td>
                                    <td class="left"><?php echo $transaction['description']; ?></td>
                                    <td class="right"><?php echo $transaction['amount']; ?></td>
                                </tr>
                            <?php } ?>
                        <?php } else { ?>
                            <tr>
                                <td class="center" colspan="5"><?php echo $text_empty; ?></td>
                            </tr>
                        <?php } ?>
                    </tbody>
                </table>
                <div class="pagination"><?php echo $pagination; ?></div>
                <div class="buttons">
                    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo strtoupper($button_continue); ?></a></div>
                </div>
            </div>
            <?php echo $content_bottom; ?>
        </div>
    </div>
    
<?php echo $footer; ?>