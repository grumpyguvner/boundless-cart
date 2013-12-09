<?php echo $header; ?>
<div class="breadcrumb">
    <?php if ($breadcrumbs) { ?>
      <?php $count = count($breadcrumbs) - 1; ?>
      <?php for ($i = 0; $i < $count; $i++) { ?>
        <?php echo '<b>' . $breadcrumbs[$i]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$i]['href']; ?>"><b><?php echo $breadcrumbs[$i]['text']; ?></b></a>
      <?php } ?>
        <?php echo '<b>' .$breadcrumbs[$count]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$count]['href']; ?>"><?php echo $breadcrumbs[$count]['text']; ?></a>
        <div class="back"><a href="<?php echo $breadcrumbs[$count-1]['href']; ?>"><?php echo $text_breadcrumb_back; ?></a></div>    
    <?php } ?>
  </div>
<div id="notification">
    <?php if (isset($success) && $success) { ?>
        <div class="success"><?php echo $success; ?></div>
        <?php
    }
    if (isset($error_warning) && $error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
        <?php
    }
    if (isset($attention) && $attention) {
        ?>
        <div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
        <?php
    }
    ?>
</div>

<?php echo $column_left; ?><?php echo $column_right; ?><div id="content"> 
        <?php echo $content_top; ?>

        <table id="shipping-head">
            <tr>
                <td><h1><?php echo strtoupper($heading_title); ?></h1></td>
                <td><h4><?php if ($weight) { ?>
                            &nbsp;(<?php echo $weight; ?>)
                        <?php } ?></h4>
                </td>

            </tr>
        </table>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

            <div class="cart-info">

                <table>
                    <thead>
                        <tr>
                            <td class="name"><h4><?php echo $column_name; ?></h4></td>
                            <td class="quantity"><h4><?php echo $column_quantity; ?></h4></td>
                            <td class="price"><h4><?php echo $column_price; ?></h4></td>
                            <td class="total"><h4><?php echo $column_total; ?></h4></td>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($products as $product) { ?>
                            <tr>
                                <td class="name">
                                    <?php if ($product['thumb']) { ?>
                                        <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                                    <?php } ?>
                                    <div>    
                                        <a href="<?php echo $product['href']; ?>"><h4 style="font-weight: 700"><?php echo $product['name']; ?></h4></a>
                                        <?php if (!$product['stock']) { ?>
                                            <span class="stock">***</span>
                                        <?php } ?>
                                    
                                        <?php foreach ($product['option'] as $option) { ?>
                                           <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
                                        <?php } ?>
                                    </div>
                                    <?php if ($product['reward']) { ?>
                                        <small><?php echo $product['reward']; ?></small>
                                    <?php } ?>
                                </td>
                                <td class="quantity"><input type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" style="width: 30px;" />
                                    &nbsp;
                                    <input type="image" src="catalog/view/theme/default/image/update.png" alt="<?php echo $button_update; ?>" title="<?php echo $button_update; ?>" />
                                    &nbsp;<a href="<?php echo $product['remove']; ?>"><img src="catalog/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a>
                                </td>
                                <td class="price"><h4 style="font-weight: normal">
                                        <?php echo $product['price']; ?></h4>
                                </td>
                                <td class="total"><?php echo $product['total']; ?></td>
                            </tr>
                        <?php } ?>
                        <?php foreach ($vouchers as $vouchers) { ?>
                            <tr>
                                <td class="image"></td>
                                <td class="name"><?php echo $vouchers['description']; ?></td>
                                <td class="model"></td>
                                <td class="quantity"><input type="text" name="" value="1" size="1" disabled="disabled" />
                                    &nbsp;<a href="<?php echo $vouchers['remove']; ?>"><img src="catalog/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a></td>
                                <td class="price"><?php echo $vouchers['amount']; ?></td>
                                <td class="total"><?php echo $vouchers['amount']; ?></td>
                            </tr>
                        <?php } ?>
                    </tbody>
                </table>
            </div>
        </form>
        <div class="cart-total">
            <table id="total">
                <?php foreach ($totals as $total) { ?>
                    <tr>
                        <td class="textTotal"><b><?php echo $total['title']; ?>:</b></td>
                        <td class="valueTotal" <?php if ($total['code'] == 'total') echo 'style="font-weight: bold;"'?>><?php echo $total['text']; ?></td>
                    </tr>
                <?php } ?>
            </table>
            <table>
                <tr>
                    <td class="promotionalCode"><?php echo $text_next; ?></td>
                    <td class="couponVoucher">
                        <span><?php echo $text_next_choice ?></span>
                        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                            <input type="text" name="coupon_voucher" value="<?php echo $coupon_voucher; ?>" />
                            <input type="hidden" name="next" value="coupon_voucher" />
                            &nbsp;
                            <input type="submit" value="ADD" class="button" />
                        </form>
                    </td>
                </tr>
            </table>
        </div>
        <div class="buttons">
            <div class="buttonLeft"><a href="<?php echo $continue; ?>" class="button"><?php echo strtoupper($button_shopping); ?></a></div>
            <div class="buttonRight"><a href="<?php echo $checkout; ?>" class="button"><?php echo strtoupper($button_checkout); ?></a></div>

        </div>
        <?php echo $content_bottom; ?>
    </div>

