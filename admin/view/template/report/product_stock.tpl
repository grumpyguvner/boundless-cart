<?php echo $header; ?>
<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <div class="box">

        <div class="heading">
            <h1><img src="view/image/report.png" alt="" /> <?php echo $heading_title; ?></h1>
            <?php if ($success) { ?>
                <?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
            <?php } ?>
            <div class="buttons form-actions form-actions-top">
                <?php echo p3html::tb_form_button($button_export, "location = '$export';", null, 'download'); ?>
            </div>
        </div>
        <div class="content">
            <?php if ($products) { ?>
                <table class="list table table-striped table-hover">
                    <thead>
                        <tr>
                            <th class="column-model hidden-phone"><?php echo $column_model; ?></th>
                            <th class="column-name"><?php echo $column_name; ?></th>
                            <?php
                            foreach ($column_options as $column) {
                                echo '<th class="option">' . $column . '</th>';
                            }
                            ?>
                            <th class="column-number"><?php echo $column_total; ?></th>
                            <th class="column-number"><?php echo $column_price; ?></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($products as $product) { ?>
                            <tr>
                                <td class="column-model hidden-phone"><?php echo $product['model']; ?></td>
                                <td class="column-name"><?php echo $product['name']; ?></td>
                                <?php
                                foreach ($column_options as $key => $column) {
                                    if (array_key_exists($column, $product['options']) === true) {
                                        echo '<td class="option">' . $product['options'][$column] . '</td>';
                                    } else {
                                        echo '<td class="option">&nbsp;</td>';
                                    }
                                }
                                ?>
                                <td class="column-number"><?php echo $product['total']; ?></td>
                                <td class="column-number"><?php echo $product['sale']; ?></td>
                            </tr>
                        <?php } ?>
                    </tbody>
                </table>
                <div class="pagination"><?php echo $pagination; ?></div>
            <?php } else { ?>
                <?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
            <?php } ?>
        </div>
    </div>
</div>
<?php echo $footer; ?>