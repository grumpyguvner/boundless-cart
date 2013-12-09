<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/banner.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
          <table class="form">
              <tr>
                  <td><span class="required">*</span> <?php echo $entry_name; ?></td>
                  <td><input type="text" name="name" value="<?php echo $name; ?>" size="100" />
                      <?php if ($error_name) { ?>
                          <span class="error"><?php echo $error_name; ?></span>
                      <?php } ?></td>
              </tr>
              <tr>
                  <td><?php echo $entry_status; ?></td>
                  <td><select name="status">
                          <?php if ($status) { ?>
                              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                              <option value="0"><?php echo $text_disabled; ?></option>
                          <?php } else { ?>
                              <option value="1"><?php echo $text_enabled; ?></option>
                              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                          <?php } ?>
                      </select></td>
              </tr>
          </table>
<!---------------------------- New Style --------------------------------------------->  
        <div id="languages" class="htabs">
            <?php foreach ($languages as $language) { ?>
                <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
            <?php } ?>
        </div>
        
            <?php $image_row = 0; ?>
        <?php foreach ($languages as $language) { ?>
            <div id="language<?php echo $language['language_id']; ?>">
                <table id="images" class="list">
                    <thead>
                        <tr>
                            <td class="left"><?php echo $entry_title; ?></td>
                            <td class="left"><?php echo $entry_link; ?></td>
                            <td class="left"><?php echo $entry_image; ?></td>
                            <td class="left"><?php echo $entry_sort_order; ?></td>
                            <td class="left"><?php echo $entry_status; ?></td>
                            <td></td>
                        </tr>
                    </thead>
                    
                    <?php if (isset($banner_images[$language['language_id']])) { ?>
                        <?php foreach ($banner_images[$language['language_id']] as $banner_image) { ?>
                            <tbody id="image-row<?php echo $language['language_id'] . '-' . $image_row; ?>">
                                <tr>
                                    <td class="left">
                                        <b><?php echo $entry_title; ?></b>
                                        <input type="text" name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][title]" value="<?php echo isset($banner_image) ? $banner_image['title'] : ''; ?>" />
                                        <!-- Check if it is fine!!! -->
                                        <?php if (isset($error_banner_image[$language['language_id']][$image_row])) { ?>
                                            <span class="error"><?php echo $error_banner_image[$language['language_id']][$image_row]; ?></span>
                                        <?php } ?>
                                        <!-- End Check if it is fine -->    
                                        <br/><br/>
                                        <b><?php echo $entry_description; ?></b>
                                        
                                        <?php if ($banner_image['description']) { ?>
                                        <br/>
                                            <textarea name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][description]" id="description<?php echo $language['language_id'] . '-' . $image_row; ?>"><?php echo isset($banner_image) ? $banner_image['description'] : ''; ?></textarea>                                            
                                        <?php } else { ?>
                                            
                                             <a href="#" class="showDesc"><?php echo $text_show; ?></a>
                                             <div id="textarea-wrap<?php echo $language['language_id'] . '-' . $image_row; ?>" style="display: none">
                                                <textarea name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][description]" id="description<?php echo $language['language_id'] . '-' . $image_row; ?>"><?php echo isset($banner_image) ? $banner_image['description'] : ''; ?></textarea>
                                             </div>
                                        <?php } ?> 
                                        <!-- Check if it is fine!!! -->
                                            <?php if (isset($error_banner_image[$language['language_id']][$image_row])) { ?>
                                                <span class="error"><?php echo $error_banner_image[$language['language_id']][$image_row]; ?></span>
                                            <?php } ?>
                                        <!-- End Check if it is fine -->       
                                    </td>
                                    <td class="left"><input type="text" name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][link]" value="<?php echo $banner_image['link']; ?>" /></td>
                                    <td class="left"><div class="image"><img src="<?php echo $banner_image['thumb']; ?>" alt="" id="thumb<?php echo $image_row; ?>" />
                                            <input type="hidden" name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][image]" value="<?php echo $banner_image['image']; ?>" id="image<?php echo $image_row; ?>"  />
                                            <br />
                                            <a onclick="image_upload('image<?php echo $image_row; ?>', 'thumb<?php echo $image_row; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb<?php echo $image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $image_row; ?>').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
                                    <td><input type="text" name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][sort_order]" value="<?php echo $banner_image['sort_order']; ?>" size="2" /></td>    
                                    <td class="left">
                                        <select name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][status]">
                                            <?php if ($banner_image['status']) { ?>
                                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                                <option value="0"><?php echo $text_disabled; ?></option>
                                            <?php } else { ?>
                                                <option value="1"><?php echo $text_enabled; ?></option>
                                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                            <?php } ?>
                                        </select>
                                    </td>
                                    <td class="left"><a onclick="$('#image-row<?php echo $language['language_id'] . '-' . $image_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
                                </tr>
                            </tbody>
                            <?php $image_row++; ?>
                        <?php } ?>
                    <?php } ?>
                    <tfoot class="image-row<?php echo $language['language_id']; ?>">
                        <tr>
                            <td colspan="5"></td>
                            <td class="left"><a onclick="addImage(<?php echo $language['language_id']; ?>);" class="button"><?php echo $button_add_banner; ?></a></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        <?php } ?>
            
