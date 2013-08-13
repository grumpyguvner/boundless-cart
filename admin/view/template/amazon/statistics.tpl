<?php echo $header; ?>
<script type="text/javascript" src="<?php echo $js . 'statistics.js' ?>" ></script>
<input type="hidden" id="amz-statistics" value="<?php echo $statistics ?>" />
<input type="hidden" id="amz-statisticsd" value="<?php echo $statisticsd ?>" />
<input type="hidden" id="amz-css" name="css" value="<?php echo $css ?>" />
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/feed.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_back; ?></span></a></div>
    </div>
    <div class="content">
      <form action="#" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><?php echo $entry_title; ?></td>
          </tr>
          <tr>
            <td>
                <div class="parameters">
                    <span class="options"><?php echo $entry_options ?></span>
                    <input type="checkbox" id="active" name="active" value="1" />&nbsp;<label for="active"><?php echo $entry_active_products ?></label>
                    <input type="checkbox" id="instock" name="instock" value="1" />&nbsp;<label for="active"><?php echo $entry_instock_products ?></label>
                    <span class="language"><?php echo $entry_language ?></span>
                    <select id="language" name="language" >
                    <option value="0" ><?php echo $entry_all ?></option>
                    <?php
                    foreach($languages as $language)
                    {
                    ?>
                        <option value="<?php echo $language['language_id'] ?>" ><?php echo ucfirst($language['name']) ?></option>
                    <?php
                    }
                    ?>
                    </select>
                    <input type="button" id="valid" value="<?php echo $entry_submit ?>" />
                </div>
            </td>
          </tr>
          <tr>
            <td>
                <div id="amz-result"></div>
            </td>
          </tr>
          <tr>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>