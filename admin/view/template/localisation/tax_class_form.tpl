<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-dollar"></i> <?php echo $heading_title; ?></h1>
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
          <div class="control-group<?php if ($error_title) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_title; ?></label>
            <div class="controls">
							<input type="text" name="title" value="<?php echo $title; ?>" class="span3">
              <?php if ($error_title) { ?>
              <span class="error help-block"><?php echo $error_title; ?></span>
              <?php } ?>
						</div>
          </div>
          <div class="control-group<?php if ($error_description) { ?> error<?php } ?>">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_description; ?></label>
            <div class="controls">
							<input type="text" name="description" value="<?php echo $description; ?>" class="span5">
              <?php if ($error_description) { ?>
              <span class="error help-block"><?php echo $error_description; ?></span>
              <?php } ?>
						</div>
          </div>
        </div>

        <br>

        <table id="tax-rule" class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-number"><?php echo $entry_rate; ?></th>
              <th class="column-name"><?php echo $entry_based; ?></th>
              <th class="column-sort"><?php echo $entry_priority; ?></th>
              <th class="column-action"></th>
            </tr>
          </thead>
					<tbody>
 						<?php $tax_rule_row = 0; ?>
						<?php foreach ($tax_rules as $tax_rule) { ?>
            <tr id="tax-rule-row<?php echo $tax_rule_row; ?>">
              <td class="column-name">
								<select name="tax_rule[<?php echo $tax_rule_row; ?>][tax_rate_id]" class="span3">
									<?php echo p3html::oc_tax_rate_options($tax_rates, $tax_rule);?>
                </select>
							</td>
              <td class="column-name">
								<select name="tax_rule[<?php echo $tax_rule_row; ?>][based]" class="span2">
									<?php echo p3html::oc_tax_rule_options($this->language, $tax_rule, 'based', array('shipping'=>$text_shipping, 'payment'=>$text_payment)); ?>
                </select>
							</td>
              <td class="column-sort">
								<input type="text" name="tax_rule[<?php echo $tax_rule_row; ?>][priority]" value="<?php echo $tax_rule['priority']; ?>" class="input-mini"></td>
              <td class="column-action">
								<a onclick="$('#tax-rule-row<?php echo $tax_rule_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
							</td>
            </tr>
						<?php $tax_rule_row++; ?>
						<?php } ?>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="3"></td>
              <td class="column-action">
								<a onclick="addRule();" class="btn btn-small" title="<?php echo $button_add_rule; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_rule; ?></a>
							</td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>

<script>
var tax_rule_row = <?php echo $tax_rule_row; ?>;

function addRule() {
	html  = '<tr id="tax-rule-row' + tax_rule_row + '">';
	html += '	<td class="column-name"><select name="tax_rule[' + tax_rule_row + '][tax_rate_id]" class="span3">';
	html += '		<?php echo p3html::oc_tax_rate_options($tax_rates, null, true);?>';
	html += '	</select></td>';
	html += '	<td class="column-name"><select name="tax_rule[' + tax_rule_row + '][based]" class="span2">';
	html += '		<?php echo p3html::oc_tax_rule_options($this->language, $tax_rule, 'based', array('shipping'=>$text_shipping, 'payment'=>$text_payment), true); ?>';
	html += '	</select></td>';
	html += '	<td class="column-sort"><input type="text" name="tax_rule[' + tax_rule_row + '][priority]" value="" class="input-mini"></td>';
	html += '	<td class="column-action"><a onclick="$(\'#tax-rule-row' + tax_rule_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
	html += '</tr>';

	$('#tax-rule > tbody').append(html);

	<?php if ($this->config->get('p3adminrebooted_select2')) { ?>
	$('#tax-rule-row' + tax_rule_row + ' select').select2();
	<?php } ?>

	tax_rule_row++;
}
</script>
<?php echo $footer; ?>