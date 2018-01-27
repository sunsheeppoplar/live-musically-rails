class AddStateToVenue < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :state, :string
  end
end
