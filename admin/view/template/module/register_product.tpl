<?php echo $header; ?>
<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>


    <div class="box">
        <div class="heading">
            <h1><i class="icon-cog"></i> <?php echo $heading_title; ?></h1>
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
                <li class="active"><a data-toggle="tab" href="#tab-module"><?php echo $tab_modules; ?></a></li>                
            </ul>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                <div class="tab-content">
                    <div class="tab-pane active" id="tab-module">
                        <table id="module" class="list table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="column-store"><?php echo $entry_store; ?></th>
                                    <th class="column-layout"><?php echo $entry_layout; ?></th>
                                    <th class="column-position"><?php echo $entry_position; ?></th>
                                    <th class="column-status"><?php echo $entry_status; ?></th>
                                    <th class="column-sort"><?php echo $entry_sort_order; ?></th>
                                    <th class="column-action"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $module_row = 0; ?>
                                    <?php foreach ($modules as $module) { ?>
                                        <tr id="module-row<?php echo $module_row; ?>">
                                           
                                        <td class="column-store">
                                            <label class="visible-480"><?php echo $entry_store; ?></label>
                                            <select name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][store_id]" class="span2 i-medium">
                                                <option value="0"><?php echo $text_default; ?></option>
                                                <?php foreach ($stores as $store) { ?>
                                                <?php if ($store['store_id'] == $module['store_id']) { ?>
                                                <option value="<?php echo $store['store_id']; ?>" selected="selected"><?php echo $store['name']; ?></option>
                                                <?php } else { ?>
                                                <option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
                                                <?php } ?>
                                                <?php } ?>
                                            </select>
                                        </td>
                                        <td class="column-layout">
                                            <label class="visible-480"><?php echo $entry_layout; ?></label>
                                            <select name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][layout_id]" class="span2 i-medium">
                                                <?php echo p3html::oc_layout_options($layouts, $module); ?>
                                            </select>
                                        </td>
                                        <td class="column-position">
                                            <label class="visible-480"><?php echo $entry_position; ?></label>
                                            <select name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][position]" class="span2 i-medium">
                                                <?php echo p3html::oc_position_options($this->language, $module); ?>
                                            </select>
                                        </td>
                                        <td class="column-status">
                                            <label class="visible-480"><?php echo $entry_status; ?></label>
                                            <select name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][status]" class="input-small">
                                                <?php echo p3html::oc_status_options($this->language, $module); ?>
                                            </select>
                                        </td>
                                        <td class="column-sort">
                                            <label class="visible-480"><?php echo $entry_sort_order; ?></label>
                                            <input type="text" name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" class="span1 i-mini">
                                        </td>
                                        
                                        <td class="column-action">
                                            <a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
                                        </td>
                                    </tr>
                                    <?php $module_row++; ?>
                                <?php } ?>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="5"></td>
                                    <td class="column-action"><a onclick="addModule();" class="btn btn-small" title="<?php echo $button_add_module; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_module; ?></span></a></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
                <div class="pagination">
                    <div class="buttons"><a onclick="location='<?php echo $export; ?>'" class="button btn"><span><?php echo $button_export; ?></span></a></div>
                </div>


            </form>
        </div>
    </div>

    <script type="text/javascript"><!--
        var module_row = <?php echo $module_row; ?>;

        function addModule() {
            html  = '<tr id="module-row' + module_row + '">';
            html += '  <tr>';
            html += '    <td class="column-store"><select name="<?php echo $classname; ?>_module[' + module_row + '][store_id]" class="span2 i-medium">';
            html += '    <option value="0"><?php echo $text_default; ?></option>';
            <?php foreach ($stores as $store) { ?>
            html += '      <option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>';
            <?php } ?>
            html += '    </select></td>';
            html += '	<td class="column-layout">';
            html += '		<label class="visible-480"><?php echo addslashes($entry_layout); ?></label>';
            html += '		<select name="<?php echo $classname; ?>_module[' + module_row + '][layout_id]" class="span2 i-medium">';
            html += '			<?php echo p3html::oc_layout_options($layouts, null, true); ?>';
            html += '		</select>';
            html += '	</td>';
            html += '	<td class="column-position">';
            html += '		<label class="visible-480"><?php echo addslashes($entry_layout); ?></label>';
            html += '		<select name="<?php echo $classname; ?>_module[' + module_row + '][position]" class="span2 i-medium">';
            html += '			<?php echo p3html::oc_position_options($this->language); ?>';
            html += '		</select>';
            html += '	</td>';
            html += '	<td class="column-status">';
            html += '		<label class="visible-480"><?php echo addslashes($entry_status); ?></label>';
            html += '		<select name="<?php echo $classname; ?>_module[' + module_row + '][status]" class="input-small">';
            html += '			<?php echo p3html::oc_status_options($this->language, null, true); ?>';
            html += '		</select>';
            html += '	</td>';
            html += '	<td class="column-sort"><label class="visible-480"><?php echo addslashes($entry_sort_order); ?></label><input type="text" name="account_module[' + module_row + '][sort_order]" value="" class="span1 i-mini"></td>';
            html += '	<td class="column-action"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
            html += '  </tr>';
            html += '</tbody>';

                    $('#module tfoot').before(html);

                    <?php if ($this->config->get('p3adminrebooted_select2')) { ?>
                        $('#module-row' + module_row + ' select').select2();
                    <?php } ?>

                    module_row++;
                }
                //--></script>

<script type="text/javascript"><!--
    $('.htabs a').tabs();
    $('#button-col').attr('colspan', $('#module thead tr td').length-1);
    $('#emails').load('index.php?route=module/register_product/autocomplete&token=<?php echo $token; ?>&filter=' + escape($('#filter').val()));
    //-->
</script>
    <?php echo $footer; ?>