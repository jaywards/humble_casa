# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	if $('body').hasClass("properties")
		$("#property_name").focus()
		$("#new_property").enableClientSideValidations()
		$("[id^=edit_property]").enableClientSideValidations()
		$("#property_assignments_attributes_0_service_id").change ->
			service = $(this).val()
			if service == ""
				$('#service-description-0').text ""
			else
				$.ajax
				  url: "/services/" + service
				  type: "get"
				  dataType: "html"
				  processData: false
				  success: (data) ->
				    if data is "record_not_found"
				      alert "Service description not found"
				    else
				      $('#service-description-0').text data
		
		$("#property_assignments_attributes_1_service_id").change ->
			service = $(this).val()
			if service == ""
				$('#service-description-1').text ""
			else
				$.ajax
				  url: "/services/" + service
				  type: "get"
				  dataType: "html"
				  processData: false
				  success: (data) ->
				    if data is "record_not_found"
				      alert "Service description not found"
				    else
				      $('#service-description-1').text data

		$("#property_assignments_attributes_2_service_id").change ->
			service = $(this).val()
			if service == ""
				$('#service-description-2').text ""
			else
				$.ajax
				  url: "/services/" + service
				  type: "get"
				  dataType: "html"
				  processData: false
				  success: (data) ->
				    if data is "record_not_found"
				      alert "Service description not found"
				    else
				      $('#service-description-2').text data
		
		$("#property_assignments_attributes_3_service_id").change ->
			service = $(this).val()
			if service == ""
				$('#service-description-3').text ""
			else
				$.ajax
				  url: "/services/" + service
				  type: "get"
				  dataType: "html"
				  processData: false
				  success: (data) ->
				    if data is "record_not_found"
				      alert "Service description not found"
				    else
				      $('#service-description-3').text data

		$("#property_assignments_attributes_4_service_id").change ->
			service = $(this).val()
			if service == ""
				$('#service-description-4').text ""
			else
				$.ajax
				  url: "/services/" + service
				  type: "get"
				  dataType: "html"
				  processData: false
				  success: (data) ->
				    if data is "record_not_found"
				      alert "Service description not found"
				    else
				      $('#service-description-4').text data
