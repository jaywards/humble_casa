# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$(".launch-property").click ->
		setTimeout (->
			$("#property_name").focus()
			$("#new_property").enableClientSideValidations()
			$("[id^=edit_property]").enableClientSideValidations()
		), 500
