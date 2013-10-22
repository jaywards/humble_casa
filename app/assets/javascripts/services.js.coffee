# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	if $('body').hasClass("services") && $(".service-form").length > 0
		$("#service_name").focus()
		$("#new_service").enableClientSideValidations()
		$("[id^=edit_service]").enableClientSideValidations()
		$("#service_phone").mask("(999) 999-9999")
