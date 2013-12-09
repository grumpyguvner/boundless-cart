<?php if (count($currencies) > 1) { ?>
    <a href="#" class="top_parent" onclick="return false;"><?php echo $text_currency; ?></a>
    <ul>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
            <?php foreach ($currencies as $currency) { ?>
                <li style="background-color: black; width: 86px;">
                    <?php if ($currency['code'] == $currency_code) { ?>
                        <?php if ($currency['symbol_left']) { ?>
                            <a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_left']; ?></b></a>
                        <?php } else { ?>
                            <a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_right']; ?></b></a>
                        <?php } ?>
                    <?php } else { ?>
                        <?php if ($currency['symbol_left']) { ?>
                            <a title="<?php echo $currency['title']; ?>" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().submit();"><?php echo $currency['symbol_left']; ?></a>
                        <?php } else { ?>
                            <a title="<?php echo $currency['title']; ?>" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().submit();"><?php echo $currency['symbol_right']; ?></a>
                        <?php } ?>
                    <?php } ?>
                </li>
            <?php } ?>
            <input type="hidden" name="currency_code" value="" />
            <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
        </form>
    </ul>
<?php } ?>
