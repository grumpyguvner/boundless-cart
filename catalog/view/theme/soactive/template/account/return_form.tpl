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
    <div id="accountNoImage"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content"> 
            <?php echo $content_top; ?>
            <div class="content-account">
                <h1><?php echo $heading_title; ?></h1>
                <?php echo $text_description; ?>
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                    <h2><?php echo $text_order; ?></h2>
                    <div class="wrapContentAccount content">
                        <div class="row"> 
                            <div class="span4">
                                <div class="left">
                                    <span class="required">*</span> <?php echo $entry_firstname; ?><br />
                                    <input type="text" name="firstname" value="<?php echo $firstname; ?>" />
                                    <br />
                                    <?php if ($error_firstname) { ?>
                                        <span class="error"><?php echo $error_firstname; ?></span>
                                    <?php } ?>
                                    <br />
                                    <span class="required">*</span> <?php echo $entry_lastname; ?><br />
                                    <input type="text" name="lastname" value="<?php echo $lastname; ?>" />
                                    <br />
                                    <?php if ($error_lastname) { ?>
                                        <span class="error"><?php echo $error_lastname; ?></span>
                                    <?php } ?>
                                    <br />
                                    <span class="required">*</span> <?php echo $entry_email; ?><br />
                                    <input type="text" name="email" value="<?php echo $email; ?>" />
                                    <br />
                                    <?php if ($error_email) { ?>
                                        <span class="error"><?php echo $error_email; ?></span>
                                    <?php } ?>
                                    <br />
                                    <span class="required">*</span> <?php echo $entry_telephone; ?><br />
                                    <input type="text" name="telephone" value="<?php echo $telephone; ?>" />
                                    <br />
                                    <?php if ($error_telephone) { ?>
                                        <span class="error"><?php echo $error_telephone; ?></span>
                                    <?php } ?>
                                    <br />
                                </div>
                            </div>
                            <div class="span3">

                                <span class="required">*</span> <?php echo $entry_order_id; ?><br />
                                    <input type="text" name="order_id" value="<?php echo $order_id; ?>" />
                                    <br />
                                    <?php if ($error_order_id) { ?>
                                        <span class="error"><?php echo $error_order_id; ?></span>
                                    <?php } ?>
                                    <br />
                                    <?php echo $entry_date_ordered; ?><br />
                                    <input type="text" name="date_ordered" value="<?php echo $date_ordered; ?>" />
                                    <br />

                            </div>
                        </div>
                    </div>
                    <h2><?php echo $text_product; ?></h2>
                    <div id="return-product">


                        <div class="wrapContentAccount content">
                            <div class="row"> 


                                <div class="return-product">

                                    <div class="span4">
                                        <div class="return-name"><span class="required">*</span> <b><?php echo $entry_product; ?></b><br />
                                            <input type="text" name="product" value="<?php echo $product; ?>" />
                                            <br />
                                            <?php if ($error_product) { ?>
                                                <span class="error"><?php echo $error_product; ?></span>
                                            <?php } ?>
                                        </div>
                                    </div>

                                    <div class="span4">
                                        <div class="return-model"><span class="required">*</span> <b><?php echo $entry_model; ?></b><br />
                                            <input type="text" name="model" value="<?php echo $model; ?>" />
                                            <br />
                                            <?php if ($error_model) { ?>
                                                <span class="error"><?php echo $error_model; ?></span>
                                            <?php } ?>
                                        </div>
                                    </div>

                                    <div class="span1">
                                        <div class="return-quantity"><b><?php echo $entry_quantity; ?></b><br />
                                            <input type="text" name="quantity" value="<?php echo $quantity; ?>" />
                                        </div>
                                    </div>
                                </div>

                            </div>

                                <div class="return-detail">
                                        <div class="return-reason"><span class="required">*</span> <b><?php echo $entry_reason; ?></b><br />
                                            <table>
                                                <?php foreach ($return_reasons as $return_reason) { ?>
                                                    <?php if ($return_reason['return_reason_id'] == $return_reason_id) { ?>
                                                        <tr>
                                                            <td width="1"><input type="radio" name="return_reason_id" value="<?php echo $return_reason['return_reason_id']; ?>" id="return-reason-id<?php echo $return_reason['return_reason_id']; ?>" checked="checked" /></td>
                                                            <td><label for="return-reason-id<?php echo $return_reason['return_reason_id']; ?>"><?php echo $return_reason['name']; ?></label></td>
                                                        </tr>
                                                    <?php } else { ?>
                                                        <tr>
                                                            <td width="1"><input type="radio" name="return_reason_id" value="<?php echo $return_reason['return_reason_id']; ?>" id="return-reason-id<?php echo $return_reason['return_reason_id']; ?>" /></td>
                                                            <td><label for="return-reason-id<?php echo $return_reason['return_reason_id']; ?>"><?php echo $return_reason['name']; ?></label></td>
                                                        </tr>
                                                    <?php } ?>
                                                <?php } ?>
                                            </table>
                                            <?php if ($error_reason) { ?>
                                                <span class="error"><?php echo $error_reason; ?></span>
                                            <?php } ?>
                                        </div>

                                        <div class="return-opened"><b><?php echo $entry_opened; ?></b><br />
                                            <?php if ($opened) { ?>
                                                <input type="radio" name="opened" value="1" id="opened" checked="checked" />
                                            <?php } else { ?>
                                                <input type="radio" name="opened" value="1" id="opened" />
                                            <?php } ?>
                                            <label for="opened"><?php echo $text_yes; ?></label>
                                            <?php if (!$opened) { ?>
                                                <input type="radio" name="opened" value="0" id="unopened" checked="checked" />
                                            <?php } else { ?>
                                                <input type="radio" name="opened" value="0" id="unopened" />
                                            <?php } ?>
                                            <label for="unopened"><?php echo $text_no; ?></label>
                                            <br />
                                            <br />
                                            <?php echo $entry_fault_detail; ?><br />
                                            <textarea name="comment" cols="150" rows="6"><?php echo $comment; ?></textarea>
                                        </div>

                                        <div class="return-captcha"><b><?php echo $entry_captcha; ?></b><br />
                                            <input type="text" name="captcha" value="<?php echo $captcha; ?>" />
                                            <br />
                                            <img src="index.php?route=account/return/captcha" alt="" />
                                            <?php if ($error_captcha) { ?>
                                                <span class="error"><?php echo $error_captcha; ?></span>
                                            <?php } ?>
                                        </div>

                                </div>

                        </div>

                    </div>
                    <div class="buttons">
                        <div class="buttonLeft"><a href="<?php echo $back; ?>" class="button"><?php echo strtoupper($button_back); ?></a></div>
                        <div class="buttonRight"><input type="submit" value="<?php echo strtoupper($button_continue); ?>" class="button" /></div>
                    </div>
                </form>
            </div>
            <?php echo $content_bottom; ?>
        </div>
    </div>
<script type="text/javascript"><!--
    $(document).ready(function() {
        $('.date').datepicker({dateFormat: 'yy-mm-dd'});
    });
    //--></script> 
<?php echo $footer; ?>