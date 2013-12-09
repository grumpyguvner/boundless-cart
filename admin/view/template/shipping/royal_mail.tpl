<?php echo $header; ?>

<div id="content">

	<?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-truck"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_save($button_save); ?>
				<?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
			</div>
    </div>

    <div class="content">
    <div class="tabbable tabs-left">

      <ul class="vtabs nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#tab-general"><?php echo $tab_general; ?></a></li>
				<li><a data-toggle="tab" href="#tab-1st-class-standard"><?php echo $tab_1st_class_standard; ?></a></li>
				<li><a data-toggle="tab" href="#tab-1st-class-recorded"><?php echo $tab_1st_class_recorded; ?></a></li>
				<li><a data-toggle="tab" href="#tab-2nd-class-standard"><?php echo $tab_2nd_class_standard; ?></a></li>
				<li><a data-toggle="tab" href="#tab-2nd-class-recorded"><?php echo $tab_2nd_class_recorded; ?></a></li>
				<li><a data-toggle="tab" href="#tab-special-delivery-500"><?php echo $tab_special_delivery_500; ?></a></li>
				<li><a data-toggle="tab" href="#tab-special-delivery-1000"><?php echo $tab_special_delivery_1000; ?></a></li>
				<li><a data-toggle="tab" href="#tab-special-delivery-2500"><?php echo $tab_special_delivery_2500; ?></a></li>
				<li><a data-toggle="tab" href="#tab-standard-parcels"><?php echo $tab_standard_parcels; ?></a></li>
				<li><a data-toggle="tab" href="#tab-airmail"><?php echo $tab_airmail; ?></a></li>
				<li><a data-toggle="tab" href="#tab-international-signed"><?php echo $tab_international_signed; ?></a></li>
				<li><a data-toggle="tab" href="#tab-airsure"><?php echo $tab_airsure; ?></a></li>
				<li><a data-toggle="tab" href="#tab-surface"><?php echo $tab_surface; ?></a></li>
			</ul>

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
			<div class="tab-content">

				<div class="tab-pane active" id="tab-general" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_display_weight; ?></label>
              <div class="controls">
								<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
								<?php echo p3html::tb_bool_buttons_radio($this->language, 'royal_mail_display_weight', $royal_mail_display_weight); ?>
								<?php } else { ?>
								<?php echo p3html::tb_bool_radio_buttons($this->language, 'royal_mail_display_weight', $royal_mail_display_weight); ?>
								<?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_display_insurance; ?></label>
              <div class="controls">
								<?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
								<?php echo p3html::tb_bool_buttons_radio($this->language, 'royal_mail_display_insurance', $royal_mail_display_insurance); ?>
								<?php } else { ?>
								<?php echo p3html::tb_bool_radio_buttons($this->language, 'royal_mail_display_insurance', $royal_mail_display_insurance); ?>
								<?php } ?>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_weight_class; ?></label>
              <div class="controls">
								<select name="royal_mail_weight_class_id" class="span2">
									<?php echo p3html::oc_weight_class_options($weight_classes, $royal_mail_weight_class_id); ?>
                </select>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_tax_class; ?></label>
              <div class="controls">
								<select name="royal_mail_tax_class_id" class="span3">
                  <option value="0"><?php echo $text_none; ?></option>
									<?php echo p3html::oc_tax_class_options($tax_classes, $royal_mail_tax_class_id); ?>
                </select>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_geo_zone; ?></label>
              <div class="controls">
								<select name="royal_mail_geo_zone_id" class="span3">
                  <option value="0"><?php echo $text_all_zones; ?></option>
									<?php echo p3html::oc_geo_zone_options($geo_zones, $royal_mail_geo_zone_id); ?>
                </select>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
								<select name="royal_mail_status" class="span2 i-small">
									<?php echo p3html::oc_status_options($this->language, (int)$royal_mail_status); ?>
                </select>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_sort_order; ?></label>
              <div class="controls">
								<input type="text" name="royal_mail_sort_order" value="<?php echo $royal_mail_sort_order; ?>" class="span1 i-mini">
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-1st-class-standard" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_rate; ?></label>
              <div class="controls"><textarea name="royal_mail_1st_class_standard_rate" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_1st_class_standard_rate; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_insurance; ?></label>
              <div class="controls"><textarea name="royal_mail_1st_class_standard_insurance" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_1st_class_standard_insurance; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
								<select name="royal_mail_1st_class_standard_status" class="span2 i-small">
									<?php echo p3html::oc_status_options($this->language, (int)$royal_mail_1st_class_standard_status); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-1st-class-recorded" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_rate; ?></label>
              <div class="controls">
								<textarea name="royal_mail_1st_class_recorded_rate" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_1st_class_recorded_rate; ?></textarea>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_insurance; ?></label>
              <div class="controls">
								<textarea name="royal_mail_1st_class_recorded_insurance" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_1st_class_recorded_insurance; ?></textarea>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
								<select name="royal_mail_1st_class_recorded_status" class="span2 i-small">
									<?php echo p3html::oc_status_options($this->language, (int)$royal_mail_1st_class_recorded_status); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-2nd-class-standard" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_rate; ?></label>
              <div class="controls"><textarea name="royal_mail_2nd_class_standard_rate" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_2nd_class_standard_rate; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
								<select name="royal_mail_2nd_class_standard_status" class="span2 i-small">
									<?php echo p3html::oc_status_options($this->language, (int)$royal_mail_2nd_class_standard_status); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-2nd-class-recorded" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_rate; ?></label>
              <div class="controls">
								<textarea name="royal_mail_2nd_class_recorded_rate" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_2nd_class_recorded_rate; ?></textarea>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_insurance; ?></label>
              <div class="controls">
								<textarea name="royal_mail_2nd_class_recorded_insurance" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_2nd_class_recorded_insurance; ?></textarea>
							</div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
								<select name="royal_mail_2nd_class_recorded_status" class="span2 i-small">
									<?php echo p3html::oc_status_options($this->language, (int)$royal_mail_2nd_class_recorded_status); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-special-delivery-500" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_rate; ?></label>
              <div class="controls"><textarea name="royal_mail_special_delivery_500_rate" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_special_delivery_500_rate; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_insurance; ?></label>
              <div class="controls"><textarea name="royal_mail_special_delivery_500_insurance" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_special_delivery_500_insurance; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
								<select name="royal_mail_special_delivery_500_status" class="span2 i-small">
									<?php echo p3html::oc_status_options($this->language, (int)$royal_mail_special_delivery_500_status); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-special-delivery-1000" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_rate; ?></label>
              <div class="controls"><textarea name="royal_mail_special_delivery_1000_rate" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_special_delivery_1000_rate; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_insurance; ?></label>
              <div class="controls"><textarea name="royal_mail_special_delivery_1000_insurance" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_special_delivery_1000_insurance; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
								<select name="royal_mail_special_delivery_1000_status" class="span2 i-small">
									<?php echo p3html::oc_status_options($this->language, (int)$royal_mail_special_delivery_1000_status); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-special-delivery-2500" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_rate; ?></label>
              <div class="controls"><textarea name="royal_mail_special_delivery_2500_rate" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_special_delivery_2500_rate; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_insurance; ?></label>
              <div class="controls"><textarea name="royal_mail_special_delivery_2500_insurance" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_special_delivery_2500_insurance; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
								<select name="royal_mail_special_delivery_2500_status" class="span2 i-small">
									<?php echo p3html::oc_status_options($this->language, (int)$royal_mail_special_delivery_2500_status); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-standard-parcels" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_rate; ?></label>
              <div class="controls"><textarea name="royal_mail_standard_parcels_rate" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_standard_parcels_rate; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_insurance; ?></label>
              <div class="controls"><textarea name="royal_mail_standard_parcels_insurance" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_standard_parcels_insurance; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
								<select name="royal_mail_standard_parcels_status" class="span2 i-small">
									<?php echo p3html::oc_status_options($this->language, (int)$royal_mail_standard_parcels_status); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-airmail" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_airmail_rate_1; ?></label>
              <div class="controls"><textarea name="royal_mail_airmail_rate_1" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_airmail_rate_1; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_airmail_rate_2; ?></label>
              <div class="controls"><textarea name="royal_mail_airmail_rate_2" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_airmail_rate_2; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
								<select name="royal_mail_airmail_status" class="span2 i-small">
									<?php echo p3html::oc_status_options($this->language, (int)$royal_mail_airmail_status); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-international-signed" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_international_signed_rate_1; ?></label>
              <div class="controls"><textarea name="royal_mail_international_signed_rate_1" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_international_signed_rate_1; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_international_signed_insurance_1; ?></label>
              <div class="controls"><textarea name="royal_mail_international_signed_insurance_1" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_international_signed_insurance_1; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_international_signed_rate_2; ?></label>
              <div class="controls"><textarea name="royal_mail_international_signed_rate_2" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_international_signed_rate_2; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_international_signed_insurance_2; ?></label>
              <div class="controls"><textarea name="royal_mail_international_signed_insurance_2" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_international_signed_insurance_2; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
								<select name="royal_mail_international_signed_status" class="span2 i-small">
									<?php echo p3html::oc_status_options($this->language, (int)$royal_mail_international_signed_status); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-airsure" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_airsure_rate_1; ?></label>
              <div class="controls"><textarea name="royal_mail_airsure_rate_1" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_airsure_rate_1; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_airsure_insurance_1; ?></label>
              <div class="controls"><textarea name="royal_mail_airsure_insurance_1" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_airsure_insurance_1; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_airsure_rate_2; ?></label>
              <div class="controls"><textarea name="royal_mail_airsure_rate_2" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_airsure_rate_2; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_airsure_insurance_2; ?></label>
              <div class="controls"><textarea name="royal_mail_airsure_insurance_2" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_airsure_insurance_2; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></label>
              <div class="controls">
								<select name="royal_mail_airsure_status" class="span2 i-small">
									<?php echo p3html::oc_status_options($this->language, (int)$royal_mail_airsure_status); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

        <div class="tab-pane" id="tab-surface" class="vtabs-content">
          <div class="form">
            <div class="control-group">
              <label class="control-label"><?php echo $entry_rate; ?></label>
              <div class="controls"><textarea name="royal_mail_surface_rate" class="span6 i-xxlarge" rows="5"><?php echo $royal_mail_surface_rate; ?></textarea></div>
            </div>
            <div class="control-group">
              <label class="control-label"><?php echo $entry_status; ?></div>
              <div class="controls">
								<select name="royal_mail_surface_status" class="span2 i-small">
									<?php echo p3html::oc_status_options($this->language, (int)$royal_mail_surface_status); ?>
                </select>
							</div>
            </div>
          </div>
        </div>

			</div>
      </form>

    </div>
    </div>
  </div>
</div>

<?php echo $footer; ?>