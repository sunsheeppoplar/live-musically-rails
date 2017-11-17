RSpec.describe 'GET /test-landing', :type => :request do
	before { get '/' }

	context 'setting up test suite for travis ci' do

		it 'redirects' do
			expect(response.body).to eq("<html><body>You are being <a href=\"http://www.example.com/auth\">redirected</a>.</body></html>")
		end
	end
end