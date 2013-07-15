$ ->
  $(".launch-complete-service-request").click ->
    
    setTimeout (->
    	$('#completed-date-picker').datepicker(
    		altField: '.service_completed_date',
    		altFormat: 'yy-mm-dd'
    	)
    ),400