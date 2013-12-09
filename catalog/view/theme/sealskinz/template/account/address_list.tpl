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
                    <h2><?php echo $text_address_book; ?></h2>

                    <?php foreach ($addresses as $result) { ?>
                        <div class="content">

                            <table style="width: 100%;">
                                <tr>
                                    <td><?php echo $result['address']; ?></td>
                                    <td style="text-align: right;"><a href="<?php echo $result['update']; ?>" class="button"><?php echo $button_edit; ?></a> &nbsp; <a href="<?php echo $result['delete']; ?>" class="button"><?php echo $button_delete; ?></a></td>
                                </tr>
                            </table>

                        </div>
                    <?php } ?>
                    <div class="buttons">

                        <div class="left"><a href="<?php echo $back; ?>" class="button-account"><?php echo $button_back; ?></a></div>
                        <div class="right"><a href="<?php echo $insert; ?>" class="button-account"><?php echo $button_new_address; ?></a></div>

                    </div>
                </div>
                <?php echo $content_bottom; ?>
            </div></div>
    </div>
</div>
<?php echo $footer; ?>