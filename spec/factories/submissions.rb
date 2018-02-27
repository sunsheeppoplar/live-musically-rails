FactoryGirl.define do
  factory :submission do
    phone_number "MyString"
    email "MyString"
    association :user, factory: :artist
  end
end
