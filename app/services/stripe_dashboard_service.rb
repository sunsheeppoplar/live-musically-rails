class StripeDashboardService
	attr_reader :account

	def initialize(account)
		@account = account
		@dashboard_helper = Stripe::Account
	end

	def call
		user_details = @dashboard_helper.retrieve(account.uid)
		link = user_details.login_links.create
		link.url
	end
end