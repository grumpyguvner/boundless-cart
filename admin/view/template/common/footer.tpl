</div><!--container-end-->
</div><!--main-end-->

<div id="footer">
	<div class="container">
		<div class="row">
			<div id="footer-content" class="span12">
				<p><small><?php echo $text_footer; ?></small></p>
			</div>
            <?php if ($error_environment) echo '<div id="error_environment" class="alert alert-error" style="float: right"><button type="button" class="close" data-dismiss="alert">&times;</button>' . $error_environment . '</div>'; ?>
		</div>
	</div>
</div>


</div><!--page-wrapper-end-->

<!--CONFIRM-DIALOG-->
<?php include_once DIR_TEMPLATE.'javascript/confirm_dialog.tpl'; ?>
<!--CONFIRM-DIALOG-->

<script>
jQuery(document).ready(function($){

	//----------------------------------------------------------------------------
	// oc setup active navigation top menu items
	//----------------------------------------------------------------------------
	route = getURLVar('route');

	var activeTopMenuClass = '<?php echo $this->config->get('p3adminrebooted_menu_highlight') ? 'active highlight' : 'active'; ?>';

	if (!route) {
		$('#dashboard').addClass(activeTopMenuClass);
	} else {
		part = route.split('/');

		url = part[0];

		if (part[1]) {
			url += '/' + part[1];
		}

		$('a[href*=\'' + url + '\']').parents('li[id]').addClass(activeTopMenuClass);
	}
	//----------------------------------------------------------------------------

	//-----------------------------------------
	// bootstrap.date/time
	//-----------------------------------------
	setupTBDatePickers('input[type="text"].date');
	setupTBTimePickers('input[type="text"].time');
	//-----------------------------------------

	<?php if ($this->config->get('p3adminrebooted_select2')) { ?>
	//-----------------------------------------
	// jquery.select2
	//-----------------------------------------
	$('select').select2();
	//-----------------------------------------
	<?php } ?>

	//-----------------------------------------
	// bootstrap.tooltip
	//-----------------------------------------
	$('a[data-hint="tooltip"]').tooltip();
	//-----------------------------------------
});

//-----------------------------------------
// A fix for the iOS orientationchange zoom bug. Script by @scottjehl, rebound by @wilto.MIT / GPLv2 License.*/
//-----------------------------------------
/*! A fix for the iOS orientationchange zoom bug. Script by @scottjehl, rebound by @wilto.MIT / GPLv2 License.*/
(function(a){function m(){d.setAttribute("content",g),h=!0}function n(){d.setAttribute("content",f),h=!1}function o(b){l=b.accelerationIncludingGravity,i=Math.abs(l.x),j=Math.abs(l.y),k=Math.abs(l.z),(!a.orientation||a.orientation===180)&&(i>7||(k>6&&j<8||k<8&&j>6)&&i>5)?h&&n():h||m()}var b=navigator.userAgent;if(!(/iPhone|iPad|iPod/.test(navigator.platform)&&/OS [1-5]_[0-9_]* like Mac OS X/i.test(b)&&b.indexOf("AppleWebKit")>-1))return;var c=a.document;if(!c.querySelector)return;var d=c.querySelector("meta[name=viewport]"),e=d&&d.getAttribute("content"),f=e+",maximum-scale=1",g=e+",maximum-scale=10",h=!0,i,j,k,l;if(!d)return;a.addEventListener("orientationchange",m,!1),a.addEventListener("devicemotion",o,!1)})(this);
//-----------------------------------------
</script>

</body>
</html>