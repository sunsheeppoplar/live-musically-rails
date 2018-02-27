RSpec.describe OpportunityApplyForm do
	describe "validations" do
		describe "#prior_submission?" do
			context "submission for opportunity from given user has been made already" do
				let(:opportunity) { FactoryGirl.create(:opportunity, :with_submission) }
				let(:artist) { opportunity.submissions.first.user }
				let(:form) { OpportunityApplyForm.new(current_user: artist, opportunity_id: opportunity.id) }

				it "is not valid" do
					expect(form).to be_invalid
				end

				it "provides an error message" do
					form.valid?
					expect(form.errors.full_messages).to eq ["Opportunity can't be submitted to more than once"]
				end
			end
		end
	end
end