class OnboardPolicy
	attr_accessor :current_user

	def initialize(current_user)
		@current_user = current_user
	end

	def registered_with_stripe?
		!current_user.not_stripe_user?
	end
end