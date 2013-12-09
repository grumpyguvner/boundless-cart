<?php echo $header; ?>
<div id="content">
  
  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>
    
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
            <?php echo p3html::tb_form_button_save($button_save); ?>
            <?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
      </div>
    </div>
    <div class="content">
            <ul class="nav nav-tabs" id="myTab">
              <li class="active"><a data-toggle="tab" href="#tab-general"><?php echo $tab_general; ?></a></li>
              <li><a data-toggle="tab" href="#tab-option">Option</a></li>
              <?php if ($advanced_coupon_id) { ?>
                <li><a data-toggle="tab" href="#tab-history"><?php echo $tab_advanced_coupon_history; ?></a></li>
              <?php } ?>
            </ul>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
        <div class="tab-content" id="myTabContent">
              <div id="tab-general" class="tab-pane fade in active">
                <div class="form">
                    <div class="control-group<?php if ($error_name) { ?> error<?php } ?>">
                        <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
                        <div class="controls">
                            <input type="text" name="name" value="<?php echo $name; ?>" class="span3">
                            <?php if ($error_name) { ?>
                                <span class="error help-block"><?php echo $error_name; ?></span>
                            <?php } ?>
                        </div>
                   </div>
                   <div class="control-group<?php if ($error_code) { ?> error<?php } ?>">
                        <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_code; ?></label>
                        <div class="controls">
                            <input type="text" name="code" value="<?php echo $code; ?>" class="span2">
                            <?php if ($error_code) { ?>
                                <span class="error help-block"><?php echo $error_code; ?></span>
                            <?php } ?>
                        </div>
                  </div>
                  <div class="control-group">
                        <label class="control-label"><?php echo $entry_type; ?></label>
                        <div class="controls">
                            <select name="type" class="span2">
                                <?php if ($type == 'P') { ?>
                                <option value="P" selected="selected"><?php echo $text_percent; ?></option>
                                <?php } else { ?>
                                <option value="P"><?php echo $text_percent; ?></option>
                                <?php } ?>
                                <?php if ($type == 'F') { ?>
                                <option value="F" selected="selected"><?php echo $text_amount; ?></option>
                                <?php } else { ?>
                                <option value="F"><?php echo $text_amount; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                 </div>
                 <div class="control-group">
                    <label class="control-label"><?php echo $entry_discount; ?></label>
                    <div class="controls">
                        <input type="text" name="discount" value="<?php echo $discount; ?>" class="span2">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><?php echo $entry_quantity_total; ?></label>
                    <div class="controls">
                        <input type="text" name="quantity_total" value="<?php echo $quantity_total; ?>" class="span2"/>
                        <?php if ($error_quantity_total) { ?>
                            <span class="error"><?php echo $error_quantity_tota; ?></span>
                        <?php } ?>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><?php echo $entry_total; ?></label>
                    <div class="controls">
                        <input type="text" name="total" value="<?php echo $total; ?>" class="span2">
                        <?php if ($error_total) { ?>
                            <span class="error"><?php echo $error_total; ?></span>
                        <?php } ?>
                    </div>
                </div>
                    
                <div class="control-group">
                   <label class="control-label"><?php echo $entry_product; ?></label>
                   <div class="controls">
                     <table>
                        <tr>
                          <td>
                            <?php echo $entry_category; ?>
                            <div class="scrollbox">
                                <?php $class = 'odd'; ?>
                                <?php foreach ($categories as $category) { ?>
                                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                <div class="<?php echo $class; ?>">
                                                      <?php 
                                  if(isset($match_category_ids)){
                                      if(in_array($category['category_id'],$match_category_ids)){
                                              $checked = 'checked="checked"';

                                      }else{
                                              $checked = '';
                                      }
                                     }
                                  ?>
                                  <input type="checkbox" name="category[]" value="<?php echo $category['category_id']; ?>" <?php if(isset($checked)){ echo $checked; } ?> />                    <?php echo $category['name']; ?> </div>
                                <?php } ?>
                            </div>
                            <a onclick="$(this).parent().find(':checkbox').attr('checked', true); CategorySelectAll();"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false); CategorySelectAll();"><?php echo $text_unselect_all; ?></a>
                          </td>
                          <td>&nbsp;</td>
                          <td><?php echo $entry_manufacturer; ?><br/>
                            <div class="scrollbox">
                                <?php $class = 'odd'; ?>
                                <?php foreach ($manufacturers as $manufacturer) { ?>
                                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                <div class="<?php echo $class; ?>">
                                                      <?php 
                                  if(isset($match_manufacturer_ids)){
                                      if(in_array($manufacturer['manufacturer_id'],$match_manufacturer_ids)){
                                              $checked = 'checked="checked"';
                                      }else{
                                              $checked = '';
                                      }
                                     }
                                  ?>
                                  <input type="checkbox" name="manufacturer[]" value="<?php echo $manufacturer['manufacturer_id']; ?>" <?php if(isset($checked)){ echo $checked; } ?> />                    <?php echo $manufacturer['name']; ?> </div>
                                <?php } ?>
                            </div>
                            <a onclick="$(this).parent().find(':checkbox').attr('checked', true); CategoryManufacturerSelectAll();"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false); CategoryManufacturerSelectAll();"><?php echo $text_unselect_all; ?></a>
                          </td>
                        </tr>
            
                        <tr>
                          <td><?php echo $entry_product_product; ?>
                          <input type="text" name="product_suggest" value="" />
                          </td>
                          <td>&nbsp;</td>
                          <td><div class="scrollbox" id="advanced_coupon-product">
                              <?php $class = 'odd'; ?>
                              <?php foreach ($advanced_coupon_product as $advanced_coupon_product) { ?>
                              <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                              <div id="advanced_coupon-product<?php echo $advanced_coupon_product['product_id']; ?>" class="<?php echo $class; ?>"> <?php echo $advanced_coupon_product['name']; ?><img src="view/image/delete.png" />
                                <input type="hidden" name="product[]" value="<?php echo $advanced_coupon_product['product_id']; ?>" />
                              </div>
                              <?php } ?>
                            </div>
                           </td>
                        </tr> 
                     </table>
                   </div>
                </div>
           
            <div class="control-group">
                <label class="control-label"><?php echo $entry_quantity_buy; ?></label>
                <div class="controls">
                    <input type="text" name="quantity_buy" value="<?php echo $quantity_buy; ?>" class="span2"/>
                    <?php if ($error_quantity_buy) { ?>
                      <span class="error"><?php echo $error_quantity_buy; ?></span>
                    <?php } ?>
                </div>
            </div>
                       
            <div class="control-group">
                <label class="control-label"><?php echo $entry_quantity_sale; ?></label>
                <div class="controls">
                    <input type="text" name="quantity_sale" value="<?php echo $quantity_sale; ?>" class="span2" />
              <?php if ($error_quantity_sale) { ?>
                <span class="error"><?php echo $error_quantity_sale; ?></span>
                <?php } ?>
                </div>
            </div>
            
            <div class="control-group">
                <label class="control-label"><?php echo $entry_quantity_type; ?></label>
                <div class="controls">
                    <select name="quantity_type" class="span2">
                  <?php if ($quantity_type == 'P') { ?>
                  <option value="P" selected="selected"><?php echo $text_proportional; ?></option>
                  <?php } else { ?>
                  <option value="P"><?php echo $text_proportional; ?></option>
                  <?php } ?>
                  <?php if ($quantity_type == 'F') { ?>
                  <option value="F" selected="selected"><?php echo $text_fixed; ?></option>
                  <?php } else { ?>
                  <option value="F"><?php echo $text_fixed; ?></option>
                  <?php } ?>
                  </select>
                </div>
            </div>
                    
         <div class="control-group">
               <label class="control-label"><?php echo $entry_product; ?></label>
               <div class="controls">
                 <?php echo $entry_product_buy; ?>
                 <table>
                    <tr>
                        <td>
                            <?php echo $entry_category; ?><br/>
                            <div class="scrollbox">
                                <?php $class = 'odd'; ?>
                                <?php foreach ($categories as $category_buy) { ?>
                                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                <div class="<?php echo $class; ?>">
                                                      <?php 
                                  if(isset($match_category_buy_ids)){
                                      if(in_array($category_buy['category_id'],$match_category_buy_ids)){
                                              $checked = 'checked="checked"';
                                      }else{
                                              $checked = '';
                                      }
                                      }
                                  ?>

                                  <input type="checkbox" name="category_buy[]" value="<?php echo $category_buy['category_id']; ?>" <?php if(isset($checked)){ echo $checked; } ?>/>                    <?php echo $category_buy['name']; ?> </div>
                                <?php } ?>
                            </div>
                            <a onclick="$(this).parent().find(':checkbox').attr('checked', true); CategoryBuySelectAll();"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false); CategoryBuySelectAll();"><?php echo $text_unselect_all; ?></a>
                        </td>
                        <td>&nbsp;</td>
                        <td><?php echo $entry_manufacturer; ?><br/>
                            <div class="scrollbox">
                                <?php $class = 'odd'; ?>
                                <?php foreach ($manufacturers as $manufacturer_buy) { ?>
                                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                <div class="<?php echo $class; ?>">
                                                      <?php 
                                  if(isset($match_manufacturer_buy_ids)){
                                      if(in_array($manufacturer_buy['manufacturer_id'],$match_manufacturer_buy_ids)){
                                              $checked = 'checked="checked"';
                                      }else{
                                              $checked = '';
                                      }
                                     }
                                  ?>
                                  <input type="checkbox" name="manufacturer_buy[]" value="<?php echo $manufacturer_buy['manufacturer_id']; ?>" <?php if(isset($checked)){ echo $checked; } ?> />                    <?php echo $manufacturer_buy['name']; ?> </div>
                                <?php } ?>
                          </div>
                          <a onclick="$(this).parent().find(':checkbox').attr('checked', true); CategoryBuyManufacturerSelectAll();"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false); CategoryBuyManufacturerSelectAll();"><?php echo $text_unselect_all; ?></a>
                        </td>
                    </tr>
                    <tr>
                      <td><?php echo $entry_product_product; ?><br/>
                      <input type="text" name="product_buy_suggest" value="" />
                      </td>
                      <td>&nbsp;</td>
                      <td><div class="scrollbox" id="advanced_coupon-product_buy">
                          <?php $class = 'odd'; ?>
                          <?php foreach ($advanced_coupon_product_buy as $advanced_coupon_product_buy) { ?>
                          <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                          <div id="advanced_coupon-product_buy<?php echo $advanced_coupon_product_buy['product_id']; ?>" class="<?php echo $class; ?>"> <?php echo $advanced_coupon_product_buy['name']; ?><img src="view/image/delete.png" />
                            <input type="hidden" name="product_buy[]" value="<?php echo $advanced_coupon_product_buy['product_id']; ?>" />
                          </div>
                          <?php } ?>
                        </div></td>
                    </tr>
                 </table>
               </div>
         </div>
                                    
            <div class="control-group">
                <label class="control-label"><?php echo $entry_date_start; ?></label>
                <div class="controls">
                    <input type="text" name="date_start" value="<?php echo $date_start; ?>" size="12" class="date span2" id="date-start">
                </div>
            </div>
            
            <div class="control-group">
                <label class="control-label"><?php echo $entry_date_end; ?></label>
                <div class="controls">
                    <input type="text" name="date_end" value="<?php echo $date_end; ?>" size="12" class="date span2" id="date-end">
                </div>
            </div>
            
            <div class="control-group">
                <label class="control-label"><?php echo $entry_uses_total; ?></label>
                <div class="controls">
                    <input type="text" name="uses_total" value="<?php echo $uses_total; ?>" class="span1">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><?php echo $entry_uses_customer; ?></label>
                <div class="controls">
                    <input type="text" name="uses_customer" value="<?php echo $uses_customer; ?>" class="span1">
                    <?php if ($error_uses_customer) { ?>
                        <span class="error"><?php echo $error_uses_customer; ?></span>
                    <?php } ?>
                </div>
            </div>
            
            <div class="control-group">
                <label class="control-label"><?php echo $entry_status; ?></label>
                <div class="controls">
                    <select name="status" class="span2">
                        <?php if ($status) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                    </select>
                </div>
            </div>
            
          </div>
              </div>
              <div id="tab-option" class="tab-pane fade">
                  <div class="control-group">
                    <label class="control-label"><?php echo $entry_logged; ?></label>
                    <div class="controls">
                        <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                            <?php echo p3html::tb_bool_buttons_radio($this->language, 'logged', $logged); ?>
                        <?php } else { ?>
                            <?php echo p3html::tb_bool_radio_buttons($this->language, 'logged', $logged); ?>
                        <?php } ?>
                    </div>
                  </div>
                
            
            <div class="control-group">
                <label class="control-label"><?php echo $entry_shipping; ?></label>
                <div class="controls">
                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'shipping', $shipping); ?>
                    <?php } else { ?>
                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'shipping', $shipping); ?>
                    <?php } ?>
                </div>
            </div>
            
            <div class="control-group">
                <label class="control-label"><?php echo $entry_coupon_combine; ?></label>
                <div class="controls">
                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'coupon_combine', $coupon_combine); ?>
                    <?php } else { ?>
                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'coupon_combine', $coupon_combine); ?>
                    <?php } ?>
                </div>
            </div>
                    
            <div class="control-group">
                <label class="control-label"><?php echo $entry_special_combine; ?></label>
                <div class="controls">
                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'special_combine', $special_combine); ?>
                    <?php } else { ?>
                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'special_combine', $special_combine); ?>
                    <?php } ?>
                </div>
            </div>
                    
            <div class="control-group">
                <label class="control-label"><?php echo $entry_discount_combine; ?></label>
                <div class="controls">
                    <?php if ($this->config->get('p3adminrebooted_toggle_buttons')) { ?>
                        <?php echo p3html::tb_bool_buttons_radio($this->language, 'discount_combine', $discount_combine); ?>
                    <?php } else { ?>
                        <?php echo p3html::tb_bool_radio_buttons($this->language, 'discount_combine', $discount_combine); ?>
                    <?php } ?>
                </div>
            </div>
            
            <div class="control-group">
                <label class="control-label"><?php echo $entry_store; ?></label>
                <div class="controls">
                    <div class="scrollbox">
                  <?php $class = 'even'; ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array(0, $advanced_coupon_store)) { ?>
                    <input type="checkbox" name="store[]" value="0" checked="checked" />
                    <?php echo $text_default; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="store[]" value="0" />
                    <?php echo $text_default; ?>
                    <?php } ?>
                  </div>
                  <?php foreach ($stores as $store) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($store['store_id'], $advanced_coupon_store)) { ?>
                    <input type="checkbox" name="store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                    <?php echo $store['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="store[]" value="<?php echo $store['store_id']; ?>" />
                    <?php echo $store['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div>
                <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
                <?php if ($error_store) { ?>
                <span class="error"><?php echo $error_store; ?></span>
                <?php } ?>
                </div>
            </div>
                    
            <div class="control-group">
                <label class="control-label"><?php echo $entry_customer_group; ?></label>
                <div class="controls">
                   <div class="scrollbox">
                 <?php if ($advanced_coupon_customer_group) { ?> 
                  <?php foreach ($customer_groups as $customer_group) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($customer_group['customer_group_id'], $advanced_coupon_customer_group)) { ?>
                    <input type="checkbox" name="customer_group[]" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                    <?php echo $customer_group['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="customer_group[]" value="<?php echo $customer_group['customer_group_id']; ?>" />
                    <?php echo $customer_group['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                  <?php } else { ?>
                  <?php foreach ($customer_groups as $customer_group) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <input type="checkbox" name="customer_group[]" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                    <?php echo $customer_group['name']; ?>
                  </div>
                  <?php } ?>
                  <?php } ?>
                </div>
                <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
                <br/>
                <?php if ($error_customer_group) { ?>
                <span class="error"><?php echo $error_customer_group; ?></span>
                <?php } ?>
                </div>
            </div>
           
            <div class="control-group">
                <label class="control-label"><?php echo $entry_currency; ?></label>
                <div class="controls">
                    <div class="scrollbox">
                   <?php if ($advanced_coupon_currency) { ?> 
                  <?php foreach ($currencies as $currency) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($currency['currency_id'], $advanced_coupon_currency)) { ?>
                    <input type="checkbox" name="currency[]" value="<?php echo $currency['currency_id']; ?>" checked="checked" />
                    <?php echo $currency['title']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="currency[]" value="<?php echo $currency['currency_id']; ?>" />
                    <?php echo $currency['title']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                  <?php } else { ?>
                   <?php foreach ($currencies as $currency) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <input type="checkbox" name="currency[]" value="<?php echo $currency['currency_id']; ?>" checked="checked" />
                    <?php echo $currency['title']; ?>
                  </div>
                  <?php } ?>
                  <?php } ?>
                </div><a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
                <br/>
            <?php if ($error_currency) { ?>
                <span class="error"><?php echo $error_currency; ?></span>
                <?php } ?>
                </div>
            </div>
          
            <div class="control-group">
                <label class="control-label"><?php echo $entry_language; ?></label>
                <div class="controls">
                    <div class="scrollbox">
                  <?php if ($advanced_coupon_language) { ?> 
                  <?php foreach ($languages as $language) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($language['language_id'], $advanced_coupon_language)) { ?>
                    <input type="checkbox" name="language[]" value="<?php echo $language['language_id']; ?>" checked="checked" />
                    <?php echo $language['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="language[]" value="<?php echo $language['language_id']; ?>" />
                    <?php echo $language['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                  <?php } else { ?>
                   <?php foreach ($languages as $language) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <input type="checkbox" name="language[]" value="<?php echo $language['language_id']; ?>" checked="checked" />
                    <?php echo $language['name']; ?>
                  </div>
                  <?php } ?>
                  <?php } ?>
                </div><a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
                <br/>
            <?php if ($error_language) { ?>
                <span class="error"><?php echo $error_language; ?></span>
                <?php } ?>
                </div>
            </div>  
                    
            <div class="control-group">
                <label class="control-label"><?php echo $entry_day; ?></label>
                <div class="controls">
                    <div class="scrollbox">
                   <?php if ($advanced_coupon_day) { ?> 
                  <?php foreach ($days as $day) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($day, $advanced_coupon_day)) { ?>
                    <input type="checkbox" name="day[]" value="<?php echo $day; ?>" checked="checked"  />
                    <?php echo $day; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="day[]" value="<?php echo $day; ?>" />
                    <?php echo $day; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                  <?php } else { ?>
                  <?php foreach ($days as $day) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <input type="checkbox" name="day[]" value="<?php echo $day; ?>" checked="checked"  />
                    <?php echo $day; ?>
                  </div>
                  <?php } ?>
                  <?php } ?>
                </div><a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
                <br/>
            <?php if ($error_day) { ?>
                <span class="error"><?php echo $error_day; ?></span>
                <?php } ?>
                </div>
            </div>
              </div>
            
            <?php if ($advanced_coupon_id) { ?>
                <div id="tab-history" class="tab-pane fade">  
                    <div id="history"></div>
                </div>
            <?php } ?>
        </div>  
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function CategorySelectAll(){ 
	var category_id;
	var filter_category_id = document.getElementsByName('category[]');
	
	for(j=0;j<(filter_category_id.length);j++){
	category_id = document.getElementsByName('category[]').item(j).value;
																					//alert(category_id);
	$.ajax({
		url: 'index.php?route=sale/advanced_coupon/autocompleteAdvancedCoupon&token=<?php echo $token; ?>&filter_category_id=' +  category_id + '&limit=10000',
		dataType: 'json',
		success: function(json) {
			for (i = 0; i < json.length; i++) {
				if ($(filter_category_id).attr('checked') == 'checked') {
					$('#advanced_coupon-product' + json[i]['product_id']).remove();
					
					$('#advanced_coupon-product').append('<div id="advanced_coupon-product' + json[i]['product_id'] + '">' + json[i]['name'] + '<img src="view/image/delete.png" /><input type="hidden" name="advanced_coupon_product[]" value="' + json[i]['product_id'] + '" /></div>');
				} else {
					$('#advanced_coupon-product' + json[i]['product_id']).remove();
				}			
			}
			
			$('#advanced_coupon-product div:odd').attr('class', 'odd');
			$('#advanced_coupon-product div:even').attr('class', 'even');			
		}
	});
	}
}

$('input[name=\'category[]\']').bind('change', function() {
	var filter_category_id = this;
	
	$.ajax({
		url: 'index.php?route=sale/advanced_coupon/autocompleteAdvancedCoupon&token=<?php echo $token; ?>&filter_category_id=' +  filter_category_id.value + '&limit=10000',
		dataType: 'json',
		success: function(json) {
			for (i = 0; i < json.length; i++) {
				if ($(filter_category_id).attr('checked') == 'checked') {
					$('#advanced_coupon-product' + json[i]['product_id']).remove();
					
					$('#advanced_coupon-product').append('<div id="advanced_coupon-product' + json[i]['product_id'] + '">' + json[i]['name'] + '<img src="view/image/delete.png" /><input type="hidden" name="product[]" value="' + json[i]['product_id'] + '" /></div>');
				} else {
					$('#advanced_coupon-product' + json[i]['product_id']).remove();
				}			
			}
			
			$('#advanced_coupon-product div:odd').attr('class', 'odd');
			$('#advanced_coupon-product div:even').attr('class', 'even');			
		}
	});
});

function CategoryManufacturerSelectAll(){ 
	var category_id;
	var filter_category_id = document.getElementsByName('manufacturer[]');
	
	for(j=0;j<(filter_category_id.length);j++){
	category_id = document.getElementsByName('manufacturer[]').item(j).value;
																					//alert(category_id);
	$.ajax({
		url: 'index.php?route=sale/advanced_coupon/autocompleteAdvancedCoupon&token=<?php echo $token; ?>&filter_manufacturer_id=' +  category_id + '&limit=10000',
		dataType: 'json',
		success: function(json) {
			for (i = 0; i < json.length; i++) {
				if ($(filter_category_id).attr('checked') == 'checked') {
					$('#advanced_coupon-product' + json[i]['product_id']).remove();
					
					$('#advanced_coupon-product').append('<div id="advanced_coupon-product' + json[i]['product_id'] + '">' + json[i]['name'] + '<img src="view/image/delete.png" /><input type="hidden" name="advanced_coupon_product[]" value="' + json[i]['product_id'] + '" /></div>');
				} else {
					$('#advanced_coupon-product' + json[i]['product_id']).remove();
				}			
			}
			
			$('#advanced_coupon-product div:odd').attr('class', 'odd');
			$('#advanced_coupon-product div:even').attr('class', 'even');			
		}
	});
	}
}

$('input[name=\'manufacturer[]\']').live('change', function() {
	var filter_manufacturer_id = this;
	
	$.ajax({
		url: 'index.php?route=sale/advanced_coupon/autocompleteAdvancedCoupon&token=<?php echo $token; ?>&filter_manufacturer_id=' +  filter_manufacturer_id.value + '&limit=10000',
		dataType: 'json',
		success: function(json) {
			for (i = 0; i < json.length; i++) {
				if ($(filter_manufacturer_id).attr('checked') == 'checked') {
					$('#advanced_coupon-product' + json[i]['product_id']).remove();
					
					$('#advanced_coupon-product').append('<div id="advanced_coupon-product' + json[i]['product_id'] + '">' + json[i]['name'] + '<img src="view/image/delete.png" /><input type="hidden" name="product[]" value="' + json[i]['product_id'] + '" /></div>');
				} else {
					$('#advanced_coupon-product' + json[i]['product_id']).remove();
				}			
			}
			
			$('#advanced_coupon-product div:odd').attr('class', 'odd');
			$('#advanced_coupon-product div:even').attr('class', 'even');			
		}
	});
});

$('input[name=\'product_suggest\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/advanced_coupon/autocompleteAdvancedCoupon&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
	}, 
	select: function(event, ui) {
		$('#advanced_coupon-product' + ui.item.value).remove();
		
		$('#advanced_coupon-product').append('<div id="advanced_coupon-product' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="product[]" value="' + ui.item.value + '" /></div>');

		$('#advanced_coupon-product div:odd').attr('class', 'odd');
		$('#advanced_coupon-product div:even').attr('class', 'even');
		
		$('input[name=\'product_suggest\']').val('');
		
		return false;
	}
});

$('#advanced_coupon-product div img').live('click', function() {
	$(this).parent().remove();
	
	$('#advanced_coupon-product div:odd').attr('class', 'odd');
	$('#advanced_coupon-product div:even').attr('class', 'even');	
});
//--></script> 

<script type="text/javascript"><!--
function CategoryBuySelectAll(){ 
	var category_id;
	var filter_category_id = document.getElementsByName('category_buy[]');
	
	for(j=0;j<(filter_category_id.length);j++){
	category_id = document.getElementsByName('category_buy[]').item(j).value;
																					//alert(category_id);
	$.ajax({
		url: 'index.php?route=sale/advanced_coupon/autocompleteAdvancedCoupon&token=<?php echo $token; ?>&filter_category_id=' +  category_id + '&limit=10000',
		dataType: 'json',
		success: function(json) {
			for (i = 0; i < json.length; i++) {
				if ($(filter_category_id).attr('checked') == 'checked') {
					$('#advanced_coupon-product_buy' + json[i]['product_id']).remove();
					
					$('#advanced_coupon-product_buy').append('<div id="advanced_coupon-product_buy' + json[i]['product_id'] + '">' + json[i]['name'] + '<img src="view/image/delete.png" /><input type="hidden" name="product_buy[]" value="' + json[i]['product_id'] + '" /></div>');
				} else {
					$('#advanced_coupon-product_buy' + json[i]['product_id']).remove();
				}			
			}
			
			$('#advanced_coupon-product_buy div:odd').attr('class', 'odd');
			$('#advanced_coupon-product_buy div:even').attr('class', 'even');			
		}
	});
	}
}

$('input[name=\'category_buy[]\']').bind('change', function() {
	var filter_category_id = this;
	
	$.ajax({
		url: 'index.php?route=sale/advanced_coupon/autocompleteAdvancedCoupon&token=<?php echo $token; ?>&filter_category_id=' +  filter_category_id.value + '&limit=10000',
		dataType: 'json',
		success: function(json) {
			for (i = 0; i < json.length; i++) {
				if ($(filter_category_id).attr('checked') == 'checked') {
					$('#advanced_coupon-product_buy' + json[i]['product_id']).remove();
					
					$('#advanced_coupon-product_buy').append('<div id="advanced_coupon-product_buy' + json[i]['product_id'] + '">' + json[i]['name'] + '<img src="view/image/delete.png" /><input type="hidden" name="product_buy[]" value="' + json[i]['product_id'] + '" /></div>');
				} else {
					$('#advanced_coupon-product_buy' + json[i]['product_id']).remove();
				}			
			}
			
			$('#advanced_coupon-product_buy div:odd').attr('class', 'odd');
			$('#advanced_coupon-product_buy div:even').attr('class', 'even');			
		}
	});
});

function CategoryBuyManufacturerSelectAll(){ 
	var category_id;
	var filter_category_id = document.getElementsByName('manufacturer_buy[]');
	
	for(j=0;j<(filter_category_id.length);j++){
	category_id = document.getElementsByName('manufacturer_buy[]').item(j).value;
																					//alert(category_id);
	$.ajax({
		url: 'index.php?route=sale/advanced_coupon/autocompleteAdvancedCoupon&token=<?php echo $token; ?>&filter_manufacturer_id=' +  category_id + '&limit=10000',
		dataType: 'json',
		success: function(json) {
			for (i = 0; i < json.length; i++) {
				if ($(filter_category_id).attr('checked') == 'checked') {
					$('#advanced_coupon-product_buy' + json[i]['product_id']).remove();
					
					$('#advanced_coupon-product_buy').append('<div id="advanced_coupon-product_buy' + json[i]['product_id'] + '">' + json[i]['name'] + '<img src="view/image/delete.png" /><input type="hidden" name="product_buy[]" value="' + json[i]['product_id'] + '" /></div>');
				} else {
					$('#advanced_coupon-product_buy' + json[i]['product_id']).remove();
				}			
			}
			
			$('#advanced_coupon-product_buy div:odd').attr('class', 'odd');
			$('#advanced_coupon-product_buy div:even').attr('class', 'even');			
		}
	});
	}
}

$('input[name=\'manufacturer_buy[]\']').bind('change', function() {
	var filter_manufacturer_id = this;
	
	$.ajax({
		url: 'index.php?route=sale/advanced_coupon/autocompleteAdvancedCoupon&token=<?php echo $token; ?>&filter_manufacturer_id=' +  filter_manufacturer_id.value + '&limit=10000',
		dataType: 'json',
		success: function(json) {
			for (i = 0; i < json.length; i++) {
				if ($(filter_manufacturer_id).attr('checked') == 'checked') {
					$('#advanced_coupon-product_buy' + json[i]['product_id']).remove();
					
					$('#advanced_coupon-product_buy').append('<div id="advanced_coupon-product_buy' + json[i]['product_id'] + '">' + json[i]['name'] + '<img src="view/image/delete.png" /><input type="hidden" name="product_buy[]" value="' + json[i]['product_id'] + '" /></div>');
				} else {
					$('#advanced_coupon-product_buy' + json[i]['product_id']).remove();
				}			
			}
			
			$('#advanced_coupon-product_buy div:odd').attr('class', 'odd');
			$('#advanced_coupon-product_buy div:even').attr('class', 'even');			
		}
	});
});

$('input[name=\'product_buy_suggest\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/advanced_coupon/autocompleteAdvancedCoupon&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
	}, 
	select: function(event, ui) {
		$('#advanced_coupon-product_buy' + ui.item.value).remove();
		
		$('#advanced_coupon-product_buy').append('<div id="advanced_coupon-product_buy' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="product_buy[]" value="' + ui.item.value + '" /></div>');

		$('#advanced_coupon-product_buy div:odd').attr('class', 'odd');
		$('#advanced_coupon-product_buy div:even').attr('class', 'even');
		
		$('input[name=\'product_buy_suggest\']').val('');
		
		return false;
	}
});

$('#advanced_coupon-product_buy div img').live('click', function() {
	$(this).parent().remove();
	
	$('#advanced_coupon-product_buy div:odd').attr('class', 'odd');
	$('#advanced_coupon-product_buy div:even').attr('class', 'even');	
});
//--></script> 


<script type="text/javascript"><!--
$('#date-start').datepicker({dateFormat: 'yy-mm-dd'});
$('#date-end').datepicker({dateFormat: 'yy-mm-dd'});
//--></script>
<?php if ($advanced_coupon_id) { ?>
<script type="text/javascript"><!--
$('#history .pagination a').live('click', function() {
	$('#history').load(this.href);
	
	return false;
});			

$('#history').load('index.php?route=sale/advanced_coupon/history&token=<?php echo $token; ?>&advanced_coupon_id=<?php echo $advanced_coupon_id; ?>');
//--></script>
<?php } ?>
<script type="text/javascript"><!--
$('#tabs a').tabs(); 
//--></script> 

<?php echo $footer; ?>