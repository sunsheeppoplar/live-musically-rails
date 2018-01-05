require 'rails_helper'

RSpec.describe Venue, type: :model do
  describe "ActiveModel associations" do
		# belongs_to
		it "belongs to an opportunity" do
			expect(subject).to belong_to(:opportunity)
		end
	end
end
