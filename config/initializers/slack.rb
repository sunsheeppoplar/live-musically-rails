unless Rails.env.test?
	slack_webhook_url = ENV["SLACK_WEBHOOK_URL"] || Rails.application.secrets.slack_webhook_url
	SLACK_NOTIFIER = Slack::Notifier.new(slack_webhook_url) do
		defaults 	channel: "#stripe-payments",
					username: "Stripe Notifier"
	end
end
