<?php echo $header; ?>
<script type="text/javascript" src="<?php echo $js . 'categories.js' ?>" ></script>
<input type="hidden" id="amz-validation" value="<?php echo $validation ?>" />
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
                 <div class="categories-map">
                     <select name="available-categories[]" id="available-categories" multiple="multiple">
                            <option disabled="disabled" style="color:silver;"><?php echo $entry_available_categories ?></option>' ;
                            <?php
                            foreach($categories as $category)
                            {
                                echo  '<option value="' . $category['id'] . '" >' . $category['name'] . '</option>' ;
                            }
                            ?>
                     </select>
                     <div class="sep">
                     <img src="view/image/amazon/arrow_left.png" id="move-left" class="move" alt="" /><br /><br />
                     <img src="view/image/amazon/arrow_right.png" id="move-right" class="move" alt="" />
                     </div>
                     <select name="selected-categories[]" id="selected-categories" multiple="multiple">
                            <option disabled="disabled" style="color:silver;"><?php echo $entry_selected_categories ?></option>' ;
                            <?php
                            foreach($selected as $category)
                            {
                                echo  '<option value="' . $category['id'] . '" >' . $category['name'] . '</option>' ;
                            }
                            ?>
                     </select>
                 </div>
            </td>
          </tr>
          <tr>
            <td>
            <div class="save buttons"><a href="#" class="button"><span><?php echo $button_save; ?></span></a></div>
            <div class="validation">test</div>
            </td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script>
<?php echo $footer; ?>