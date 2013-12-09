<!--FILEMANAGER-->
<div id="dialog" class="modal hide" tabindex="-1" role="dialog" aria-labelledby="dialog-label" aria-hidden="true" data-field="" data-thumb="">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="dialog-label"><?php echo $text_image_manager; ?></h3>
	</div>
	<div class="modal-body">
		<iframe id="fm-iframe" style="display:block; border:0; padding:0; margin:0; width:100%; height:360px; overflow:auto;"></iframe>
	</div>
  <div class="modal-footer">
    <a href="#" id="dialog-confirm" class="btn btn-success hide"><i class="icon-thumbs-up"></i> Confirm</a>
    <a href="#" class="btn" data-dismiss="modal" aria-hidden="true">Close</a>
  </div>
</div>
<!--FILEMANAGER-->

<script>
function image_upload(field, thumb) {

	$('#dialog').attr('data-field', field);
	$('#dialog').attr('data-thumb', thumb);
	$('#dialog #fm-iframe').attr('src', 'index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field));
};

jQuery(document).ready(function($) {

	$('#dialog').on('show', function() {
		$(this).find('#dialog-confirm').addClass('hide');
	});

	$('#dialog').on('hidden', function() {

		var field = $(this).attr('data-field');
		var thumb = $(this).attr('data-thumb');

		if ($('#' + field).attr('value')) {
			$.ajax({
				url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
				dataType: 'text',
				success: function(data) {
					$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '">');
				}
			});
		}
		$('#dialog').attr('data-field', '');
		$('#dialog').attr('data-thumb', '');
		$('#dialog #fm-iframe').attr('src', '');
	});
});
</script>
