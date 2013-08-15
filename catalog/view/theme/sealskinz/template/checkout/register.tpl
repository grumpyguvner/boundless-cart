<?php
if (!$this->customer->isLogged())
{
?>
<div class="left" style="border-right: none;">
    
        <h2><?php echo $text_your_details; ?></h2>
        <div class="prow">
            <div class="pLabel">
                <span class="required">*</span> <?php echo $entry_firstname; ?>
            </div>
            <div class="pInput">
                <input type="text" name="firstname" value="" class="large-field" />
            </div>
        </div>
        <div class="prow">
            <div class="pLabel">
                <span class="required">*</span> <?php echo $entry_lastname; ?>
            </div>
            <div class="pInput">
                <input type="text" name="lastname" value="" class="large-field" />
            </div>
        </div>
        <div class="prow">
            <div class="pLabel">
                <span class="required">*</span> <?php echo $entry_email; ?>
            </div>
            <div class="pInput">  
                <input type="text" name="email" value="" class="large-field" />
            </div>
        </div>
        <div class="prow">
            <div class="pLabel">
                <span class="required">*</span> <?php echo $entry_telephone; ?>
            </div>
            <div class="pInput">
                <input type="text" name="telephone" value="" class="large-field" />
            </div>
        </div>
        <input type="hidden" name="fax" value="" class="large-field" />
        <div style="display: <?php echo (count($customer_groups) > 1 ? 'table-row' : 'none'); ?>;">
            <?php echo $entry_customer_group; ?><br />
            <?php foreach ($customer_groups as $customer_group) { ?>
                <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
                    <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                    <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
                    <br />
                <?php } else { ?>
                    <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
                    <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
                    <br />
                <?php } ?>
            <?php } ?>
            <br />
        </div>
        <h2><?php echo $text_your_password; ?></h2>
        <div class="prow">
            <div class="pLabel">
                <span class="required">*</span> <?php echo $entry_password; ?>
            </div>
            <div class="pInput">  
                <input type="password" name="password" value="" class="large-field" />
            </div>
        </div>
        <div class="prow">
            <div class="pLabel">
                <span class="required">*</span> <?php echo $entry_confirm; ?>
            </div>
            <div class="pInput">   
                <input type="password" name="confirm" value="" class="large-field" />
            </div>
        </div>
    
</div>
<div class="right"  style="border-right: none;">
    
   
</div>
<div style="clear: both; padding-top: 15px; border-top: 1px solid #EEEEEE;">  
    <?php
    if ($show_newsletter) {
        ?>
        <label for="newsletter" class="checkbox"><input type="checkbox" name="newsletter" value="1" id="newsletter" />
            <?php echo $entry_newsletter; ?></label>
        <br />
        <?php
    } else {
        ?>
        <input type="hidden" name="newsletter" value="1" />
        <?php
    }
    ?>
</div>
<?php if ($text_agree) { ?>
    <div class="buttons">
        <label class="checkbox"><?php echo $text_agree; ?>
                <input type="checkbox" name="agree" value="1" /></label>
            <input type="button" value="<?php echo $button_continue; ?>" id="button-register" class="button" />
    </div>
<?php } else { ?>
    <div class="buttons">
            <input type="button" value="<?php echo $button_continue; ?>" id="button-register" class="button" />
    </div>
<?php } ?>

<script type="text/javascript"><!--
    $('.colorbox').colorbox({
        width: 640,
        height: 480
    });
    //--></script>

<script type="text/javascript"><!--
    $('#payment-address input').live('keydown, change', function () {
        if ($('#payment-address input[name=firstname]').val() &&
            $('#payment-address input[name=lastname]').val() &&
            $('#payment-address input[name=email]').val() &&
            $('#payment-address input[name=telephone]').val() &&
            $('#payment-address input[name=password]').val() &&
            $('#payment-address input[name=confirm]').val()<?php if ($text_agree) { ?> && $('#payment-address input[name=agree]').is(':checked')<?php } ?>)
        {
            $('#button-register').attr('disabled', false);
        } else {
            $('#button-register').attr('disabled', 'disabled');;
        }
    }).trigger('change');
    //--></script>
<?php
} else {
?>
<div style="margin-bottom: 10px"><?php echo $text_register_logged_in; ?></div>

<div class="buttons">
        <input type="button" value="<?php echo $button_continue; ?>" id="button-register-account" class="button" />
</div>
<?php
}
?>
