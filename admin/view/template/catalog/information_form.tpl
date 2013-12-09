<?php echo $header; ?>
<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <div class="box">

        <div class="heading">
            <h1><i class="icon-info"></i> <?php echo $heading_title; ?></h1>
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
                <li><a data-toggle="tab" href="#tab-data"><?php echo $tab_data; ?></a></li>
                <li><a data-toggle="tab" href="#tab-design"><?php echo $tab_design; ?></a></li>
            </ul>

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
                <div class="tab-content">

                    <div class="tab-pane active" id="tab-general">

                        <ul id="languages" class="htabs nav nav-tabs">
                            <?php $langIndex = 0 ?>
                            <?php foreach ($languages as $language) { ?>
                                <li<?php if ($langIndex == 0) { ?> class="active"<?php } ?>><a data-toggle="tab" href="#language<?php echo $language['language_id']; ?>"><i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i> <?php echo $language['name']; ?></a><li>
                                    <?php $langIndex++ ?>
                                <?php } ?>
                        </ul>

                        <div class="tab-content">
                            <?php $langIndex = 0 ?>
                            <?php foreach ($languages as $language) { ?>
                                <div class="tab-pane<?php if ($langIndex == 0) { ?> active<?php } ?>" id="language<?php echo $language['language_id']; ?>">
                                    <div class="form">
                                        <div class="control-group<?php if (isset($error_title[$language['language_id']])) { ?> error<?php } ?>">
                                            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_category; ?></label>
                                            <div class="controls">
                                                <input type="text" name="information_description[<?php echo $language['language_id']; ?>][category]" class="span6 i-xxlarge" value="<?php echo isset($information_description[$language['language_id']]) ? $information_description[$language['language_id']]['category'] : ''; ?>">
                                                <?php if (isset($error_category[$language['language_id']])) { ?>
                                                    <span class="error help-block"><?php echo $error_category[$language['language_id']]; ?></span>
                                                <?php } ?>
                                            </div>
                                        </div>
                                        <div class="control-group<?php if (isset($error_title[$language['language_id']])) { ?> error<?php } ?>">
                                            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_title; ?></label>
                                            <div class="controls">
                                                <input type="text" name="information_description[<?php echo $language['language_id']; ?>][title]" class="span6 i-xxlarge" value="<?php echo isset($information_description[$language['language_id']]) ? $information_description[$language['language_id']]['title'] : ''; ?>">
                                                <?php if (isset($error_title[$language['language_id']])) { ?>
                                                    <span class="error help-block"><?php echo $error_title[$language['language_id']]; ?></span>
                                                <?php } ?>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_meta_title; ?></label>
                                            <div class="controls">
                                                <input type="text" name="information_description[<?php echo $language['language_id']; ?>][meta_title]" class="span6 i-xxlarge" value="<?php echo isset($information_description[$language['language_id']]) ? $information_description[$language['language_id']]['meta_title'] : ''; ?>">                                                
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_meta_description; ?></label>
                                            <div class="controls">
                                                <textarea name="information_description[<?php echo $language['language_id']; ?>][meta_description]" class="span6 i-xxlarge"><?php echo isset($information_description[$language['language_id']]) ? $information_description[$language['language_id']]['meta_description'] : ''; ?></textarea>                                                
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_meta_keyword; ?></label>
                                            <div class="controls">
                                                <textarea name="information_description[<?php echo $language['language_id']; ?>][meta_keyword]" class="span6 i-xxlarge"><?php echo isset($information_description[$language['language_id']]) ? $information_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>                                                
                                            </div>
                                        </div>
                                        <div class="control-group<?php if (isset($error_description[$language['language_id']])) { ?> error<?php } ?>">
                                            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_description; ?></label>
                                            <div class="controls">
                                                <textarea name="information_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>" class="input-block-level" rows="16"><?php echo isset($information_description[$language['language_id']]) ? $information_description[$language['language_id']]['description'] : ''; ?></textarea>
                                                <?php if (isset($error_description[$language['language_id']])) { ?>
                                                    <span class="error help-block"><?php echo $error_description[$language['language_id']]; ?></span>
                                                <?php } ?>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <?php $langIndex++ ?>
                            <?php } ?>
                        </div>
                    </div>

                    <div class="tab-pane" id="tab-data">
                        <div class="form">
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_store; ?></label>
                                <div class="controls">
                                    <div class="scrollbox">
                                        <?php $class = 'even'; ?>
                                        <div class="<?php echo $class; ?>">
                                            <label class="checkbox inline">
                                                <input type="checkbox" name="information_store[]" value="0"<?php if (in_array(0, $information_store)) { ?> checked="checked"<?php } ?>>
                                                <?php echo $text_default; ?>
                                            </label>
                                        </div>
                                        <?php foreach ($stores as $store) { ?>
                                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                            <div class="<?php echo $class; ?>">
                                                <label class="checkbox inline">
                                                    <input type="checkbox" name="information_store[]" value="<?php echo $store['store_id']; ?>"<?php if (in_array($store['store_id'], $information_store)) { ?> checked="checked"<?php } ?>>
                                                    <?php echo $store['name']; ?>
                                                </label>
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_keyword; ?></label>
                                <div class="controls"><input type="text" name="keyword" value="<?php echo $keyword; ?>" class="span6 i-xxlarge"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_image; ?></label>
                                <div class="controls" valign="top">
                                    <div class="image">
                                        <img src="<?php echo $thumb; ?>" alt="" id="thumb">
                                        <input type="hidden" name="image" value="<?php echo $image; ?>" id="image">
                                        <br><br>
                                        <a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('image', 'thumb');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>
                                        <a class="btn" title="<?php echo $text_clear; ?>" onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>
                                    </div>
                                </div>
                            </div> 
                            <div class="control-group">
                                <label class="control-label" for="informaton-menu"><?php echo $entry_menu; ?></label>
                                <div class="controls">
                                    <input type="checkbox" id="informaton-bottom" name="menu" value="1"<?php if ($menu) { ?> checked="checked"<?php } ?>>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="informaton-bottom"><?php echo $entry_bottom; ?></label>
                                <div class="controls">
                                    <input type="checkbox" id="informaton-bottom" name="bottom" value="1"<?php if ($bottom) { ?> checked="checked"<?php } ?>>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_status; ?></label>
                                <div class="controls">
                                    <select name="status" class="span2 i-medium">
                                        <?php echo p3html::oc_status_options($this->language, $status); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_sort_order; ?></label>
                                <div class="controls">
                                    <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" class="input-mini">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tab-design">
                        <table class="list table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="column-name"><?php echo $entry_store; ?></th>
                                    <th class="column-layout"><?php echo $entry_layout; ?></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="column-name"><?php echo $text_default; ?></td>
                                    <td class="column-layout">
                                        <select name="information_layout[0][layout_id]" class="span2 i-medium">
                                            <option value="">&nbsp;</option>
                                            <?php $selected = isset($information_layout[0]) ? $information_layout[0] : null; ?>
                                            <?php echo p3html::oc_layout_options($layouts, $selected); ?>
                                        </select>
                                    </td>
                                </tr>
                                <?php foreach ($stores as $store) { ?>
                                    <tr>
                                        <td class="columnname-"><?php echo $store['name']; ?></td>
                                        <td class="column-layout">
                                            <select name="information_layout[<?php echo $store['store_id']; ?>][layout_id]" class="span2 i-medium">
                                                <option value="">&nbsp;</option>
                                                <?php echo p3html::oc_layout_options($layouts, $layout); ?>
                                            </select>
                                        </td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<!--FILEMANAGER-->
<?php include_once DIR_TEMPLATE . 'javascript/filemanager_dialog.tpl'; ?>
<!--FILEMANAGER-->

<!--CKEDITOR-->
<script src="<?php echo P3_CKEDITOR_DIR; ?>/ckeditor.js"></script>
<script>
<?php foreach ($languages as $language) { ?>
    <?php echo p3html::oc_ckeditor_replace('description' . $language['language_id'], $token); ?>
<?php } ?>
</script>
<!--CKEDITOR-->

<?php echo $footer; ?>