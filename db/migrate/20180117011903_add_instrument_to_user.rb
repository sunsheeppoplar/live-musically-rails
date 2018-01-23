class AddInstrumentToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :instrument, :integer
  end
end
