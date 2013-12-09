<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-star"></i> <?php echo $heading_title; ?></h1>

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
          <div class="control-group">
            <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
						<?php foreach ($languages as $language) { ?>
            <div class="controls language-row<?php if (isset($error_name[$language['language_id']])) { ?> error<?php } ?>">
              <input type="text" name="attribute_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($attribute_description[$language['language_id']]) ? $attribute_description[$language['language_id']]['name'] : ''; ?>" class="span3 i-xlarge">
              <i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i>
              <?php if (isset($error_name[$language['language_id']])) { ?>
              <span class="error help-block"><?php echo $error_name[$language['language_id']]; ?></span>
              <?php } ?>
						</div>
						<?php } ?>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_attribute_group; ?></label>
            <div class="controls">
							<select name="attribute_group_id" class="span3 i-xlarge">
                <?php foreach ($attribute_groups as $attribute_group) { ?>
                <option value="<?php echo $attribute_group['attribute_group_id']; ?>"<?php if ($attribute_group['attribute_group_id'] == $attribute_group_id) { ?> selected="selected"<?php } ?>><?php echo $attribute_group['name']; ?></option>
                <?php } ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_sort_order; ?></label>
            <div class="controls"><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" class="input-mini"></div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>