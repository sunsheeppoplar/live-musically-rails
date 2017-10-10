RSpec.describe 'GET /test-landing', :type => :request do
	before { get '/' }

	context 'setting up test suite for travis ci' do

		it 'says hello' do
			expect(response.body).to eq('hi s&m')
		end
	end
end