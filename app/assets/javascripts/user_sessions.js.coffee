$ ->
  $(".launch-login-form").click ->
    setTimeout (->
      $("#user_session_email").focus()
      $("#login").enableClientSideValidations()

    ), 400