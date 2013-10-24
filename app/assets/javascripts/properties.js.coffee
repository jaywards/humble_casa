# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	if $('body').hasClass("properties")
		
		$('#confirmed0').hide()
		$('#confirmed1').hide()
		$('#confirmed2').hide()
		$('#confirmed3').hide()
		$('#confirmed4').hide()
		
		$("#property_name").focus()
		$("#new_property").enableClientSideValidations()
		$("[id^=edit_property]").enableClientSideValidations()
		$("#property_assignments_attributes_0_service_id").change ->
			service = $(this).val()
			if service == ""
				$('#service-description-0').text ""
				$('#confirmed0').hide(400)
			else
				$('#confirmed0').show(400)
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
				$('#confirmed1').hide(400)
			else
				$('#confirmed1').show(400)
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
				$('#confirmed2').hide(400)
			else
				$('#confirmed2').show(400)
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
				$('#confirmed3').hide(400)
			else
				$('#confirmed3').show(400)
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
				$('#confirmed4').hide(400)
			else
				$('#confirmed4').show(400)
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
