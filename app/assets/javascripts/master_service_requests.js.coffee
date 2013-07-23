# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
    $("#master_service_request_onetime_true").focus()
    $("#new_master_service_request").enableClientSideValidations()
    $("[id^=edit_master_service_request]").enableClientSideValidations()

    setDatePickers()

    populateForm()

    $(".onetime").change ->
      if $(this).val() == "true"
        showAndHideFields('.onetime-fields', '.repeating-fields')
      else
        showAndHideFields('.repeating-fields', '.onetime-fields')
      
    $(".frequency").change ->
      $('#first-scheduled-fields').hide(400)
      if $(this).val() == "weekly" || $(this).val() == "every_other_week"
          showAndHideFields('.weekly-fields', '.monthly-fields')
      else
          showAndHideFields('.monthly-fields', '.weekly-fields')

    $("#daypicker").change ->
      nextScheduledWeekDay($(this).val())
      $('#first-scheduled-fields').show(400)

    $("#monthpicker").change ->
      nextScheduledMonthDay($(this).val())
      $('#first-scheduled-fields').show(400)

    $("#save-btn").click ->
      validateForm()

 
setDatePickers = ->
  $("#start-date-picker").datepicker(
    altField: '.service_start_date, .first_scheduled'
    altFormat: 'yy-mm-dd'
    )
  $('#end-date-picker').datepicker(
    altField: '.service_end_date',
    altFormat: 'yy-mm-dd'
    )


populateForm = ->
  if $("#master_service_request_onetime_true").attr("checked")
    $('.onetime-fields').show()
  if $("#master_service_request_onetime_false").attr("checked")
    $('.repeating-fields').show()
    e = document.getElementById("master_service_request_frequency")
    selectedFrequency = e.options[e.selectedIndex].value
    if selectedFrequency == "weekly" || selectedFrequency == "every_other_week"
      $('.weekly-fields').show()
    else
      $('.monthly-fields').show()
    stringDate = new Date(document.getElementById("master_service_request_first_scheduled").value.substring(0, 19).replace(/-/g, "/")).toDateString()
    $('#date-string').text stringDate
    $('#first-scheduled-fields').show()

showAndHideFields = (showField, hideField) ->
  $(showField).show(400)
  $(hideField).hide(400)

nextScheduledWeekDay = (day) ->
  days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  selected_day_num = days.indexOf(day)
  today = new Date()
  today_day = today.getDay()
  if selected_day_num > today_day
    scheduled_date = new Date 1900+today.getYear(), today.getMonth(), today.getDate()+(selected_day_num - today_day) 
  else
    scheduled_date = new Date 1900+today.getYear(), today.getMonth(), today.getDate()+(selected_day_num - today_day + 7)
  $('.first_scheduled').val scheduled_date
  dateString = scheduled_date.toDateString()
  $('#date-string').text dateString
 
nextScheduledMonthDay = (selected_day_num) ->
  today = new Date()
  today_day = today.getDate()
  if selected_day_num > today_day
    scheduled_date = new Date 1900+today.getYear(), today.getMonth(), selected_day_num 
  else
    scheduled_date = new Date 1900+today.getYear(), (today.getMonth() + 1), selected_day_num
  $('.first_scheduled').val scheduled_date
  dateString = scheduled_date.toDateString()
  $('#date-string').text dateString
 
validateForm = -> 
  if $("#master_service_request_onetime_true").is(":checked")
    validateOneTimeRequest()

  else if $("#master_service_request_onetime_false").is(":checked")
    validateRepeatingRequest()

  else
    alert("You must choose either a one-time or repeating request before saving.")
    false

validateOneTimeRequest = ->
 startdate = $("#master_service_request_service_start_date").val()
 enddate = $("#master_service_request_service_end_date").val()

 if startdate && enddate
    today = new Date()
    
    xstartdate = new Date(startdate.substring(0,4), startdate.substring(5,7) - 1, startdate.substring(8))
    
    if today > xstartdate
      alert("You cannot select the service window to start in the past.")
      false
    else if startdate > enddate
      alert("You must select an service window end date that is later than the start date.")
      false
    else if !$("#master_service_request_terms_agreement").prop('checked')
      alert("You must agree to the Terms and Conditions before saving.")
      false
    else    
      $("#master_service_request_frequency").val "weekly"
      $("#daypicker").val "Monday"
      $("#monthpicker").val 1  
  else
    alert("You must define a service window before saving.")
    false

