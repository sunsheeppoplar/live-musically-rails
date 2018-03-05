RSpec.describe User, type: :model do
	describe "ActiveModel associations" do
		# has_many
		it "has many submissions" do
			expect(subject).to have_many(:submissions)
		end

		it "has many oauth identities" do
			expect(subject).to have_many(:oauth_identities)
		end
	end

	describe "instance methods" do
		describe "#not_stripe_user?" do
			let(:user) { FactoryGirl.create(:user) }

			context "has registered with Stripe" do
				let!(:stripe) { FactoryGirl.create(:oauth_identity, uid: "uid", provider: "stripe_connect", user_id: user.id) }

				it "returns false" do
					expect(user.not_stripe_user?).to eq false
				end
			end

			context "hasn't registered with Stripe" do
				it "returns true" do
					expect(user.not_stripe_user?).to eq true
				end
			end
		end

		describe "#recently_registered?" do
			let(:user) { FactoryGirl.create(:user) }

			before do
				expect(user).to receive(:not_stripe_user?).and_return(true)
			end

			context "just registered" do
				before do
					user.sign_in_count = 1
				end
					
				it "returns true" do
					expect(user.recently_registered?).to eq true
				end

				it "does not return false" do
					expect(user.recently_registered?).to_not eq false
				end
			end

			context "has already registered" do
				before do
					user.sign_in_count = 2
				end
					
				it "returns false" do
					expect(user.recently_registered?).to eq false
				end

				it "does not return true" do
					expect(user.recently_registered?).to_not eq true
				end
			end
		end
	end
end
