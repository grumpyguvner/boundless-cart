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
            <h1><img src="view/image/information.png" alt="" /> <?php echo $heading_title; ?></h1>
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
                            <th width="1" align="center"><input type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);" /></th>
                            <th class="column-headline">
                                <?php if ($sort == 'nd.title') { ?>
                                    <a href="<?php echo $sort_title; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_title; ?></a>
                                <?php } else { ?>
                                    <a href="<?php echo $sort_title; ?>"><?php echo $column_title; ?></a>
                                <?php } ?>
                            </th>
                            <th class="column-status">
                                <?php if ($sort == 'n.status') { ?>
                                    <?php echo $column_status; ?>
                                <?php } else { ?>
                                    <?php echo $column_status; ?>
                                <?php } ?>
                            </th>
                            <th class="column-action"><?php echo $column_action; ?></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if ($news) { ?>
                            <?php $class = 'odd'; ?>
                            <?php foreach ($news as $news_story) { ?>
                                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                <tr class="<?php echo $class; ?>">
                                    <td align="center">
                                        <?php if ($news_story['delete']) { ?>
                                            <input type="checkbox" name="delete[]" value="<?php echo $news_story['news_id']; ?>" checked="checked" />
                                        <?php } else { ?>
                                            <input type="checkbox" name="delete[]" value="<?php echo $news_story['news_id']; ?>" />
                                        <?php } ?>
                                    </td>
                                    <td class="column-headline">
                                        <label class="visible-480"><?php echo $column_title; ?>:</label>
                                        <?php echo $news_story['title']; ?></td>
                                    <td class="column-status">
                                        <label class="visible-480"><?php echo $column_status; ?>:</label>
                                        <?php echo $news_story['status']; ?></td>
                                    <td class="column-action">
                                        <?php foreach ($news_story['action'] as $action) { ?>
                                            [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                                        <?php } ?>
                                    </td>
                                </tr>
                            <?php } ?>
                        <?php } else { ?>
                            <tr class="even">
                                <td class="center" colspan="5"><?php echo $text_no_results; ?></td>
                            </tr>
                        <?php } ?>
                    </tbody>
                </table>
            </form>
            <div class="pagination"><?php echo $pagination; ?></div>
        </div>
