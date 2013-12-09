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

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
                <div class="tabbable tabs-left">

                    <ul class="vtabs nav nav-tabs">
                        <?php $module_row = 1; ?>
                        <?php foreach ($modules as $module) { ?>
                            <li<?php if ($module_row == 1) { ?> class="active"<?php } ?>>
                                <a data-toggle="tab" href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>">
                                    <i class="icon-trash" title="remove" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;"></i>
                                    <?php echo $tab_module . ' ' . $module_row; ?>
                                </a>
                            </li>
                            <?php $module_row++; ?>
                        <?php } ?>
                        <li id="module-add">
                            <a>
                                <i class="icon-plus-squared" onclick="addModule();"></i>
                                <?php echo $button_add_module; ?>
                            </a>
                        </li>
                    </ul>

                    <div id="modules" class="tab-content">
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
                                                        <label class="control-label"><?php echo $entry_description; ?></label>
                                                        <div class="controls">
                                                            <textarea name="welcome_module[<?php echo $module_row; ?>][description][<?php echo $language['language_id']; ?>]" id="description-<?php echo $module_row . '-' . $language['language_id']; ?>" class="input-block-level"><?php echo isset($module['description'][$language['language_id']]) ? $module['description'][$language['language_id']] : ''; ?></textarea>
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
                                                <select name="welcome_module[<?php echo $module_row; ?>][layout_id]" class="span2 i-large">
                                                    <?php echo p3html::oc_layout_options($layouts, $module); ?>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_position; ?></label>
                                            <div class="controls">
                                                <select name="welcome_module[<?php echo $module_row; ?>][position]" class="input-large">
                                                    <?php echo p3html::oc_position_options($this->language, $module); ?>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_status; ?></label>
                                            <div class="controls">
                                                <select name="welcome_module[<?php echo $module_row; ?>][status]" class="input-medium">
                                                    <?php echo p3html::oc_status_options($this->language, $module); ?>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_sort_order; ?></label>
                                            <div class="controls"><input type="text" name="welcome_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" class="span1 i-mini"></div>
                                        </div>
                                    </div>

                                </div><!--end-tabbable-->
                            </div><!--end-tab-pane tab-module-x-->
                            <?php $module_row++; ?>
                        <?php } ?>
                    </div><!--end-modules-tab-content-->

                </div><!--end-tabs-left-->
            </form>

        </div><!--end-class-content-->
    </div><!--end-box-->
</div><!--end-id-content-->

<script src="<?php echo P3_CKEDITOR_DIR; ?>/ckeditor.js"></script>
<script>
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
    <?php foreach ($languages as $language) { ?>
        <?php echo p3html::oc_ckeditor_replace('description-' . $module_row . '-' . $language['language_id'], $token); ?>
    <?php } ?>
    <?php $module_row++; ?>
<?php } ?>
</script>

<script>
    var module_row = <?php echo $module_row; ?>;

    function addModule() {
        html	= '<div class="tab-pane active vtabs-content" id="tab-module-' + module_row + '">';
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
                    html += '						<label class="control-label"><?php echo $entry_description; ?></label>';
                    html += '						<div class="controls"><textarea name="welcome_module[' + module_row + '][description][<?php echo $language['language_id']; ?>]" id="description-' + module_row + '-<?php echo $language['language_id']; ?>" class="input-block-level"></textarea></div>';
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
                html += '					<select name="welcome_module[' + module_row + '][layout_id]" class="span2 i-large">';
                html += '						<?php echo p3html::oc_layout_options($layouts, null, true); ?>';
                html += '					</select>';
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

<script>
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
        //$('#language-<?php echo $module_row; ?> a').tabs();
    <?php $module_row++; ?>
<?php } ?>
</script>

<?php echo $footer; ?>