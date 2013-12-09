<?php echo $header; ?>

<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <div class="box">

        <div class="heading">
            <h1><i class="icon-user"></i> <?php echo $heading_title; ?></h1>
            <?php if ($error_warning) { ?>
                <?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
            <?php } ?>
            <?php if ($success) { ?>
                <?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
            <?php } ?>
            <div class="buttons form-actions form-actions-top">
                <?php echo p3html::tb_form_button_insert($button_insert, $insert); ?>
                <?php echo p3html::tb_form_button_delete($button_delete); ?>
            </div>
        </div>

        <div class="content">

            <?php if ($users) { ?>
                <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
                    <table class="list table table-striped table-hover">
                        <thead>
                            <tr>
                                <th class="column-checkbox">
                                    <input type="checkbox" onclick="$('input[name*=\"selected\"]').attr('checked', this.checked);">
                                </th>
                                <th class="column-name">
                                    <?php echo p3html::tb_sort_heading($column_username, $sort_username, $sort, $order, 'username'); ?>
                                </th>  
                                <th class="column-user-group hidden-phone">
                                    <?php echo p3html::tb_sort_heading($column_user_group, $sort_user_group, $sort, $order, 'user_group'); ?>
                                </th>
                                <th class="column-status">
                                    <?php echo p3html::tb_sort_heading($column_status, $sort_status, $sort, $order, 'status'); ?>
                                </th>
                                <th class="column-date hidden-phone">
                                    <?php echo p3html::tb_sort_heading($column_date_added, $sort_date_added, $sort, $order, 'date_added'); ?>
                                </th>
                                <th class="column-action"><?php echo $column_action; ?></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($users as $user) { ?>
                                <tr>
                                    <td style="text-align: center;"><?php if ($user['superuser'] && !$this->user->isSuperuser()) { ?>
                                    &nbsp;
                                    <?php } else { ?>
                                        <input type="checkbox" name="selected[]" value="<?php echo $user['user_id']; ?>"<?php if ($user['selected']) { ?> checked="checked"<?php } ?>>
                                    <?php } ?></td>
                                    <td class="column-name"><?php echo $user['username']; ?></td>
                                    <td class="column-user-group hidden-phone"><?php echo $user['user_group']; ?></td>
                                    <td class="column-status">
                                        <?php //echo $user['status']; ?>
                                        <?php $status = $user['status'] == $this->language->get('text_enabled'); ?>
                                        <?php // echo p3html::tb_bool_icon($status); ?>
                                        <?php echo p3html::tb_status_label($status, $user['status']); ?>
                                    </td>
                                    <td class="column-date hidden-phone"><?php echo $user['date_added']; ?></td>
                                    <td class="column-action">
                                        <?php echo p3html::tb_action_buttons($user); ?>
                                    </td>
                                </tr>
                            <?php } ?>
                        </tbody>
                    </table>
                </form>
                <div class="pagination"><?php echo $pagination; ?></div>
            <?php } else { ?>
                <?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
            <?php } ?>

        </div>

    </div>

</div>

<?php echo $footer; ?>