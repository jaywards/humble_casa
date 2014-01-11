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
    initializeRaty()
    initializeListGroup()
    
    
        
initializeRaty = ->
  $.fn.raty.defaults.path = "http://www.humblecasa.com/assets"
  $(".raty").raty 
    readOnly: true,
    score: ->
      $(this).attr "data-score"

initializeListGroup = ->
  $(".list-group-item").click (event) ->
    serviceListing = $(this)
    assignID = serviceListing.attr "assignid"
    serviceID = serviceListing.attr "serviceid"
    checkboxID = '#selected' + serviceID + '-' + assignID
    assignmentField = '#property_assignments_attributes_' + assignID + '_service_id'
    checkedField = '#checkedField' + serviceID + '-' + assignID 

    if $(event.target).hasClass("selected")
      if $(checkedField).val() == 'true'
        #alert("clicked on checked box - deactivate")
        deactivate(serviceListing, assignID, serviceID, checkedField)
      else
        #alert("clicked on unchecked box - activate")
        activate(serviceListing, assignID, serviceID, checkedField)
    else
      if $(checkedField).val() == 'false'
        #alert("clicked on unselected service - activate")
        activate(serviceListing, assignID, serviceID, checkedField)
  
activate = (serviceListing, assignID, serviceID, checkedField) ->
  current = serviceListing.attr "current"
  currentActive = serviceListing.closest(".list-group").children(".active")
  CAServiceID = currentActive.attr "serviceid"
  currentActive.removeClass "active"
  $('#selected' + CAServiceID).prop("checked", false)
  $('#confirmed' + CAServiceID).hide(400)
  serviceListing.addClass "active"
  $('#property_assignments_attributes_' + assignID + '_service_id').val(serviceID)
  $('#selected' + serviceID + '-' + assignID).prop("checked", true)
  $(checkedField).val(true)
  if current == "false"
    $('#confirmed' + serviceID + '-' + assignID).show(400)  

deactivate = (serviceListing, assignID, serviceID, checkedField) ->
  serviceListing.removeClass "active"
  $('#property_assignments_attributes_' + assignID + '_service_id').val("")
  $('#selected' + serviceID + '-' + assignID).prop("checked", false)
  $('#confirmed' + serviceID + '-' + assignID).hide(400)
  $(checkedField).val(false)