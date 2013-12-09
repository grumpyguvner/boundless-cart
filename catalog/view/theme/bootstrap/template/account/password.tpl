<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
    <div class="row">
        <div class="span12">
            <div class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
            <?php } ?>
          </div>
        </div>
    </div>
    <div class="row">
        <div class="span12">
           
                <h1><?php echo $heading_title; ?></h1>
            
        </div>
    </div>
    
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <h2><?php echo $text_password; ?></h2>
    <div class="row">
        <div class="span12">
            <div class="content">
                <div class="row">
                    <div class="span2">
                        <span class="required">*</span> <?php echo $entry_password; ?>
                    </div>
                    <div class="span9">
                        <input type="password" name="password" value="<?php echo $password; ?>" />
                        <?php if ($error_password) { ?>
                        <span class="error"><?php echo $error_password; ?></span>
                        <?php } ?>
                    </div>
                    <div class="span2">
                        <span class="required">*</span> <?php echo $entry_confirm; ?>
                    </div>
                    <div class="span9">
                        <input type="password" name="confirm" value="<?php echo $confirm; ?>" />
                        <?php if ($error_confirm) { ?>
                        <span class="error"><?php echo $error_confirm; ?></span>
                        <?php } ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
        <div class="row">
            <div class="span12">
                <div class="buttons">
                  <div class="left"><a href="<?php echo $back; ?>" class="btn"><?php echo $button_back; ?></a></div>
                  <div class="right"><input type="submit" value="<?php echo $button_continue; ?>" class="btn" /></div>
                </div>
            </div>
        </div>
  </form>
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>