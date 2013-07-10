# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$(".launch-service-form").click ->
		setTimeout (->
			$("#service_name").focus()
			$("#new_service").enableClientSideValidations()
			$("[id^=edit_service]").enableClientSideValidations()
		), 500