validateRepeatingRequest = ->
  frequency = $("#master_service_request_frequency").val()
  if frequency == "weekly" || frequency == "every_other_week"
    
    if $("#daypicker").val()
      if !$("#master_service_request_terms_agreement").prop('checked')
        alert("You must agree to the Terms and Conditions before saving.")
        false
      else
        blankdate = new Date()
        $("#monthpicker").val 1
        $("#master_service_request_service_start_date").val blankdate   
        $("#master_service_request_service_end_date").val blankdate   
    else
      alert("You must select which day of the week you want the services scheduled for.")
      false

  else if frequency == "monthly" || frequency == "every_other_month"
    
    if $("#monthpicker").val()
      if !$("#master_service_request_terms_agreement").prop('checked')
        alert("You must agree to the Terms and Conditions before saving.")
        false
      else
        blankdate = new Date()
        $("#daypicker").val "Monday"
        $("#master_service_request_service_start_date").val blankdate   
        $("#master_service_request_service_end_date").val blankdate
    else
      alert("You must select the day of the month you want the services scheduled for.")
      false
  else
    alert("You must select a service frequency before saving.")
    false



$ ->
   $("#restart-date-picker").datepicker(
      altFormat: 'yy-mm-dd'
    )

    stringDate = new Date(document.getElementById("master_service_request_first_scheduled").value.substring(0, 19).replace(/-/g, "/")).toDateString()
    $('#date-string').text stringDate

    $(".paused").change ->
      if $(this).val() == "true"
        $(".master_service_request_restart_date").show(400)
      else
        $(".master_service_request_restart_date").hide(400)
        frequency = $("#master_service_request_frequency").val()
        if frequency == "weekly" || frequency == "every_other_week"
          day = $("#master_service_request_service_week_day").val()
          nextScheduledWeekDay(day, $(this).val())
        else
          day = $("#master_service_request_service_month_day").val()
          nextScheduledMonthDay(day, $(this).val())
        

    $("#restart-date-picker").change ->
      frequency = $("#master_service_request_frequency").val()
      if frequency == "weekly" || frequency == "every_other_week"
        day = $("#master_service_request_service_week_day").val()
        futureNextScheduledWeekDay(day, $(this).val())
      else
        day = $("#master_service_request_service_month_day").val()
        futureNextScheduledMonthDay(day, $(this).val())


  futureNextScheduledWeekDay = (day, future) ->
    futureDate = new Date(future.substring(6), future.substring(0,2) - 1, future.substring(3,5))
    days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    selected_day_num = days.indexOf(day)
    future_day = futureDate.getDay()
    if selected_day_num > future_day
      scheduled_date = new Date 1900+futureDate.getYear(), futureDate.getMonth(), futureDate.getDate()+(selected_day_num - future_day) 
    else
      scheduled_date = new Date 1900+futureDate.getYear(), futureDate.getMonth(), futureDate.getDate()+(selected_day_num - future_day + 7)
    $('.first_scheduled').val scheduled_date
    dateString = scheduled_date.toDateString()
    $('#date-string').text dateString

  futureNextScheduledMonthDay = (selected_day_num, future) ->
    futureDate = new Date(future.substring(6), future.substring(0,2) - 1, future.substring(3,5))
    future_day = futureDate.getDate()
    if selected_day_num > future_day
      scheduled_date = new Date 1900+futureDate.getYear(), futureDate.getMonth(), selected_day_num 
    else
      scheduled_date = new Date 1900+futureDate.getYear(), (futureDate.getMonth() + 1), selected_day_num
    $('.first_scheduled').val scheduled_date
    dateString = scheduled_date.toDateString()
    $('#date-string').text dateString