class StripeSubscriptionForm
	include ActiveModel::Model
	include Virtus.model

	attribute :current_user, Hash
	attribute :stripe_token, String
	attribute :subscription_type, String

	validates :stripe_token, presence: true
	validates :subscription_type, presence: true
	validate :were_stripe_requests_successful?

	def persist
		if valid?
			make_stripe_requests
			persist!
			true
		else
			false
		end
	end

	private
	def were_stripe_requests_successful?
		Stripe::Customer
	end

	def persist!
	end

	def stripe_subscription_params
		{
			stripe_token: stripe_token,
			subscription_type: subscription_type
		}
	end
end