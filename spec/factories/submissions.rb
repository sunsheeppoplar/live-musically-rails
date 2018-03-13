FactoryGirl.define do
  factory :submission do
    association :user, factory: :artist
  end
end
