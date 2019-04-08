class StripeSubscriptionService
	attr_reader :current_user, :customer_helper, :errors, :request_params, :subscription_helper, :subscription_types, :subscription_types_as_nouns

	def initialize(request_params)
		@customer_helper = Stripe::Customer
		@subscription_helper = Stripe::Subscription

		@request_params = request_params
		@current_user = request_params.current_user
		@subscription_types = {
			monthly: STRIPE_MONTHLY_SUBSCRIPTION_ID,
			yearly: STRIPE_YEARLY_SUBSCRIPTION_ID
		}
		@subscription_types_as_nouns = {
			monthly: "month",
			yearly: "year"
		}
		@errors = []
	end

	def call
		begin
			# Use Stripe's library to make requests...
			customer = customer_helper.create({
				email: request_params.current_user.email,
				source: request_params.stripe_token
			})
			subscription = subscription_helper.create({
			    customer: customer,
			    items: [{plan: subscription_types[subscription_type_to_symbol]}],
			    coupon: apply_coupon
			})

			if customer.present? && subscription.present?
				ActiveRecord::Base.transaction do
					current_user.update(stripe_customer_token: customer.id)
					current_user.create_subscription(
						date_paid: DateTime.now,
						date_paid_until: DateTime.now + 1.send(subscription_types_as_nouns[subscription_type_to_symbol]),
						stripe_token: subscription.id,
						duration: request_params.subscription_type
					)
				end
			else
				raise "Couldn't complete subscription, sorry!"
			end
		rescue Stripe::CardError => e
		  # Since it's a decline, Stripe::CardError will be caught
			error = e.json_body[:error]
			errors.push(error[:message])

			puts "Status is: #{e.http_status}"
			puts "Type is: #{error[:type]}"
			puts "Charge ID is: #{error[:charge]}"
			# The following fields are optional
			puts "Code is: #{error[:code]}" if error[:code]
			puts "Decline code is: #{error[:decline_code]}" if error[:decline_code]
			puts "Param is: #{error[:param]}" if error[:param]
			puts "Message is: #{error[:message]}" if error[:message]
		rescue Stripe::RateLimitError => e
			# Too many requests made to the API too quickly
			error = e.json_body[:error][:message]
			errors.push(error)
			puts e
		rescue Stripe::InvalidRequestError => e
			# Invalid parameters were supplied to Stripe's API
			error = e.json_body[:error][:message]
			errors.push(error)
			puts e
		rescue Stripe::AuthenticationError => e
			# Authentication with Stripe's API failed
			# (maybe you changed API keys recently)
			error = e.json_body[:error][:message]
			errors.push(error)
			puts e
		rescue Stripe::APIConnectionError => e
			# Network communication with Stripe failed
			error = e.message
			errors.push(error)
			puts e
			notify_error(customer, subscription, error)
		rescue Stripe::StripeError => e
			# Display a very generic error to the user, and maybe send
			# yourself an email
			error = e.message
			errors.push(error)
			puts e
			notify_error(customer, subscription, error)
		rescue => e
			# Something else happened, completely unrelated to Stripe
			error = e.to_s
			errors.push(error)
			puts e
			notify_error(customer, subscription, error)
		end
	end

	def persist
		errors.length < 1
	end

	private
	def notify_error(customer, subscription, error)
		customer_link = slack_formatted_link(customer.id, "customers")
		subscription_link = slack_formatted_link(subscription.id, "subscriptions")

		message = "Sent from our *#{Rails.env}* environment - might need to go check out the following:\nCustomer ID: #{customer_link}\nSubscription ID: #{subscription_link}\nOriginal error: #{error}"
		SLACK_NOTIFIER.post text: message
	end

	def stripe_base_url
		if !Rails.env.production?
			"https://dashboard.stripe.com/test/"
		else
			"https://dashboard.stripe.com/"
		end
	end

	def slack_formatted_link(displayed_text, resource)
		"<#{stripe_base_url + resource}/#{displayed_text}|#{displayed_text}>"
	end

	def apply_coupon
		request_params.subscription_type == "yearly" ? request_params.stripe_promotion : nil
	end

	def subscription_type_to_symbol
		request_params.subscription_type.to_sym
	end
end