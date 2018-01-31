class RemoveInstrumentFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :instrument, :integer
  end
end
