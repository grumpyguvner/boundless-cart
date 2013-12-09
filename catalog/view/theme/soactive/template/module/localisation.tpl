<?php if (count($currencies) > 1 || count($languages) > 1) { ?>
    <div id="wrapCurrency">
        <div class="heading">
          <a><span id="currentCurrency">
              <?php
                    if ($language_code == 'en') { 
                        echo '<img src="catalog/view/theme/soactive/image/flags/gb.png" alt="gb.png" />'; 

                    } elseif ($language_code == 'fr') { 
                        echo '<img src="catalog/view/theme/soactive/image/flags/fr.png" alt="fr.png" />'; 
                    }

                    if ($currency_code == 'GBP') { 
                        echo $symbol_left . ' ' . $currency_code; 

                    } elseif ($currency_code == 'EUR') { 
                        echo $symbol_right . ' ' . $currency_code; 

                    } elseif ($currency_code == 'USD') {
                        echo $symbol_left . ' ' . $currency_code;
                    }   
               ?>
             </span></a>
        </div>
        <div class="content">
            <div class="mini-currency-info">
                <div class="CurrencyTitle">
                    <span>
                        <?php
                            if ($language_code == 'en') { 
                                echo $text_gbp_heading; 

                            } elseif ($language_code == 'fr') { 
                                echo $text_eur_heading; 
                            
                            } /*elseif ($language_code == 'USD') {
                                echo $text_usd_heading;
                            } */
                        ?>
                    </span>
                </div>
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                                       <?php 
                      if (count($currencies) > 1)
                      {
                          ?>
                    <div id="currency"><?php echo $text_currency; ?><br />
 <?php 
                      foreach ($currencies as $currency) { 
                          if ($currency['code'] == $currency_code) { 
                              if ($currency['symbol_left']) { ?>
                      <a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_left'] . ' ' . $currency['code']; ?></b></a>
                      <?php } else { ?>
                      <a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_right'] . ' ' . $currency['code']; ?></b></a>
                      <?php } ?>
                      <?php } else { ?>
                      <?php if ($currency['symbol_left']) { ?>
                      <a title="<?php echo $currency['title']; ?>" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parents('form').submit();"><?php echo $currency['symbol_left'] . ' ' . $currency['code']; ?></a>
                      <?php } else { ?>
                      <a title="<?php echo $currency['title']; ?>" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parents('form').submit();"><?php echo $currency['symbol_right'] . ' ' . $currency['code']; ?></a>
                      <?php 
                      } 
                      } 
                      }
                      ?>
                      <input type="hidden" name="currency_code" value="" />
                    </div>                      <?php 
                      }
                      ?>
                    
                    <div id="language"><?php echo $text_language; ?><br />
                        <?php foreach ($languages as $language) { ?>
                        <div class="<?php echo $language['code']; ?>Flag">
                            <img src="catalog/view/theme/soactive/image/flags/big_<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" onclick="$('input[name=\'language_code\']').attr('value', '<?php echo $language['code']; ?>'); $(this).parents('form').submit();" />
                            <p><?php echo $language['name']; ?></p>
                        </div>
                        <?php } ?>
                        <input type="hidden" name="language_code" value="" />
                    </div>
                    
                    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                </form>
                
                
                
            </div> 
        </div>
 </div>
<?php } ?>
