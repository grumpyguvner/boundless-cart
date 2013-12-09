<?php echo $header; ?>
<div id="content">
  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">
    <div class="heading">
      <h1><i class="icon-info"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
			<?php if ($success) { ?>
				<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_insert($button_insert, $insert); ?>
				<?php echo p3html::tb_form_button_delete($button_delete, '#form'); ?>
			</div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
          <table class="list table table-striped table-hover">
              <thead>
                  <tr>
                      <th class="column-checkbox">
                          <input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);">
                      </th>
                      <th class="column-name">
                          <?php if ($sort == 'id.title') { ?>
                              <a href="<?php echo $sort_title; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_title; ?></a>
                          <?php } else { ?>
                              <a href="<?php echo $sort_title; ?>"><?php echo $column_title; ?></a>
                          <?php } ?>
                      </th>
                      <th class="column-sort"><?php if ($sort == 'i.sort_order') { ?>
                              <a href="<?php echo $sort_sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_sort_order; ?></a>
                          <?php } else { ?>
                              <a href="<?php echo $sort_sort_order; ?>"><?php echo $column_sort_order; ?></a>
                          <?php } ?>
                      </th>
                      <th class="column-action"><?php echo $column_action; ?></th>
                  </tr>
              </thead>
              <tbody>
                  
                  <?php if ($events) { ?>
                      <?php foreach ($events as $event) { ?>
                          <tr>
                              <td class="column-checkbox" style="text-align: center;">
                                <input type="checkbox" name="selected[]" value="<?php echo $event['event_id']; ?>"<?php if ($event['selected']) { ?> checked="checked"<?php } ?>>
                              </td>
                              <td class="column-name"><?php echo $event['title']; ?></td>
                              <td class="column-sort"><?php echo $event['sort_order']; ?></td>
                              <td class="column-action">[ <a href="<?php echo $subscribers_href; ?>&event_id=<?php echo $event['event_id']; ?>"><?php echo $subscribers ?></a> ]
                                  <?php foreach ($event['action'] as $action) { ?>
                                      [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                                  <?php } ?>
                              </td>
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
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>