$ ->
  if $('body').hasClass("service_requests") && $(".complete-request-form").length > 0
    maxD = new Date()
    maxD.setDate(maxD.getDate()) 

    $('#completed-date-picker').datepicker(
      altField: '.completed_date',
      altFormat: 'yy-mm-dd',
      maxDate: maxD
    )

$ ->
  if $('body').hasClass("service_requests") && $(".assign-request-form").length > 0
    
    s = $("#start_date").val()
    startD = new Date(s.substring(0,4), (s.substring(5,7) * 1) - 1, s.substring(8,10), s.substring(11,13), s.substring(14,16), 0, 0)
    
    s = $("#end_date").val()
    endD = new Date(s.substring(0,4), (s.substring(5,7) * 1) - 1, s.substring(8,10), s.substring(11,13), s.substring(14,16), 0, 0)
    
    $('#scheduled-date-picker').datetimepicker({
      timeFormat: 'h:mm TT',
      stepMinute: 15,
      altField: '.first_scheduled_date',
      altFieldTimeOnly: false; 
      altFormat: 'yy-mm-dd',
      altTimeFormat: 'HH:mm',
      hourMin: 8,
      hourMax: 18,
      minDate: startD, 
      maxDate: endD
    })
    if $("#service_request_scheduled_true").attr("checked")
      scheduled = "true"
      $(".scheduling-fields").show()
    else
      scheduled = "false"
      $("#scheduled-date-picker").hide()
      $(".scheduling-fields").hide()
      $('#service_request_first_scheduled').val startD

    $(".scheduled").change ->
      if $(this).val() == "true"
        $(".scheduling-fields").show(400)
        $("#scheduled-date-picker").show(400)
        scheduled = "true"
      else
        $(".scheduling-fields").hide(400)
        $("#scheduled-date-picker").hide(400)
        scheduled = "false"
        $('#service_request_first_scheduled').val startD

    $("#save-btn").click ->    
      if scheduled == "true"
        if $("#scheduled-date-picker").val() == ""
          alert("You must select a valid date to schedule this request.")
          false


$ ->
  if $('body').hasClass("service_requests") && $(".schedule-request-form").length > 0
    s = $("#start_date").val()
    startD = new Date(s.substring(0,4), (s.substring(5,7) * 1) - 1, s.substring(8,10), s.substring(11,13), s.substring(14,16), 0, 0)
    
    e = $("#end_date").val()
    endD = new Date(e.substring(0,4), (e.substring(5,7) * 1) - 1, e.substring(8,10), e.substring(11,13), e.substring(14,16), 0, 0)

    $('#scheduled-date-picker').datetimepicker({
      timeFormat: 'h:mm TT',
      stepMinute: 15,
      altField: '.first_scheduled_date',
      altFieldTimeOnly: false; 
      altFormat: 'yy-mm-dd',
      altTimeFormat: 'HH:mm',
      hourMin: 8,
      hourMax: 18,
      minDate: startD, 
      maxDate: endD
    })
    $("#save-btn").click ->
      validateScheduling()



validateScheduling = ->
  if $("#scheduled-date-picker").val() == ""
    alert("You must select a valid date to schedule this request.")
    false
  else
    $('.scheduled').val "t"

$ ->
  if $('body').hasClass("service_requests") && $(".complete-request-form").length > 0
    standardCharge = $("#service_request_charge").val()
    $("#save-btn").click ->
      charge = $("#service_request_charge").val()
      if charge != standardCharge && $("#service_request_charge_notes").val() == ""
        alert("The standard charge for this property is $" + standardCharge + " and you have entered $" + charge + ". Since you are not charging the standard amount you must provide a charge explanation to complete this request.")
        false