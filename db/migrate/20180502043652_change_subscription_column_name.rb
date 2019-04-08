class ChangeSubscriptionColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :subscriptions, :type, :duration
  end
end
