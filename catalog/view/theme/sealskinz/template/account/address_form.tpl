<?php echo $header; ?>
<div id="breadcrumb">
    <div class="container">
        <?php
        foreach ($breadcrumbs as $breadcrumb) {
            echo $breadcrumb['separator'] . '<a href="' . $breadcrumb['href'] . '">' . $breadcrumb['text'] . '</a>';
        }
        ?>
    </div>
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
<div id="content-back">
    <div class="green-bar">
        <div id="accountContainer" class="container"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content"> 
                <?php echo $content_top; ?>
                <div class="content-account">
                    <h1><?php echo $heading_title; ?></h1>
                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                        <h2><?php echo $text_edit_address; ?></h2>

                        <div class="content">

                            <div class="row"> 
                                <div class="span2">
                                    <span class="required">*</span> <?php echo $entry_firstname; ?>
                                </div>
                                <div class="span4">
                                    <input type="text" name="firstname" value="<?php echo $firstname; ?>" />
                                    <?php if ($error_firstname) { ?>
                                        <span class="error"><?php echo $error_firstname; ?></span>
                                    <?php } ?>
                                </div>
                                <div class="span2">
                                    <span class="required">*</span> <?php echo $entry_lastname; ?>
                                </div>
                                <div class="span4">
                                    <input type="text" name="lastname" value="<?php echo $lastname; ?>" />
                                    <?php if ($error_lastname) { ?>
                                        <span class="error"><?php echo $error_lastname; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>


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
                                            <?php if ($error_postcode_lookup) { ?>
                                                <span class="error"><?php echo $error_postcode_lookup; ?></span>
                                            <?php } ?>
                                                <br><a href="#" class="manualAddress"><?php echo $text_enter_manually; ?></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="paSelect content">
                                    <div class="row">
                                        <div class="span2"><span class="paSelect_required required">*</span> <?php echo $entry_select_address; ?></div>
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
                            <div id="paAddress" class="content">

                                <div class="row"> 

                                    <div class="span2">
<?php echo $entry_company; ?>
                                    </div>
                                    <div class="span4">
                                        <input type="text" name="company" value="<?php echo $company; ?>" />
                                    </div>
<?php if ($company_id_display) { ?>
                                        <div class="span2">
                                        <?php echo $entry_company_id; ?>
                                        </div>
                                        <div class="span4">
                                            <input type="text" name="company_id" value="<?php echo $company_id; ?>" />
    <?php if ($error_company_id) { ?>
                                                <span class="error"><?php echo $error_company_id; ?></span>
                                            <?php } ?>
                                        </div>
                                        <?php } ?>
                                    <?php if ($tax_id_display) { ?>
                                        <div class="span2">
                                        <?php echo $entry_tax_id; ?>
                                        </div>
                                        <div class="span4">
                                            <input type="text" name="tax_id" value="<?php echo $tax_id; ?>" />
    <?php if ($error_tax_id) { ?>
                                                <span class="error"><?php echo $error_tax_id; ?></span>
                                            <?php } ?>
                                        </div>
                                        <?php } ?>
                                    <div class="span2">
                                        <span class="required">*</span> <?php echo $entry_address_1; ?>
                                    </div>
                                    <div class="span4">
                                        <input type="text" name="address_1" value="<?php echo $address_1; ?>" />
<?php if ($error_address_1) { ?>
                                            <span class="error"><?php echo $error_address_1; ?></span>
                                        <?php } ?>
                                    </div>

                                    <div class="span2">
<?php echo $entry_address_2; ?>
                                    </div>
                                    <div class="span4">
                                        <input type="text" name="address_2" value="<?php echo $address_2; ?>" />
                                    </div>
                                    <div class="span2">
                                        <span class="required">*</span> <?php echo $entry_city; ?>
                                    </div>
                                    <div class="span4">
                                        <input type="text" name="city" value="<?php echo $city; ?>" />
<?php if ($error_city) { ?>
                                            <span class="error"><?php echo $error_city; ?></span>
                                        <?php } ?>
                                    </div>
                                    <div class="span2">
                                        <span id="postcode-required" class="required">*</span> <?php echo $entry_postcode; ?>
                                    </div>
                                    <div class="span4">
                                        <input type="text" name="postcode" value="<?php echo $postcode; ?>" />
<?php if ($error_postcode) { ?>
                                            <span class="error"><?php echo $error_postcode; ?></span>
                                        <?php } ?>
                                    </div>
                                    <div class="span2">
                                        <span class="required">*</span> <?php echo $entry_country; ?>
                                    </div>
                                    <div class="span4">
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
                                    <div class="span2">
                                        <span class="required">*</span> <?php echo $entry_zone; ?>
                                    </div>
                                    <div class="span4">
                                        <select name="zone_id">
                                        </select>
<?php if ($error_zone) { ?>
                                            <span class="error"><?php echo $error_zone; ?></span>
                                        <?php } ?>
                                    </div>
                                    <div class="span2">
<?php echo $entry_default; ?>
                                    </div>
                                    <div class="span4">
<?php if ($default) { ?>
                                            <input type="radio" name="default" value="1" checked="checked" />
                                            <?php echo $text_yes; ?>
                                            <input type="radio" name="default" value="0" />
                                            <?php echo $text_no; ?>
                                        <?php } else { ?>
                                            <input type="radio" name="default" value="1" />
                                            <?php echo $text_yes; ?>
                                            <input type="radio" name="default" value="0" checked="checked" />
                                            <?php echo $text_no; ?>
                                        <?php } ?>
                                    </div>
                                </div>    
                            </div>

                            <div class="buttons">

                                <div class="left"><a href="<?php echo $back; ?>" class="button-account"><?php echo $button_back; ?></a></div>
                                <div class="right">
                                    <input type="submit" value="<?php echo $button_continue; ?>" class="button-account" />
                                </div>

                            </div>
                    </form>
                </div>
<?php echo $content_bottom; ?>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript"><!--
    $('select[name=\'country_id\']').bind('change', function() {
        $.ajax({
            url: 'index.php?route=account/address/country&country_id=' + this.value,
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
			
                html = '<option value=""><?php echo $text_select; ?></option>';
			
                if (json['zone'] != '') {
                    for (i = 0; i < json['zone'].length; i++) {
                        html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
                        if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
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
<?php echo $footer; ?>