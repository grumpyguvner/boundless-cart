<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-attention"></i> <?php echo $heading_title; ?></h1>
    </div>

    <div class="content">
      <div class="alert alert-error"><?php echo $text_permission; ?></div>
    </div>
  </div>
</div>

<?php echo $footer; ?>