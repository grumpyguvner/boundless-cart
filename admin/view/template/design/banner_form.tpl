<?php echo $header; ?>

<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <div class="box">
        <div class="heading">
            <h1><img src="view/image/banner.png" alt=""> <?php echo $heading_title; ?></h1>
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
                        <label class="control-label"><?php echo $entry_status; ?></label>
                        <div class="controls">
                            <select name="status" class="span2 i-medium">
                                <?php echo p3html::oc_status_options($this->language, $status); ?>
                            </select>
                        </div>
                    </div>
                </div>
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
                    </div>
                </div>
                <div class="tab-content">
                    <?php $langIndex = 0; ?>
                    <?php $image_row = 0; ?>
                    <?php foreach ($languages as $language) { ?>
                        <div class="tab-pane<?php if ($langIndex == 0) { ?> active<?php } ?>" id="language<?php echo $language['language_id']; ?>">
                            <table id="module" class="list table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th class="column-name"><?php echo $entry_title; ?></th>
                                        <th class="column-url"><?php echo $entry_link; ?></th>
                                        <th class="column-image"><?php echo $entry_image; ?></th>
                                        <th class="column-sort"><?php echo $entry_sort_order; ?></th>
                                        <th class="status"><?php echo $entry_status; ?></th>
                                        <th class="column-action"></th>
                                    </tr>
                                </thead>

                                <?php if (isset($banner_images[$language['language_id']])) { ?>
                                    <?php foreach ($banner_images[$language['language_id']] as $banner_image) { ?>

                                        <tbody id="image-row<?php echo $language['language_id'] . '-' . $image_row; ?>">
                                            <tr>
                                                <td class="column-name">
                                                    <label class="visible-480"><?php echo $entry_title; ?></label>
                                                    <input type="text" name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][title]" value="<?php echo isset($banner_image) ? $banner_image['title'] : ''; ?>" class="span3 i-large" />
                                                    <!-- Check if it is fine!!! -->
                                                    <?php if (isset($error_banner_image[$language['language_id']][$image_row])) { ?>
                                                        <span class="error"><?php echo $error_banner_image[$language['language_id']][$image_row]; ?></span>
                                                    <?php } ?>
                                                    <!-- End Check if it is fine -->    
                                                    <br/><br/>

                                                    <label class="visible-480"><?php echo $entry_description; ?></label>

                                                    <?php if ($banner_image['description']) { ?>
                                                        <br/>
                                                        <textarea name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][description]" id="description<?php echo $language['language_id'] . '-' . $image_row; ?>" class="input-block-level"><?php echo isset($banner_image) ? $banner_image['description'] : ''; ?></textarea>                                            
                                                    <?php } else { ?>

                                                        <a href="#" class="showDesc"><?php echo $text_show; ?></a>
                                                        <div id="textarea-wrap<?php echo $language['language_id'] . '-' . $image_row; ?>" style="display: none">
                                                            <textarea name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][description]" id="description<?php echo $language['language_id'] . '-' . $image_row; ?>" class="input-block-level"><?php echo isset($banner_image) ? $banner_image['description'] : ''; ?></textarea>
                                                        </div>
                                                    <?php } ?> 
                                                    <!-- Check if it is fine!!! -->
                                                    <?php if (isset($error_banner_image[$language['language_id']][$image_row])) { ?>
                                                        <span class="error"><?php echo $error_banner_image[$language['language_id']][$image_row]; ?></span>
                                                    <?php } ?>
                                                    <!-- End Check if it is fine -->  
                                                </td>
                                                <td class="column-url">
                                                    <label class="visible-480"><?php echo $entry_link; ?></label>
                                                    <input type="text" name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][link]" value="<?php echo $banner_image['link']; ?>" class="span3 i-large" />
                                                </td>
                                                <td class="column-image">
                                                    <label class="visible-480"><?php echo $entry_image; ?></label>
                                                    <div class="image">
                                                        <img src="<?php echo $banner_image['thumb']; ?>" alt="" id="thumb<?php echo $image_row; ?>">
                                                        <input type="hidden" name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][image]" value="<?php echo $banner_image['image']; ?>" id="image<?php echo $image_row; ?>"  />
                                                        <br><br>
                                                        <a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('image<?php echo $image_row; ?>', 'thumb<?php echo $image_row; ?>');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>
                                                        <a class="btn" title="<?php echo $text_clear; ?>" onclick="$('#thumb<?php echo $image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $image_row; ?>').attr('value', '');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>
                                                    </div>
                                                </td>
                                                <td class="column-sort">
                                                    <label class="visible-480"><?php echo $entry_sort_order; ?></label>
                                                    <input type="text" name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][sort_order]" value="<?php echo $banner_image['sort_order']; ?>" class="span1 i-mini" />
                                                </td>
                                                <td class="status">
                                                    <label class="visible-480"><?php echo $entry_status; ?></label>
                                                    <select name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][status]" class="span2 i-medium">
                                                        <?php if ($banner_image['status']) { ?>
                                                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                                            <option value="0"><?php echo $text_disabled; ?></option>
                                                        <?php } else { ?>
                                                            <option value="1"><?php echo $text_enabled; ?></option>
                                                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                                        <?php } ?>
                                                    </select>
                                                </td>
                                                <td class="column-action">
                                                    <a onclick="$('#image-row<?php echo $language['language_id'] . '-' . $image_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
                                                </td>
                                            </tr>
                                        </tbody>
                                        <?php $image_row++; ?>    
                                    <?php } ?>
                                <?php } ?>
                                <tfoot class="image-row<?php echo $language['language_id']; ?>">
                                    <tr>
                                        <td colspan="5"></td>
                                        <td class="column-action"><a onclick="addImage(<?php echo $language['language_id']; ?>);" class="btn btn-small" title="<?php echo $button_add_banner; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_banner; ?></a></td>
                                    </tr>
                                </tfoot>  
                            </table>
                        </div>
                    <?php $langIndex++; ?>
                    <?php } ?>
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
<?php $image_row = 0; ?>
<?php foreach ($languages as $language) { ?>
    <?php foreach ($banner_images[$language['language_id']] as $banner_image) { ?>  
                
        <?php echo p3html::oc_ckeditor_replace('description' . $language['language_id'] . '-' . $image_row, $token); ?>

        <?php $image_row++; ?>
    <?php } ?>
<?php } ?>
</script>
<!--CKEDITOR-->


