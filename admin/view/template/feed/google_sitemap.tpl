<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">
    <div class="heading">
      <h1><i class="icon-google"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_save($button_save); ?>
				<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
			</div>
    </div>

    <div class="content">

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
        <div class="form">
          <div class="control-group">
            <label class="control-label"><?php echo $entry_status; ?></label>
            <div class="controls">
							<select name="google_sitemap_status" class="input-medium">
                <?php echo p3html::oc_status_options($this->language, $google_sitemap_status); ?>
              </select>
						</div>
          </div>
          <div class="control-group">
            <label class="control-label"><?php echo $entry_data_feed; ?></label>
            <div class="controls"><textarea class="span6 i-xxlarge" rows="5"><?php echo $data_feed; ?></textarea></div>
          </div>
            
          <div class="control-group">
            <label class="control-label"><?php echo $entry_products; ?></label>
            <div class="controls">
                <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                    <?php echo p3html::tb_bool_buttons_radio($this->language, 'google_sitemap_products', $google_sitemap_products); ?>
                <?php } else { ?>
                    <?php echo p3html::tb_bool_radio_buttons($this->language, 'google_sitemap_products', $google_sitemap_products); ?>
                <?php } ?>
            </div>
        </div>
          
         <div class="control-group">
            <label class="control-label"><?php echo $entry_products_category; ?></label>
            <div class="controls">
                <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                    <?php echo p3html::tb_bool_buttons_radio($this->language, 'google_sitemap_products_category', $google_sitemap_products_category); ?>
                <?php } else { ?>
                    <?php echo p3html::tb_bool_radio_buttons($this->language, 'google_sitemap_products_category', $google_sitemap_products_category); ?>
                <?php } ?>
            </div>
        </div>
            
        </div>
      </form>

    </div>
  </div>

</div>

<?php echo $footer; ?>