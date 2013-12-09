<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">
    <div class="heading">
      <h1><i class="icon-layout"></i> <?php echo $heading_title; ?></h1>
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
							<input type="text" name="name" value="<?php echo $name; ?>" class="span3">
              <?php if ($error_name) { ?>
              <span class="error help-block"><?php echo $error_name; ?></span>
              <?php } ?>
						</div>
          </div>
        </div>

        <table id="route" class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-name"><?php echo $entry_store; ?></th>
              <th class="column-name"><?php echo $entry_route; ?></th>
              <th class="column-action"></th>
            </tr>
          </thead>
					<tbody>
		        <?php $route_row = 0; ?>
			      <?php foreach ($layout_routes as $layout_route) { ?>
	          <tr id="route-row<?php echo $route_row; ?>">
              <td class="column-name">
								<select name="layout_route[<?php echo $route_row; ?>][store_id]" class="span2 i-medium">
                  <option value="0"><?php echo $text_default; ?></option>
									<?php echo p3html::oc_store_options($stores, $layout_route); ?>
                </select>
							</td>
              <td class="column-name"><input type="text" name="layout_route[<?php echo $route_row; ?>][route]" value="<?php echo $layout_route['route']; ?>" class="input-xxlarge"></td>
              <td class="column-action"><a onclick="$('#route-row<?php echo $route_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>
            </tr>
						<?php $route_row++; ?>
						<?php } ?>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="2"></td>
              <td class="column-action"><a onclick="addRoute();" class="btn btn-small" title="<?php echo $button_add_route; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_route; ?></a></td>
            </tr>
          </tfoot>
        </table>

      </form>
    </div>

  </div>
</div>
<script>
var route_row = <?php echo $route_row; ?>;

function addRoute() {
	html  = '<tr id="route-row' + route_row + '">';
	html += '	<td class="column-name"><select name="layout_route[' + route_row + '][store_id]" class="span2 i-medium">';
	html += '		<option value="0"><?php echo $text_default; ?></option>';
	html += '		<?php echo p3html::oc_store_options($stores, null, true); ?>';
	html += '	</select></td>';
	html += '	<td class="column-name"><input type="text" name="layout_route[' + route_row + '][route]" value="" class="input-xxlarge"></td>';
	html += '	<td class="column-action"><a onclick="$(\'#route-row' + route_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
	html += '</tr>';

	$('#route > tbody').append(html);

	<?php if ($this->config->get('p3adminrebooted_select2')) { ?>
	$('#route-row' + route_row + ' select').select2();
	<?php } ?>

	route_row++;
}
</script>
<?php echo $footer; ?>