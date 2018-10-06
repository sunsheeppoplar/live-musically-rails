FactoryGirl.define do
	factory :user do
		first_name "fake"
		last_name "fake"
		email "fake@fake.com"
		password "password"
		password_confirmation "password"

		factory :employer do
			email "e@e.com"
			role "artist_employer"
		end

		factory :artist do
			email "a@a.com"
			role "musician"
		end

		trait :has_stripe_subscription do
			stripe_customer_token "string"
		end

		trait :does_not_have_stripe_subscription do
			stripe_customer_token nil
		end
	end
end
