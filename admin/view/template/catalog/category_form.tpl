<?php echo $header; ?>

<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <div class="box">

        <div class="heading">
            <h1><i class="icon-sitemap icon-large"></i> <?php echo $heading_title; ?></h1>

            <?php if ($error_warning) { ?>
                <div class="warning alert alert-error"><button type="btn-small" class="close" data-dismiss="alert">×</button><?php echo $error_warning; ?></div>
            <?php } ?>

            <div class="buttons form-actions form-actions-top">
                <?php echo p3html::tb_form_button_save($button_save); ?>
                <?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
            </div>
        </div>

        <div class="content">

            <ul id="tabs" class="htabs nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#tab-general" data-toggle="tab"><i class="icon-cog"></i> <?php echo $tab_general; ?></a></li>
                <li><a data-toggle="tab" href="#tab-data"><i class="icon-database"></i> <?php echo $tab_data; ?></a></li>
                <li><a data-toggle="tab" href="#tab-design"><i class="icon-compass"></i> <?php echo $tab_design; ?></a></li>
            </ul>

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
                <div class="tab-content">
                    <div class="tab-pane active" id="tab-general">
                        <ul id="languages" class="htabs nav nav-tabs">
                            <?php $langIndex = 0; ?>
                            <?php foreach ($languages as $language) { ?>
                                <li<?php if ($langIndex == 0) { ?> class="active"<?php } ?>>
                                    <a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab">
                                        <i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i>
                                        <?php echo $language['name']; ?>
                                    </a>
                                <li>
                                    <?php $langIndex++; ?>
                                <?php } ?>
                        </ul>
                        <div class="tab-content">
                            <?php $langIndex = 0; ?>
                            <?php foreach ($languages as $language) { ?>
                                <div class="tab-pane<?php if ($langIndex == 0) { ?> active<?php } ?>" id="language<?php echo $language['language_id']; ?>">
                                    <div class="form">
                                        <div class="control-group<?php if (isset($error_name[$language['language_id']])) { ?> error<?php } ?>">
                                            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
                                            <div class="controls">
                                                <input type="text" name="category_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['name'] : ''; ?>" class="span6 i-xxlarge">
                                                <?php if (isset($error_name[$language['language_id']])) { ?>
                                                    <span class="error help-block"><?php echo $error_name[$language['language_id']]; ?></span>
                                                <?php } ?>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_meta_title; ?></label>
                                            <div class="controls">
                                                <input type="text" name="category_description[<?php echo $language['language_id']; ?>][meta_title]" value="<?php echo isset($category_description[$language['language_id']]['meta_title']) ? $category_description[$language['language_id']]['meta_title'] : ''; ?>" class="span6 i-xxlarge">
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_meta_description; ?></label>
                                            <div class="controls">
                                                <textarea name="category_description[<?php echo $language['language_id']; ?>][meta_description]" rows="4" class="input-block-level"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_meta_keyword; ?></label>
                                            <div class="controls">
                                                <textarea name="category_description[<?php echo $language['language_id']; ?>][meta_keyword]" rows="4" class="input-block-level"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_description; ?></label>
                                            <div class="controls">
                                                <textarea name="category_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>" class="input-block-level"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['description'] : ''; ?></textarea>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><?php echo $entry_keyword; ?></label>
                                            <div class="controls">
                                                <input type="text" name="category_description[<?php echo $language['language_id']; ?>][keyword]" value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['keyword'] : ''; ?>" class="span6 i-xxlarge">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <?php $langIndex++; ?>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="tab-pane" id="tab-data">
                        <div class="form">
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_parent; ?></label>
                                <div class="controls">
                                    <select name="parent_id" class="span6 i-xxlarge">
                                        <option value="0"><?php echo $text_none; ?></option>
                                        <?php echo p3html::oc_category_options($categories, $parent_id); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_googlebase_text; ?></label>
                                <div class="controls">
                                    <input type="text" name="googlebase_text" value="<?php echo $googlebase_text ?>" class="span6 i-xxlarge">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_googlebase_xml; ?></label>
                                <div class="controls">
                                    <input type="text" name="googlebase_xml" value="<?php echo $googlebase_xml ?>" class="span6 i-xxlarge">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_store; ?></label>
                                <div class="controls">
                                    <div class="scrollbox">
                                        <?php $class = 'even'; ?>
                                        <div class="<?php echo $class; ?>">
                                            <label class="checkbox inline" for="category-store-0">
                                                <input type="checkbox" name="category_store[]" id="category-store-0" value="0"<?php if (in_array(0, $category_store)) { ?> checked="checked"<?php } ?>>
                                                <?php echo $text_default; ?>
                                            </label>
                                        </div>
                                        <?php foreach ($stores as $store) { ?>
                                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                            <div class="<?php echo $class; ?>">
                                                <label class="checkbox inline" for="category-store-<?php echo $store['store_id']; ?>">
                                                    <input type="checkbox" name="category_store[]" id="category-store-<?php echo $store['store_id']; ?>" value="<?php echo $store['store_id']; ?>"<?php if (in_array($store['store_id'], $category_store)) { ?> checked="checked"<?php } ?>>
                                                    <?php echo $store['name']; ?>
                                                </label>
                                            </div>
                                        <?php } ?>
                                    </div></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_keyword; ?></label>
                                <div class="controls">
                                    <input type="text" name="keyword" value="<?php echo $keyword; ?>" class="span6 i-xxlarge">
                                </div>
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
                                <label class="control-label" for="category-top"><?php echo $entry_top; ?></label>
                                <div class="controls">
                                    <input type="checkbox" name="top" id="category-top" value="1"<?php if ($top) { ?> checked="checked"<?php } ?>>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_column; ?></label>
                                <div class="controls"><input type="text" name="column" value="<?php echo $column; ?>" maxlength="1" class="input-mini"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="category-members_only"><?php echo $entry_members_only; ?></label>
                                <div class="controls"><input type="checkbox" name="members_only" id="category-members_only" value="1"<?php if ($members_only) { ?> checked="checked"<?php } ?>></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_date_start; ?></label>
                                <div class="controls"><input type="text" name="date_start_date" value="<?php echo $date_start_date; ?>" class="date input-small"> <input type="text" name="date_start_time" value="<?php echo $date_start_time; ?>" class="time input-small"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_date_end; ?></label>
                                <div class="controls"><input type="text" name="date_end_date" value="<?php echo $date_end_date; ?>" class="date input-small"> <input type="text" name="date_end_time" value="<?php echo $date_end_time; ?>" class="time input-small"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_sort_order; ?></label>
                                <div class="controls"><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" maxlength="1" class="input-mini"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_status; ?></label>
                                <div class="controls">
                                    <select name="status" class="span2">
                                        <?php echo p3html::oc_bool_options($this->language, $status); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="tab-design">
                        <table class="list table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="column-name span3"><?php echo $entry_store; ?></th>
                                    <th class="column-layout span9"><?php echo $entry_layout; ?></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="column-name"><?php echo $text_default; ?></td>
                                    <td class="column-layout">
                                        <select name="category_layout[0][layout_id]" class="span2">
                                            <option value="">&nbsp;</option>
                                            <?php $current = isset($category_layout[0]) ? $category_layout[0] : null; ?>
                                            <?php echo p3html::oc_layout_options($layouts, $current); ?>
                                        </select>
                                    </td>
                                </tr>
                                <?php foreach ($stores as $store) { ?>
                                    <tr>
                                        <td class="column-name"><?php echo $store['name']; ?></td>
                                        <td class="column-layout">
                                            <select name="category_layout[<?php echo $store['store_id']; ?>][layout_id]" class="span2">
                                                <option value="">&nbsp;</option>
                                                <?php $current = isset($category_layout[$store['store_id']]) ? $category_layout[$store['store_id']] : null; ?>
                                                <?php echo p3html::oc_layout_options($layouts, $current); ?>
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