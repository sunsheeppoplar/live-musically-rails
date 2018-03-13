RSpec.describe Apply::OpportunitiesController, type: :controller do
	describe 'POST /apply/opportunities' do
		context 'not logged in' do
			it 'should not access this page and redirect' do
				post :create
				expect(response.status).to eq 302
			end
		end

		context 'logged in' do
			let(:artist) { FactoryGirl.create(:artist) }
			let(:resource) { FactoryGirl.create(:opportunity) }
			let(:policy_double) { instance_double(OpportunityPolicy) }
			let(:policy_result) { nil }

			before do
				sign_in(artist)

				expect(OpportunityPolicy)
					.to receive(:new).with(artist, nil)
					.and_return(policy_double)
				expect(policy_double).to receive(:artist?).and_return(policy_result)
			end

			context 'as authorized user' do

				setup_devise
				let(:policy_result) { true }
				let(:submission) { Submission.last }

				context 'it saves' do
					before do
						post :create, params: { opportunity_apply_form: {opportunity_id: resource.id} }
					end

					it 'should return authorized status' do
						expect(response.status).to eq 302
					end

					it 'should associate the submission with the current user' do
						expect(submission.user_id).to eq artist.id
					end

					it 'should associate the submission with the proper opportunity' do
						expect(submission.opportunity_id).to eq resource.id
					end

					it 'redirects to home page' do
						expect(response).to redirect_to root_path
					end

					it 'notifies user of success' do
						expect(flash[:notice]).to eq "Your application was submitted!"
					end
				end

				context 'it does not save' do
					before do
						post :create, params: { opportunity_apply_form: {opportunity_id: nil} }
					end

					it 'redirects to home page' do
						expect(response).to redirect_to root_path
					end

					it 'notifies user of success' do
						expect(flash[:alert]).to eq "Sorry, something went wrong!"
					end
				end
			end
		end
	end
end