$(document).on('turbolinks:load', function() {
	if (page.controller() === 'onboards' && page.action() === 'show') {
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
				var displayError = document.getElementById('card-errors');
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
						var errorElement = document.getElementById('card-errors');
						errorElement.textContent = result.error.message;
					} else {
						// Send the token to your server.
						stripeTokenHandler(result.token);
					}
				});
			});

			function stripeTokenHandler(token) {
				// Insert the token ID into the form so it gets submitted to the server
				var form = document.getElementById('payment-form');
				var hiddenInput = document.createElement('input');
				hiddenInput.setAttribute('type', 'hidden');
				hiddenInput.setAttribute('name', 'stripe_subscription_form[stripe_token]');
				hiddenInput.setAttribute('value', token.id);
				form.appendChild(hiddenInput);

				// Submit the form
				form.submit();
			}
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
	}
})