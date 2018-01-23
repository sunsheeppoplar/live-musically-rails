class RemoveEventDurationFromOpportunities < ActiveRecord::Migration[5.0]
  def change
    remove_column :opportunities, :event_duration, :integer
  end
end
