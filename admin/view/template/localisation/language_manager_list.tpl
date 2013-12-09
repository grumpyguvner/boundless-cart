<?php echo $header; ?>
<div id="content">
  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">
    <div class="heading">
      <h1><i class="icon-flag"></i> <?php echo $heading_title; ?></h1>
            <?php if ($error_warning) { ?>
                    <?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
            <?php } ?>
            <?php if ($success) { ?>
                    <?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
            <?php } ?>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-name"><?php echo p3html::tb_sort_heading($column_name, 'name'); ?></th> 
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php if ($language_files) { ?>
            <?php foreach ($language_files as $language_file) { ?>
            <tr>
              <td class="column-name"><?php echo $language_file['file']; ?></td>
              <td class="column-action"><?php echo p3html::tb_action_buttons($language_file); ?></td>
              
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="5"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>