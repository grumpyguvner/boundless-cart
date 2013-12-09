<?php
@require_once DIR_TEMPLATE.'helper/p3html.php';

if (!defined('P3_UPDATED')) define('P3_UPDATED', 1359608423);
?><!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title><?php echo $title; ?></title>
	<base href="<?php echo $base; ?>">

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script>
	window.jQuery || document.write('<script src="view/js/jquery/jquery-1.7.2.min.js"><\/script>');
	</script>

	<link type="text/css" href="view/js/jqueryui/1.8.24/themes/flick/jquery-ui.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="view/css/<?php echo p3html::p3_stylesheet($this->config->get('p3adminrebooted_flavour')); ?>.min.css?t=<?php echo P3_UPDATED; ?>">
	<link rel="stylesheet" type="text/css" href="view/css/filemanager.min.css?t=<?php echo P3_UPDATED; ?>">

	<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.24/jquery-ui.min.js"></script>
	<script>
		(typeof jQuery.ui != 'undefined') || document.write('<script src="view/js/jqueryui/1.8.24/jquery-ui.min.js"><\/script>');
	</script>

	<script src="view/javascript/jquery/ui/external/jquery.bgiframe-2.1.2.js"></script>
	<script src="view/javascript/jquery/jstree/jquery.tree.min.js"></script>
	<script src="view/javascript/jquery/ajaxupload.js"></script>
</head>

<body>

<div class="container-fluid">
<div id="fm-container" class="row-fluid">

	<div id="fm-menu" class="span12">
		<a id="create" class="btn" title="<?php echo $button_folder; ?>"><i class="icon-folder"></i><span class="hidden-phone"> <?php echo $button_folder; ?></span></a>
		<a id="delete" class="btn" title="<?php echo $button_delete; ?>"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $button_delete; ?></span></a>
		<a id="move" class="btn" title="<?php echo $button_move; ?>"><i class="icon-scissors"></i><span class="hidden-phone"></i> <?php echo $button_move; ?></span></a>
		<a id="copy" class="btn" title="<?php echo $button_copy; ?>"><i class="icon-paste"></i><span class="hidden-phone"> <?php echo $button_copy; ?></span></a>
		<a id="rename" class="btn" title="<?php echo $button_rename; ?>"><i class="icon-pencil"></i><span class="hidden-phone"> <?php echo $button_rename; ?></span></a>
		<a id="upload" class="btn" title="<?php echo $button_upload; ?>"><i class="icon-upload"></i><span class="hidden-phone"> <?php echo $button_upload; ?></span></a>
		<a id="refresh" class="btn" title="<?php echo $button_refresh; ?>"><i class="icon-arrows-ccw"></i><span class="hidden-phone"> <?php echo $button_refresh; ?></span></a>
	</div>

	<div class="row-fluid">
		<div id="fm-column-left" class="span3 clearfix"></div>
		<div id="fm-column-right" class="span9"></div>
	</div>

	<?php if ($fckeditor) { ?>
  <div class="modal-footer">
    <a href="#" id="window-confirm" class="btn btn-success hide"><i class="icon-thumbs-up"></i> Confirm</a>
    <a href="#" class="btn" onclick="self.close();">Close</a>
  </div>
	<?php } ?>

</div>
</div>


