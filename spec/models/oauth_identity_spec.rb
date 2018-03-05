RSpec.describe OauthIdentity, type: :model do
	describe "ActiveModel associations" do
		# belongs_to
		it "belongs to an user" do
			expect(subject). to belong_to(:user)
		end
	end
end