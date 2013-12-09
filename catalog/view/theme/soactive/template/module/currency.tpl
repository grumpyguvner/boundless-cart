   <?php if (count($currencies) > 1) { ?>
    <div id="wrapCurrency">
        <div class="heading">
          <a><span id="currentCurrency"></span><?php echo $currency_code; ?></a>
        </div>
        <div class="content">
            <div class="mini-currency-info">
                <div class="CurrencyTitle">
                    <span></span><span><?php echo $text_uk; ?></span>
                </div>
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                    <div id="currency"><?php echo $text_currency; ?><br />
                      <?php foreach ($currencies as $currency) { ?>
                      <?php if ($currency['code'] == $currency_code) { ?>
                      <?php if ($currency['symbol_left']) { ?>
                      <a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_left'] . ' ' . $currency['code']; ?></b></a>
                      <?php } else { ?>
                      <a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_right'] . ' ' . $currency['code']; ?></b></a>
                      <?php } ?>
                      <?php } else { ?>
                      <?php if ($currency['symbol_left']) { ?>
                      <a title="<?php echo $currency['title']; ?>" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().submit();"><?php echo $currency['symbol_left'] . ' ' . $currency['code']; ?></a>
                      <?php } else { ?>
                      <a title="<?php echo $currency['title']; ?>" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().submit();"><?php echo $currency['symbol_right'] . ' ' . $currency['code']; ?></a>
                      <?php } ?>
                      <?php } ?>
                      <?php } ?>
                      <input type="hidden" name="currency_code" value="" />
                      <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                    </div>
                </form>
                <div class="country">
                    <?php echo $text_select; ?>
                </div>
            </div> 
        </div>
</div>
<?php } ?>

