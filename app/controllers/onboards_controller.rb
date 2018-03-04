class OnboardsController < ApplicationController
	before_action :authenticate_user!

	def show
		if onboard_policy.registered_with_stripe?
			redirect_to root_path, alert: "Already registered with Stripe!"
		end
	end

	private
	def onboard_policy
		OnboardPolicy.new(current_user)
	end
end