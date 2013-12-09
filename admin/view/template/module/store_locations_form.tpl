<?php echo $header; ?>
<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
  <div class="heading">
        <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
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
    <div>
      <table id="module" class="list table table-striped table-hover">
        <tr>
          <td><?php echo $store_loc_name; ?></td>
          <td><input type="text" id="Name" name="Name" value="<?php echo $Name ?>" style="width:180px" /></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_detail; ?></td>
          <td><textarea id="Details" name="Details" cols="20" rows="3"><?php echo $Details ?></textarea></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_address; ?></td>
          <td><textarea id="Address" name="Address" cols="20" rows="3"><?php echo $Address; ?></textarea><span><input type="checkbox" name="gCodeReq" id="gCodeReq" <?php echo $edit; ?>  />&nbsp;<?php echo $store_loc_gcode_req ?></span></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_latlon; ?></td>
          <td><?php echo $lat; ?>, <?php echo $lon; ?></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_email; ?></td>
          <td><input type="text" id="Email" value="<?php echo $Email; ?>" name="Email" /></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_website; ?></td>
          <td><input type="text" id="Website" name="Website" value="<?php echo $Website ?>" /></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_phone; ?></td>
          <td><input type="text" id="Phone" name="Phone" value="<?php echo $Phone; ?>"  /></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_offers; ?></td>
          <td><input type="text" name="SpecialOffers" value="<?php echo $SpecialOffers; ?>" /></td>
        </tr>
        <tr>
          <td><?php echo $store_loc_timing; ?></td>
          <td><input type="text" name="Timing" value="<?php echo $Timing; ?>" /></td>
        </tr>
        <tr>
          <td><?php echo $entry_sort_order; ?></td>
          <td><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" /></td>
        </tr>
      </table>
      </div>
      <div id="tab-image">
          <table id="images" class="list table table-striped table-hover">
            <thead>
              <tr>
                <th class="column-loc-image"><?php echo $store_loc_image; ?></th>
                <th class="column-sort"><?php echo $entry_sort_order; ?></th>
                <th class="column-action"></th>
              </tr>
            </thead>
            <?php $image_row = 0; ?>
            <?php foreach ($location_images as $location_image) { ?>
            <tbody id="image-row<?php echo $image_row; ?>">
              <tr>
                <td class="column-loc-image">
                    <div class="image"><img src="<?php echo $location_image['thumb']; ?>" alt="" id="thumb<?php echo $image_row; ?>" />
                    <input type="hidden" name="location_image[<?php echo $image_row; ?>][image]" value="<?php echo $location_image['image']; ?>" id="image<?php echo $image_row; ?>" />
                    <br />
                    <a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('image<?php echo $image_row; ?>', 'thumb<?php echo $image_row; ?>');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <a class="btn" title="<?php echo $text_clear; ?>" onclick="$('#thumb<?php echo $image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $image_row; ?>').attr('value', '');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>
                    </div>
                    
                    
                </td>
                <td class="column-sort"><input type="text" name="location_image[<?php echo $image_row; ?>][sort_order]" value="<?php echo $location_image['sort_order']; ?>" size="2" class="span1 i-mini" /></td>
                <td class="column-action"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>
              </tr>
            </tbody>
            <?php $image_row++; ?>
            <?php } ?>
            <tfoot>
              <tr>
                <td colspan="2"></td>
                <td class="column-action"><a onclick="addImage();" class="btn btn-small"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_image; ?></span></a></td>
              </tr>
            </tfoot>
          </table>
        </div>
    </form>
  </div>
</div>
<script src="<?php echo P3_CKEDITOR_DIR; ?>/ckeditor.js"></script>

<script>
        <?php echo p3html::oc_ckeditor_replace('Details', $token); ?>
</script> 
<script type="text/javascript">

	
	var image_row = <?php echo $image_row; ?>;
	function addImage() {
		html  = '<tbody id="image-row' + image_row + '">';
		html += '  <tr>';
		html += '    <td class="column-loc-image"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="thumb' + image_row + '" /><input type="hidden" name="location_image[' + image_row + '][image]" value="" id="image' + image_row + '" /><br /><a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a class="btn" title="<?php echo $text_browse; ?>" onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a></div></td>';
		html += '    <td class="column-sort"><input type="text" name="location_image[' + image_row + '][sort_order]" value="0" class="span1 i-mini" /></td>';
		html += '    <td class="column-action"><a onclick="$(\'#image-row' + image_row  + '\').remove();" class="btn btn-small"><i class="icon-trash ims"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
		html += '  </tr>';
		html += '</tbody>';
		
		$('#images tfoot').before(html);
		
		image_row++;
	}
</script> 

<!--FILEMANAGER-->
<?php include_once DIR_TEMPLATE . 'javascript/filemanager_dialog.tpl'; ?>
<!--FILEMANAGER-->

<?php echo $footer; ?>