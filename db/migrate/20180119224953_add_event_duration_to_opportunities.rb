class AddEventDurationToOpportunities < ActiveRecord::Migration[5.0]
  def change
    add_column :opportunities, :event_duration, :integer
  end
end
