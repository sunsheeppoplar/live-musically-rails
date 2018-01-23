class AddEndDateToOpportunities < ActiveRecord::Migration[5.0]
  def change
    add_column :opportunities, :event_end_date, :datetime
  end
end
