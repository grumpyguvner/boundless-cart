<?php echo $header; ?>
<div class="breadline">
    <div class="container">
      <div class="row"> 
          <div class="span12">
              <div id="container-in">
                <div class="breadcrumb">
                    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
                    <?php } ?>
                </div>
              </div>
            </div>
      </div>
    </div>
  </div>
    <div id="content-back">
    <div class="green-bar">
        <div id="container-in" class="content-in">
    <?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><div class="row"><?php echo $content_top; ?>
    <div class="margin-95" id="margin-t33">
      <h1 class="heading-account"><?php echo $heading_title; ?></h1>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
      <h2><?php echo $text_password; ?></h2>
    </div>
            <div class="content">
                <div class="row">
                  <div class="margin-65"> 
                    <div class="span2">
                        <span class="required">*</span> <?php echo $entry_password; ?>
                    </div>
                    <div class="span5">
                        <input type="password" name="password" value="<?php echo $password; ?>" />
                        <?php if ($error_password) { ?>
                        <span class="error"><?php echo $error_password; ?></span>
                        <?php } ?>
                    </div>
                    <div class="span2">
                        <span class="required">*</span> <?php echo $entry_confirm; ?>
                    </div>
                    <div class="span5">
                        <input type="password" name="confirm" value="<?php echo $confirm; ?>" />
                        <?php if ($error_confirm) { ?>
                        <span class="error"><?php echo $error_confirm; ?></span>
                        <?php } ?>
                    </div>
                  </div>  
                </div>
            </div>
       
                <div class="buttons">
                    <div id="margin-r50" class="margin-65">  
                        <div class="left"><a href="<?php echo $back; ?>" class="button-account"><?php echo $button_back; ?></a></div>
                        <div class="right"><input type="submit" value="<?php echo $button_continue; ?>" class="button-account" /></div>
                    </div>
               </div>
            
  </form>
  <?php echo $content_bottom; ?>
</div>
</div>
    </div>
    </div>
    </div>
<?php echo $footer; ?>