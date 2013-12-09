<?php echo $header; ?>
<div id="content">
    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <div class="box">

        <div class="heading">
            <h1><i class="icon-flag"></i> <?php echo $heading_title; ?></h1>
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
               <div id="tab-general"> 
                 <table class="form">
                  <tr>
                    <td><?php echo $text_filename; ?></td>
                    <td><?php echo $filename; ?></td>
                  </tr>
                </table> 
                   <br />
                <ul id="tabs" class="htabs nav nav-tabs">
                    <?php foreach ($languages as $language) { ?>
                        <li class="active"><a data-toggle="tab" href="#language<?php echo $language['language_id']; ?>">
                                <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                        </li>
                    <?php } ?>
                </ul>
                <?php foreach ($languages as $language) { ?>
                    <div id="language<?php echo $language['language_id']; ?>">
                        <input type="hidden" name="language_manager[<?php echo $language['language_id']; ?>][language_id]" value="<?php echo isset($information_description[$language['language_id']]) ? $language_manager[$language['language_id']]['language_id'] : $language['language_id']; ?>" />
                        <table class="form" style="width: 100%;">
                            <?php foreach ($language_manager[$language['language_id']]['default'] as $key => $value) { ?>
                                <tr>
                                    <td style="width: 30%;"><?php echo ucwords(str_replace('_', ' ', $key)); ?></td>
                                    <?php
                                    if (array_key_exists($key, $language_manager[$language['language_id']]['value'])) { ?>
                                        <td style="width: 10%;"><input type="checkbox" value="<?php echo $language_manager[$language['language_id']]['default'][$key]; ?>" checked="checked" /></td><td style="width: 60%;"><input type="text" name="language_manager[<?php echo $language['language_id']; ?>][value][<?php echo $key; ?>]" size="100" placeholder="<?php echo $language_manager[$language['language_id']]['default'][$key]; ?>" value="<?php echo $language_manager[$language['language_id']]['value'][$key]; ?>" class="span6 i-xxlarge" /></td>
                                    <?php } else { ?>
                                        <td style="width: 10%;"><input type="checkbox" value="<?php echo $language_manager[$language['language_id']]['default'][$key]; ?>" /></td><td style="width: 60%;"><input type="text" name="language_manager[<?php echo $language['language_id']; ?>][value][<?php echo $key; ?>]" size="100" placeholder="<?php echo $language_manager[$language['language_id']]['default'][$key]; ?>" value="<?php echo $language_manager[$language['language_id']]['default'][$key]; ?>" disabled="disabled" class="span6 i-xxlarge" /></td>
                                    <?php } ?>
                                </tr>
                            <?php } ?>
                        </table>
                    </div>
                <?php } ?>
               </div>
            </form>
        </div> 
    </div>
</div>
<script type="text/javascript"><!--


    $('#tab-general input[type=text]').parents('td').click(function () {
        if (!$(this).parents('tr').find('input[type=checkbox]').is(':checked')) {
            $(this).parents('tr').find('input[type=checkbox]').trigger('click');
        }
    });

    $('#tab-general input[type=checkbox]').change(function () {
        if ($(this).is(':checked')) {
            $(this).parents('tr').find('input[type=text]').attr('disabled', false).trigger('focus');
        } else {
            $(this).parents('tr').find('input[type=text]').attr('disabled', 'disabled').val($(this).attr('value'));
        }
    });
    //--></script> 
<?php echo $footer; ?>