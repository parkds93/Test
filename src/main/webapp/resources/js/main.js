(function ($) {
	"use strict";


	/*==================================================================
	[ Focus input ]*/
	$('.input100').each(function () {
		$(this).on('blur', function () {
			if ($(this).val().trim() != "") {
				$(this).addClass('has-val');
			} else {
				$(this).removeClass('has-val');
			}
		})
	})


	/*==================================================================
	[ Validate ]*/
	var input = $('.validate-input .input100');

	$('.validate-form').on('submit', function () {
		var check = true;

		for (var i = 0; i < input.length; i++) {
			if (validate(input[i]) == false) {
				showValidate(input[i]);
				check = false;
			}
		}

		return check;
	});


	$('.validate-form .input100').each(function () {
		$(this).focus(function () {
			hideValidate(this);
		});
	});

	function validate(input) {
		if ($(input).attr('type') == 'email' || $(input).attr('name') == 'email') {
			if ($(input).val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) == null) {
				return false;
			}
		} else {
			if ($(input).val().trim() == '') {
				return false;
			}
		}
	}

	function showValidate(input) {
		var thisAlert = $(input).parent();

		$(thisAlert).addClass('alert-validate');
	}

	function hideValidate(input) {
		var thisAlert = $(input).parent();

		$(thisAlert).removeClass('alert-validate');
	}

	/*==================================================================
	[ Show pass ]*/
	var showPass = 0;
	$('.btn-show-pass').on('click', function () {
		if (showPass == 0) {
			$(this).next('input').attr('type', 'text');
			$(this).addClass('active');
			showPass = 1;
		} else {
			$(this).next('input').attr('type', 'password');
			$(this).removeClass('active');
			showPass = 0;
		}

	});


})(jQuery);

$(document).ready(function () {
	$(".animsition").animsition({
		inClass: 'fade-in-down',
		outClass: 'fade-out-up',
		inDuration: 500,
		outDuration: 300,
		linkElement: '.animsition-link',
		// e.g. linkElement: 'a:not([target="_blank"]):not([href^="#"])'
		loading: true,
		loadingParentElement: 'body', //animsition wrapper element
		loadingClass: 'animsition-loading',
		loadingInner: '', // e.g '<img src="loading.svg" />'
		timeout: true,
		timeoutCountdown: 0,
		onLoadEvent: true,
		browser: ['animation-duration', '-webkit-animation-duration'],
		// "browser" option allows you to disable the "animsition" in case the css property in the array is not supported by your browser.
		// The default setting is to disable the "animsition" in a browser that does not support "animation-duration".
		overlay: false,
		overlayClass: 'animsition-overlay-slide',
		overlayParentElement: 'body',
	});
});

$(document).on('change', '.up', function () {
	var names = [];
	var length = $(this).get(0).files.length;
	for (var i = 0; i < $(this).get(0).files.length; ++i) {
		names.push($(this).get(0).files[i].name);
	}
	// $("input[name=file]").val(names);
	if (length > 2) {
		var fileName = names.join(', ');
		$(this).closest('.form-group').find('.form-control').attr("value", length + " files selected");
	} else {
		$(this).closest('.form-group').find('.form-control').attr("value", names);
	}
});
