$(document).on('turbolinks:load', function() {

	function setDefaultStripeLink() {
		// naive implementation, cache it, etc. when merging rest of stripe-signup feature branch
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

	setDefaultStripeLink();

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
})