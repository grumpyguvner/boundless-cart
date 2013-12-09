<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <div id="module_ec"><?php echo $event_cal;?></div>  
  </div>
</div>
<script type="text/javascript">
function do_cal(yr, mt) {
	var myData = 'x='+mt+'&y='+yr;
	$.ajax({
		type: 'get',
		url: 'index.php?route=module/event/callback',
		dataType: 'html',
		data: myData,
		success: function (html) {
		$('#module_ec').html(html);
	}
	,
	complete: function () {
		
	}
	});
} 
</script>