$ ->
	if $('body').hasClass("properties")
		
		hideConfirmed()
 		
		$.fn.raty.defaults.path = "http://www.humblecasa.com/assets"
		
		initializeRatys()

		$("#property_name").focus()
		$("#new_property").enableClientSideValidations()
		$("[id^=edit_property]").enableClientSideValidations()
		
		actOnSelect()

hideConfirmed = ->

     $('#confirmed0').hide()
     $('#confirmed1').hide()
     $('#confirmed2').hide()
     $('#confirmed3').hide()
     $('#confirmed4').hide()


initializeRatys = ->

     $("#star0").raty
          readOnly: true
          score: ->
               $(this).attr "data-score"

     $("#star1").raty
          readOnly: true
          score: ->
               $(this).attr "data-score"


     $("#star2").raty
          readOnly: true
          score: ->
               $(this).attr "data-score"

     $("#star3").raty
          readOnly: true
          score: ->
               $(this).attr "data-score"

     $("#star4").raty
          readOnly: true
          score: ->
               $(this).attr "data-score"

actOnSelect = ->
	
	$("#property_assignments_attributes_0_service_id").change ->
		selectAction('0', $(this).val())
	$("#property_assignments_attributes_1_service_id").change ->
    	selectAction('1', $(this).val())
    $("#property_assignments_attributes_2_service_id").change ->
    	selectAction('2', $(this).val())
    $("#property_assignments_attributes_3_service_id").change ->
    	selectAction('3', $(this).val())
   	$("#property_assignments_attributes_4_service_id").change ->
   		selectAction('4', $(this).val())
    
selectAction = (id, service) ->
	if service == ""
		sd = '#service-description-' + id
		$('#service-description-' + id).text ""
		cn = '#confirmed' + id
		$(cn).hide(400)
		st = '#star' + id
		$(st).hide(400)  
	else
    	$('#confirmed' + id).show(400)
    	$.ajax
        	url: "/services/" + service
        	type: "get"
        	dataType: "html"
        	processData: false
        	success: (data) ->
                if data is "record_not_found"
                	alert "Service description not found"
                else
                    content = data.split("|")
                    $('#star' + id).raty "set",
                    	score: content[0]
                    $('#star' + id).show(400)
                    $('#service-description-' + id).text content[1]