<script type="text/javascript"><!--
    var image_row = <?php echo $image_row; ?>;

    function addImage(languageId) {
                
                html  = '<tbody id="image-row'  + languageId +  '-' + image_row + '">';
                html += '<tr>';
                html += '<td class="column-name">';
                html += '<label class="visible-480"><?php echo $entry_title; ?></label>';
                html += '<input type="text" name="banner_image[' + languageId + '][' + image_row + '][title]" value="" class="span3 i-large" />';
                html += '<br />';
                html += '<label class="visible-480"><?php echo $entry_description; ?></label>';
                html += '<br /><br />';
                html += '<textarea name="banner_image[' + languageId + '][' + image_row + '][description]" id="description' + languageId + '-' + image_row + '" class="input-block-level"></textarea>';
                html += '</td>';	
                html += '<td class="column-url"><label class="visible-480"><?php echo $entry_link; ?></label><input type="text" name="banner_image[' + languageId + '][' + image_row + '][link]" value="" class="span3 i-large" /></td>';            
                html += '<td class="column-image"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="thumb' + image_row + '" /><input type="hidden" name="banner_image[' + languageId + '][' + image_row + '][image]" value="" id="image' + image_row + '"  /><br /><a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a><a class="btn" title="<?php echo $text_clear; ?>" onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a></div></td>';
                html += '<td class="column-sort"><label class="visible-480"><?php echo $entry_sort_order; ?></label><input type="text" name="banner_image[' + languageId + '][' + image_row + '][sort_order]" value="" class="span1 i-mini" /></td>';
                html += '<td class="column-status"><label class="visible-480"><?php echo $entry_status; ?></label>';
                html += '<select name="banner_image[' + languageId + '][' + image_row + '][status]" class="span2 i-medium">';
                html += '   <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
                html += '   <option value="0"><?php echo $text_disabled; ?></option>';
                html += '</select>';
                html += '</td>';
                html += '<td class="column-action"><a onclick="$(\'#image-row'  + languageId +  '-' + image_row  + '\').remove();" class="btn btn-small"><?php echo $button_remove; ?></a></td>';
                
                html += '</tr>';
                html += '</tbody>'; 

                $('#module tfoot.image-row' + languageId).before(html);

                eval("<?php echo str_replace("\n", ' ', p3html::oc_ckeditor_replace('description££££-$$$$', $token)); ?>".replace("££££",languageId).replace("$$$$",image_row));

        image_row++;
    } 
//--></script>   

<script type="text/javascript"><!--
  $('.showDesc').click(function (e) {
      e.preventDefault();
      $(this).hide().next().show();
  })
//--></script>

<?php echo $footer; ?>