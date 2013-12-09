<?php echo $header; ?>
<?php echo $column_left; ?>

<!--div id="column-left">
    
   <?php /*if ($heading_title == 'Contact us') { */ ?>
        <div class="box">
            <div class="box-heading">
                <a href="index.php?route=information/information&information_id=10">Contact Us</a>
            </div>
            <div class="box-content">
                <p><a href="index.php?route=information/information&information_id=10">Our Contact Details</a></p>
                <p><a href="index.php?route=information/information&information_id=11">Stockists</a></p>
                <p><a href="index.php?route=information/information&information_id=12">Wholesale Enquiries</a></p>
            </div>
        </div>
  <?php /* }  */?>
</div-->

<div id="content">
<?php echo $content_top; ?>
<div class="breadcrumb">
<?php foreach ($breadcrumbs as $breadcrumb) { ?>
<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
<?php } ?>
</div>


<?php echo $description; ?>

<!--div class="buttons">
<div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
</div-->
<?php echo $content_bottom; ?>
</div>

<?php echo $footer; ?>