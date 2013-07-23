# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	if $('body').hasClass('WILL NEVER LOAD')

		setTimeout (->

			displaySoonest openSRs

		), 500

	displaySoonest = (unOrderedSRs) ->
		SR = findSoonest unOrderedSRs
		if SR.onetime == true
			startDateString = new Date(SR.service_start_date.substring(0, 10).replace(/-/g, "/")).toDateString()
			endDateString = new Date(SR.service_end_date.substring(0, 10).replace(/-/g, "/")).toDateString()
			scheduleString = "One-time request to be completed between " + 
								startDateString + " and " + endDateString
		else
			firstDateString = new Date(SR.first_scheduled.substring(0, 10).replace(/-/g, "/")).toDateString()		
			scheduleString = "Repeating request (" + SR.frequency.replace(/_/g, " ") + ") with next scheduled for " + firstDateString
		$('.scheduled-string').text scheduleString

	findSoonest = (serviceRequests) ->
		serviceRequests.sort SRcompare
		return serviceRequests[0]


	SRcompare = (a, b) ->
		return -1  if a.first_scheduled < b.first_scheduled
		return 1  if a.first_scheduled > b.first_scheduled
		0
