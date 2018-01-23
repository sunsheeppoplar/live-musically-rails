class AddStartDateToOpportunities < ActiveRecord::Migration[5.0]
  def change
    add_column :opportunities, :event_start_date, :datetime
  end
end
