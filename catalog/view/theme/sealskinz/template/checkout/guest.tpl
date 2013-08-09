
    <div class="left" style="border-right: none;">
        
            <h2><?php echo $text_your_details; ?></h2>
            <div class="prow">
                <div class="pLabel">
                    <span class="required">*</span> <?php echo $entry_firstname; ?>
                </div>
                <div class="pInput">
                    <input type="text" name="firstname" value="<?php echo $firstname; ?>" class="large-field" />
                </div>
            </div>
            <div class="prow">
                <div class="pLabel">
                    <span class="required">*</span> <?php echo $entry_lastname; ?>
                </div>
                <div class="pInput">
                    <input type="text" name="lastname" value="<?php echo $lastname; ?>" class="large-field" />
                </div>
            </div>
            <div class="prow">
                <div class="pLabel">
                    <span class="required">*</span> <?php echo $entry_email; ?>
                </div>
                <div class="pInput">
                    <input type="text" name="email" value="<?php echo $email; ?>" class="large-field" />
                </div>
            </div>
            <div class="prow">
                <div class="pLabel">
                    <span class="required">*</span> <?php echo $entry_telephone; ?>
                </div>
                <div class="pInput">
                    <input type="text" name="telephone" value="<?php echo $telephone; ?>" class="large-field" />
                </div>
            </div>
            <div class="prow" style="display: <?php echo (count($customer_groups) > 1 ? 'table-row' : 'none'); ?>;"> <?php echo $entry_customer_group; ?>
                <div class="prow">
                    <?php foreach ($customer_groups as $customer_group) { ?>
                        <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
                            <div class="pLabel">  
                                <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                            </div>
                            <div class="pInput">
                                <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
                            </div>
                        <?php } else { ?>
                            <div class="pLabel">
                                <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
                            </div>
                            <div class="pInput">  
                                <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
                            </div>
                        <?php } ?>
                    <?php } ?>
                </div>

            </div>
            <input type="hidden" name="fax" value="<?php echo $fax; ?>" />
    </div>

<div class="buttons">
        <input type="button" value="<?php echo $button_continue; ?>" id="button-guest" class="button" />
</div>