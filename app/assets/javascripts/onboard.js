$(document).on('turbolinks:load', function() {
	if (page.controller() === 'onboards' && page.action() === 'show') {
		var cachedDom = {
			$subscriptionInfo: $('.js-subscription-info'),
			$subscriptionButton: $('.js-subscription-info__button'),
			$stripeConnectForm: $('.js-stripe-connect-form'),
			$stripeSubscriptionForm: $('.js-stripe-subscription-form'),
			$stripeSubscriptionFormErrors: $('#js-stripe-subscription-form__errors'),
			$stripeSubscriptionFormNotices: $('.notice')
		}

		var formNavigation = {
			1: cachedDom.$subscriptionInfo,
			2: cachedDom.$stripeSubscriptionForm,
			3: cachedDom.$stripeConnectForm
		}

		function setDefaultStripeLink() {
			$('.js-setup-stripe-button').attr('href', function(i, val) {
				var baseHref = val;
				var redirectURI = setStripeConnectCallbackParameter();
				var companyType = setDefaultBusinessTypeParameter();

				return baseHref + redirectURI + companyType;
			})
		}

		function setStripeConnectCallbackParameter() {
			return '&redirect_uri=' + window.location.origin + '/users/auth/stripe_connect/callback';
		}

		function setDefaultBusinessTypeParameter() {
			var companyType = $('.js-stripe-radio-button').filter(':checked').val()

			return  '&stripe_user[business_type]=' + companyType;
		}

		function switchMembershipType() {
			var membershipDuration = this.dataset.subscriptionType;
			var targetBaseIdString = '#stripe_subscription_form_subscription_type_';
			var fullTargetBaseIdString = targetBaseIdString + membershipDuration;

			$(fullTargetBaseIdString).prop('checked', true);
			navigate(this.dataset.step);
		}

		function navigate(currentStep) {
			formNavigation[currentStep].hide()
			formNavigation[parseInt(currentStep) + 1].show()
		}

		function handleStripeSubscriptionSuccess(data, textStatus, xhr) {
			var success = data.notice;
			var step = "2";

			cachedDom.$stripeSubscriptionFormNotices.html(success);
			navigate(step)
		}

		function handleStripeSubscriptionError(xhr, textStatus, errorThrown) {
			var errors = xhr.responseJSON.errors

			cachedDom.$stripeSubscriptionFormErrors.html(errors)
		}

		var stepInOnboarding = $('.js-onboard-form-step').val()

		if (stepInOnboarding === "1") {
			var stripePublishableKey = $('meta[name=stripe]').attr('content');
			var stripe = Stripe(stripePublishableKey);
			var elements = stripe.elements()

			// Custom styling can be passed to options when creating an Element.
			var style = {
				base: {
					// Add your base input styles here. For example:
					fontSize: '16px',
					color: "#32325d",
				}
			};

			// Create an instance of the card Element.
			var card = elements.create('card', {style: style});

			// Add an instance of the card Element into the `card-element` <div>.
			card.mount('#card-element');

			card.addEventListener('change', function(event) {
				var displayError = document.getElementById('js-stripe-subscription-form__errors');
				if (event.error) {
					displayError.textContent = event.error.message;
				} else {
					displayError.textContent = '';
				}
			});

			// Create a token or display an error when the form is submitted.
			var form = document.getElementById('payment-form');
			form.addEventListener('submit', function(event) {
				event.preventDefault();

				stripe.createToken(card).then(function(result) {
					if (result.error) {
						// Inform the customer that there was an error.
						var errorElement = document.getElementById('js-stripe-subscription-form__errors');
						errorElement.textContent = result.error.message;
					} else {
						// Send the token to your server.
						stripeTokenHandler(result.token);
					}
				});
			});

			function stripeTokenHandler(token) {
				var subscriptionType = findSubscriptionType();
				var stripePromotion = findStripePromotion();

				$.ajax({
					method: "POST",
					url: "/onboard",
					data: {
						"stripe_subscription_form": {
							"stripe_token": token.id,
							"stripe_promotion": stripePromotion,
							"subscription_type": subscriptionType
						}
					}
				})
				.done(handleStripeSubscriptionSuccess)
				.fail(handleStripeSubscriptionError)
			}
		}

		function findSubscriptionType() {
			return $('input[name="stripe_subscription_form[subscription_type]"').filter(':checked').val();
		}

		function findStripePromotion() {
			return $('#stripe_subscription_form_stripe_promotion').val();
		}

		$('.js-stripe-radio-button').on("change", function(event) { 
			var companyType = this.value;

			$('.js-setup-stripe-button').attr('href', function(i, val) {
				var stripeBusinessTypeQuery = '&stripe_user[business_type]=';
				if (val.indexOf(stripeBusinessTypeQuery) !== -1) {
					var baseHref = val.split(stripeBusinessTypeQuery)[0];
					return baseHref + stripeBusinessTypeQuery + companyType;
				} else {
					return val + stripeBusinessTypeQuery + companyType;
				}
			})
		})

		cachedDom.$subscriptionButton.on('click', switchMembershipType);
		setDefaultStripeLink();
	}
})