<!------------------------- End New Style -------------------------------------------->
      </form>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript"><!--
    
    myFileBrowser = {
            filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
            filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
    };
    

<?php $image_row = 0; ?>
<?php foreach ($languages as $language) { ?>
    <?php foreach ($banner_images[$language['language_id']] as $banner_image) { ?>    

       CKEDITOR.replace('description<?php echo $language['language_id']; ?>-<?php echo $image_row; ?>', myFileBrowser);

        <?php $image_row++; ?>
    <?php } ?>
<?php } ?>
      
//--></script>
<script type="text/javascript"><!--
var image_row = <?php echo $image_row; ?>;


function addImage(languageId) {
                html  = '<tbody id="image-row'  + languageId +  '-' + image_row + '">';
                html += '<tr>';
                html += '<td class="left">';
                html += '<input type="text" name="banner_image[' + languageId + '][' + image_row + '][title]" value="" />';
                html += '<br />';
                html += '<b><?php echo $entry_description; ?></b>';
                html += '<br /><br />';
                html += '<textarea name="banner_image[' + languageId + '][' + image_row + '][description]" id="description' + languageId + '-' + image_row + '"></textarea>';
                html += '</td>';	
                html += '<td class="left"><input type="text" name="banner_image[' + languageId + '][' + image_row + '][link]" value="" /></td>';            
                html += '<td class="left"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="thumb' + image_row + '" /><input type="hidden" name="banner_image[' + languageId + '][' + image_row + '][image]" value="" id="image' + image_row + '"  /><br /><a onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
                html += '<td><input type="text" name="banner_image[' + languageId + '][' + image_row + '][sort_order]" value="" size="2" /></td>';
                html += '<td class="left">';
                html += '<select name="banner_image[' + languageId + '][' + image_row + '][status]">';
                html += '   <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
                html += '   <option value="0"><?php echo $text_disabled; ?></option>';
                html += '</select>';
                html += '</td>';
                html += '<td class="left"><a onclick="$(\'#image-row'  + languageId +  '-' + image_row  + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
                html += '</tr>';
                html += '</tbody>'; 

                $('#images tfoot.image-row' + languageId).before(html);
                
                eval("CKEDITOR.replace('description££££-$$$$', myFileBrowser);".replace("££££",languageId).replace("$$$$",image_row));

                image_row++;
      } 
//--></script>
<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(data) {
						$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 700,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script>
<script type="text/javascript"><!--
$('#tabs a').tabs(); 
$('#languages a').tabs();
//--></script> 

<script type="text/javascript"><!--
  $('.showDesc').click(function (e) {
      e.preventDefault();
      $(this).hide().next().show();
  })
//--></script>
<?php echo $footer; ?>