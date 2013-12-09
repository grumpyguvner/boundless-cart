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

            <h1><?php echo strtoupper($heading_title); ?></h1>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                <h2><?php echo $text_your_details; ?></h2>

                <div class="wrapContentAccount content">
                    <div class="prow">
                        <div class="pLabel">  
                            <span class="required">*</span> <span><?php echo $entry_title; ?></span>
                        </div>
                        <div class="pInput">
                            <select class="registerTitle" name="title"><option></option><?php
                            foreach ($select_title as $titles)
                            {
                                if ($titles == $title) {
                                    echo '<option selected="selected">' . $titles . '</option>';
                                } else {
                                    echo '<option>' . $titles . '</option>';
                                }
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
                                if ($day_birth) {
                                    for ($i = 1930; $i <= $actYear; $i++) {
                                        if ($i == $year_birth) {
                                           echo '<option value="'.$year_birth.'" selected="selected">'.$year_birth.'</option>'; 
                                        } else {
                                           echo '<option value="'.$i.'">'.$i.'</option>';
                                        } 
                                    }
                                } else {
                                    echo '<option value=""></option>';
                                    for($i = 1930; $i <= $actYear; $i++) {
                                        echo '<option value="'.$i.'">'.$i.'</option>';
                                    }
                                }
                                ?>
                            </select>
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
<?php echo $footer; ?>