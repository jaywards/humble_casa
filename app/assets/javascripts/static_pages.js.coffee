# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  
  #for bootstrap 3 use 'shown.bs.tab' instead of 'shown' in the next line
  $("a[data-toggle=\"tab\"]").on "click", (e) ->
    
    #save the latest tab; use cookies if you like 'em better:
    localStorage.setItem "lastTab", $(e.target).attr("href")

  
  #go to the latest tab, if it exists:
  lastTab = localStorage.getItem("lastTab")
  $("a[href=\"" + lastTab + "\"]").click()  if lastTab

$ ->
	if $('body').hasClass("static_pages")
		$('.carousel').carousel({
  			interval: 3000
		})