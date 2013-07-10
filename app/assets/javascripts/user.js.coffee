$ ->
  $(".launch-user-form").click ->
    setTimeout (->
      $("#user_first_name").focus()
      $("#new_user").enableClientSideValidations()
      $("[id^=edit_user]").enableClientSideValidations()

    ), 400