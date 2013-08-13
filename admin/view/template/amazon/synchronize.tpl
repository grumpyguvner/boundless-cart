<?php echo $header; ?>
<script type="text/javascript" src="<?php echo $js . 'synchronize.js' ?>" ></script>
<input type="hidden" id="amz-synchronize" value="<?php echo $synchronize ?>" />
<input type="hidden" id="amz-css" name="css" value="<?php echo $css ?>" />

<input type="hidden" id="entry_submit" value="<?php echo $entry_submit ?>" />
<input type="hidden" id="entry_lookup" value="<?php echo $entry_lookup ?>" />
<input type="hidden" id="entry_synchronized" value="<?php echo $entry_synchronized ?>" />

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
      <form action="lookup" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><?php echo $entry_title; ?></td>
          </tr>
          <tr>
            <td>
                    <div class="buttons" id="valid"><a class="button"><span class="action"><?php echo $entry_submit ?></span></a></div>
            </td>
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
                  $language_id = $language['language_id'] ;

                  $status  = 'status_' . $lng ;

                  $marketplace = 'marketplace_' . $lng ;
                  $marketplace_url = 'marketplace_url_' . $lng ;

                  $last_synch_never = 'last_synch_never_' . $lng ;
                  $last_synch   = 'last_synch_' . $lng ;

                  $synch_range  = 'synch_range_' . $lng ;
                  $synch_range1 = 'synch_range1_' . $lng ;
                  $synch_range2 = 'synch_range2_' . $lng ;
                ?>
                <div id="amazon-<?php echo $lng ?>" style="display:none;">
                    <input type="hidden" name="language" value="<?php echo $lng ?>" />
                    <input type="hidden" name="language_id" value="<?php echo $language_id ?>" />

                    <img src="view/image/amazon/flag_<?php echo $$marketplace ?>.png" alt="" />

                    <span class="marketplace-url" ><?php echo $$marketplace_url ?></span>
                    <span class="last-synch"><?php echo $$last_synch ? sprintf($$synch_range2, $$last_synch) : $$last_synch_never ?></span>

                    <span class="synch-action">
                        <?php echo $$synch_range ?> :&nbsp; &nbsp;
                        <select name="synch-date">
                            <?php echo '<option value="1970-01-01">' . $$synch_range1 . '</option>'  ?>
                            <?php if ( $$synch_range2 ) echo '<option value="'. $$last_synch .'" selected="selected">' . sprintf($$synch_range2, $$last_synch) . '</option>'  ?>
                        </select>
                    </span>

                    <span class="options"><?php echo $entry_options ?>
                        <input type="checkbox" class="lookup" name="lookup" value="1" checked="checked" />&nbsp;<label for="lookup"><?php echo $entry_lookup_products ?></label>
                    </span>
                </div>

                <?php
                }
                ?>
            </td>
          </tr>
            <td>
                <div id="amz-result">
                </div>

                <div id="amz-table">
                    <table class="result-table" id="created-table">
                    <thead>
                        <td colspan="6"><b></b>&nbsp;<?php echo $entry_product_created ?></td>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="6" style="display:none"></td>
                        </tr>
                    </tbody>
                    </table>

                    <table class="result-table" id="updated-table">
                    <thead>
                        <td colspan="6"><b></b>&nbsp;<?php echo $entry_product_updated ?></td>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="6" style="display:none"></td>
                        </tr>
                    </tbody>
                    </table>

                    <table class="result-table" id="ignored-table">
                    <thead>
                        <td colspan="6"><b></b>&nbsp;<?php echo $entry_product_ignored ?></td>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="6" style="display:none"></td>
                        </tr>
                    </tbody>
                    </table>

                    <table class="result-table" id="deleted-table">
                    <thead>
                        <td colspan="6"><b></b>&nbsp;<?php echo $entry_product_deleted ?></td>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="6" style="display:none"></td>
                        </tr>
                    </tbody>
                    </table>


                </div>
                <div class="cleaner"></div>
                <div id="some_html"></div>
            </td>
          <tr>
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