<?php echo $header; ?>
<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <?php if ($error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/information.png" alt="" /> <?php echo $heading_title; ?></h1>
            <?php if ($error_warning) { ?>
                <?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
            <?php } ?>
            <div class="buttons form-actions form-actions-top">
                <?php echo p3html::tb_form_button_save($button_save); ?>
                <?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
            </div>
        </div>
        <div class="content">
            <ul class="nav nav-tabs" id="myTab">
              <li class="active"><a data-toggle="tab" href="#tab-general"><?php echo $tab_general; ?></a></li>
              <li><a data-toggle="tab" href="#tab-data"><?php echo $tab_data; ?></a></li>
              <li><a data-toggle="tab" href="#tab-design"><?php echo $tab_design; ?></a></li>
            </ul>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
              <div class="tab-content" id="myTabContent">
                 
                    <div id="tab-general" class="tab-pane fade in active">
                        <div class="control-group">
                            <label class="control-label">Language</label>
                            <div class="controls">
                                <div id="languages" class="htabs">
                                    <?php foreach ($languages as $language) { ?>
                                        <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                        <?php foreach ($languages as $language) { ?>
                        <div id="language<?php echo $language['language_id']; ?>">
                            <div class="control-group">
                                <label class="control-label"><span class="required">*</span> <?php echo $entry_name; ?></label>
                                <div class="controls">
                                    <input type="text" name="ncategory_description[<?php echo $language['language_id']; ?>][name]" size="100" value="<?php echo isset($ncategory_description[$language['language_id']]) ? $ncategory_description[$language['language_id']]['name'] : ''; ?>" />
                                        <?php if (isset($error_name[$language['language_id']])) { ?>
                                            <span class="error"><?php echo $error_name[$language['language_id']]; ?></span>
                                        <?php } ?>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_meta_title; ?></label>
                                <div class="controls">
                                    <input type="text" name="ncategory_description[<?php echo $language['language_id']; ?>][meta_title]" size="100" value="<?php echo isset($ncategory_description[$language['language_id']]) ? $ncategory_description[$language['language_id']]['meta_title'] : ''; ?>" />                                       
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"> <?php echo $entry_meta_description; ?></label>
                                <div class="controls">
                                    <textarea name="ncategory_description[<?php echo $language['language_id']; ?>][meta_description]" cols="40" rows="5"><?php echo isset($ncategory_description[$language['language_id']]) ? $ncategory_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
                                </div>
                            </div>    
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_meta_keyword; ?></label>
                                <div class="controls">
                                    <textarea name="ncategory_description[<?php echo $language['language_id']; ?>][meta_keyword]" cols="40" rows="5"><?php echo isset($ncategory_description[$language['language_id']]) ? $ncategory_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>
                                </div>
                            </div>         
                            <div class="control-group">
                                <label class="control-label"><?php echo $entry_description; ?></label>
                                <div class="controls">
                                    <textarea name="ncategory_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>" class="input-block-level" rows="8"><?php echo isset($ncategory_description[$language['language_id']]) ? $ncategory_description[$language['language_id']]['description'] : ''; ?></textarea>
                                </div>
                            </div>  
                        </div>
                    <?php } ?>
                    </div>
                     
                    <div id="tab-data" class="tab-pane fade">
                       <div class="control-group">
                            <label class="control-label"><?php echo $entry_parent; ?></label>
                            <div class="controls">
                                <select name="parent_id">
                                    <option value="0"><?php echo $text_none; ?></option>
                                    <?php foreach ($ncategories as $ncategory) { ?>
                                        <?php if ($ncategory['ncategory_id'] == $parent_id) { ?>
                                            <option value="<?php echo $ncategory['ncategory_id']; ?>" selected="selected"><?php echo $ncategory['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $ncategory['ncategory_id']; ?>"><?php echo $ncategory['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>  
                        
                        <div class="control-group">
                            <label class="control-label"><?php echo $entry_store; ?></label>
                            <div class="controls">
                                <div class="scrollbox">
                                    <?php $class = 'even'; ?>
                                    <div class="<?php echo $class; ?>">
                                        <?php if (in_array(0, $ncategory_store)) { ?>
                                            <input type="checkbox" name="ncategory_store[]" value="0" checked="checked" />
                                            <?php echo $text_default; ?>
                                        <?php } else { ?>
                                            <input type="checkbox" name="ncategory_store[]" value="0" />
                                            <?php echo $text_default; ?>
                                        <?php } ?>
                                    </div>
                                    <?php foreach ($stores as $store) { ?>
                                        <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                        <div class="<?php echo $class; ?>">
                                            <?php if (in_array($store['store_id'], $ncategory_store)) { ?>
                                                <input type="checkbox" name="ncategory_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                                                <?php echo $store['name']; ?>
                                            <?php } else { ?>
                                                <input type="checkbox" name="ncategory_store[]" value="<?php echo $store['store_id']; ?>" />
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
                                <input type="text" name="keyword" value="<?php echo $keyword; ?>" />
                            </div>
                        </div> 
                        
                        <div class="control-group">
                            <label class="control-label"><?php echo $entry_image; ?></label>
                            <div class="controls">
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
                            <label class="control-label"><?php echo $entry_top; ?></label>
                            <div class="controls">
                                <?php if ($top) { ?>
                                    <input type="checkbox" name="top" value="1" checked="checked" />
                                <?php } else { ?>
                                    <input type="checkbox" name="top" value="1" />
                                <?php } ?>
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label class="control-label"><?php echo $entry_column; ?></label>
                            <div class="controls">
                                <input type="text" name="column" value="<?php echo $column; ?>" size="3" />
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label class="control-label"><?php echo $entry_sort_order; ?></label>
                            <div class="controls">
                                <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="3" />
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label class="control-label"><?php echo $entry_status; ?></label>
                            <div class="controls">
                                <select name="status">
                                    <?php if ($status) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                    </div>
                     
                    <div id="tab-design" class="tab-pane fade">
                      <table id="module" class="list table table-striped table-hover">
                        <thead>
                            <tr>
                                <td class="left"><?php echo $entry_store; ?></td>
                                <td class="left"><?php echo $entry_layout; ?></td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="left"><?php echo $text_default; ?></td>
                                <td class="left"><select name="ncategory_layout[0][layout_id]" class="span2 i-medium">
                                        <option value=""></option>
                                        <?php foreach ($layouts as $layout) { ?>
                                            <?php if (isset($ncategory_layout[0]) && $ncategory_layout[0] == $layout['layout_id']) { ?>
                                                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                            <?php } else { ?>
                                                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                            <?php } ?>
                                        <?php } ?>
                                    </select></td>
                            </tr>
                        </tbody>
                        <?php foreach ($stores as $store) { ?>
                            <tbody>
                                <tr>
                                    <td class="left"><?php echo $store['name']; ?></td>
                                    <td class="left"><select name="ncategory_layout[<?php echo $store['store_id']; ?>][layout_id]" class="span2 i-medium">
                                            <option value=""></option>
                                            <?php foreach ($layouts as $layout) { ?>
                                                <?php if (isset($ncategory_layout[$store['store_id']]) && $ncategory_layout[$store['store_id']] == $layout['layout_id']) { ?>
                                                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                                <?php } else { ?>
                                                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                                <?php } ?>
                                            <?php } ?>
                                        </select></td>
                                </tr>
                            </tbody>
                        <?php } ?>
                    </table>
                    </div>
                
                </div> 
            </form>
        </div>
    </div>
</div>
<script src="<?php echo P3_CKEDITOR_DIR; ?>/ckeditor.js"></script>
<!--FILEMANAGER-->
<?php include_once DIR_TEMPLATE . 'javascript/filemanager_dialog.tpl'; ?>
<!--FILEMANAGER-->
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
        CKEDITOR.replace('description<?php echo $language['language_id']; ?>', {
            filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
        });
<?php } ?>
    //--></script> 

<script type="text/javascript"><!--
       $('#myTab a').click(function (e) {
            e.preventDefault();
            $(this).tab('show');
       })
    //--></script> 
<?php echo $footer; ?>