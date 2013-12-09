<?php echo $header; ?>
<div id="content">
    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>
        
    <div class="box">
        
        <div class="heading">
            <h1><i class="icon-check"></i> <?php echo $heading_title; ?></h1>
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
                <li class="active"><a data-toggle="tab" href="#BlockContent" data-toggle="tab"><?php echo $tab_content; ?></a></li>
                <li><a data-toggle="tab" href="#BlockHeader"> <?php echo $tab_header; ?></a></li>
                <li><a data-toggle="tab" href="#BlockFooter"><?php echo $tab_footer; ?></a></li>
            </ul>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
              <div class="tab-content">     
                <div class="tab-pane active" id="BlockContent">
                    <div class="tabbable tabs-left">
                        <ul class="vtabs nav nav-tabs">
                            <?php $module_row = 1; ?>
                            <?php foreach ($modules as $module) { ?>
                                <li<?php if ($module_row == 1) { ?> class="active"<?php } ?>>
                                    <a data-toggle="tab" href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>">
                                        <i class="icon-trash" title="remove" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;"></i>
                                        <?php echo $tab_block . ' ' . $module_row; ?>&nbsp;
                                    </a>
                                </li>
                                <?php $module_row++; ?>
                            <?php } ?>
                            <li id="module-add">
                                <a>
                                    <i class="icon-plus-squared" onclick="addModule();"></i>
                                    <?php echo $button_add_new_block; ?>
                                </a>
                            </li>
                        </ul>
                            
                        <div class="tab-content">
                            <?php $module_row = 1; ?>
                            <?php foreach ($modules as $module) { ?>
                                <div class="tab-pane<?php if ($module_row == 1) { ?> active<?php } ?> vtabs-content" id="tab-module-<?php echo $module_row; ?>">
                                    <div class="tabbable">
                                        <ul id="language-<?php echo $module_row; ?>" class="htabs nav nav-tabs">
                                            <?php $langIndex = 0; ?>
                                            <?php foreach ($languages as $language) { ?>
                                                <li<?php if ($langIndex == 0) { ?> class="active"<?php } ?>><a data-toggle="tab" href="#tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i> <?php echo $language['name']; ?></a></li>
                                                <?php $langIndex++; ?>
                                            <?php } ?>
                                        </ul>
                                        <div class="tab-content">
                                            <?php $langIndex = 0; ?>
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="tab-pane<?php if ($langIndex == 0) { ?> active<?php } ?>" id="tab-language-<?php echo $module_row . '-' . $language['language_id']; ?>">
                                                    <div class="form">
                                                        <div class="control-group">
                                                            <label class="control-label"><?php echo $entry_content; ?></label>
                                                            <div class="controls">
                                                                <textarea name="blocks_module[<?php echo $module_row; ?>][description][<?php echo $language['language_id']; ?>]" id="description-<?php echo $module_row . '-' . $language['language_id']; ?>" class="input-block-level"><?php echo isset($module['description'][$language['language_id']]) ? $module['description'][$language['language_id']] : ''; ?></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <?php $langIndex++; ?>
                                            <?php } ?>
                                        </div>
                                        <div class="form">
                                            <div class="control-group">
                                                <label class="control-label"><?php echo $entry_layout; ?></label>
                                                <div class="controls">
                                                    <select name="blocks_module[<?php echo $module_row; ?>][layout_id]" class="span2 i-large">
                                                        <?php echo p3html::oc_layout_options($layouts, $module); ?>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label"><?php echo $entry_store; ?></label>
                                                <div class="controls">
                                                    <div class="scrollbox">
                                                        <?php $class = 'even'; ?>
                                                        <div class="<?php echo $class; ?>">
                                                            <?php if (isset($module['store_id']) && in_array(0, $module['store_id'])) { ?>
                                                                <input type="checkbox" name="blocks_module[<?php echo $module_row; ?>][store_id][]" value="0" checked="checked" />
                                                            <?php } else { ?>
                                                                <input type="checkbox" name="blocks_module[<?php echo $module_row; ?>][store_id][]" value="0" />
                                                            <?php } ?>
                                                            <?php echo $text_default; ?>
                                                        </div>
                                                        <?php foreach ($stores as $store) { ?>
                                                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                                            <div class="<?php echo $class; ?>">
                                                                <?php if (isset($module['store_id']) && in_array($store['store_id'], $module['store_id'])) { ?>
                                                                    <input type="checkbox" name="blocks_module[<?php echo $module_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                                                                    <?php echo $store['name']; ?>
                                                                <?php } else { ?>
                                                                    <input type="checkbox" name="blocks_module[<?php echo $module_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" />
                                                                    <?php echo $store['name']; ?>
                                                                <?php } ?>
                                                            </div>
                                                        <?php } ?>
                                                    </div> 
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label"><?php echo $entry_position; ?></label>
                                                <div class="controls">
                                                    <select name="blocks_module[<?php echo $module_row; ?>][position]" class="input-large">
                                                        <?php echo p3html::oc_position_options($this->language, $module); ?>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label"><?php echo $entry_status; ?></label>
                                                <div class="controls">
                                                    <select name="blocks_module[<?php echo $module_row; ?>][status]" class="input-medium">
                                                        <?php echo p3html::oc_status_options($this->language, $module); ?>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label"><?php echo $entry_sort_order; ?></label>
                                                <div class="controls"><input type="text" name="blocks_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" class="span1 i-mini"></div>
                                            </div>
                                        </div>
                                            
                                    </div><!--end-tabbable-->
                                </div><!--end-tab-pane tab-module-x-->
                                <?php $module_row++; ?>
                            <?php } ?>
                        </div><!--end-modules-tab-content-->
                    </div><!--end-tabs-left-->
                </div><!--end-block-content-->
                    
                <!-- CUSTOM BLOCK HEADER -->
                <div class="tab-pane" id="BlockHeader">
                    <div class="tabbable tabs-left">
                        
                        <ul class="vtabs nav nav-tabs">
                            <?php $module_header_row = 1; ?>
                            <?php foreach ($modules_header as $module_header) { ?>
                                <li<?php if ($module_header_row == 1) { ?> class="active"<?php } ?>>
                                    <a data-toggle="tab" href="#tab-module_header-<?php echo $module_header_row; ?>" id="module_header-<?php echo $module_header_row; ?>">
                                        <i class="icon-trash" title="remove" onclick="$('.vtabs a:first').trigger('click'); $('#module_header-<?php echo $module_header_row; ?>').remove(); $('#tab-module_header-<?php echo $module_header_row; ?>').remove(); return false;"></i>
                                        <?php echo $tab_block . ' ' . $module_header_row; ?>&nbsp;
                                    </a>
                                </li>
                                <?php $module_header_row++; ?>
                            <?php } ?>
                            <li id="module-add">
                                <a>
                                    <i class="icon-plus-squared" onclick="addModuleHeader();"></i>
                                    <?php echo $button_add_new_block; ?>
                                </a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <?php $module_header_row = 1; ?>
                            <?php foreach ($modules_header as $module_header) { ?>
                                <div class="tab-pane<?php if ($module_header_row == 1) { ?> active<?php } ?> vtabs-content" id="tab-module_header-<?php echo $module_header_row; ?>">
                                    <div class="tabbable">
                                        <ul id="language_header-<?php echo $module_header_row; ?>" class="htabs nav nav-tabs">
                                            <?php $langIndex = 0; ?>
                                            <?php foreach ($languages as $language) { ?>
                                                <li<?php if ($langIndex == 0) { ?> class="active"<?php } ?>><a data-toggle="tab" href="#tab-language_header-<?php echo $module_header_row; ?>-<?php echo $language['language_id']; ?>"><i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i> <?php echo $language['name']; ?></a></li>
                                                <?php $langIndex++; ?>
                                            <?php } ?>
                                        </ul>
                                        <div class="tab-content">
                                            <?php $langIndex = 0; ?>
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="tab-pane<?php if ($langIndex == 0) { ?> active<?php } ?>" id="tab-language_header-<?php echo $module_header_row; ?>-<?php echo $language['language_id']; ?>">
                                                    <div class="form">
                                                        <div class="control-group">
                                                            <label class="control-label"><?php echo $entry_content; ?></label>
                                                            <div class="controls">
                                                                <textarea name="blocks_module_header[<?php echo $module_header_row; ?>][description][<?php echo $language['language_id']; ?>]" id="description2-<?php echo $module_header_row; ?>-<?php echo $language['language_id']; ?>" class="input-block-level"><?php echo isset($module_header['description'][$language['language_id']]) ? $module_header['description'][$language['language_id']] : ''; ?></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <?php $langIndex++; ?>
                                            <?php } ?>
                                        </div>
                                        <div class="form">
                                            <div class="control-group">
                                                <label class="control-label"><?php echo $entry_store; ?></label>
                                                <div class="controls">
                                                    <div class="scrollbox">
                                                        <?php $class = 'even'; ?>
                                                        <div class="<?php echo $class; ?>">
                                                            <?php if (isset($module_header['store_id']) && in_array(0, $module_header['store_id'])) { ?>
                                                                <input type="checkbox" name="blocks_module_header[<?php echo $module_header_row; ?>][store_id][]" value="0" checked="checked" />
                                                            <?php } else { ?>
                                                                <input type="checkbox" name="blocks_module_header[<?php echo $module_header_row; ?>][store_id][]" value="0" />
                                                            <?php } ?>
                                                            <?php echo $text_default; ?>
                                                        </div>
                                                        <?php foreach ($stores as $store) { ?>
                                                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                                            <div class="<?php echo $class; ?>">
                                                                <?php if (isset($module_header['store_id']) && in_array($store['store_id'], $module_header['store_id'])) { ?>
                                                                    <input type="checkbox" name="blocks_module_header[<?php echo $module_header_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                                                                    <?php echo $store['name']; ?>
                                                                <?php } else { ?>
                                                                    <input type="checkbox" name="blocks_module_header[<?php echo $module_header_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" />
                                                                    <?php echo $store['name']; ?>
                                                                <?php } ?>
                                                            </div>
                                                        <?php } ?>
                                                    </div> 
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label"><?php echo $entry_status; ?></label>
                                                <div class="controls">
                                                    <select name="blocks_module_header[<?php echo $module_header_row; ?>][status]" class="input-medium">
                                                        <?php echo p3html::oc_status_options($this->language, $module_header); ?>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label"><?php echo $entry_sort_order; ?></label>
                                                <div class="controls"><input type="text" name="blocks_module_header[<?php echo $module_header_row; ?>][sort_order]" value="<?php echo $module_header['sort_order']; ?>" class="span1 i-mini"></div>
                                            </div>
                                        </div>
                                            
                                    </div><!--end-tabbable-->
                                </div><!--end-tab-pane tab-module-x-->
                                <?php $module_header_row++; ?>
                            <?php } ?>
                        </div><!--end-modules-tab-content-->
                            
                    </div><!--end-tabs-left-->
                </div>
                <!-- END CUSTOM BLOCK HEADER -->
                    
                <!-- CUSTOM BLOCK FOOTER -->
                <div class="tab-pane" id="BlockFooter">
                    <div class="tabbable tabs-left">
                        
                        <ul class="vtabs nav nav-tabs">
                            <?php $module_footer_row = 1; ?>
                            <?php foreach ($modules_footer as $module_footer) { ?>
                                <li<?php if ($module_footer_row == 1) { ?> class="active"<?php } ?>>
                                    <a data-toggle="tab" href="#tab-module_footer-<?php echo $module_footer_row; ?>" id="module_footer-<?php echo $module_footer_row; ?>">
                                        <i class="icon-trash" title="remove" onclick="$('.vtabs a:first').trigger('click'); $('#module_footer-<?php echo $module_footer_row; ?>').remove(); $('#tab-module_footer-<?php echo $module_footer_row; ?>').remove(); return false;"></i>
                                        <?php echo $tab_block . ' ' . $module_footer_row; ?>&nbsp;
                                    </a>
                                </li>
                                <?php $module_footer_row++; ?>
                            <?php } ?>
                            <li id="module-add">
                                <a>
                                    <i class="icon-plus-squared" onclick="addModuleFooter();"></i>
                                    <?php echo $button_add_new_block; ?>
                                </a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <?php $module_footer_row = 1; ?>
                            <?php foreach ($modules_footer as $module_footer) { ?>
                                <div class="tab-pane<?php if ($module_footer_row == 1) { ?> active<?php } ?> vtabs-content" id="tab-module_footer-<?php echo $module_footer_row; ?>">
                                    <div class="tabbable">
                                        <ul id="language_footer-<?php echo $module_footer_row; ?>" class="htabs nav nav-tabs">
                                            <?php $langIndex = 0; ?>
                                            <?php foreach ($languages as $language) { ?>
                                                <li<?php if ($langIndex == 0) { ?> class="active"<?php } ?>><a data-toggle="tab" href="#tab-language_footer-<?php echo $module_footer_row; ?>-<?php echo $language['language_id']; ?>"><i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i> <?php echo $language['name']; ?></a></li>
                                                <?php $langIndex++; ?>
                                            <?php } ?>
                                        </ul>
                                        <div class="tab-content">
                                            <?php $langIndex = 0; ?>
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="tab-pane<?php if ($langIndex == 0) { ?> active<?php } ?>" id="tab-language_footer-<?php echo $module_footer_row; ?>-<?php echo $language['language_id']; ?>">
                                                    <div class="form">
                                                        <div class="control-group">
                                                            <label class="control-label"><?php echo $entry_content; ?></label>
                                                            <div class="controls">
                                                                <textarea name="blocks_module_footer[<?php echo $module_footer_row; ?>][description][<?php echo $language['language_id']; ?>]" id="description1-<?php echo $module_footer_row; ?>-<?php echo $language['language_id']; ?>" class="input-block-level"><?php echo isset($module_footer['description'][$language['language_id']]) ? $module_footer['description'][$language['language_id']] : ''; ?></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <?php $langIndex++; ?>
                                            <?php } ?>
                                        </div>
                                        <div class="form">
                                            <div class="control-group">
                                                <label class="control-label"><?php echo $entry_store; ?></label>
                                                <div class="controls">
                                                    <div class="scrollbox">
                                                        <?php $class = 'even'; ?>
                                                        <div class="<?php echo $class; ?>">
                                                            <?php if (isset($module_footer['store_id']) && in_array(0, $module_footer['store_id'])) { ?>
                                                                <input type="checkbox" name="blocks_module_footer[<?php echo $module_footer_row; ?>][store_id][]" value="0" checked="checked" />
                                                            <?php } else { ?>
                                                                <input type="checkbox" name="blocks_module_footer[<?php echo $module_footer_row; ?>][store_id][]" value="0" />
                                                            <?php } ?>
                                                            <?php echo $text_default; ?>
                                                        </div>
                                                        <?php foreach ($stores as $store) { ?>
                                                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                                            <div class="<?php echo $class; ?>">
                                                                <?php if (isset($module_footer['store_id']) && in_array($store['store_id'], $module_footer['store_id'])) { ?>
                                                                    <input type="checkbox" name="blocks_module_footer[<?php echo $module_footer_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                                                                    <?php echo $store['name']; ?>
                                                                <?php } else { ?>
                                                                    <input type="checkbox" name="blocks_module_footer[<?php echo $module_footer_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" />
                                                                    <?php echo $store['name']; ?>
                                                                <?php } ?>
                                                            </div>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label"><?php echo $entry_status; ?></label>
                                                <div class="controls">
                                                    <select name="blocks_module_footer[<?php echo $module_footer_row; ?>][status]" class="input-medium">
                                                        <?php echo p3html::oc_status_options($this->language, $module_footer); ?>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label"><?php echo $entry_sort_order; ?></label>
                                                <div class="controls"><input type="text" name="blocks_module_footer[<?php echo $module_footer_row; ?>][sort_order]" value="<?php echo $module_footer['sort_order']; ?>" class="span1 i-mini"></div>
                                            </div>
                                        </div>
                                            
                                    </div><!--end-tabbable-->
                                </div><!--end-tab-pane tab-module-x-->
                                <?php $module_footer_row++; ?>
                            <?php } ?>
                        </div><!--end-modules-tab-content-->
                            
                    </div><!--end-tabs-left-->
                </div>
                <!-- END CUSTOM BLOCK FOOTER -->
              </div>       
            </form>
        </div> <!-- End .content -->
            
    </div> <!-- End .box -->
        
