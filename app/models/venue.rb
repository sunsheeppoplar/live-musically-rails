class Venue < ApplicationRecord
	belongs_to :opportunity
	enum category: { "bar / restaurant": 0, hotel: 1, party: 2, performance: 3, "wedding / anniversary": 4, "private lessons": 5 }
end
