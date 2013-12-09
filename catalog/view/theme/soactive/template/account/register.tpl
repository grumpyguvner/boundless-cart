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
    <?php }
    ?>
</div>
        <div id="accountContainer"><div id="column-left"><div class="register-account"></div></div><div id="content"> 
                <?php echo $content_top; ?>
                <div class="content-account" id="registerAccount">
                    <h1><?php echo $heading_title; ?></h1>

                    <p><?php echo $text_account_already; ?></p>


                    <form action="<?php echo $action; ?>" class="form-register" method="post" enctype="multipart/form-data">
                        <h3><?php echo $text_your_details; ?></h3>
                        <div class="content">
                            <div class="prow">
                                <div class="pLabel">  
                                    <span class="required">*</span> <span><?php echo $entry_title; ?></span>
                                </div>
                                <div class="pInput">
                                    <select class="registerTitle" name="title"><option></option><?php
                                    foreach ($select_title as $title)
                                    {
                                        echo '<option>' . $title . '</option>';
                                    }
                                    ?></select>
                                </div>
                            </div>
                            <div class="prow">
                                <div class="pLabel">  
                                    <span class="required">*</span> <span><?php echo $entry_firstname; ?></span>
                                </div>
                                <div class="pInput">
                                    <input type="text" name="firstname" value="<?php echo $firstname; ?>" />
                                    <?php if ($error_firstname) { ?>
                                        <span class="error"><?php echo $error_firstname; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="prow">
                                <div class="pLabel">  
                                    <span class="required">*</span> <span><?php echo $entry_lastname; ?></span>
                                </div>
                                <div class="pInput">
                                    <input type="text" name="lastname" value="<?php echo $lastname; ?>" />
                                    <?php if ($error_lastname) { ?>
                                        <span class="error"><?php echo $error_lastname; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="prow">
                                <div class="pLabel">  
                                    <span class="required">*</span> <span><?php echo $entry_email; ?></span>
                                </div>
                                <div class="pInput">
                                    <input type="text" name="email" value="<?php echo $email; ?>" />
                                    <?php if ($error_email) { ?>
                                        <span class="error"><?php echo $error_email; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="prow">
                                <div class="pLabel">  
                                    <span class="required">*</span> <span><?php echo $entry_telephone; ?></span>
                                </div>
                                <div class="pInput">
                                    <input type="text" name="telephone" value="<?php echo $telephone; ?>" />
                                    <?php if ($error_telephone) { ?>
                                        <span class="error"><?php echo $error_telephone; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="prow" style="display: none;">
                                <div class="pLabel">  
                                    <span><?php echo $entry_fax; ?></span>
                                </div>
                                <div class="pInput">
                                    <input type="text" name="fax" value="<?php echo $fax; ?>" />
                                </div>
                            </div>
                            <div class="prow">
                        <div class="pLabel">
                                <span><?php echo $entry_date_birth; ?></span>
                        </div>
                        <div class="pInput">
                            <select class="day" name="day_birth">
                                <?php
                                if ($day_birth) {
                                    for ($i = 1; $i <= 31; $i++) {
                                        if ($i == $day_birth) {
                                           echo '<option value="'.$day_birth.'" selected="selected">'.$day_birth.'</option>'; 
                                        } else {
                                           echo '<option value="'.$i.'">'.$i.'</option>';
                                        } 
                                    }
                                } else {
                                    echo '<option value=""></option>';
                                    for($i = 1; $i <= 31; $i++) {
                                        echo '<option value="'.$i.'">'.$i.'</option>';
                                    }
                                }
                                ?>
                            </select>

                            <select class="month" name="month_birth">
                                <?php
                                if ($day_birth) {
                                    for ($i = 1; $i <= 12; $i++) {
                                        if ($i == $month_birth) {
                                           echo '<option value="'.$month_birth.'" selected="selected">'.date("F", mktime(0, 0, 0, $month_birth, 1, 2013)).'</option>'; 
                                        } else {
                                           echo '<option value="'.$i.'">'.date("F", mktime(0, 0, 0, $i, 1, 2013)).'</option>';
                                        } 
                                    }
                                } else {
                                    echo '<option value=""></option>';
                                    for($i = 1; $i <= 12; $i++) {
                                        echo '<option value="'.$i.'">'.date("F", mktime(0, 0, 0, $i, 1, 2013)).'</option>';
                                    }
                                }
                                ?>
                            </select>

                            <select class="year" name="year_birth">
                                <?php
                                $actYear = date("Y",time());
                                $startYear = date("Y",strtotime('-110years'));
                                if ($day_birth) {
                                    for ($i = $actYear; $i >= $startYear; $i--) {
                                        if ($i == $year_birth) {
                                           echo '<option value="'.$year_birth.'" selected="selected">'.$year_birth.'</option>'; 
                                        } else {
                                           echo '<option value="'.$i.'">'.$i.'</option>';
                                        } 
                                    }
                                } else {
                                    echo '<option value=""></option>';
                                    for($i = $actYear; $i >= $startYear; $i--) {
                                        echo '<option value="'.$i.'">'.$i.'</option>';
                                    }
                                }
                                ?>
                            </select>
                        </div>
                    </div>
                            
                        </div>

                        <h3><?php echo $text_your_address; ?></h3>

                        <div class="postcodeAnywhereContainer">
                            <?php
                            if ($use_postcode_anywhere) {
                                ?>
                                <div class="paLookup content">
                                    <div class="row">
                                        <div class="span2"><span class="paLookup_required required">*</span> <?php echo $entry_search_address; ?></div>
                                        <div class="span5">
                                            <select name="postcode_lookup_country_id">
                                                <?php foreach ($countries as $country) { ?>
                                                    <?php if ($country['country_id'] == $postcode_lookup_country_id) { ?>
                                                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                                    <?php } else { ?>
                                                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                                    <?php } ?>
                                                <?php } ?>
                                            </select><br >
                                            <input class="span2" name="postcode_lookup" type="text" value="<?php echo $postcode_lookup; ?>">
                                            <button class="btn" name="lookup" type="submit"><?php echo $button_find_address; ?></button>
                                            <?php if (isset($error_postcode_lookup)) { ?>
                                                <span class="error"><?php echo $error_postcode_lookup; ?></span>
                                            <?php } ?>
                                                <br><a href="#" class="manualAddress"><?php echo $text_enter_manually; ?></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="paSelect content">
                                    <div class="row">
                                        <div class="span2">
                                            <span class="paSelect_required required">*</span> <?php echo $entry_select_address; ?>
                                        </div>
                                        <div class="span5">
                                            <select name="address_dropdown"<?php if ($addresses) echo ' size="' . (count($addresses) > 9 ? 10 : count($addresses)) . '"'; ?>>
                                                <?php
                                                if ($addresses) {
                                                    foreach ($addresses as $address_info) {
                                                        echo "<option value='" . $address_info['value'] . "'";
                                                        if ($address_dropdown == $address_info['value'])
                                                            echo ' selected="selected"';
                                                        echo '>' . $address_info['text'] . '</option>';
                                                    }
                                                }
                                                ?>
                                            </select><br >
                                            <button class="btn" name="address_select" type="submit"><?php echo $button_select_address; ?></button>
                                        </div>
                                    </div>
                                </div>
                                <?php
                            }
                            ?>
                            <div class="paAddress content">
                                <div class="prow">
                                    <div class="pLabel">  
                                        <span><?php echo $entry_company; ?></span>
                                    </div>
                                    <div class="pInput">
                                        <input type="text" name="company" value="<?php echo $company; ?>" />
                                    </div>
                                </div>

                                    <table class="form" style="display: <?php echo (count($customer_groups) > 1 ? 'table-row' : 'none'); ?>;">

                                        <tr >
                                            <td><?php echo $entry_customer_group; ?></td>
                                            <td><?php foreach ($customer_groups as $customer_group) { ?>
                                                    <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
                                                        <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                                                        <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
                                                        <br />
                                                    <?php } else { ?>
                                                        <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
                                                        <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
                                                        <br />
                                                    <?php } ?>
                                                <?php } ?></td>
                                        </tr>
                                    </table>

                                    <div class="prow" id="company-id-display">
                                        <div class="pLabel">  
                                            <span id="company-id-required" class="required">*</span> <span><?php echo $entry_company_id; ?></span>
                                        </div>
                                        <div class="pInput">
                                            <input type="text" name="company_id" value="<?php echo $company_id; ?>" />
                                            <?php if ($error_company_id) { ?>
                                                <span class="error"><?php echo $error_company_id; ?></span>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="prow" id="tax-id-display">
                                        <div class="pLabel">  
                                            <span id="tax-id-required" class="required">*</span> <span><?php echo $entry_tax_id; ?></span>
                                        </div>
                                        <div class="pInput">
                                            <input type="text" name="tax_id" value="<?php echo $tax_id; ?>" />
                                            <?php if ($error_tax_id) { ?>
                                                <span class="error"><?php echo $error_tax_id; ?></span>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="prow">
                                        <div class="pLabel">  
                                            <span class="required">*</span> <span><?php echo $entry_address_1; ?></span>
                                        </div>
                                        <div class="pInput">
                                            <input type="text" name="address_1" value="<?php echo $address_1; ?>" />
                                            <?php if ($error_address_1) { ?>
                                                <span class="error"><?php echo $error_address_1; ?></span>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="prow">
                                        <div class="pLabel">  
                                            <span><?php echo $entry_address_2; ?></span>
                                        </div>
                                        <div class="pInput">
                                            <input type="text" name="address_2" value="<?php echo $address_2; ?>" />
                                        </div>
                                    </div>
                                    <div class="prow">
                                        <div class="pLabel">  
                                            <span class="required">*</span> <span><?php echo $entry_city; ?></span>
                                        </div>
                                        <div class="pInput">
                                            <input type="text" name="city" value="<?php echo $city; ?>" />
                                            <?php if ($error_city) { ?>
                                                <span class="error"><?php echo $error_city; ?></span>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="prow">
                                        <div class="pLabel">  
                                            <span id="postcode-required" class="required">*</span> <span><?php echo $entry_postcode; ?></span>
                                        </div>
                                        <div class="pInput">
                                            <input type="text" name="postcode" class="span2" value="<?php echo $postcode; ?>" />
                                            <?php
                                            if ($use_postcode_anywhere) {
                                                ?>
                                                <button class="btn" name="lookup" type="submit"><?php echo $button_find_address; ?></button>
                                                <?php
                                            }
                                            if ($error_postcode) {
                                                ?>
                                                <span class="error"><?php echo $error_postcode; ?></span>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="prow">
                                        <div class="pLabel">  
                                            <span class="required">*</span> <span><?php echo $entry_country; ?></span>
                                        </div>
                                        <div class="pInput">
                                            <select name="country_id">
                                            <option value=""><?php echo $text_select; ?></option>
                                            <?php foreach ($countries as $country) { ?>
                                                <?php if ($country['country_id'] == $country_id) { ?>
                                                    <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                                <?php } else { ?>
                                                    <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                                <?php } ?>
                                            <?php } ?>
                                        </select>
                                        <?php if ($error_country) { ?>
                                            <span class="error"><?php echo $error_country; ?></span>
                                        <?php } ?>
                                        </div>
                                    </div>
                                    <div class="prow">
                                        <div class="pLabel">  
                                            <span class="required">*</span> <span><?php echo $entry_zone; ?></span>
                                        </div>
                                        <div class="pInput">
                                            <select name="zone_id">
                                            </select>
                                            <?php if ($error_zone) { ?>
                                                <span class="error"><?php echo $error_zone; ?></span>
                                            <?php } ?>
                                        </div>
                                    </div>
                            </div> 
                        </div>
                        <h3><?php echo $text_your_password; ?></h3>
                        <div class="content">
                            <div class="prow">
                                <div class="pLabel">  
                                    <span class="required">*</span> <span><?php echo $entry_password; ?></span>
                                </div>
                                <div class="pInput">
                                    <input type="password" name="password" value="<?php echo $password; ?>" />
                                    <?php if ($error_password) { ?>
                                        <span class="error"><?php echo $error_password; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="prow">
                                <div class="pLabel">  
                                    <span class="required">*</span> <span><?php echo $entry_confirm; ?></span>
                                </div>
                                <div class="pInput">
                                    <input type="password" name="confirm" value="<?php echo $confirm; ?>" />
                                    <?php if ($error_confirm) { ?>
                                        <span class="error"><?php echo $error_confirm; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                           
                        </div>
                        <?php
                        if ($show_newsletter) {
                            ?>
                            <h3><?php echo $text_newsletter; ?></h3>
                            <div class="content">
                                <div class="prow">
                                    <div class="pLabel">  
                                        <span><?php echo $entry_newsletter; ?></span>
                                    </div>
                                    <div class="pInput">
                                        <?php if ($newsletter) { ?>
                                            <input type="radio" name="newsletter" value="1" checked="checked" />
                                            <?php echo $text_yes; ?>
                                            <input type="radio" name="newsletter" value="0" />
                                            <?php echo $text_no; ?>
                                        <?php } else { ?>
                                            <input type="radio" name="newsletter" value="1" />
                                            <?php echo $text_yes; ?>
                                            <input type="radio" name="newsletter" value="0" checked="checked" />
                                            <?php echo $text_no; ?>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                            <?php
                        } else {
                            ?>
                            <input type="hidden" name="newsletter" value="1" />
                            <?php
                        }
                        ?>
                        <?php if ($text_agree) { ?>
                            <div class="buttons">

                                <div class="right"><?php echo $text_agree; ?>
                                    <?php if ($agree) { ?>
                                        <input type="checkbox" name="agree" value="1" checked="checked" />
                                    <?php } else { ?>
                                        <input type="checkbox" name="agree" value="1" />
                                    <?php } ?>
                                    <input type="submit" value="<?php echo $button_continue; ?>" class="button" />
                                </div>

                            </div>
                        <?php } else { ?>
                            <div class="buttons">

                                <div class="right">
                                    <input type="submit" value="<?php echo $button_continue; ?>" class="button" />
                                </div>

                            </div>
                        <?php } ?>
                    </form>

                    <?php echo $content_bottom; ?>
                </div>
            </div>
        </div>
    
<script type="text/javascript"><!--
    $('.postcodeAnywhereContainer').postcodeAnywhere();
    
    $('input[name=\'customer_group_id\']:checked').live('change', function() {
        var customer_group = [];
	
<?php foreach ($customer_groups as $customer_group) { ?>
            customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
            customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
            customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
            customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
            customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
<?php } ?>	

        if (customer_group[this.value]) {
            if (customer_group[this.value]['company_id_display'] == '1') {
                $('#company-id-display').show();
            } else {
                $('#company-id-display').hide();
            }
		
            if (customer_group[this.value]['company_id_required'] == '1') {
                $('#company-id-required').show();
            } else {
                $('#company-id-required').hide();
            }
		
            if (customer_group[this.value]['tax_id_display'] == '1') {
                $('#tax-id-display').show();
            } else {
                $('#tax-id-display').hide();
            }
		
            if (customer_group[this.value]['tax_id_required'] == '1') {
                $('#tax-id-required').show();
            } else {
                $('#tax-id-required').hide();
            }	
        }
    });

    $('input[name=\'customer_group_id\']:checked').trigger('change');
    //--></script> 
<script type="text/javascript"><!--
    $('select[name=\'country_id\']').bind('change', function() {
        $.ajax({
            url: 'index.php?route=account/register/country&country_id=' + this.value,
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
<script type="text/javascript"><!--
    $('.colorbox').colorbox({
        width: 640,
        height: 480
    });
    //--></script> 
<?php echo $footer; ?>