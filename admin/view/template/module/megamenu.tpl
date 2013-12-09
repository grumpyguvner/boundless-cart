<?php echo $header; ?>
<div id="content">
<?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

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
  <script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
		<!-- start menu -->  
        <table id="module" class="list table table-striped table-hover">
          <thead>
            <tr>
                <th class="column-name"><?php echo $menu_title; ?></th>
                <th class="column-dropdown"><?php echo $menu_dropdown; ?></th>
                <th class="column-option" style="<?php echo $text_width; ?>45%;"><?php echo $menu_options; ?></th>
                <th class="column-sort"><?php echo $menu_order; ?></th>
                <th class="column-status"><?php echo $entry_status; ?></th>
                <th class="column-action"></th>
            </tr>
          </thead>
          <?php $menu_row = 0; ?>
		  <?php $des_num = 0; ?>
          <?php foreach ($menus as $menu) { ?>
          <tbody id="menu-row<?php echo $menu_row; ?>" style="border-bottom: 2px solid #808080;">
            <tr>
                <td class="column-name">
                    <label class="visible-480"></label>
                    <?php foreach ($languages as $language) { ?>
                        <input name="megamenu_menu[<?php echo $menu_row; ?>][title][<?php echo $language['language_id']; ?>]" value="<?php echo isset($menu['title'][$language['language_id']]) ? $menu['title'][$language['language_id']] : ''; ?>" />
                        
                        <i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i><br>
                    <?php } ?>
               </td>
               
                <!-- title --> 
			 
               
               <!-- dropdown -->
               <td class="column-dropdown">
                    <label class="visible-480"></label>
                    <?php echo $text_width; ?><input type="text" name="megamenu_menu[<?php echo $menu_row; ?>][dropdown_width]" value="<?php echo $menu['dropdown_width']; ?>" class="span1 i-mini" /><br/>
                    <?php echo $text_number_of_columns; ?><input type="text" name="megamenu_menu[<?php echo $menu_row; ?>][dropdown_column]" value="<?php echo $menu['dropdown_column']; ?>" class="span1 i-mini" />
               </td>
			  
			  <!-- options --> 
              <td class="column-option">
                    <label class="visible-480"></label>
                    <!-- bonus hide / show / count option -->
				<div class="right">
				  <a href="#" class="btn btn-small" id="text-hide<?php echo $menu_row; ?>" style="display: none"><?php echo $text_hide; ?></a>
				  <a href="#" class="btn btn-small" id="text-show<?php echo $menu_row; ?>"><?php echo $text_show; ?></a>
				</div>
				<p class="text-menu-row<?php echo $menu_row; ?>" style="text-align: center; font-weight: bold;" ><?php echo count($menu['options']).' '.$text_options; ?></p>
				<!-- end bonus hide / show / count option -->
				
				<div id="frame-menu-row<?php echo $menu_row; ?>" style="display: none;">
			    <?php $opt_row = 0; ?>
				<?php foreach ($menu['options'] as $opt) { ?>
				<div class="count-option<?php echo $menu_row; ?>" id="menu-row<?php echo $menu_row; ?>-opt-row<?php echo $opt_row; ?>" style="border-bottom: 1px solid #DDD;padding: 5px 0;">
				  <span><strong><?php echo $text_option." ".($opt_row + 1); ?></strong></span>
			      <select name="megamenu_menu[<?php echo $menu_row; ?>][options][<?php echo $opt_row; ?>][opt]" onchange="showCustom(this,<?php echo $menu_row; ?>,<?php echo $opt_row; ?>)" class="span2 i-mini">
					<?php if ($opt['opt'] == 'linkto') { ?>
					<option value="linkto" selected="selected"><?php echo $option_linkto; ?></option>
					<?php } else { ?>
					<option value="linkto"><?php echo $option_linkto; ?></option>
					<?php } ?>
					<?php if ($opt['opt'] == 'category') { ?>
					<option value="category" selected="selected"><?php echo $option_category; ?></option>
					<?php } else { ?>
					<option value="category"><?php echo $option_category; ?></option>
					<?php } ?>
					<?php if ($opt['opt'] == 'product') { ?>
					<option value="product" selected="selected"><?php echo $option_product; ?></option>
					<?php } else { ?>
					<option value="product"><?php echo $option_product; ?></option>
					<?php } ?>
					<?php if ($opt['opt'] == 'static_block') { ?>
					<option value="static_block" selected="selected"><?php echo $option_static_block; ?></option>
					<?php } else { ?>
					<option value="static_block"><?php echo $option_static_block; ?></option>
					<?php } ?>
					<?php if ($opt['opt'] == 'manufacturer') { ?>
					<option value="manufacturer" selected="selected"><?php echo $option_manufacturer; ?></option>
					<?php } else { ?>
					<option value="manufacturer"><?php echo $option_manufacturer; ?></option>
					<?php } ?>
					<?php if ($opt['opt'] == 'information') { ?>
					<option value="information" selected="selected"><?php echo $option_information; ?></option>
					<?php } else { ?>
					<option value="information"><?php echo $option_information; ?></option>
					<?php } ?>
                  </select>
				  <span style="margin-left: 20px;"><?php echo $text_fill_the_column ?></span>
				  <input name="megamenu_menu[<?php echo $menu_row; ?>][options][<?php echo $opt_row; ?>][fill_column]" value="<?php echo $opt['fill_column']; ?>" size="3" class="span1 i-mini"/>
				  <i class="btn btn-small icon-trash ims remove" style="float: right;" onclick="$('#menu-row<?php echo $menu_row; ?>-opt-row<?php echo $opt_row; ?>').remove();" title="<?php echo $button_remove_option; ?>"></i> 
				  <div class="divcustom_<?php echo $menu_row; ?><?php echo $opt_row; ?>"></div>
				  <!-- option category -->
				  <?php if ($opt['opt'] == 'category') { ?>
					<div id="opt_category<?php echo $menu_row;?><?php echo $opt_row; ?>" style="padding-left: 50px;">
						<p><span><?php echo $text_show_image; ?></span><select name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_category_show_img]">
						  <?php if ($opt['opt_category_show_img']) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						  <?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						  <?php } ?>
						</select> 
						&nbsp;&nbsp;&nbsp;&nbsp;<span><?php echo $text_w_x_h; ?></span><input type="text" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_category_img_w]" value="<?php echo $opt['opt_category_img_w']; ?>" size="3" /><input type="text" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_category_img_h]" value="<?php echo $opt['opt_category_img_h']; ?>" size="3" /></p>
						<p><span><?php echo $text_show_sub_category; ?></span><select name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_category_show_sub]">
						  <?php if ($opt['opt_category_show_sub']) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						  <?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						  <?php } ?>
						</select></p>
						<p><span><?php echo $text_show_parent_category; ?></span><select name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_category_show_parent]">
						  <?php if ($opt['opt_category_show_parent']) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						  <?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						  <?php } ?>
						</select></p>
						<span><?php echo $text_choose_parent_category; ?></span><div class="scrollbox">
							<div class="odd">
							  <?php if (isset($opt['opt_category_id']) && $opt['opt_category_id'] == 0) { ?>
								<input type="radio" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_category_id]" value="0" checked="checked" />
							  <?php } else { ?>
								<input type="radio" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_category_id]" value="0" />
							  <?php } ?>
							  <?php echo $text_root_category; ?>
							</div>
							<?php $divclass = 'odd'; ?>
							<?php foreach ($categories as $category) { ?>
							  <?php $divclass = ($divclass == 'even' ? 'odd' : 'even'); ?>
							  <div class="<?php echo $divclass; ?>">
							  <?php if (isset($opt['opt_category_id']) && $category['category_id'] == $opt['opt_category_id']) { ?>
								<input type="radio" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_category_id]" value="<?php echo $category['category_id']; ?>" checked="checked" />
							  <?php } else { ?>
								<input type="radio" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_category_id]" value="<?php echo $category['category_id']; ?>" />
							  <?php } ?>
							  <?php echo $category['name']; ?>
							  </div>
							<?php } ?>
						</div>
					</div>
				  <?php } ?>
				  <!-- end option category -->
				  <!-- option link to -->
				  <?php if ($opt['opt'] == 'linkto') { ?>
					<div id="opt_linkto<?php echo $menu_row;?><?php echo $opt_row; ?>" style="padding-left: 50px;">
						<p style="margin: 13px 0;"><span><?php echo $text_homepage_or_other_link; ?></span><input style="<?php echo $text_width; ?>50%;" type="text" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_linkto_link]" value="<?php echo $opt['opt_linkto_link']; ?>" /></p>
					</div>
				  <?php } ?>
				  <!-- end option link to -->
				  <!-- option static block -->
				  <?php if ($opt['opt'] == 'static_block') { ?>
					<div id="opt_static_block<?php echo $menu_row;?><?php echo $opt_row; ?>" style="padding-left: 50px;">
						<p><span><?php echo $text_content; ?></span></p>
                                                <ul id="language-<?php echo $menu_row;?><?php echo $opt_row; ?>" class="htabs nav nav-tabs">
                                                    <?php $langIndex = 0; ?>
                                                    <?php foreach ($languages as $language) { ?>
                                                        <li<?php if ($langIndex == 0) { ?> class="active"<?php } ?>><a href="#tab-language-<?php echo $menu_row;?><?php echo $opt_row; ?>-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                                                        <?php $langIndex++; ?>
                                                    <?php } ?>
                                                </ul>
                                                <div class="tab-content">
                                                    <?php $langIndex = 0; ?>
                                                    <?php foreach ($languages as $language) { ?>
                                                        <div class="tab-pane<?php if ($langIndex == 0) { ?> active<?php } ?>" id="tab-language-<?php echo $menu_row . $opt_row . '-' . $language['language_id']; ?>">
                                                            <div class="form">
                                                                <div id="tab-language-<?php echo $menu_row;?><?php echo $opt_row; ?>-<?php echo $language['language_id']; ?>">
                                                                    <textarea name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_static_block_des][<?php echo $language['language_id']; ?>]" id="description-<?php echo $des_num;?>-<?php echo $language['language_id']; ?>"><?php echo isset($opt['opt_static_block_des'][$language['language_id']]) ? $opt['opt_static_block_des'][$language['language_id']] : ''; ?></textarea>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <?php $langIndex++; ?>
                                                    <?php } ?>
                                                </div>
			
						<script type="text/javascript"><!--
							<?php foreach ($languages as $language) { ?>
								CKEDITOR.replace('description-<?php echo $des_num;?>-<?php echo $language['language_id']; ?>', {
									filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
									filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
									filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
									filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
									filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
								});  
							<?php } ?>
								
							$('#language-<?php echo $menu_row;?><?php echo $opt_row; ?> li a').tabs();

						//--></script>
					</div>
					<?php $des_num++;?>
				  <?php } ?>
				  <!-- end static block -->
				  <!-- option manufacturer -->
				  <?php if ($opt['opt'] == 'manufacturer') { ?>
					<div id="opt_manufacturer<?php echo $menu_row;?><?php echo $opt_row; ?>" style="padding-left: 50px;">
						<p><span><?php echo $text_show_image; ?></span><select name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_manufacturer_img]">
						  <?php if ($opt['opt_manufacturer_img']) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						  <?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						  <?php } ?>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;<span><?php echo $text_w_x_h; ?></span><input type="text" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_manufacturer_img_w]" value="<?php echo $opt['opt_manufacturer_img_w']; ?>" size="3" /><input type="text" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_manufacturer_img_h]" value="<?php echo $opt['opt_manufacturer_img_h']; ?>" size="3" /></p>
						<p><span><?php echo $text_show_name; ?></span><select name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_manufacturer_name]">
						  <?php if ($opt['opt_manufacturer_name']) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						  <?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						  <?php } ?>
						</select></p>
						<span><?php echo $text_choose_manufacturers; ?></span><div class="scrollbox">
							<?php $divclass = 'odd'; ?>
							<?php foreach ($manufacturers as $manufacturer) { ?>
							  <?php $divclass = ($divclass == 'even' ? 'odd' : 'even'); ?>
							  <div class="<?php echo $divclass; ?>">
							  <?php if(isset($opt['opt_manufacturer_ids']) && in_array($manufacturer['manufacturer_id'], $opt['opt_manufacturer_ids'] )) { ?>
								<input type="checkbox" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_manufacturer_ids][]" value="<?php echo $manufacturer['manufacturer_id']; ?>" checked="checked" />
							  <?php } else { ?>
								<input type="checkbox" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_manufacturer_ids][]" value="<?php echo $manufacturer['manufacturer_id']; ?>" />
							  <?php } ?>
							  <?php echo $manufacturer['name']; ?>
							  </div>
							<?php } ?>
						</div>
					</div>
				  <?php } ?>
				  <!-- end option manufacturer -->
				  <!-- option information -->
				  <?php if ($opt['opt'] == 'information') { ?>
					<div id="opt_information<?php echo $menu_row;?><?php echo $opt_row; ?>" style="padding-left: 50px;">
						<p></p><span><?php echo $text_choose_informations; ?></span>
						<div class="scrollbox">
							<?php $divclass = 'odd'; ?>
							<?php foreach ($informations as $information) { ?>
							  <?php $divclass = ($divclass == 'even' ? 'odd' : 'even'); ?>
							  <div class="<?php echo $divclass; ?>">
							  <?php if(isset($opt['opt_information_ids']) && in_array($information['information_id'], $opt['opt_information_ids'] )) { ?>
								<input type="checkbox" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_information_ids][]" value="<?php echo $information['information_id']; ?>" checked="checked" />
							  <?php } else { ?>
								<input type="checkbox" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_information_ids][]" value="<?php echo $information['information_id']; ?>" />
							  <?php } ?>
							  <?php echo $information['title']; ?>
							  </div>
							<?php } ?>
						</div>
					</div>
				  <?php } ?>
				  <!-- end option information -->
				  <!-- option product -->
				  <?php if ($opt['opt'] == 'product') { ?>
					<div id="opt_product<?php echo $menu_row;?><?php echo $opt_row; ?>" style="padding-left: 50px;">
						<p><span><?php echo $text_show_image; ?></span><select name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_product_show_img]">
						  <?php if ($opt['opt_product_show_img']) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						  <?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						  <?php } ?>
						</select> 
						&nbsp;&nbsp;&nbsp;&nbsp;<span><?php echo $text_w_x_h; ?></span><input type="text" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_product_img_w]" value="<?php echo $opt['opt_product_img_w']; ?>" size="3" /><input type="text" name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_product_img_h]" value="<?php echo $opt['opt_product_img_h']; ?>" size="3" /></p>
						<p><span><?php echo $text_products_autocomplete; ?></span><input type="text" name="product_autocomplete<?php echo $menu_row;?><?php echo $opt_row; ?>" /></p>
						<div class="scrollbox" id="product_list<?php echo $menu_row;?><?php echo $opt_row; ?>">
							<?php $divclass = 'odd'; ?>
							<?php foreach ($opt['opt_product_ids'] as $product_id) { ?>
							  <?php $divclass = ($divclass == 'even' ? 'odd' : 'even'); ?>
							  <div class="<?php echo $divclass; ?>" id="product-item<?php echo $menu_row;?><?php echo $opt_row; ?>-<?php echo $product_id; ?>"><?php echo $products_name[$product_id]; ?><img src="view/image/delete.png" /><input name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_product_ids][]" type="hidden" value="<?php echo $product_id; ?>" /></div>
							<?php } ?>
						</div>
						<script type="text/javascript"><!--
							$('input[name=\'product_autocomplete<?php echo $menu_row;?><?php echo $opt_row; ?>\']').autocomplete({
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
									$('#product-item<?php echo $menu_row;?><?php echo $opt_row; ?>-' + ui.item.value).remove();
									
									$('#product_list<?php echo $menu_row;?><?php echo $opt_row; ?>').append('<div id="product-item<?php echo $menu_row;?><?php echo $opt_row; ?>-' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input name="megamenu_menu[<?php echo $menu_row;?>][options][<?php echo $opt_row; ?>][opt_product_ids][]" type="hidden" value="' + ui.item.value + '" /></div>');

									$('#product_list<?php echo $menu_row;?><?php echo $opt_row; ?> div:odd').attr('class', 'odd');
									$('#product_list<?php echo $menu_row;?><?php echo $opt_row; ?> div:even').attr('class', 'even');
									
									return false;
								},
								focus: function(event, ui) {
									return false;
								}
							});
							$('#product_list<?php echo $menu_row;?><?php echo $opt_row; ?> div img').live('click', function() {
								$(this).parent().remove();
								
								$('#product_list<?php echo $menu_row;?><?php echo $opt_row; ?> div:odd').attr('class', 'odd');
								$('#product_list<?php echo $menu_row;?><?php echo $opt_row; ?> div:even').attr('class', 'even');
							});
						//--></script>
					</div>
				  <?php } ?>
				  <!-- end option product -->
				</div>
				<?php $opt_row++; ?>
				<?php } ?>
				<a style="float: right; margin-top: 5px;" onclick="addOption(this,<?php echo $menu_row; ?>, <?php echo $opt_row; ?>);" class="btn btn-small"><?php echo $button_add_option; ?></a>
				</div>	
				<script type="text/javascript"><!--
					$('#text-hide<?php echo $menu_row; ?>').click(function(){
						var n = $(".count-option<?php echo $menu_row; ?>").length;
						$(".text-menu-row<?php echo $menu_row; ?>").text("" + n + "<?php echo " ".$text_options; ?>");
						$('#text-hide<?php echo $menu_row; ?>').hide();
						$('#text-show<?php echo $menu_row; ?>').show();
						$('#frame-menu-row<?php echo $menu_row; ?>').hide();
						$('.text-menu-row<?php echo $menu_row; ?>').show();
						return false;
					});
					$('#text-show<?php echo $menu_row; ?>').click(function(){
						$('#text-show<?php echo $menu_row; ?>').hide();
						$('#text-hide<?php echo $menu_row; ?>').show();
						$('#frame-menu-row<?php echo $menu_row; ?>').show();
						$('.text-menu-row<?php echo $menu_row; ?>').hide();
						return false;
					});
				//--></script>
               </td>
			  <!-- order -->
                <td class="column-sort">
                  <label class="visible-480"><?php echo $entry_sort_order; ?></label>
                  <input type="text" name="megamenu_menu[<?php echo $menu_row; ?>][order]" value="<?php echo $menu['order']; ?>" class="span1 i-mini">
                </td>  
			  <!-- status -->
                <td class="column-status">
                    <label class="visible-480"><?php echo $entry_status; ?></label>
                    <select name="megamenu_menu[<?php echo $menu_row; ?>][status]" class="input-small">
                        <?php echo p3html::oc_status_options($this->language, $menu); ?>
                    </select>
                </td>
                <td class="column-action">
                    <a onclick="$('#menu-row<?php echo $menu_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
                </td>	
            </tr>
          </tbody>
          <?php $menu_row++; ?>
          <?php } ?>
		  <!-- button add menu --> 
          <tfoot>
            <tr>
              <td colspan="5"></td>
              <td class="column-action">
                  <a onclick="addMenu();" class="btn btn-small" title="<?php echo $button_add_menu; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_menu; ?></span></a>
              </td>
            </tr>
          </tfoot>
        </table>	 
        <!-- end menu --> 
    </form>
  </div>