<script type="text/javascript"><!--
    $('input[name=\'next\']').bind('change', function() {
        $('.cart-module > div').hide();
	
        $('#' + this.value).show();
    });
    //--></script>
<?php if ($shipping_status) { ?>
    <script type="text/javascript"><!--
        $('#button-quote').live('click', function() {
            $.ajax({
                url: 'index.php?route=checkout/cart/quote',
                type: 'post',
                data: 'country_id=' + $('select[name=\'country_id\']').val() + '&zone_id=' + $('select[name=\'zone_id\']').val() + '&postcode=' + encodeURIComponent($('input[name=\'postcode\']').val()),
                dataType: 'json',		
                beforeSend: function() {
                    $('#button-quote').attr('disabled', true);
                    $('#button-quote').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                },
                complete: function() {
                    $('#button-quote').attr('disabled', false);
                    $('.wait').remove();
                },		
                success: function(json) {
                    $('.success, .warning, .attention, .error').remove();			
            						
                    if (json['error']) {
                        if (json['error']['warning']) {
                            $('#notification').html('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
            					
                            $('.warning').fadeIn('slow');
            					
                            $('html, body').animate({ scrollTop: 0 }, 'slow'); 
                        }	
            							
                        if (json['error']['country']) {
                            $('select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
                        }	
            				
                        if (json['error']['zone']) {
                            $('select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
                        }
            				
                        if (json['error']['postcode']) {
                            $('input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
                        }					
                    }
            			
                    if (json['shipping_method']) {
                        html  = '<h2><?php echo $text_shipping_method; ?></h2>';
                        html += '<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">';
                        html += '  <table class="radio">';
            				
                        for (i in json['shipping_method']) {
                            html += '<tr>';
                            html += '  <td colspan="3"><b>' + json['shipping_method'][i]['title'] + '</b></td>';
                            html += '</tr>';
            				
                            if (!json['shipping_method'][i]['error']) {
                                for (j in json['shipping_method'][i]['quote']) {
                                    html += '<tr class="highlight">';
            							
                                    if (json['shipping_method'][i]['quote'][j]['code'] == '<?php echo $shipping_method; ?>') {
                                        html += '<td><input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" id="' + json['shipping_method'][i]['quote'][j]['code'] + '" checked="checked" /></td>';
                                    } else {
                                        html += '<td><input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" id="' + json['shipping_method'][i]['quote'][j]['code'] + '" /></td>';
                                    }
            								
                                    html += '  <td><label for="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['title'] + '</label></td>';
                                    html += '  <td style="text-align: right;"><label for="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['text'] + '</label></td>';
                                    html += '</tr>';
                                }		
                            } else {
                                html += '<tr>';
                                html += '  <td colspan="3"><div class="error">' + json['shipping_method'][i]['error'] + '</div></td>';
                                html += '</tr>';						
                            }
                        }
            				
                        html += '  </table>';
                        html += '  <br />';
                        html += '  <input type="hidden" name="next" value="shipping" />';
            				
    <?php if ($shipping_method) { ?>
                            html += '  <input type="submit" value="<?php echo $button_shipping; ?>" id="button-shipping" class="button" />';	
    <?php } else { ?>
                            html += '  <input type="submit" value="<?php echo $button_shipping; ?>" id="button-shipping" class="button" disabled="disabled" />';	
    <?php } ?>
            							
                        html += '</form>';
            				
                        $.colorbox({
                            overlayClose: true,
                            opacity: 0.5,
                            width: '600px',
                            height: '400px',
                            href: false,
                            html: html
                        });
            				
                        $('input[name=\'shipping_method\']').bind('change', function() {
                            $('#button-shipping').attr('disabled', false);
                        });
                    }
                    }
                });
            });
            //--></script> 
    <script type="text/javascript"><!--
        $('select[name=\'country_id\']').bind('change', function() {
            $.ajax({
                url: 'index.php?route=checkout/cart/country&country_id=' + this.value,
                dataType: 'json',
                beforeSend: function() {
                    $('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                },
                complete: function() {
                    $('.wait').remove();
                },			
                success: function(json) {
                    if (json['postcode_required'] == '1') {
                        $('#postcode-required').show();
                    } else {
                        $('#postcode-required').hide();
                    }
                    
                    zone_id = $('select[name=\'zone_id\']').val() ? $('select[name=\'zone_id\']').val() : '<?php echo $zone_id; ?>' ;
            			
                    html = '<option value=""><?php echo $text_select; ?></option>';
            			
                    if (json['zone'] != '') {
                        for (i = 0; i < json['zone'].length; i++) {
                            html += '<option value="' + json['zone'][i]['zone_id'] + '"';
            	    			
                            if (json['zone'][i]['zone_id'] == zone_id) {
                                html += ' selected="selected"';
                            }
            	
                            html += '>' + json['zone'][i]['name'] + '</option>';
                        }
                    } else {
                        html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
                    }
            			
                    $('select[name=\'zone_id\']').html(html);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        });

        $('select[name=\'country_id\']').trigger('change');
        //--></script>
<?php } ?>
<script type="text/javascript">
    $(document).ready(function () {
        $('td.promotionalCode > span').click(
          function () {
              $('td.promotionalCode').css({'display': 'none'});
              $('td.couponVoucher').css({'display': 'block'});
          }
        );
    });
</script>    
<?php echo $footer; ?>