RSpec.describe Opportunity, type: :model do
	describe "ActiveModel associations" do
		# has_many
		it "has many submissions" do
			expect(subject).to have_many(:submissions)
		end
	end
end