</div>
<script type="text/javascript"><!--
	var menu_row = <?php echo $menu_row; ?>;
	var des_num = <?php echo $des_num;?>;
	// add menu
    function addMenu() {
          html  = '<tbody id="menu-row' + menu_row + '" style="border-bottom: 2px solid #808080;">';
          html += '<tr>';
          html += '<td class="column-name">';
          html += '<label class="visible-480"></label>';
	  <?php foreach ($languages as $language) { ?>
		html += '<input name="megamenu_menu[' + menu_row + '][title][<?php echo $language['language_id']; ?>]" />';
		html += '<i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i><br>';
	  <?php } ?>
	  html += '</td>';
	  html += '<td class="column-dropdown"><label class="visible-480"></label><?php echo $text_width; ?><input type="text" name="megamenu_menu[' + menu_row + '][dropdown_width]" value="960" class="span1 i-mini" />';
	  html += '<br/><?php echo $text_number_of_columns; ?><input type="text" name="megamenu_menu[' + menu_row + '][dropdown_column]" value="6" class="span1 i-mini" /></td>';
	  
          html += '<td class="left">';
	  html += '<div id="menu-row' + menu_row + '-opt-row0" style="border-bottom: 1px solid #DDD;padding: 5px 0;">';
	  html += '<span><strong><?php echo $text_option." 1"; ?></strong></span>';
	  html += '<select name="megamenu_menu[' + menu_row + '][options][0][opt]" onchange="showCustom(this,' + menu_row + ',0)" >';
	  html += '	 <option value="linkto"><?php echo $option_linkto; ?></option>';
	  html += '	 <option value="category"><?php echo $option_category; ?></option>';
	  html += '	 <option value="product"><?php echo $option_product; ?></option>';
	  html += '  <option value="static_block"><?php echo $option_static_block; ?></option>';
	  html += '  <option value="manufacturer"><?php echo $option_manufacturer; ?></option>';
	  html += '  <option value="information"><?php echo $option_information; ?></option>';
	  html += '</select>';
	  html += '<span style="margin-left: 20px;"><?php echo $text_fill_the_column ?></span><input name="megamenu_menu[' + menu_row + '][options][0][fill_column]" value="6" size="3" class="span1 i-mini" />';
	  html += '<i class="btn btn-small icon-trash ims remove" style="float: right;" onclick="$(\'#menu-row' + menu_row  + '-opt-row0\').remove();" title="<?php echo $button_remove_option; ?>"></i>';
          
	  html += '<div class="divcustom_' + menu_row + '0"></div>';
	  html += '<div id="opt_linkto' + menu_row + '0" style="padding-left: 50px;">';
	  html += '<p><span><?php echo $text_homepage_or_other_link; ?></span><input style="<?php echo $text_width; ?>50%;" type="text" name="megamenu_menu[' + menu_row + '][options][0][opt_linkto_link]" value="<?php echo HTTP_CATALOG; ?>" /></p>';
	  html += '</div>'; 
	  html += '</div>';
	  html += '<a style="float: right; margin-top: 5px;" onclick="addOption(this,' + menu_row + ', 1);" class="btn btn-small"><?php echo $button_add_option; ?></a>';
	  html += '</td>';
	  html += '<td class="left"><input type="text" name="megamenu_menu[' + menu_row + '][order]" class="span1 i-mini" /></td>';
	  html += '<td class="left"><select name="megamenu_menu[' + menu_row + '][status]" class="input-small">';
      html += '   <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
      html += '   <option value="0"><?php echo $text_disabled; ?></option>';
      html += '</select></td>';
      html += '<td class="left"><a onclick="$(\'#menu-row' + menu_row  + '\').remove();" class="btn btn-small"><?php echo $button_remove; ?></a></td>';
      html += '</tr>';
      html += '</tbody>'; 
	
      $('#module tfoot').before(html);
	  
      menu_row++;
    }
	// add option
	function addOption(btAdd, opt_menu_row, opt_row) {
	  //opt_row = $('select[name^="megamenu_menu[' + opt_menu_row + '][options]"][name$="[opt]"]').length;
	  
	  html = '<div class="count-option'+opt_menu_row+'" id="menu-row' + opt_menu_row + '-opt-row' + opt_row + '" style="border-bottom: 1px solid #DDD;padding: 5px 0;">';
	  html += '<strong><span><?php echo $text_option; ?> ' + (opt_row + 1) + '</strong> </span>';
	  html += '<select name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt]" onchange="showCustom(this,' + opt_menu_row + ',' + opt_row + ')" class="input-small">';
	  html += '	 <option value="linkto"><?php echo $option_linkto; ?></option>';
	  html += '	 <option value="category"><?php echo $option_category; ?></option>';
	  html += '	 <option value="product"><?php echo $option_product; ?></option>';
	  html += '  <option value="static_block"><?php echo $option_static_block; ?></option>';
	  html += '  <option value="manufacturer"><?php echo $option_manufacturer; ?></option>';
	  html += '  <option value="information"><?php echo $option_information; ?></option>';
	  html += '</select>';
	  html += '<span style="margin-left: 20px;"><?php echo $text_fill_the_column ?></span><input name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][fill_column]" value="6" size="3" class="span1 i-mini"/>';
	  html += '<a style="float: right" onclick="$(\'#menu-row' + opt_menu_row  + '-opt-row' + opt_row + '\').remove();" class="btn btn-small"><?php echo $button_remove_option; ?></a>';
	  html += '<div class="divcustom_' + opt_menu_row + opt_row + '"></div>';
	  html += '<div id="opt_linkto' + opt_menu_row + opt_row +'" style="padding-left: 50px;">';
	  html += '<p style="margin: 13px 0;"><span><?php echo $text_homepage_or_other_link; ?></span><input style="<?php echo $text_width; ?>50%;" type="text" name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_linkto_link]" value="<?php echo HTTP_CATALOG; ?>" /></p>';
	  html += '</div>';
	  html += '</div>';
	  html += '<a style="float: right; margin-top: 5px;" onclick="addOption(this,' + opt_menu_row + ', ' + (opt_row + 1) + ');" class="btn btn-small"><?php echo $button_add_option; ?></a>';

	  $(btAdd).before(html);
	  $(btAdd).remove();
	}
	// show custom
	function showCustom(select, opt_menu_row, opt_row) {
	  $('#opt_category' + opt_menu_row + opt_row).slideUp("normal", function() { $(this).remove(); } );
	  $('#opt_linkto' + opt_menu_row + opt_row).slideUp("normal", function() { $(this).remove(); } );
	  $('#opt_static_block' + opt_menu_row + opt_row).slideUp("normal", function() { $(this).remove(); } );
	  $('#opt_manufacturer' + opt_menu_row + opt_row).slideUp("normal", function() { $(this).remove(); } );
	  $('#opt_information' + opt_menu_row + opt_row).slideUp("normal", function() { $(this).remove(); } );
	  $('#opt_product' + opt_menu_row + opt_row).slideUp("normal", function() { $(this).remove(); } );
	  // show category
	  if (select.options[select.selectedIndex].value == 'category') {
		html = '<div id="opt_category' + opt_menu_row + opt_row + '" style="padding-left: 50px;">';
		html += '<p style="margin: 13px 0;"><span><?php echo $text_show_image; ?></span><select name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_category_show_img]" class="input-small">';
		html += '   <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
		html += '   <option value="0"><?php echo $text_disabled; ?></option>';
		html += '</select>';
		html += '&nbsp;&nbsp;&nbsp;&nbsp;<span><?php echo $text_w_x_h; ?></span><input type="text" name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_category_img_w]" value="45" size="3" class="span1 i-mini" /><input type="text" name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_category_img_h]" value="45" size="3" class="span1 i-mini" /></p>';
		html += '<p style="margin: 13px 0;"><span><?php echo $text_show_sub_category; ?></span><select name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_category_show_sub]" class="input-small">';
		html += '   <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
		html += '   <option value="0"><?php echo $text_disabled; ?></option>';
		html += '</select></p>';
		html += '<p style="margin: 13px 0;"><span><?php echo $text_show_parent_category; ?></span><select name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_category_show_parent]" class="input-small">';
		html += '   <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
		html += '   <option value="0"><?php echo $text_disabled; ?></option>';
		html += '</select></p>';
		html += '<span><?php echo $text_choose_parent_category; ?></span><div class="scrollbox">';
		html += '<div class="even">';
	    html += '<input type="radio" name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_category_id]" value="0" />';
		html += '<?php echo $text_root_category; ?>'
		html += '</div>';
		divclass = 'odd';
		<?php foreach ($categories as $category) { ?>
		  divclass = divclass == 'even' ? 'odd' : 'even';
		  html += '<div class="' + divclass + '">';
		  html += '<input type="radio" name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_category_id]" value="<?php echo $category['category_id']; ?>" />';
		  html += '<?php echo $category['name']; ?>'
		  html += '</div>';
		<?php } ?>
		html += '</div>';
		
		html += '</div>';  
		$('.divcustom_'+ opt_menu_row + opt_row).html(html);
	  }
	  // show link to
	  else if (select.options[select.selectedIndex].value == 'linkto') {
		html = '<div id="opt_linkto' + opt_menu_row + opt_row + '" style="padding-left: 50px;">';
		html += '<p><span><?php echo $text_homepage_or_other_link; ?></span><input style="<?php echo $text_width; ?>50%;" type="text" name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_linkto_link]" value="<?php echo HTTP_CATALOG; ?>" /></p>';
		
		html += '</div>';  
		$('.divcustom_'+ opt_menu_row + opt_row).html(html);
	  }
	  // show static block
	  else if (select.options[select.selectedIndex].value == 'static_block') {
		html  = '<div id="opt_static_block' + opt_menu_row + opt_row + '" style="padding-left: 50px;">';
		html += '  <p><span><?php echo $text_content; ?></span></p>';
		html += '  <ul id="language-' + opt_menu_row + opt_row + '" class="htabs nav nav-tabs">';
                <?php $langIndex = 0; ?>
		<?php foreach ($languages as $language) { ?>
                html += '<li<?php if ($langIndex == 0) { ?> class="active"<?php } ?>><a data-toggle="tab" href="#tab-language-' + opt_menu_row + opt_row + '-<?php echo $language['language_id']; ?>"><i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i> <?php echo $language['name']; ?></a></li>';
                <?php $langIndex++; ?>
                <?php } ?>
                html += '</ul>';
                html += '<div class="tab-content">';
                <?php $langIndex = 0; ?>
                <?php foreach ($languages as $language) { ?>
                html += '<div class="tab-pane<?php if ($langIndex == 0) { ?> active<?php } ?>" id="tab-language-' + opt_menu_row + opt_row + '-<?php echo $language['language_id']; ?>">';
                html += '<div class="form">';
                html += '   <div id="tab-language-' + opt_menu_row + opt_row + '-<?php echo $language['language_id']; ?>">';
                html += '      <textarea name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_static_block_des][<?php echo $language['language_id']; ?>]" id="description-' + des_num + '-<?php echo $language['language_id']; ?>"></textarea>';
		html += '   </div></div></div>';
                <?php $langIndex++; ?>
                <?php } ?>    
                html += '</div>';
		
		$('.divcustom_'+ opt_menu_row + opt_row).html(html);
		
		<?php foreach ($languages as $language) { ?>
		CKEDITOR.replace('description-' + des_num + '-<?php echo $language['language_id']; ?>', {
			filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
		});  
		<?php } ?>
		
		$('#language-' + opt_menu_row + opt_row + ' li a').tabs();
		des_num++;
	  }
	  // show manufacturer
	  else if (select.options[select.selectedIndex].value == 'manufacturer') {
		html = '<div id="opt_manufacturer' + opt_menu_row + opt_row + '" style="padding-left: 50px;">';
		html += '<p style="margin: 13px 0"><span><?php echo $text_show_image; ?></span><select name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_manufacturer_img]" class="input-small">';
		html += '   <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
		html += '   <option value="0"><?php echo $text_disabled; ?></option>';
		html += '</select>';
		html += '&nbsp;&nbsp;&nbsp;&nbsp;<span><?php echo $text_w_x_h; ?></span><input type="text" name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_manufacturer_img_w]" value="45" size="3" class="span1 i-mini" /><input type="text" name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_manufacturer_img_h]" value="45" size="3" class="span1 i-mini" /></p>';
		html += '<p style="margin: 13px 0"><span><?php echo $text_show_name; ?></span><select name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_manufacturer_name]" class="input-small">';
		html += '   <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
		html += '   <option value="0"><?php echo $text_disabled; ?></option>';
		html += '</select></p>';
		html += '<span><?php echo $text_choose_manufacturers; ?></span><div class="scrollbox">';
		divclass = 'odd';
		<?php foreach ($manufacturers as $manufacturer) { ?>
		  divclass = divclass == 'even' ? 'odd' : 'even';
		  html += '<div class="' + divclass + '">';
		  html += '<input type="checkbox" name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_manufacturer_ids][]" value="<?php echo $manufacturer['manufacturer_id']; ?>" />';
		  html += '<?php echo $manufacturer['name']; ?>'
		  html += '</div>';
		<?php } ?>
		html += '</div>';
		
		html += '</div>';  
		$('.divcustom_'+ opt_menu_row + opt_row).html(html);
	  }
	  // show information
	  else if (select.options[select.selectedIndex].value == 'information') {
		html = '<div id="opt_information' + opt_menu_row + opt_row + '" style="padding-left: 50px;">';
		html += '<p></p><span><?php echo $text_choose_informations; ?></span><div class="scrollbox">';
		divclass = 'odd';
		<?php foreach ($informations as $information) { ?>
		  divclass = divclass == 'even' ? 'odd' : 'even';
		  html += '<div class="' + divclass + '">';
		  html += '<input type="checkbox" name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_information_ids][]" value="<?php echo $information['information_id']; ?>" />';
		  html += '<?php echo $information['title']; ?>'
		  html += '</div>';
		<?php } ?>
		html += '</div>';
		
		html += '</div>';  
		$('.divcustom_'+ opt_menu_row + opt_row).html(html);
	  }
	  // show product
	  else if (select.options[select.selectedIndex].value == 'product') {
		html  = '<div id="opt_product' + opt_menu_row + opt_row + '" style="padding-left: 50px;">';
		html += '<p style="margin: 13px 0;"><span><?php echo $text_show_image; ?></span><select name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_product_show_img]" class="input-small">';
		html += '   <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
		html += '   <option value="0"><?php echo $text_disabled; ?></option>';
		html += '</select>';
		html += '&nbsp;&nbsp;&nbsp;&nbsp;<span><?php echo $text_w_x_h; ?></span><input type="text" name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_product_img_w]" value="45" size="3" class="span1 i-mini" /><input type="text" name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_product_img_h]" value="45" size="3" class="span1 i-mini" /></p>';
		html += '<p><span><?php echo $text_products_autocomplete; ?> </span><input type="text" name="product_autocomplete' + opt_menu_row + opt_row + '" /></p>';
		html += '<div class="scrollbox" id="product_list' + opt_menu_row + opt_row + '"></div>';
		html += '</div>';  
		$('.divcustom_'+ opt_menu_row + opt_row).html(html);
		
		$('input[name=\'product_autocomplete' + opt_menu_row + opt_row + '\']').autocomplete({
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
				$('#product-item'+ opt_menu_row + opt_row + '-' + ui.item.value).remove();
				
				$('#product_list' + opt_menu_row + opt_row).append('<div id="product-item' + opt_menu_row + opt_row + '-' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input name="megamenu_menu[' + opt_menu_row + '][options][' + opt_row + '][opt_product_ids][]" type="hidden" value="' + ui.item.value + '" /></div>');

				$('#product_list' + opt_menu_row + opt_row + ' div:odd').attr('class', 'odd');
				$('#product_list' + opt_menu_row + opt_row + ' div:even').attr('class', 'even');
				
				return false;
			},
			focus: function(event, ui) {
				return false;
			}
		});
		$('#product_list'+ opt_menu_row + opt_row + ' div img').live('click', function() {
			$(this).parent().remove();
			
			$('#product_list'+ opt_menu_row + opt_row + ' div:odd').attr('class', 'odd');
			$('#product_list'+ opt_menu_row + opt_row + ' div:even').attr('class', 'even');
		});
	  }
    }

//--></script>
<?php echo $footer; ?>