</div> <!-- End #content -->
<script src="<?php echo P3_CKEDITOR_DIR; ?>/ckeditor.js"></script> 
<script type="text/javascript"><!--
<?php $module_footer_row = 1; ?>
  <?php foreach ($modules_footer as $module_footer) { ?>
      <?php foreach ($languages as $language) { ?>
        <?php echo p3html::oc_ckeditor_replace('description1-' . $module_footer_row . '-' . $language['language_id'], $token); ?>
    <?php } ?>
    <?php $module_footer_row++; ?>
<?php } ?>
<?php $module_header_row = 1; ?>
  <?php foreach ($modules_header as $module_header) { ?>
      <?php foreach ($languages as $language) { ?>
        <?php echo p3html::oc_ckeditor_replace('description2-' . $module_header_row . '-' . $language['language_id'], $token); ?>
    <?php } ?>
    <?php $module_header_row++; ?>
<?php } ?>    
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
    <?php foreach ($languages as $language) { ?>
        <?php echo p3html::oc_ckeditor_replace('description-' . $module_row . '-' . $language['language_id'], $token); ?>
    <?php } ?>
    <?php $module_row++; ?>
<?php } ?>
    //--></script>
<!------------------- New addModule ---------------------->
<script>
    var module_row = <?php echo $module_row; ?>;

    function addModule() {
        html = '<div class="tab-pane active vtabs-content" id="tab-module-' + module_row + '">';
        html += '	<div class="tabbable">';

        html += '		<ul id="language-' + module_row + '" class="htabs nav nav-tabs">';
<?php $langIndex = 0; ?>
<?php foreach ($languages as $language) { ?>
                    var active = <?php if ($langIndex == 0) { ?>' class="active"'<?php } else { ?>''<?php } ?>;
                    html += '			<li'+active+'><a data-toggle="tab" href="#tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>"><i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i> <?php echo $language['name']; ?></a></li>';
    <?php $langIndex++; ?>
<?php } ?>
                html += '		</ul>';

                html += '		<div class="tab-content">';
<?php $langIndex = 0; ?>
<?php foreach ($languages as $language) { ?>
                    var active = <?php if ($langIndex == 0) { ?>' active'<?php } else { ?>''<?php } ?>;
                    html += '			<div class="tab-pane'+active+'" id="tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>">';
                    html += '				<div class="form">';
                    html += '					<div class="control-group">';
                    html += '						<label class="control-label"><?php echo $entry_content; ?></label>';
                    html += '						<div class="controls"><textarea name="blocks_module[' + module_row + '][description][<?php echo $language['language_id']; ?>]" id="description-' + module_row + '-<?php echo $language['language_id']; ?>" class="input-block-level"></textarea></div>';
                    html += '					</div>';
                    html += '				</div>';
                    html += '			</div>';
    <?php $langIndex++; ?>
<?php } ?>
                html += '		</div>';

                html += '		<div class="form">';
                html += '			<div class="control-group">';
                html += '				<label class="control-label"><?php echo $entry_layout; ?></label>';
                html += '				<div class="controls">';
                html += '					<select name="blocks_module[' + module_row + '][layout_id]" class="span2 i-large">';
                html += '						<?php echo p3html::oc_layout_options($layouts, null, true); ?>';
                html += '					</select>';
                html += '				</div>';
                html += '			</div>';
                html += '			<div class="control-group">';
                html += '				<label class="control-label"><?php echo $entry_store; ?></label>';
                html += '				<div class="controls">';
                html += '                                   <div class="scrollbox">';
                                                              <?php $class = 'even'; ?>
                html += '                                       <div class="<?php echo $class; ?>">';
//                                                                    <?php /*if (isset($module['store_id']) && in_array(0, $module['store_id'])) {*/ ?>;
//                html += '                                               <input type="checkbox" name="blocks_module[' + module_row + '][store_id][]" value="0" checked="checked" />';
                html += '				    </div>';
                html += '				</div>';
                html += '			</div>';
                html += '			<div class="control-group">';
                html += '				<label class="control-label"><?php echo $entry_position; ?></label>';
                html += '				<div class="controls">';
                html += '					<select name="welcome_module[' + module_row + '][position]" class="input-large">';
                html += '						<?php echo p3html::oc_position_options($this->language); ?>';
                html += '					</select>';
                html += '				</div>';
                html += '			</div>';
                html += '			<div class="control-group">';
                html += '				<label class="control-label"><?php echo $entry_status; ?></label>';
                html += '				<div class="controls">';
                html += '					<select name="welcome_module[' + module_row + '][status]" class="input-medium">';
                html += '						<?php echo p3html::oc_status_options($this->language, null, true); ?>';
                html += '					</select>';
                html += '				</div>';
                html += '			</div>';
                html += '			<div class="control-group">';
                html += '				<label class="control-label"><?php echo $entry_sort_order; ?></label>';
                html += '				<div class="controls"><input type="text" name="welcome_module[' + module_row + '][sort_order]" value="" class="span1 i-mini"></div>';
                html += '			</div>';
                html += '		</div>';

                html += '	</div>'; // end tab-tabbable
                html += '</div>';// end tab-module

                $('#modules').append(html);

<?php foreach ($languages as $language) { ?>
    <?php echo p3html::oc_ckeditor_replace('description-\' + module_row + \'-' . $language['language_id'], $token); ?>
<?php } ?>

                $('#module-add').before(
                '<li><a data-toggle="tab" href="#tab-module-' + module_row + '" id="module-' + module_row + '"><i class="icon-trash" title="remove" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;"></i> <?php echo $tab_module; ?> ' + module_row + '</a></li>'
            );

<?php if ($this->config->get('p3adminrebooted_select2')) { ?>
                    $('#tab-module-' + module_row + ' select').select2();
<?php } ?>

                $('#module-' + module_row).trigger('click');

                module_row++;
            }
