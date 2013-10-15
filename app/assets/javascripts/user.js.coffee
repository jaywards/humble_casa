$ ->
	if $('body').hasClass("users")
    	$("#user_first_name").focus()
    	$("#new_user").enableClientSideValidations()
    	$("[id^=edit_user]").enableClientSideValidations()
