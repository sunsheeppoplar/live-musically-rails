class StripeSubscriptionForm
	include ActiveModel::Model
	include Virtus.model

	attribute :current_user, Hash
	attribute :stripe_token, String
	attribute :subscription_type, String
	attribute :stripe_promotion, String

	validates :stripe_token, presence: true
	validates :subscription_type, presence: true

	private
	def stripe_subscription_params
		{
			stripe_promotion: stripe_promotion,
			stripe_token: stripe_token,
			subscription_type: subscription_type
		}
	end
end