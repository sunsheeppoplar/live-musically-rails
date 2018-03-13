FactoryGirl.define do
	factory :opportunity do
		title "MyString"
		description "MyText"
		employer

		trait :with_submission do
			after :create do |opportunity|
				FactoryGirl.create_list :submission, 1, opportunity: opportunity
			end
		end
	end
end
