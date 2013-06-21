# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
    $(".launch-service-request").click ->
      setTimeout (->

        $("#start-date-picker").datepicker(
          altField: '.service_start_date',
          altFormat: 'yy-mm-dd'
          )
        $('#end-date-picker').datepicker(
          altField: '.service_end_date',
          altFormat: 'yy-mm-dd'
          )

        if $("#service_request_onetime_true").attr("checked")
          $('.onetime-fields').show()
        if $("#service_request_onetime_false").attr("checked")
          $('.repeating-fields').show()
          e = document.getElementById("service_request_frequency")
          selectedFrequency = e.options[e.selectedIndex].value
          if selectedFrequency == "weekly" || selectedFrequency == "every_other_week"
            $('.weekly-fields').show()
          else
            $('.monthly-fields').show()
          stringDate = new Date(document.getElementById("service_request_first_scheduled").value.substring(0, 19).replace(/-/g, "/")).toDateString()
          $('#date-string').text stringDate
          $('#first-scheduled-fields').show()
      
        $(".onetime").change ->
          if $(this).val() == "true"
              $('.onetime-fields').show(400)
              $('.repeating-fields').hide(400)
          else
              $('.onetime-fields').hide(400)
              $('.repeating-fields').show(400)     


        $(".frequency").change ->
          $('#first-scheduled-fields').hide(400)
          if $(this).val() == "weekly" || $(this).val() == "every_other_week"
              $('.weekly-fields').show(400)
              $('.monthly-fields').hide(400)
          else
              $('.weekly-fields').hide(400)
              $('.monthly-fields').show(400)

        $("#daypicker").change ->
          days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
          selected_day_num = days.indexOf($(this).val())
          today = new Date()
          today_day = today.getDay()
          if selected_day_num > today_day
            scheduled_date = new Date 1900+today.getYear(), today.getMonth(), today.getDate()+(selected_day_num - today_day) 
          else
            scheduled_date = new Date 1900+today.getYear(), today.getMonth(), today.getDate()+(selected_day_num - today_day + 7)
          $('.first_scheduled').val scheduled_date
          dateString = scheduled_date.toDateString()
          $('#date-string').text dateString
          $('#first-scheduled-fields').show(400)

        $("#monthpicker").change ->
          selected_day_num = $(this).val()
          today = new Date()
          today_day = today.getDate()
          if selected_day_num > today_day
            scheduled_date = new Date 1900+today.getYear(), today.getMonth(), selected_day_num 
          else
            scheduled_date = new Date 1900+today.getYear(), (today.getMonth() + 1), selected_day_num
          $('.first_scheduled').val scheduled_date
          dateString = scheduled_date.toDateString()
          $('#date-string').text dateString
          $('#first-scheduled-fields').show(400)
      ), 500