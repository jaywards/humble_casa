$ ->
	if $('body').hasClass("users")
    	$("#user_first_name").focus()
    	$("#new_user").enableClientSideValidations()
    	$("[id^=edit_user]").enableClientSideValidations()
    	$("#user_primary_phone").mask("(999) 999-9999")
