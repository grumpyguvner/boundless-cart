<?php echo $header; ?>
<div class="container">
    <div class="row">
        <div class="col-sm-12">
          <div class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
            <?php } ?>
          </div>
        </div>
    </div>
</div>
<div class="container"><div class="row"><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content" class="<?php if(empty($column_left) && empty($column_right)){echo 'col-sm-12';} else if (empty($column_left) || empty($column_right)){echo 'col-sm-9';}else{echo 'col-sm-6';} ?>"><?php echo $content_top; ?>
  <h1 class="heading_title"><?php echo $heading_title; ?></h1>
  <?php echo $description; ?>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php echo $content_bottom; ?></div>
</div></div>
<?php echo $footer; ?>