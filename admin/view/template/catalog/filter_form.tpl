<?php echo $header; ?>
<div id="content">
    
    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>
  
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
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
          
        <div class="form">
          <div class="control-group<?php if ($error_name[$language['language_id']]) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_group; ?></label>
            <div class="controls">
                <?php foreach ($languages as $language) { ?>
                    <input type="text" name="filter_group_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($filter_group_description[$language['language_id']]) ? $filter_group_description[$language['language_id']]['name'] : ''; ?>" />
                    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
                <?php } ?>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls">
                <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="1" class="span1" />
            </div>
          </div>
        </div>

        <br>
        
        
        <table id="module" class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-name"><span class="required">*</span><?php echo $entry_name; ?></th>
              <th class="column-sort"><?php echo $entry_sort_order; ?></th>
              <th class="column-action"></th>
            </tr>
          </thead> 
          <?php $filter_row = 0; ?>
          <?php foreach ($filters as $filter) { ?>
          <tbody id="filter-row<?php echo $filter_row; ?>">
            <tr>
                <td class="column-name">
                    <label class="visible-480"><?php echo $entry_name; ?></label>
                    <input type="hidden" name="filter[<?php echo $filter_row; ?>][filter_id]" value="<?php echo $filter['filter_id']; ?>" />
                    <?php foreach ($languages as $language) { ?>
                        <input type="text" name="filter[<?php echo $filter_row; ?>][filter_description][<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($filter['filter_description'][$language['language_id']]) ? $filter['filter_description'][$language['language_id']]['name'] : ''; ?>" />
                        <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
                        <?php if (isset($error_filter[$filter_row][$language['language_id']])) { ?>
                            <span class="error"><?php echo $error_filter[$filter_row][$language['language_id']]; ?></span>
                        <?php } ?>
                    <?php } ?>
                </td>
                <td class="column-sort">
                    <label class="visible-480"><?php echo $entry_sort_order; ?></label>
                    <input type="text" name="filter[<?php echo $filter_row; ?>][sort_order]" value="<?php echo $filter['sort_order']; ?>" size="1" class="span1" /></td>
                <td class="column-action">
                    <a onclick="$('#filter-row<?php echo $filter_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
                </td>
            </tr>
          </tbody>
          <?php $filter_row++; ?>
          <?php } ?>
          <tfoot>
            <tr>
              <td colspan="2"></td>
              <td class="left"><a onclick="addFilter();" class="btn btn-small"><?php echo $button_add_filter; ?></a></td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var filter_row = <?php echo $filter_row; ?>;

function addFilter() {
	html  = '<tbody id="filter-row' + filter_row + '">';
	html += '  <tr>';	
    html += '    <td class="column-name"><input type="hidden" name="filter[' + filter_row + '][filter_id]" value="" />';
	<?php foreach ($languages as $language) { ?>
	html += '    <input type="text" name="filter[' + filter_row + '][filter_description][<?php echo $language['language_id']; ?>][name]" value="" /> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />';
    <?php } ?>
	html += '    </td>';
	html += '    <td class="column-sort"><input type="text" name="filter[' + filter_row + '][sort_order]" value="" size="1" class="span1" /></td>';
	html += '     <td class="column-action"><a onclick="$(\'#filter-row' + filter_row + '\').remove();" class="btn btn-small"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';	
    html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	filter_row++;
}
//--></script> 
<?php echo $footer; ?>