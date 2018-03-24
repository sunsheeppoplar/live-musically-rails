SLACK_NOTIFIER = Slack::Notifier.new(Rails.application.secrets.slack_webhook_url) do
	defaults 	channel: "#stripe-payments",
				username: "Stripe Notifier"
end
