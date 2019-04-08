RSpec.describe ArtistProfile, type: :model do
	describe "ActiveModel associations" do
  	# has_one
  	it "has one artist profile" do
  		expect(subject).to belong_to(:user)
  	end
  end
end
