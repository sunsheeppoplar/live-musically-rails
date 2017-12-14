RSpec.describe User, type: :model do
	describe "ActiveModel associations" do
		# has_one
		it "has one artist profile" do
			expect(subject).to have_one(:artist_profile)
		end
	end
end
