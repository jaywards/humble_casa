$ ->
	if $('body').hasClass("users") && $(".user-form").length
    $("#user_first_name").focus()
    $("#new_user").enableClientSideValidations()
    $("[id^=edit_user]").enableClientSideValidations()
    $("#user_primary_phone").mask("(999) 999-9999")

$ ->
  if $("body").hasClass("users") && $(".user-employer-select").length
    $("#employer_code").focus()
    $("#user_employment_attributes_service_id").attr('disabled', true)
    services = $("#services").data("services")
    $("#employer_state").change ->
      state = $(this).val()
      services_options = '<select>'
      $.each services, (i, service) ->
        if service.state == state
          services_options += '<option value="' + service.id + '">' + service.name + '</option>';
      services_options += '</select>'
      $("#user_employment_attributes_service_id").html(services_options)
      $("#user_employment_attributes_service_id").attr('disabled', false)