</script>
<!----------------- End New addModule -------------------->
<!----------------------------------- FOOTER ---------------------------------------->
<script type="text/javascript"><!--
    var module_footer_row = <?php echo $module_footer_row; ?>;

    function addModuleFooter() {	
        html  = '<div id="tab-module_footer-' + module_footer_row + '" class="vtabs-content">';
        html += '  <div id="language_footer-' + module_footer_row + '" class="htabs">';
<?php foreach ($languages as $language) { ?>
                html += '    <a href="#tab-language_footer-'+ module_footer_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
<?php } ?>
            html += '  </div>';

<?php foreach ($languages as $language) { ?>
                    html += '    <div id="tab-language_footer-'+ module_footer_row + '-<?php echo $language['language_id']; ?>">';
                    html += '      <table class="form">';
                    html += '        <tr>';
                    html += '          <td><?php echo $entry_content; ?></td>';
                    html += '          <td><textarea name="blocks_module_footer[' + module_footer_row + '][description][<?php echo $language['language_id']; ?>]" id="description1-' + module_footer_row + '-<?php echo $language['language_id']; ?>"></textarea></td>';
                    html += '        </tr>';
                    html += '      </table>';
                    html += '    </div>';
<?php } ?>

                html += '  <table class="form">';
                html += '    <tr>';
                html += '      <td><?php echo $entry_store; ?></td>';
                html += '      <td><div class="scrollbox">';
                divclass = 'even';
                html += '      	  <div class="' + divclass + '">';
                html += '		    <input type="checkbox" name="blocks_module_footer[' + module_footer_row + '][store_id][]" value="0" checked="checked" />';
                html += '			<?php echo $text_default; ?>';
                html += '         </div>';
<?php foreach ($stores as $store) { ?>
                    divclass = (divclass == 'even' ? 'odd' : 'even');
                    html += '         <div class="' + divclass + '">';
                    html += '           <input type="checkbox" name="blocks_module_footer[' + module_footer_row + '][store_id][]" value="<?php echo $store['store_id']; ?>" checked="checked" />';
                    html += '           <?php echo $store['name']; ?>';
                    html += '          </div>';
<?php } ?>
            html += '      </div></td>';
            html += '    </tr>';
            html += '    <tr>';
            html += '      <td><?php echo $entry_position; ?></td>';
            html += '      <td><select name="blocks_module_footer[' + module_footer_row + '][position]">';
            html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
            html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
            html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
            html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
            html += '      </select></td>';
            html += '    </tr>';
            html += '    <tr>';
            html += '      <td><?php echo $entry_status; ?></td>';
            html += '      <td><select name="blocks_module_footer[' + module_footer_row + '][status]">';
            html += '        <option value="1"><?php echo $text_enabled; ?></option>';
            html += '        <option value="0"><?php echo $text_disabled; ?></option>';
            html += '      </select></td>';
            html += '    </tr>';
            html += '    <tr>';
            html += '      <td><?php echo $entry_sort_order; ?></td>';
            html += '      <td><input type="text" name="blocks_module_footer[' + module_footer_row + '][sort_order]" value="" size="3" /></td>';
            html += '    </tr>';
            html += '  </table>'; 
            html += '</div>';
	
            $('#BlockFooter').append(html);
	
<?php foreach ($languages as $language) { ?>
                    CKEDITOR.replace('description1-' + module_footer_row + '-<?php echo $language['language_id']; ?>', {
                        filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
                    });  
<?php } ?>
	
                $('#language_footer-' + module_footer_row + ' a').tabs();
	
                $('#module_footer-add').before('<a href="#tab-module_footer-' + module_footer_row + '" id="module_footer-' + module_footer_row + '"><?php echo $tab_block; ?> ' + module_footer_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module_footer-' + module_footer_row + '\').remove(); $(\'#tab-module_footer-' + module_footer_row + '\').remove(); return false;" /></a>');

                $('#blockfootertab a').tabs();
	
                $('#module_footer-' + module_footer_row).trigger('click');
	
                module_footer_row++;
            }
            //--></script>

