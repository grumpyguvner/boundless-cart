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
                    <h2><?php echo $text_address_book; ?></h2>

                    <?php foreach ($addresses as $result) { ?>
                    <div class="addressBookWrap"> 
                        <div class="content">

                            <table style="width: 100%;">
                                <tr>
                                    <td><?php echo $result['address']; ?></td>
                                    <td style="text-align: right;"><a href="<?php echo $result['update']; ?>" class="button"><?php echo strtoupper($button_edit); ?></a> &nbsp; <a href="<?php echo $result['delete']; ?>" class="button"><?php echo strtoupper($button_delete); ?></a></td>
                                </tr>
                            </table>

                        </div>
                    </div>
                    <?php } ?>
                    <div class="buttons">
                        <div class="buttonLeft"><a href="<?php echo $back; ?>" class="button"><?php echo strtoupper($button_back); ?></a></div>
                        <div class="buttonRight"><a href="<?php echo $insert; ?>" class="button"><?php echo strtoupper($button_new_address); ?></a></div>
                    </div>
                    
                </div>
                <?php echo $content_bottom; ?>
            </div></div>
   
<?php echo $footer; ?>