<?php echo $header; ?>
<div id="content">
  
  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">
     <div class="heading">
      <h1><img src="view/image/log.png" alt="" /> <?php echo $heading_title; ?></h1>
        <?php if ($error_warning) { ?>
                <?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
        <?php } ?>
        <?php if ($success) { ?>
                <?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
        <?php } ?>
        <div class="buttons form-actions form-actions-top">
            <?php echo p3html::tb_form_button_save($button_save); ?>
           <a onclick="location='<?php echo $import; ?>'" class="btn"><span><?php echo $button_import; ?></span></a>
        </div>
    </div>
    
    <div class="content">
      <ul class="nav nav-tabs" id="myTab">
          <li class="active"><a data-toggle="tab" href="#tab-general"><?php echo $tab_general; ?></a></li>
      </ul>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
          <div class="tab-general" id="myTabContent">
              <div id="home" class="tab-pane fade in active">
                  
                <div class="control-group<?php if ($error_wms_server) { ?> error<?php } ?>">
                    <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_wms_server; ?></label>
                    <div class="controls">
                        <input type="text" name="wms_server" value="<?php echo $wms_server; ?>" class="span4 i-xlarge">
                        <?php if ($error_wms_server) { ?>
                            <span class="error help-block"><?php echo $error_wms_server; ?></span>
                        <?php } ?>
                    </div>
                </div>
                  
                <div class="control-group<?php if ($error_wms_port) { ?> error<?php } ?>">
                    <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_wms_port; ?></label>
                    <div class="controls">
                        <input type="text" name="wms_port" value="<?php echo $wms_port; ?>" class="span4 i-xlarge">
                        <?php if ($error_wms_port) { ?>
                            <span class="error help-block"><?php echo $error_wms_port; ?></span>
                        <?php } ?>
                    </div>
                </div>
                  
                <div class="control-group<?php if ($error_wms_warehouse) { ?> error<?php } ?>">
                    <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_wms_warehouse; ?></label>
                    <div class="controls">
                        <input type="text" name="wms_warehouse" value="<?php echo $wms_warehouse; ?>" class="span4 i-xlarge">
                        <?php if ($error_wms_warehouse) { ?>
                            <span class="error help-block"><?php echo $error_wms_warehouse; ?></span>
                        <?php } ?>
                    </div>
                </div>  
                  
              </div>
            </div>
        
      </form>
    </div>
  </div>
</div>
<script type="text/javascript">
    $('#myTab a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
    })
</script>
<?php echo $footer; ?>