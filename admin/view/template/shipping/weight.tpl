<?php echo $header; ?>

<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <div class="box">

        <div class="heading">
            <h1><i class="icon-truck"></i> <?php echo $heading_title; ?></h1>
            <?php if ($error_warning) { ?>
                <?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
            <?php } ?>
            <div class="buttons form-actions form-actions-top">
                <?php echo p3html::tb_form_button_save($button_save); ?>
                <?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
            </div>
        </div>

        <div class="content">
            <div class="tabbable tabs-left">

                <ul class="vtabs nav nav-tabs">
                    <li class="active"><a data-toggle="tab" href="#tab-general"><?php echo $tab_general; ?></a></li>
                    <?php foreach ($geo_zones as $geo_zone) { ?>
                        <li><a data-toggle="tab" href="#tab-geo-zone<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></a></li>
                    <?php } ?>
                </ul>

                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
                    <div class="tab-content">

                        <div class="tab-pane active" id="tab-general" class="vtabs-content">
                            <div class="form">
                                <div class="control-group">
                                    <label class="control-label"><?php echo $entry_tax_class; ?></label>
                                    <div class="controls">
                                        <select name="weight_tax_class_id" class="span3">
                                            <option value="0"><?php echo $text_none; ?></option>
                                            <?php echo p3html::oc_tax_class_options($tax_classes, $weight_tax_class_id); ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><?php echo $entry_status; ?></label>
                                    <div class="controls">
                                        <select name="weight_status" class="span2">
                                            <?php echo p3html::oc_status_options($this->language, (int) $weight_status); ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><?php echo $entry_sort_order; ?></label>
                                    <div class="controls">
                                        <input type="text" name="weight_sort_order" value="<?php echo $weight_sort_order; ?>" class="span1 i-mini">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <?php foreach ($geo_zones as $geo_zone) { ?>
                            <div class="tab-pane" id="tab-geo-zone<?php echo $geo_zone['geo_zone_id']; ?>" class="vtabs-content">
                                <div class="form">
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_rate; ?></label>
                                        <div class="controls">
                                            <textarea name="weight_<?php echo $geo_zone['geo_zone_id']; ?>_rate" class="span6 i-xxlarge" rows="5"><?php echo ${'weight_' . $geo_zone['geo_zone_id'] . '_rate'}; ?></textarea>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_status; ?></label>
                                        <div class="controls">
                                            <select name="weight_<?php echo $geo_zone['geo_zone_id']; ?>_status" class="span2">
                                                <?php echo p3html::oc_status_options($this->language, (int) ${'weight_' . $geo_zone['geo_zone_id'] . '_status'}); ?>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><?php echo $entry_sort_order; ?></label>
                                        <div class="controls">

                                            <input type="text" name="weight_<?php echo $geo_zone['geo_zone_id']; ?>_sort_order" value="<?php echo ${'weight_' . $geo_zone['geo_zone_id'] . '_sort_order'} ?>" class="span1 i-mini">

                                        </div>
                                    </div> 

                                </div>
                            </div>
                        <?php } ?>

                    </div>
                </form>

            </div>
        </div>

    </div>
</div>

<?php echo $footer; ?>