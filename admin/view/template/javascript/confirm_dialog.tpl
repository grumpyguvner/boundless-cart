<div class="modal hide fade" tabindex="-1" id="confirm-dialog" role="dialog" aria-labelledby="confirm-heading">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="confirm-heading"><i class="icon-attention"></i></h3>
	</div>
	<div class="modal-body">
		<p><?php echo $this->language->get('text_confirm'); ?></p>
	</div>
	<div class="modal-footer">
		<button data-dismiss="modal" id="confirm-dialog-btn-cancel" class="btn" aria-hidden="true">Cancel</button>
		<button data-dismiss="modal" id="confirm-dialog-btn-confirm" class="btn">Confirm</button>
	</div>
	<input id="confirm-dialog-action" type="hidden" name="confirm-dialog-action" value="">
</div>

