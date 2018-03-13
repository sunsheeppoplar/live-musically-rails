$(document).on('turbolinks:load', function() {
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