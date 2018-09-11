Stripe.api_key = Rails.env.production? ? ENV["STRIPE_OAUTH_APP_SECRET"] : Rails.application.secrets.stripe_oauth_app_secret
Stripe.max_network_retries = 3

STRIPE_PUBLISHABLE_KEY = Rails.env.production? ? ENV["STRIPE_PUBLISHABLE_KEY"] : Rails.application.secrets.stripe_publishable_key
STRIPE_YEARLY_SUBSCRIPTION_ID = Rails.env.production? ? ENV["STRIPE_YEARLY_SUBSCRIPTION_ID"] : Rails.application.secrets.stripe_subscription_yearly_id
STRIPE_MONTHLY_SUBSCRIPTION_ID = Rails.env.production? ? ENV["STRIPE_MONTHLY_SUBSCRIPTION_ID"] : Rails.application.secrets.stripe_subscription_monthly_id