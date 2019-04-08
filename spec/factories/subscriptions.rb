FactoryGirl.define do
  factory :subscription do
    type ""
    stripe_token "MyString"
    user nil
  end
end
