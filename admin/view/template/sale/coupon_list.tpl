<?php echo $header; ?>

<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <div class="box">

        <div class="heading">
            <h1><i class="icon-ticket"></i> <?php echo $heading_title; ?></h1>
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

            <?php if ($coupons) { ?>
                <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
                    <table class="list table table-striped table-hover">
                        <thead>
                            <tr>
                                <th class="column-checkbox">
                                    <input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);">
                                </th>
                                <th class="column-name">
                                    <?php echo p3html::tb_sort_heading($column_name, $sort_name, $sort, $order, 'cd.name'); ?>
                                </th>
                                <th class="column-code hidden-phone">
                                    <?php echo p3html::tb_sort_heading($column_code, $sort_code, $sort, $order, 'c.code'); ?>
                                </th>
                                <th class="column-price hidden-phone">
                                    <?php echo p3html::tb_sort_heading($column_discount, $sort_discount, $sort, $order, 'c.discount'); ?>
                                </th>
                                <th class="column-date hidden-phone">
                                    <?php echo p3html::tb_sort_heading($column_date_start, $sort_date_start, $sort, $order, 'c.date_start'); ?>
                                </th>
                                <th class="column-date hidden-phone">
                                    <?php echo p3html::tb_sort_heading($column_date_end, $sort_date_end, $sort, $order, 'c.date_end'); ?>
                                </th>
                                <th class="column-status">
                                    <?php echo p3html::tb_sort_heading($column_status, $sort_status, $sort, $order, 'c.status'); ?>
                                </th>
                                <th class="column-action"><?php echo $column_action; ?></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($coupons as $coupon) { ?>
                                <tr>
                                    <td class="column-checkbox">
                                        <input type="checkbox" name="selected[]" value="<?php echo $coupon['coupon_id']; ?>"<?php if ($coupon['selected']) { ?> checked="checked"<?php } ?>>
                                    </td>
                                    <td class="column-name"><?php echo $coupon['name']; ?></td>
                                    <td class="column-code hidden-phone"><?php echo $coupon['code']; ?></td>
                                    <td class="column-price hidden-phone"><?php echo $coupon['discount']; ?></td>
                                    <td class="column-date hidden-phone"><?php echo $coupon['date_start']; ?></td>
                                    <td class="column-date hidden-phone"><?php echo $coupon['date_end']; ?></td>
                                    <td class="column-status">
                                        <?php $status = ($coupon['status'] == $this->language->get('text_enabled')) ?>
                                        <?php echo p3html::tb_status_label($status, $coupon['status']); ?>
                                    </td>
                                    <td class="column-action">
                                        <?php echo p3html::tb_action_buttons($coupon); ?>
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