class OnboardsController < ApplicationController
	before_action :authenticate_user!

	def show
		if onboard_policy.registered_with_stripe?
			redirect_to root_path, alert: "Already registered with Stripe!"
		end
		step = 1
		stripe_subscription_form = StripeSubscriptionForm.new
		render "#{current_user.role}.html.erb", locals: { stripe_subscription_form: stripe_subscription_form, step: step }
	end

	def create
		stripe_subscription_form = StripeSubscriptionForm.new(stripe_subscription_form_params.merge(current_user: current_user))
		if stripe_subscription_form.valid?
			service = StripeSubscriptionService.new(stripe_subscription_form)
			service.call
			binding.pry
			if service.persist
			end
		end
	end

	private
	def onboard_policy
		@onboard_policy ||= OnboardPolicy.new(current_user)
	end

	def stripe_subscription_form_params
		params.require(:stripe_subscription_form).permit(:stripe_token, :subscription_type)
	end
end