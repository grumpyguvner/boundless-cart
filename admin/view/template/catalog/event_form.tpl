<?php echo $header; ?>
<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <div class="box">

        <div class="heading">
            <h1><i class="icon-info icon-large"></i> <?php echo $heading_title; ?></h1>

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
                                            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_title; ?></label>
                                            <div class="controls">
                                                <input type="text" name="event_description[<?php echo $language['language_id']; ?>][title]" size="100" value="<?php echo isset($event_description[$language['language_id']]) ? $event_description[$language['language_id']]['title'] : ''; ?>" class="span6 i-xxlarge" />
                                                <?php if (isset($error_title[$language['language_id']])) { ?>
                                                    <span class="error help-block"><?php echo $error_title[$language['language_id']]; ?></span>
                                                <?php } ?>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_description; ?></label>                                            
                                            <div class="controls">
                                                <textarea name="event_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>" rows="4" class="input-block-level"><?php echo isset($event_description[$language['language_id']]) ? $event_description[$language['language_id']]['description'] : ''; ?></textarea>
                                                <?php if (isset($error_description[$language['language_id']])) { ?>
                                                    <span class="error help-block"><?php echo $error_description[$language['language_id']]; ?></span>
                                                <?php } ?>
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
                                <label class="control-label"><?php echo $entry_allow_subscribe; ?></label>
                                <div class="controls">
                                    <select name="allow_subscribe" class="span6 i-xxlarge">
                                        <option value="n" <?php if ($allow_subscribe == 'n') {
                                            echo "selected";
                                        } ?>>No</option>
                                        <option value="y" <?php if ($allow_subscribe == 'y') {
                                            echo "selected";
                                        } ?>>Yes</option>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $allow_no_subscribers; ?></label>
                                <div class="controls">
                                  <input type="text" name="no_of_sub" id="no_of_sub" value="<?php echo $no_of_sub; ?>" class="span6 i-xxlarge" />  
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_date; ?></label>
                                <div class="controls">
                                    <input type="text" name="event_date" id="event_date" value="<?php echo $event_date; ?>" class="date input-small">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_image; ?></label>
                                <div class="controls" valign="top">
                                    <div class="image">
                                        <img src="<?php echo $preview; ?>" alt="" id="preview">
                                        <input type="hidden" name="image" value="<?php echo $image; ?>" id="image">
                                        <br><br>
                                        <a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('image', 'preview');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>
                                        <a class="btn" title="<?php echo $text_clear; ?>" onclick="$('#preview').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" ><?php echo $entry_store; ?></label>
                                <div class="controls">
                                    <div class="scrollbox">
                                        <?php $class = 'even'; ?>
                                    <div class="<?php echo $class; ?>">
                                        <?php if (in_array(0, $event_store)) { ?>
                                            <input type="checkbox" name="event_store[]" value="0" checked="checked" />
                                            <?php echo $text_default; ?>
                                    <?php } else { ?>
                                            <input type="checkbox" name="event_store[]" value="0" />
                                        <?php echo $text_default; ?>
                                        <?php } ?>
                                    </div>
                                        <?php foreach ($stores as $store) { ?>
                                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                        <div class="<?php echo $class; ?>">
                                            <?php if (in_array($store['store_id'], $event_store)) { ?>
                                                <input type="checkbox" name="event_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                                                <?php echo $store['name']; ?>
                                        <?php } else { ?>
                                                <input type="checkbox" name="event_store[]" value="<?php echo $store['store_id']; ?>" />
        <?php echo $store['name']; ?>
    <?php } ?>
                                        </div>
<?php } ?>
                                </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_keyword; ?></label>
                                <div class="controls">
                                    <input type="text" name="keyword" value="<?php echo $keyword; ?>" class="input-mini"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_status; ?></label>
                                <div class="controls">
                                    <select name="status" class="span2">
                                        <?php echo p3html::oc_bool_options($this->language, $status); ?>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_sort_order; ?></label>
                                <div class="controls">
                                    <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="1" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_related; ?></label>
                                <div class="controls"><input type="text" name="related" value="" class="span-3 i-large"></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">&nbsp;</label>
                                <div class="controls">
                                    <div id="product-related" class="scrollbox">
                                        <?php $class = 'odd'; ?>
                                        <?php foreach ($product_related as $product_related) { ?>
                                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                            <div id="product-related<?php echo $product_related['product_id']; ?>" class="<?php echo $class; ?>">
                                                <i class="btn btn-small icon-trash ims remove" title="<?php echo $button_remove; ?>"></i> <?php echo $product_related['name']; ?>
                                                <input type="hidden" name="product_related[]" value="<?php echo $product_related['product_id']; ?>">
                                            </div>
                                        <?php } ?>
                                    </div>
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
                                        <select name="event_layout[0][layout_id]" class="span2">
                                            <option value="">&nbsp;</option>
                                            <?php $current = isset($event_layout[0]) ? $event_layout[0] : null; ?>
                                            <?php echo p3html::oc_layout_options($layouts, $current); ?>
                                        </select>
                                    </td>
                                </tr>
                                <?php foreach ($stores as $store) { ?>
                                    <tr>
                                        <td class="column-name"><?php echo $store['name']; ?></td>
                                        <td class="column-layout">
                                            <select name="event_layout[<?php echo $store['store_id']; ?>][layout_id]" class="span2">
                                                <option value="">&nbsp;</option>
                                                <?php $current = isset($event_layout[$store['store_id']]) ? $event_layout[$store['store_id']] : null; ?>
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

<script>
    $('input[name="related"]').autocomplete({
        delay: 0,
        source: function(request, response) {
            $.ajax({
                url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
                dataType: 'json',
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            label: item.name,
                            value: item.product_id
                        }
                    }));
                }
            });

        },
        select: function(event, ui) {
            $('#product-related' + ui.item.value).remove();

            $('#product-related').append('<div id="product-related' + ui.item.value + '"><i class="btn btn-small icon-trash ims remove" title="<?php echo addslashes($button_remove); ?>"></i> ' + ui.item.label + '<input type="hidden" name="product_related[]" value="' + ui.item.value + '"></div>');


            return false;
        },
        focus: function(event, ui) {
            return false;
        }
    });

    $('form').on('click', '#product-related div i.remove', function() {
        $(this).parent().remove();
    });
</script>
<?php echo $footer; ?>