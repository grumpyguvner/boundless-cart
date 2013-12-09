<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-globe"></i> <?php echo $heading_title; ?></h1>
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
          <div class="control-group<?php if ($error_description) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_description; ?></label>
            <div class="controls">
							<input type="text" name="description" value="<?php echo $description; ?>" class="span3">
              <?php if ($error_description) { ?>
              <span class="error help-block"><?php echo $error_description; ?></span>
              <?php } ?>
						</div>
          </div>
        </div>

        <br>

        <table id="zone-to-geo-zone" class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-name"><?php echo $entry_country; ?></th>
              <th class="column-name"><?php echo $entry_zone; ?></th>
              <th class="column-action"></th>
            </tr>
          </thead>
					<tbody>
						<?php $zone_to_geo_zone_row = 0; ?>
						<?php foreach ($zone_to_geo_zones as $zone_to_geo_zone) { ?>
						<tr id="zone-to-geo-zone-row<?php echo $zone_to_geo_zone_row; ?>">
              <td class="column-name">
								<select name="zone_to_geo_zone[<?php echo $zone_to_geo_zone_row; ?>][country_id]" id="country<?php echo $zone_to_geo_zone_row; ?>"
									class="span3">
									<?php echo p3html::oc_country_options($countries, $zone_to_geo_zone); ?>
                </select>
							</td>
              <td class="column-name">
								<select name="zone_to_geo_zone[<?php echo $zone_to_geo_zone_row; ?>][zone_id]" id="zone<?php echo $zone_to_geo_zone_row; ?>" class="span3">
                </select>
							</td>
              <td class="column-action">
								<a onclick="$('#zone-to-geo-zone-row<?php echo $zone_to_geo_zone_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
							</td>
            </tr>
						<?php $zone_to_geo_zone_row++; ?>
						<?php } ?>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="2"></td>
              <td class="column-action">
								<a onclick="addGeoZone();" class="btn btn-small" title="<?php echo $button_add_geo_zone; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_geo_zone; ?></a>
							</td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>

<!--<script>
$('#zone-id').load('index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=' + $('#country-id').attr('value') + '&zone_id=0');
</script>-->

<script>
jQuery(document).ready(function($){

	$(document).on('change', 'select[name*="country_id"]', function(){
		var country_id = $(this).val();
		var zone_select = $(this).closest('tr').find('select[name*="zone_id"]');
		zone_select.load('index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=' + country_id + '&zone_id=0', function(){
			$(this).trigger('change');
		});
	});

	<?php $zone_to_geo_zone_row = 0; ?>
	<?php foreach ($zone_to_geo_zones as $zone_to_geo_zone) { ?>
	$('#zone<?php echo $zone_to_geo_zone_row; ?>').load('index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=<?php echo $zone_to_geo_zone['country_id']; ?>&zone_id=<?php echo $zone_to_geo_zone['zone_id']; ?>', function(){
		$(this).trigger('change');
	});
	<?php $zone_to_geo_zone_row++; ?>
	<?php } ?>
});
</script>

<script>
var zone_to_geo_zone_row = <?php echo $zone_to_geo_zone_row; ?>;

function addGeoZone() {
	html  = '<tr id="zone-to-geo-zone-row' + zone_to_geo_zone_row + '">';
	html += '	<td class="column-name"><select name="zone_to_geo_zone[' + zone_to_geo_zone_row + '][country_id]" id="country' + zone_to_geo_zone_row + '" class="span3">';
	html += '		<?php echo p3html::oc_country_options($countries, null, true); ?>';
	html += '	</select></td>';
	html += '	<td class="column-name"><select name="zone_to_geo_zone[' + zone_to_geo_zone_row + '][zone_id]" id="zone' + zone_to_geo_zone_row + '" class="span3"></select></td>';
	html += '	<td class="column-action"><a onclick="$(\'#zone-to-geo-zone-row' + zone_to_geo_zone_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
	html += '</tr>';

	$('#zone-to-geo-zone > tbody').append(html);

	$('#zone' + zone_to_geo_zone_row).load('index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=' + $('#country' + zone_to_geo_zone_row).attr('value') + '&zone_id=0', function(){
		<?php if ($this->config->get('p3adminrebooted_select2')) { ?>
		$(this).closest('tr').find('select').select2();
		$(this).trigger('change');
		<?php } ?>
	});

	zone_to_geo_zone_row++;
}
</script>

<?php echo $footer; ?>