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

<div id="content-back">
    <div class="green-bar">
        <div id="accountContainer" class="container"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content"> 
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
                        <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
                    </div>
                </div>
                <?php echo $content_bottom; ?>
            </div></div>
    </div>
</div>
<?php echo $footer; ?>