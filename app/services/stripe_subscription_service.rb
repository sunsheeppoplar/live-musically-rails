class StripeSubscriptionService
	attr_reader :current_user, :customer_helper, :errors, :request_params, :subscription_helper, :subscription_types

	def initialize(request_params)
		@customer_helper = Stripe::Customer
		@subscription_helper = Stripe::Subscription

		@request_params = request_params
		@current_user = request_params.current_user
		@subscription_types = {
			monthly: STRIPE_MONTHLY_SUBSCRIPTION_ID,
			yearly: STRIPE_YEARLY_SUBSCRIPTION_ID
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
			    items: [{plan: subscription_types[request_params.subscription_type.to_sym]}]
			})

			if customer.present? && subscription.present?
				# need to migrate and add save!
			else
				raise "Couldn't complete subscription, sorry!"
			end
		rescue Stripe::CardError => e
			binding.pry
		  # Since it's a decline, Stripe::CardError will be caught
			body = e.json_body
			err  = body[:error]

			errors.push(err[:message])

			puts "Status is: #{e.http_status}"
			puts "Type is: #{err[:type]}"
			puts "Charge ID is: #{err[:charge]}"
			# The following fields are optional
			puts "Code is: #{err[:code]}" if err[:code]
			puts "Decline code is: #{err[:decline_code]}" if err[:decline_code]
			puts "Param is: #{err[:param]}" if err[:param]
			puts "Message is: #{err[:message]}" if err[:message]
		rescue Stripe::RateLimitError => e
			# Too many requests made to the API too quickly
			body = e.json_body
			err  = body[:error]

			errors.push(err[:message])
			puts e
		rescue Stripe::InvalidRequestError => e
			# Invalid parameters were supplied to Stripe's API
			body = e.json_body
			err  = body[:error]

			errors.push(err[:message])
			puts e
		rescue Stripe::AuthenticationError => e
			# Authentication with Stripe's API failed
			# (maybe you changed API keys recently)
			body = e.json_body
			err  = body[:error]

			errors.push(err[:message])
			puts e
		rescue Stripe::APIConnectionError => e
			# Network communication with Stripe failed
			body = e.json_body
			err  = body[:error]

			errors.push(err[:message])
			puts e
		rescue Stripe::StripeError => e
			# Display a very generic error to the user, and maybe send
			# yourself an email
			body = e.json_body
			err  = body[:error]

			errors.push(err[:message])
			puts e
		rescue => e
			binding.pry
			# Something else happened, completely unrelated to Stripe
			puts e
			error = e.to_s
			errors.push(error)
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
end