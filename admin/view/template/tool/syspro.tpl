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
                  
                <div class="control-group<?php if ($error_syspro_input_folder) { ?> error<?php } ?>">
                    <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_syspro_input_folder; ?></label>
                    <div class="controls">
                        <input type="text" name="syspro_input_folder" value="<?php echo $syspro_input_folder; ?>" class="span4 i-xlarge">
                        <?php if ($error_syspro_input_folder) { ?>
                            <span class="error help-block"><?php echo $error_syspro_input_folder; ?></span>
                        <?php } ?>
                    </div>
                </div>
                 
                <div class="control-group<?php if ($error_syspro_output_folder) { ?> error<?php } ?>">
                    <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_syspro_output_folder; ?></label>
                    <div class="controls">
                        <input type="text" name="syspro_output_folder" value="<?php echo $syspro_output_folder; ?>" class="span4 i-xlarge">
                        <?php if ($error_syspro_output_folder) { ?>
                            <span class="error help-block"><?php echo $error_syspro_output_folder; ?></span>
                        <?php } ?>
                    </div>
                </div>
                  
                <div class="control-group<?php if ($error_syspro_processed_folder) { ?> error<?php } ?>">
                    <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_syspro_processed_folder; ?></label>
                    <div class="controls">
                        <input type="text" name="syspro_processed_folder" value="<?php echo $syspro_processed_folder; ?>" class="span4 i-xlarge">
                        <?php if ($error_syspro_processed_folder) { ?>
                            <span class="error help-block"><?php echo $error_syspro_processed_folder; ?></span>
                        <?php } ?>
                    </div>
                </div> 
                
                <div class="control-group<?php if ($error_syspro_warehouse) { ?> error<?php } ?>">
                    <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_syspro_warehouse; ?></label>
                    <div class="controls">
                        <input type="text" name="syspro_warehouse" value="<?php echo $syspro_warehouse; ?>" class="span4 i-xlarge">
                        <?php if ($error_syspro_warehouse) { ?>
                            <span class="error help-block"><?php echo $error_syspro_warehouse; ?></span>
                        <?php } ?>
                    </div>
                </div>   
                 
                <div class="control-group">
                    <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_syspro_create_products; ?></label>
                    <div class="controls">
                        <input type="radio" name="syspro_create_products" value="1" <?php if ($syspro_create_products) echo 'checked="checked"'; ?> >Yes
                        <input type="radio" name="syspro_create_products" value="0" <?php if (!$syspro_create_products) echo 'checked="checked"'; ?> >No
                    </div>
                </div> 
                
                <div class="control-group<?php if ($error_syspro_default_priceband) { ?> error<?php } ?>">
                    <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_syspro_default_priceband; ?></label>
                    <div class="controls">
                        <input type="text" name="syspro_default_priceband" value="<?php echo $syspro_default_priceband; ?>" class="span4 i-xlarge">
                        <?php if ($error_syspro_default_priceband) { ?>
                            <span class="error help-block"><?php echo $error_syspro_default_priceband; ?></span>
                        <?php } ?>
                    </div>
                </div>  
                  
                <div class="control-group">
                    <label class="control-label">Import Products?</label>
                    <div class="controls">
                        <input type="checkbox" name="syspro_import_products" value="syspro_import_products" />
                        <input type="text" name="syspro_selected_products" value="" size="60" class="span4 i-xlarge" />
                    </div>
                </div>
                 
                <div class="control-group">
                    <label class="control-label">Import Customers?</label>
                    <div class="controls">
                        <input type="checkbox" name="syspro_import_customers" value="syspro_import_customers" />
                        <input type="text" name="syspro_selected_customers" value="" size="60" class="span4 i-xlarge" />
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label">Export Orders?</label>
                    <div class="controls">
                        <input type="checkbox" name="syspro_import_orders" value="syspro_import_orders" />
                    </div>
                </div>
                  
              </div>
            </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>