<!--<script type="text/javascript">
    $('#blockfootertab .vtabs a').tabs();
    //</script>-->

<!--<script type="text/javascript">
<?php /* $module_footer_row = 1; ?>
<?php foreach ($modules_footer as $module_footer) { ?>
        $('#language_footer-<?php echo $module_footer_row; ?> a').tabs();
    <?php $module_footer_row++; ?>
<?php } */ ?> 
    //</script> -->
<!---------------------------------- END FOOTER ----------------------------------------->

<!----------------------------------- HEADER ---------------------------------------->
<script type="text/javascript"><!--
    var module_header_row = <?php echo $module_header_row; ?>;

    function addModuleHeader() {	
        html  = '<div id="tab-module_header-' + module_header_row + '" class="vtabs-content">';
        html += '  <div id="language_header-' + module_header_row + '" class="htabs">';
<?php foreach ($languages as $language) { ?>
                html += '    <a href="#tab-language_header-'+ module_header_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
<?php } ?>
            html += '  </div>';

<?php foreach ($languages as $language) { ?>
                    html += '    <div id="tab-language_header-'+ module_header_row + '-<?php echo $language['language_id']; ?>">';
                    html += '      <table class="form">';
                    html += '        <tr>';
                    html += '          <td><?php echo $entry_content; ?></td>';
                    html += '          <td><textarea name="blocks_module_header[' + module_header_row + '][description][<?php echo $language['language_id']; ?>]" id="description2-' + module_header_row + '-<?php echo $language['language_id']; ?>"></textarea></td>';
                    html += '        </tr>';
                    html += '      </table>';
                    html += '    </div>';
<?php } ?>

                html += '  <table class="form">';
                html += '    <tr>';
                html += '      <td><?php echo $entry_store; ?></td>';
                html += '      <td><div class="scrollbox">';
                divclass = 'even';
                html += '      	  <div class="' + divclass + '">';
                html += '		    <input type="checkbox" name="blocks_module_header[' + module_header_row + '][store_id][]" value="0" checked="checked" />';
                html += '			<?php echo $text_default; ?>';
                html += '         </div>';
<?php foreach ($stores as $store) { ?>
                    divclass = (divclass == 'even' ? 'odd' : 'even');
                    html += '         <div class="' + divclass + '">';
                    html += '           <input type="checkbox" name="blocks_module_header[' + module_header_row + '][store_id][]" value="<?php echo $store['store_id']; ?>" checked="checked" />';
                    html += '           <?php echo $store['name']; ?>';
                    html += '          </div>';
<?php } ?>
            html += '      </div></td>';
            html += '    </tr>';
            html += '    <tr>';
            html += '      <td><?php echo $entry_status; ?></td>';
            html += '      <td><select name="blocks_module_header[' + module_header_row + '][status]">';
            html += '        <option value="1"><?php echo $text_enabled; ?></option>';
            html += '        <option value="0"><?php echo $text_disabled; ?></option>';
            html += '      </select></td>';
            html += '    </tr>';
            html += '    <tr>';
            html += '      <td><?php echo $entry_sort_order; ?></td>';
            html += '      <td><input type="text" name="blocks_module_header[' + module_header_row + '][sort_order]" value="" size="3" /></td>';
            html += '    </tr>';
            html += '  </table>'; 
            html += '</div>';
	
            $('#BlockHeader').append(html);
	
<?php foreach ($languages as $language) { ?>
                    CKEDITOR.replace('description2-' + module_header_row + '-<?php echo $language['language_id']; ?>', {
                        filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                        filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
                    });  
<?php } ?>
	
                $('#language_header-' + module_header_row + ' a').tabs();
	
                $('#module_header-add').before('<a href="#tab-module_header-' + module_header_row + '" id="module_footer-' + module_header_row + '"><?php echo $tab_block; ?> ' + module_header_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module_footer-' + module_header_row + '\').remove(); $(\'#tab-module_footer-' + module_header_row + '\').remove(); return false;" /></a>');

                $('#blockheadertab a').tabs();
	
                $('#module_header-' + module_header_row).trigger('click');
	
                module_header_row++;
            }
            //--></script>

<!--<script type="text/javascript">
    $('#blockheadertab .vtabs a').tabs();
    //</script>-->

<!--<script type="text/javascript">
<?php /* $module_header_row = 1; ?>
<?php foreach ($modules_header as $module_header) { ?>
        $('#language_header-<?php echo $module_header_row; ?> a').tabs();
    <?php $module_header_row++; ?>
<?php } */ ?> 
    //</script> -->
<!---------------------------------- END HEADER ----------------------------------------->

<!--<script type="text/javascript"-->
    <!-- TABS 
    $('#mainTabs a').tabs();
    $('#tabs1 a').tabs();
    $('#tabs2 a').tabs();
    $('#blockcontenttab a').tabs();
    $('#blockfootertab a').tabs();
    $('#blockheadertab a').tabs();
    $('#languages_header_top a').tabs(); 
    $('#languages_header_bottom a').tabs(); 
    $('#languages_footer_1 a').tabs(); 
    $('#languages_footer_2 a').tabs(); 
    $('#languages_footer_3 a').tabs(); 
    //--><!--/script-->
<?php echo $footer; ?>