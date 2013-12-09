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
                    <h1><?php echo $text_account; ?></h1>
                    <h2><?php echo $text_my_account; ?></h2>
                    <div class="wrap-edit">
                        <ul>
                            <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
                            <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
                            <li><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
                            <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
                        </ul>
                    </div>
                    <h2><?php echo $text_my_orders; ?></h2>
                    <div class="wrap-edit">
                        <ul>
                            <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                            <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
                            <?php if ($reward) { ?>
                                <li><a href="<?php echo $reward; ?>"><?php echo $text_reward; ?></a></li>
                            <?php } ?>
                            <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
                            <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
                        </ul>
                    </div>
                    <h2><?php echo $text_my_newsletter; ?></h2>
                    <div class="wrap-edit">
                        <ul>
                            <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
                        </ul>
                    </div>
                </div>
                <?php echo $content_bottom; ?>
            </div></div>
    </div>
</div>

<?php echo $footer; ?> 