/*!
 * jQuery Cookie Plugin v1.1
 * https://github.com/carhartl/jquery-cookie
 *
 * Copyright 2011, Klaus Hartl
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.opensource.org/licenses/GPL-2.0
 */
(function($, document) {

	var pluses = /\+/g;
	function raw(s) {
		return s;
	}
	function decoded(s) {
		return decodeURIComponent(s.replace(pluses, ' '));
	}

	$.cookie = function(key, value, options) {

		// key and at least value given, set cookie...
		if (arguments.length > 1 && (!/Object/.test(Object.prototype.toString.call(value)) || value == null)) {
			options = $.extend({}, $.cookie.defaults, options);

			if (value == null) {
				options.expires = -1;
			}

			if (typeof options.expires === 'number') {
				var days = options.expires, t = options.expires = new Date();
				t.setDate(t.getDate() + days);
			}

			value = String(value);

			return (document.cookie = [
				encodeURIComponent(key), '=', options.raw ? value : encodeURIComponent(value),
				options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
				options.path    ? '; path=' + options.path : '',
				options.domain  ? '; domain=' + options.domain : '',
				options.secure  ? '; secure' : ''
			].join(''));
		}

		// key and possibly options given, get cookie...
		options = value || $.cookie.defaults || {};
		var decode = options.raw ? raw : decoded;
		var cookies = document.cookie.split('; ');
		for (var i = 0, parts; (parts = cookies[i] && cookies[i].split('=')); i++) {
			if (decode(parts.shift()) === key) {
				return decode(parts.join('='));
			}
		}
		return null;
	};

	$.cookie.defaults = {};

})(jQuery, document);

jQuery(document).ready(function() 
{

		$('#language .drop').dropkick({
			width:30, 
			change: function (value, label) 
			{
				jQuery("#language input[name=language_code]").val(value);
				jQuery("#language form").submit();
			}
		});
		
		$('#currency .drop').dropkick({width:10, change: function (value, label) 
			{
				jQuery("#currency input[name=currency_code]").val(value);
				jQuery("#currency form").submit();
			}
		});
		
		$('#limit_select').dropkick({width:50, change: function (value, label) 
			{
				location = value;
			}
		});
		
		$('#sort_select').dropkick({width:120, change: function (value, label) 
			{
				location = value;
			}
		});

		$(window).scroll(function() {
			if($(this).scrollTop() > 200) {
				$('#scroll_top').fadeIn();	
			} else {
				$('#scroll_top').fadeOut();
			}
		});
	 
		$('#scroll_top').click(function(e) {
			$('body,html').animate({scrollTop:0},500);
			e.preventDefault();
			return false;
		});

		var _first_load = true;
		$("#first_visit_message a").on("click", function (e) 
		{
			$.cookie('first_visit_message', 'true', { expires: 365 });
			e.preventDefault();
			$("#first_visit_message").animate({opacity:0}, 1000, function () { jQuery(this).hide();});
			return false;
		});
	
		$(".dropdown dt a").click(function() {
			$(".dropdown dd ul").toggle();
			$(document).bind('click', dropdown_doc_click);			
		});
					
		$(".dropdown dd ul li a").click(function() {
			var text = $(this).html();
			$(".dropdown dt a span").html(text);
			$(".dropdown dd ul").hide();
		});
					
		function getSelectedValue(id) {
			return $("#" + id).find("dt a span.value").html();
		}

		var dropdown_doc_click = function(e) {
			var $clicked = $(e.target);
			if (! $clicked.parents().hasClass("dropdown"))
			{
				$(".dropdown dd ul").hide();
			}
			$(document).unbind('click', upIncrement);
		}
		
		if ($.cookie('first_visit_message') != "true") $("#first_visit_message").show();
});
