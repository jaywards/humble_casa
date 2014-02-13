$ ->
	if $('body').hasClass("services") && $(".service-form").length > 0
		$("#service_name").focus()
		$("#new_service").enableClientSideValidations()
		$("[id^=edit_service]").enableClientSideValidations()
		$("#service_phone").mask("(999) 999-9999")

$ ->
	if $('body').hasClass("services") && $(".add-employee").length
		$("#service_user_primary_phone").mask("(999) 999-9999")
		$("#service_user_first_name").focus()
		
$ ->
	if $('body').hasClass("services") && $(".service-payment-form").length > 0
		Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content')) 
		$('#service_invoice_me').change ->
			if $(this).prop('checked')
				$('#card_number').prop('disabled', true)
				$('#card_number').val("")
				
				$('#card_code').prop('disabled', true)
				$('#card_code').val("")
				
				$('#card_month').prop('disabled', true)
				$('#card_month').val("")
				
				$('#card_year').prop('disabled', true)
				$('#card_year').val("")
				
			else
				$('#card_number').prop('disabled', false)
				$('#card_code').prop('disabled', false)
				$('#card_month').prop('disabled', false)
				$('#card_year').prop('disabled', false) 
		service.setupPaymentForm()
		$('#card_number').mask("9999 9999 9999 9999")
		$('#card_number').focus()

service =
	setupPaymentForm: ->
		$('[id^=edit_service]').submit ->
			$('input[type=submit]').attr('disabled', true)
			if $('#service_invoice_me').prop('checked') == false && $('#card_number').length
				service.processCard()
				false
			else
				true

	processCard: ->
		card =
			number: $('#card_number').val()
			cvc: $('#card_code').val()
			expMonth: $('#card_month').val()
			expYear: $('#card_year').val()
		Stripe.createToken(card, service.handleStripeCardResponse)

	handleStripeCardResponse: (status, response) ->
		if status == 200
			$('#service_stripe_card_token').val(response.id)
			$('#service_last_four').val(response.card.last4)
			$('#service_card_type').val(response.card.type)
			$('[id^=edit_service]')[0].submit()
		else
			$('#stripe_error').text(response.error.message)
			$('input[type=submit]').attr('disabled', false)


$ ->
	if $('body').hasClass("services") && $(".provide-estimate").length > 0
		$("#service_assignments_attributes_0_cost").maskMoney()
		$("#service_assignments_attributes_0_cost").focus()
