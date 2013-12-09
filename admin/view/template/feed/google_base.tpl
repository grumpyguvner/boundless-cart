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
                            <select name="google_base_status" class="input-medium">
                                <?php echo p3html::oc_status_options($this->language, $google_base_status); ?>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"><?php echo $entry_data_feed; ?></label>
                        <div class="controls"><textarea class="span6 i-xxlarge" rows="5"><?php echo $data_feed; ?></textarea></div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"><?php echo $entry_excluded; ?></label>
                        <div class="controls">
                            <input type="text" name="excluded" value="" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"><?php echo $entry_excluded; ?></label>
                        <div class="controls">
                            <div id="products_excluded" class="scrollbox">
                                <?php $class = 'odd'; ?>
                                <?php foreach ($products_excluded as $product_excluded) { ?>
                                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                <div id="product_excluded<?php echo $product_excluded['product_id']; ?>" class="<?php echo $class; ?>"> 
                                  <i class="btn btn-small icon-trash ims remove" title="<?php echo $button_remove; ?>"></i> <?php echo $product_excluded['name']; ?>
                                  <input type="hidden" name="google_base_product_excluded[]" value="<?php echo $product_excluded['product_id']; ?>" />
                                </div>
                                <?php } ?>
                            </div>
                        </div>
                    </div>
                    
                    
                    
                   
            </form>

        </div>

    </div>
</div>
<script type="text/javascript"><!--
$('input[name=\'excluded\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
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
		$('#product_excluded' + ui.item.value).remove();
		
		$('#products_excluded').append('<div id="product_excluded' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="google_base_product_excluded[]" value="' + ui.item.value + '" /></div>');

		$('#products_excluded div:odd').attr('class', 'odd');
		$('#products_excluded div:even').attr('class', 'even');
                
		return false;
	},
	focus: function(event, ui) {
      return false;
   }
});

$('#products_excluded div i.remove').live('click', function() {
	$(this).parent().remove();
	
	$('#products_excluded div:odd').attr('class', 'odd');
	$('#products_excluded div:even').attr('class', 'even');	
});
//--></script>

        <?php echo $footer; ?>