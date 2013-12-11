$ ->
  if $('body').hasClass("properties") && $(".property-form").length > 0
    $("#property_name").focus()
    $("#new_property").enableClientSideValidations()
    $("[id^=edit_property]").enableClientSideValidations()

$ ->
  if $('body').hasClass("properties") && $(".property-payment-form").length > 0
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content')) 
    property.setupPaymentForm()
    $('#card_number').mask("9999 9999 9999 9999")
    $('#card_number').focus()

property =
  setupPaymentForm: ->

    $('[id^=edit_property]').submit ->
      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        property.processCard()
        false
      else
        true

  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, property.handleStripeCardResponse)

  handleStripeCardResponse: (status, response) ->
    if status == 200
      $('#property_stripe_card_token').val(response.id)
      $('#property_card_type').val(response.card.type)
      $('#property_last_four').val(response.card.last4)
      $('[id^=edit_property]')[0].submit()
    else
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)


$ ->
  if $('body').hasClass("properties") && $(".register-services").length
    $.fn.raty.defaults.path = "http://www.humblecasa.com/assets"
    initializeRegisterServiceForm()


initializeRegisterServiceForm = ->
  counter = 0
  while counter < catCount
    $('#confirmed' + counter).hide()
    $('#star' + counter).raty
      readOnly: true
      score: ->
        $(this).attr "data-score"
    if $('#property_assignments_attributes_' + counter + '_service_id').val() == ""
      $('#star' + counter).hide()
    $('#property_assignments_attributes_' + counter + '_service_id').change ->
      service = $(this).val()
      id = $(this).attr('id').match(/[0-9]+/)
      if service == ""
        $('#service-description-' + id).text ""
        $('#confirmed' + id).hide(400)
        $('#star' + id).hide(400) 
      else
        $('#confirmed' + id).show(400)
        $.ajax
          url: "/services/" + service
          type: "get"
          dataType: "html"
          processData: false
          success: (data) ->
            if data is "record_not_found"
              alert "Service description not found"
            else
              content = data.split("|")
              $('#star' + id).raty "set",
                score: content[0]
              $('#star' + id).show(400)
              $('#service-description-' + id).text content[1]
    counter++