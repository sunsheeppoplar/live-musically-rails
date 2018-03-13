FactoryGirl.define do
	factory :user do
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
	end
end