<script>
jQuery(document).ready(function($) {

	// REMOVE SELECTED CLASS
	$('#fm-column-right a').removeClass('selected');

	(function(){
		var special = jQuery.event.special,
			uid1 = 'D' + (+new Date()),
			uid2 = 'D' + (+new Date() + 1);

		special.scrollstart = {
			setup: function() {
				var timer,
					handler =  function(evt) {
						var _self = this,
							_args = arguments;

						if (timer) {
							clearTimeout(timer);
						} else {
							evt.type = 'scrollstart';
							jQuery.event.handle.apply(_self, _args);
						}

						timer = setTimeout( function(){
							timer = null;
						}, special.scrollstop.latency);

					};

				jQuery(this).bind('scroll', handler).data(uid1, handler);
			},
			teardown: function(){
				jQuery(this).unbind( 'scroll', jQuery(this).data(uid1) );
			}
		};

		special.scrollstop = {
			latency: 300,
			setup: function() {

				var timer,
						handler = function(evt) {

						var _self = this,
							_args = arguments;

						if (timer) {
							clearTimeout(timer);
						}

						timer = setTimeout( function(){

							timer = null;
							evt.type = 'scrollstop';
							jQuery.event.handle.apply(_self, _args);

						}, special.scrollstop.latency);

					};

				jQuery(this).bind('scroll', handler).data(uid2, handler);

			},
			teardown: function() {
				jQuery(this).unbind('scroll', jQuery(this).data(uid2));
			}
		};
	})();

	$('#fm-column-right').bind('scrollstop', function() {
		$('#fm-column-right a').each(function(index, element) {
			var height = $('#fm-column-right').height();
			var offset = $(element).offset();

			if ((offset.top > 0) && (offset.top < height) && $(element).find('img').attr('src') == '<?php echo $no_image; ?>') {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent('data/' + $(element).find('input[name=\'image\']').attr('value')),
					dataType: 'html',
					success: function(html) {
						$(element).find('img').replaceWith('<img class="thumb" src="' + html + '" alt="" title="">');
					}
				});
			}
		});
	});

	$('#fm-column-left').tree({
		data: {
			type: 'json',
			async: true,
			opts: {
				method: 'post',
				url: 'index.php?route=common/filemanager/directory&token=<?php echo $token; ?>'
			}
		},
		selected: 'top',
		ui: {
			theme_name: 'classic',
			animation: 700
		},
		types: {
			'default': {
				clickable: true,
				creatable: false,
				renameable: false,
				deletable: false,
				draggable: false,
				max_children: -1,
				max_depth: -1,
				valid_children: 'all'
			}
		},
		callback: {
			beforedata: function(NODE, TREE_OBJ) {
				if (NODE == false) {
					TREE_OBJ.settings.data.opts.static = [
						{
							data: 'image',
							attributes: {
								'id': 'top',
								'directory': ''
							},
							state: 'closed'
						}
					];

					return { 'directory': '' }
				} else {
					TREE_OBJ.settings.data.opts.static = false;

					return { 'directory': $(NODE).attr('directory') }
				}
			},
			onselect: function (NODE, TREE_OBJ) {
				$.ajax({
					url: 'index.php?route=common/filemanager/files&token=<?php echo $token; ?>',
					type: 'post',
					data: 'directory=' + encodeURIComponent($(NODE).attr('directory')),
					dataType: 'json',
					success: function(json) {
						html = '<div>';

						if (json) {
							for (i = 0; i < json.length; i++) {
								html += '<a><img class="thumb" src="<?php echo $no_image; ?>" alt="" title=""><br>' + ((json[i]['filename'].length > 15) ? (json[i]['filename'].substr(0, 15) + '..') : json[i]['filename']) + '<br>' + json[i]['size'] + '<input type="hidden" name="image" value="' + json[i]['file'] + '"></a>';
							}
						}

						html += '</div>';

						$('#fm-column-right').html(html);

						$('#fm-column-right').trigger('scrollstop');
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			}
		}
	});

	$('#fm-column-right a').live('click', function()
	{
		if ($(this).hasClass('selected'))
		{
			$(this).removeClass('selected');

			parent.$('#dialog-confirm').addClass('hide');
			window.$('#window-confirm').addClass('hide');
		}
		else
		{
			$('#fm-column-right a').removeClass('selected');
			$(this).addClass('selected');

			parent.$('#dialog-confirm').removeClass('hide');
			window.$('#window-confirm').removeClass('hide');
		}
	});

	// SELECT IMAGE BY dbclick (desktops)
	$('#fm-column-right a').live('dblclick', function() {
		<?php if ($fckeditor) { ?>
		window.opener.CKEDITOR.tools.callFunction(<?php echo $fckeditor; ?>, '<?php echo $directory; ?>' + $(this).find('input[name=\'image\']').attr('value'));
		self.close();
		<?php } else { ?>
		parent.$('#<?php echo $field; ?>').attr('value', 'data/' + $(this).find('input[name=\'image\']').attr('value'));
		<?php } ?>
		parent.$('#dialog').modal('hide');
	});

	// SELECT IMAGE BY button (touch devices)
	<?php if ($fckeditor) { ?>
	var dialogConfirmButton = window.$('#window-confirm');
	<?php } else { ?>
	var dialogConfirmButton = parent.$('#dialog-confirm');
	<?php } ?>;
	dialogConfirmButton.off('click');
	dialogConfirmButton.on('click', function(e) {
		e.preventDefault();
		var imageValue = $('#fm-column-right ').find('a.selected input[name="image"]').first().attr('value');
		if (imageValue != undefined) {
			$(this).addClass('hide');
			<?php if ($fckeditor) { ?>
			window.opener.CKEDITOR.tools.callFunction(<?php echo $fckeditor; ?>, '<?php echo $directory; ?>' + imageValue);
			self.close();
			<?php } else { ?>
			parent.$('#<?php echo $field; ?>').attr('value', 'data/' + imageValue);
			parent.$('#dialog').modal('hide');
			<?php } ?>
		}
	});

	$('#create').bind('click', function() {
		var tree = $.tree.focused();

		if (tree.selected) {
			$('#dialog').remove();

			html  = '<div id="dialog">';
			html += '<?php echo $entry_folder; ?> <input type="text" name="name" value=""> <input type="button" value="<?php echo $button_submit; ?>">';
			html += '</div>';

			$('#fm-column-right').prepend(html);

			$('#dialog').dialog({
				title: '<?php echo $button_folder; ?>',
				resizable: false
			});

			$('#dialog input[type=\'button\']').bind('click', function() {
				$.ajax({
					url: 'index.php?route=common/filemanager/create&token=<?php echo $token; ?>',
					type: 'post',
					data: 'directory=' + encodeURIComponent($(tree.selected).attr('directory')) + '&name=' + encodeURIComponent($('#dialog input[name=\'name\']').val()),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#dialog').remove();

							tree.refresh(tree.selected);

							alert(json.success);
						} else {
							alert(json.error);
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			});
		} else {
			alert('<?php echo $error_directory; ?>');
		}
	});

	$('#delete').bind('click', function() {
		path = $('#fm-column-right a.selected').find('input[name=\'image\']').attr('value');

		if (path) {
			$.ajax({
				url: 'index.php?route=common/filemanager/delete&token=<?php echo $token; ?>',
				type: 'post',
				data: 'path=' + encodeURIComponent(path),
				dataType: 'json',
				success: function(json) {
					if (json.success) {
						var tree = $.tree.focused();

						tree.select_branch(tree.selected);

						alert(json.success);
					}

					if (json.error) {
						alert(json.error);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		} else {
			var tree = $.tree.focused();

			if (tree.selected) {
				$.ajax({
					url: 'index.php?route=common/filemanager/delete&token=<?php echo $token; ?>',
					type: 'post',
					data: 'path=' + encodeURIComponent($(tree.selected).attr('directory')),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							tree.select_branch(tree.parent(tree.selected));

							tree.refresh(tree.selected);

							alert(json.success);
						}

						if (json.error) {
							alert(json.error);
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			} else {
				alert('<?php echo $error_select; ?>');
			}
		}
	});

	$('#move').bind('click', function() {
		$('#dialog').remove();

		html  = '<div id="dialog">';
		html += '<?php echo $entry_move; ?> <select name="to"></select> <input type="button" value="<?php echo $button_submit; ?>">';
		html += '</div>';

		$('#fm-column-right').prepend(html);

		$('#dialog').dialog({
			title: '<?php echo $button_move; ?>',
			resizable: false
		});

		$('#dialog select[name=\'to\']').load('index.php?route=common/filemanager/folders&token=<?php echo $token; ?>');

		$('#dialog input[type=\'button\']').bind('click', function() {
			path = $('#fm-column-right a.selected').find('input[name=\'image\']').attr('value');

			if (path) {
				$.ajax({
					url: 'index.php?route=common/filemanager/move&token=<?php echo $token; ?>',
					type: 'post',
					data: 'from=' + encodeURIComponent(path) + '&to=' + encodeURIComponent($('#dialog select[name=\'to\']').val()),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#dialog').remove();

							var tree = $.tree.focused();

							tree.select_branch(tree.selected);

							alert(json.success);
						}

						if (json.error) {
							alert(json.error);
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			} else {
				var tree = $.tree.focused();

				$.ajax({
					url: 'index.php?route=common/filemanager/move&token=<?php echo $token; ?>',
					type: 'post',
					data: 'from=' + encodeURIComponent($(tree.selected).attr('directory')) + '&to=' + encodeURIComponent($('#dialog select[name=\'to\']').val()),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#dialog').remove();

							tree.select_branch('#top');

							tree.refresh(tree.selected);

							alert(json.success);
						}

						if (json.error) {
							alert(json.error);
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			}
		});
	});

	$('#copy').bind('click', function() {
		$('#dialog').remove();

		html  = '<div id="dialog">';
		html += '<?php echo $entry_copy; ?> <input type="text" name="name" value=""> <input type="button" value="<?php echo $button_submit; ?>">';
		html += '</div>';

		$('#fm-column-right').prepend(html);

		$('#dialog').dialog({
			title: '<?php echo $button_copy; ?>',
			resizable: false
		});

		$('#dialog select[name=\'to\']').load('index.php?route=common/filemanager/folders&token=<?php echo $token; ?>');

		$('#dialog input[type=\'button\']').bind('click', function() {
			path = $('#fm-column-right a.selected').find('input[name=\'image\']').attr('value');

			if (path) {
				$.ajax({
					url: 'index.php?route=common/filemanager/copy&token=<?php echo $token; ?>',
					type: 'post',
					data: 'path=' + encodeURIComponent(path) + '&name=' + encodeURIComponent($('#dialog input[name=\'name\']').val()),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#dialog').remove();

							var tree = $.tree.focused();

							tree.select_branch(tree.selected);

							alert(json.success);
						}

						if (json.error) {
							alert(json.error);
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			} else {
				var tree = $.tree.focused();

				$.ajax({
					url: 'index.php?route=common/filemanager/copy&token=<?php echo $token; ?>',
					type: 'post',
					data: 'path=' + encodeURIComponent($(tree.selected).attr('directory')) + '&name=' + encodeURIComponent($('#dialog input[name=\'name\']').val()),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#dialog').remove();

							tree.select_branch(tree.parent(tree.selected));

							tree.refresh(tree.selected);

							alert(json.success);
						}

						if (json.error) {
							alert(json.error);
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			}
		});
	});

	$('#rename').bind('click', function() {
		$('#dialog').remove();

		html  = '<div id="dialog">';
		html += '<?php echo $entry_rename; ?> <input type="text" name="name" value=""> <input type="button" value="<?php echo $button_submit; ?>">';
		html += '</div>';

		$('#fm-column-right').prepend(html);

		$('#dialog').dialog({
			title: '<?php echo $button_rename; ?>',
			resizable: false
		});

		$('#dialog input[type=\'button\']').bind('click', function() {
			path = $('#fm-column-right a.selected').find('input[name=\'image\']').attr('value');

			if (path) {
				$.ajax({
					url: 'index.php?route=common/filemanager/rename&token=<?php echo $token; ?>',
					type: 'post',
					data: 'path=' + encodeURIComponent(path) + '&name=' + encodeURIComponent($('#dialog input[name=\'name\']').val()),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#dialog').remove();

							var tree = $.tree.focused();

							tree.select_branch(tree.selected);

							alert(json.success);
						}

						if (json.error) {
							alert(json.error);
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			} else {
				var tree = $.tree.focused();

				$.ajax({
					url: 'index.php?route=common/filemanager/rename&token=<?php echo $token; ?>',
					type: 'post',
					data: 'path=' + encodeURIComponent($(tree.selected).attr('directory')) + '&name=' + encodeURIComponent($('#dialog input[name=\'name\']').val()),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#dialog').remove();

							tree.select_branch(tree.parent(tree.selected));

							tree.refresh(tree.selected);

							alert(json.success);
						}

						if (json.error) {
							alert(json.error);
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			}
		});
	});

	new AjaxUpload('#upload', {
		action: 'index.php?route=common/filemanager/upload&token=<?php echo $token; ?>',
		name: 'image',
		autoSubmit: false,
		responseType: 'json',
		onChange: function(file, extension) {
			var tree = $.tree.focused();

			if (tree.selected) {
				this.setData({'directory': $(tree.selected).attr('directory')});
			} else {
				this.setData({'directory': ''});
			}

			this.submit();
		},
		onSubmit: function(file, extension) {
			$('#upload').append('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;">');
		},
		onComplete: function(file, json) {
			if (json.success) {
				var tree = $.tree.focused();

				tree.select_branch(tree.selected);

				alert(json.success);
			}

			if (json.error) {
				alert(json.error);
			}

			$('.loading').remove();
		}
	});

	$('#refresh').bind('click', function() {
		var tree = $.tree.focused();

		tree.refresh(tree.selected);
	});
});
</script>

</body>
</html>