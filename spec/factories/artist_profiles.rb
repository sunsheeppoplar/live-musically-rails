FactoryGirl.define do
  factory :artist_profile do
    about "MyText"
    desired_compensation_lower_bound 1
    desired_compensation_upper_bound "MyString"
    youtube_link "MyString"
    facebook_link "MyString"
    instagram_link "MyString"
  end
end
