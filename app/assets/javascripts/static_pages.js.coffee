# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#home-tabs > li > a').hover ->
      $(this).tab 'show'

$ ->
  if $('body').hasClass("static_pages")
    $('#options_report_start_date').datepicker({ dateFormat: 'MM-dd-yy' })
    $('#options_report_end_date').datepicker({ dateFormat: 'MM-dd-yy' })

$ ->
  
  #for bootstrap 3 use 'shown.bs.tab' instead of 'shown' in the next line
  
  $("a[data-toggle=\"tab\"]").on "click", (e) ->
    if $(e.target).hasClass('service-tab')
      localStorage.setItem "lastTab", $(e.target).attr("href")
    else
      localStorage.setItem "reportLastTab", $(e.target).attr("href")
  
  lastTab = localStorage.getItem("lastTab")
  $("a[href=\"" + lastTab + "\"]").click()  if lastTab  
  reportLastTab = localStorage.getItem("reportLastTab")
  $("a[href=\"" + reportLastTab + "\"]").click()  if reportLastTab

$ ->
  if $('body').hasClass("static_pages")
    $('.carousel').carousel({
      interval: 3000
    })
    $(".star").raty
      path: "assets"
      score: ->
        $(this).attr "data-score"
      click: (score, evt) ->
        id = $(this).attr("id")
        $.ajax
          url: "/services/" + id + "/rate?rating=" + score
          type: "POST"
          success: (data) ->
            if data is "record_not_found"
              alert "Unable to process your rating at this time. Please try again later"
            else
              msgID = '.votemsg' + id
              $(msgID).text "Thank you for your feedback!"   