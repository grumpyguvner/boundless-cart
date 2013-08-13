<?php echo $header; ?>
<script type="text/javascript" src="<?php echo $js . 'lookup.js' ?>" ></script>
<input type="hidden" id="amz-lookup" value="<?php echo $lookup ?>" />
<input type="hidden" id="amz-create" value="<?php echo $create ?>" />
<input type="hidden" id="amz-choose-cat" value="<?php echo $entry_choose_category ?>" />

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
      <h1><img src="view/image/amazon/amazon.gif" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_back; ?></span></a></div>
    </div>
    <div class="content">
        <table class="form">
          <tr>
            <td><?php echo $entry_title; ?></td>
          </tr>
          <tr>
            <td>
                <div id="tabs" class="htabs">
                <?php foreach($languages as $language)
                {
                ?>
                    <a href="#amazon-<?php echo $language['code'] ?>" ><?php echo ucfirst($language['name']) ?></a>
                <?php
                }
                ?>
                </div>
                <?php foreach($languages as $language)
                {
                  $lng = $language['code'] ;
                  $status  = 'status_' . $lng ;

                  $marketplace = 'marketplace_' . $lng ;
                  $marketplace_url = 'marketplace_url_' . $lng ;

                  $adv_key = 'adv_key_' . $lng ;
                  $adv_secret_key = 'adv_secret_key_' . $lng ;

                ?>
                <form method="post" enctype="multipart/form-data" name="marketplace">

                <div id="amazon-<?php echo $lng ?>" style="display:none;">
                    <img src="view/image/amazon/flag_<?php echo $$marketplace ?>.png" alt="" />
                    <span class="marketplace-url" ><?php echo $$marketplace_url ?></span>

                    <input type="hidden" name="marketplace" value="<?php echo $$marketplace ?>" />
                    <input type="hidden" name="language" value="<?php echo $language['language_id'] ?>" />
                    <input type="hidden" name="adv_key" value="<?php echo $$adv_key ?>" />
                    <input type="hidden" name="adv_secret_key" value="<?php echo $$adv_secret_key ?>" />

                    <table class="amz-lookup">
                    <tr>
                        <td><?php echo $entry_types ?>
                        <select name="type" class="type">
                            <option value="EAN"><?php echo $entry_type_ean ?></option>
                            <option value="UPC"><?php echo $entry_type_upc ?></option>
                            <option value="ISBN"><?php echo $entry_type_isbn ?></option>
                            <option value="ASIN"><?php echo $entry_type_asin ?></option>
                        </select>
                        </td>
                        <td>
                            <span class="value"><?php echo $entry_value ?></span>
                            <input type="text" name="value" class="input-value" />
                        </td>
                        <td>
                        <div class="buttons lookup"><a class="button"><span><?php echo $button_lookup; ?></span></a></div>
                        </td>
                    </tr>
                    </table>
                </div>
                </form>
                <?php
                }
                ?>
            </td>
          </tr>
            <td>
                <div class="buttons create"><a class="button"><span><?php echo $button_create; ?></span></a></div>

                 <select name="categories" class="categories">
                        <option disabled="disabled" style="color:silver;" value="0"><?php echo $entry_categories ?></option>' ;
                        <?php
                        foreach($categories as $category)
                        {
                            echo  '<option value="' . $category['id'] . '" >' . $category['name'] . '</option>' ;
                        }
                        ?>
                 </select>

                <div id="amz-result"></div>
            </td>
          <tr>
          </tr>
        </table>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script>
<?php echo $footer; ?>