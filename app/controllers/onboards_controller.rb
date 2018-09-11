class OnboardsController < ApplicationController
	before_action :authenticate_user!

	def show
		if onboard_policy.registered_with_stripe?
			redirect_to root_path, alert: "Already registered with Stripe!"
		else
			step = 1
			stripe_subscription_form = StripeSubscriptionForm.new
			render "#{current_user.role}.html.erb", locals: { stripe_subscription_form: stripe_subscription_form, step: step }
		end
	end

	def create
		stripe_subscription_form = StripeSubscriptionForm.new(stripe_subscription_form_params.merge(current_user: current_user))
		respond_to do |format|
			if stripe_subscription_form.valid?
				service = StripeSubscriptionService.new(stripe_subscription_form)
				service.call

				if service.persist
					format.json {
						render json: { notice: "Stripe subscription successful" }, status: :ok
					}
				else
					format.json {
						render json: { errors: service.errors }, status: :unprocessable_entity
					}
				end
			end
		end
	end

	private
	def onboard_policy
		@onboard_policy ||= OnboardPolicy.new(current_user)
	end

	def stripe_subscription_form_params
		params.require(:stripe_subscription_form).permit(:stripe_token, :stripe_promotion, :subscription_type)
	end
end