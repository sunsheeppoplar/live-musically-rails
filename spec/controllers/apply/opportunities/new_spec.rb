RSpec.describe Apply::OpportunitiesController, type: :controller do
	describe 'GET /apply/opportunities/new' do
		def trigger
			get :new, xhr: true
		end

		context 'not logged in' do
			it 'should not access this page and redirect' do
				trigger
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
				render_views

				before do
					expect(Opportunity).to receive(:find).and_return(resource)
					trigger
				end

				setup_devise
				let(:policy_result) { true }

				it 'should return authorized status' do
					expect(response.status).to eq 200
				end

				it 'should return a form partial as a string' do
					expect(response.body).to eq "{\"new_application\":\"\\u003cform class=\\\"new_opportunity_apply_form\\\" id=\\\"new_opportunity_apply_form\\\" action=\\\"/apply/opportunities\\\" accept-charset=\\\"UTF-8\\\" method=\\\"post\\\"\\u003e\\u003cinput name=\\\"utf8\\\" type=\\\"hidden\\\" value=\\\"\\u0026#x2713;\\\" /\\u003e\\n\\tApply to MYSTRING\\n\\t\\u003cinput value=\\\"1\\\" type=\\\"hidden\\\" name=\\\"opportunity_apply_form[opportunity_id]\\\" id=\\\"opportunity_apply_form_opportunity_id\\\" /\\u003e\\n\\t\\u003cinput type=\\\"submit\\\" name=\\\"commit\\\" value=\\\"SUBMIT APPLICATION\\\" data-disable-with=\\\"SUBMIT APPLICATION\\\" /\\u003e\\n\\u003c/form\\u003e\"}"
				end
			end

			context 'as non-authorized user' do
				before do
					trigger
				end

				setup_devise
				let(:policy_result) { false }

				it 'should return not authorized status' do
					expect(response.status).to eq 403
				end

				it 'should include location to redirect to' do
					expect(parsed_body["location"]).to eq "/"
				end

				it 'should include an error message' do
					expect(parsed_body["error"]).to eq 'Not authorized, sorry!'
				end
			end
		end
	end
end