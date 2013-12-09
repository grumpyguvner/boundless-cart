<?php echo $header; ?>
<div id="content">
  
    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
    
    <?php echo $newspanel; ?>
  <br />
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/ncategory.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
          <a onclick="location = '<?php echo $insert; ?>'" class="btn btn-small"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_insert; ?></span></a>
          <a onclick="$('form').submit();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_delete; ?>"></i><span class="hidden-phone"> <?php echo $button_delete; ?></span></a>
      </div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
        <table id="module" class="list table table-striped table-hover">
          <thead>
            <tr>
              <th width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></th>
              <th class="column-name"><?php echo $column_name; ?></th>
              <th class="column-sort"><?php echo $entry_sort_order; ?></th>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php if ($ncategories) { ?>
            <?php foreach ($ncategories as $ncategory) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($ncategory['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $ncategory['ncategory_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $ncategory['ncategory_id']; ?>" />
                <?php } ?></td>
              <td class="column-name"><label class="visible-480"><?php echo $column_name; ?></label><?php echo $ncategory['name']; ?></td>
              <td class="column-sort"><label class="visible-480"><?php echo $entry_sort_order; ?></label><?php echo $ncategory['sort_order']; ?></td>
              <td class="column-action"><label class="visible-480"><?php echo $column_action; ?></label><?php foreach ($ncategory['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>