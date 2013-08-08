$ ->
  $(".launch-complete-service-request").click ->
    
    setTimeout (->
    	$('#completed-date-picker').datepicker(
    		altField: '.completed_date',
    		altFormat: 'yy-mm-dd'
    	)


    ),1000

$ ->
  $(".launch-assign-service-request").click ->
    
    setTimeout (->
      SD = new Date($("#service_request_service_start_date").val().substring(0, 19).replace(/-/g, "/"))
      ED = new Date($("#service_request_service_end_date").val().substring(0, 19).replace(/-/g, "/"))

      $('#scheduled-date-picker').datepicker({
        altField: '.first_scheduled_date',
        altFormat: 'yy-mm-dd',
        minDate: SD,
        maxDate: ED
      })

      if $("#service_request_scheduled_true").attr("checked")
        scheduled = "true"
        $(".service_request_first_scheduled_date").show()
      else
        scheduled = "false"
        $(".service_request_first_scheduled_date").hide()

      $(".scheduled").change ->
        if $(this).val() == "true"
          $(".service_request_first_scheduled_date").show(400)
          scheduled = "true"
        else
          $(".service_request_first_scheduled_date").hide(400)
          scheduled = "false"

      $("#save-btn").click ->
        if scheduled == "true"
          if $("#scheduled-date-picker").val() == ""
            alert("You must select a valid date to schedule this request.")
            false

    ),750

$ ->
  $(".launch-schedule-service-request").click ->
    
    setTimeout (->

      SD = new Date($("#service_request_service_start_date").val().substring(0, 19).replace(/-/g, "/"))
      ED = new Date($("#service_request_service_end_date").val().substring(0, 19).replace(/-/g, "/"))

      $('#scheduled-date-picker').datepicker({
        altField: '.scheduled_date',
        altFormat: 'yy-mm-dd',
        minDate: SD,
        maxDate: ED
      })
      

      $("#save-btn").click ->
        validateScheduling()
      
    ),750


validateScheduling = ->
  if $("#scheduled-date-picker").val() == ""
    alert("You must select a valid date to schedule this request.")
    false
  else
    $('.scheduled').val "t"