<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-tags"></i> <?php echo $heading_title; ?></h1>

			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>

      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_save($button_save); ?>
				<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
			</div>
    </div>

    <div class="content">
      <ul id="tabs" class="htabs nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#tab-general"><?php echo $tab_general; ?></a></li>
			</ul>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
			<div class="tab-content">
        <div class="tab-pane active" id="tab-general">
          <div class="form">
            <div class="control-group<?php if ($error_name) { ?> error<?php } ?>">
              <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
              <div class="controls">
								<input type="text" name="name" value="<?php echo $name; ?>" class="span6 i-xxlarge">
                <?php if ($error_name) { ?>
                <span class="error help-block"><?php echo $error_name; ?></span>
                <?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_store; ?></label>
              <div class="controls">
								<div class="scrollbox">
                  <?php $class = 'even'; ?>
                  <div class="<?php echo $class; ?>">
										<label class="checkbox inline">
											<input type="checkbox" name="manufacturer_store[]" value="0"<?php if (in_array(0, $manufacturer_store)) { ?> checked="checked"<?php } ?>>
											<?php echo $text_default; ?>
										</label>
                  </div>
                  <?php foreach ($stores as $store) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
										<label class="checkbox inline">
											<input type="checkbox" name="manufacturer_store[]" value="<?php echo $store['store_id']; ?>"<?php if (in_array($store['store_id'], $manufacturer_store)) { ?> checked="checked"<?php } ?>>
											<?php echo $store['name']; ?>
										</label>
                  </div>
                  <?php } ?>
                </div>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_keyword; ?></label>
              <div class="controls">
								<input type="text" name="keyword" value="<?php echo $keyword; ?>" class="span4">
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_image; ?></label>
              <div class="controls" valign="top">
								<div class="image">
									<img src="<?php echo $thumb; ?>" alt="" id="thumb">
									<input type="hidden" name="image" value="<?php echo $image; ?>" id="image">
									<br>
									<br>
									<a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('image', 'thumb');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>
									<a class="btn" title="<?php echo $text_clear; ?>" onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></a>
								</div>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_sort_order; ?></label>
              <div class="controls"><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" class="input-mini"></div>
            </div>
          </div>
        </div>
			</div>
      </form>
    </div>
  </div>
</div>

<!--FILEMANAGER-->
<?php include_once DIR_TEMPLATE.'javascript/filemanager_dialog.tpl'; ?>
<!--FILEMANAGER-->

<script>
//$('#tabs a').tabs();
</script>

<?php echo $footer; ?>