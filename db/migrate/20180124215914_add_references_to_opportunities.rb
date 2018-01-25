class AddReferencesToOpportunities < ActiveRecord::Migration[5.0]
  def change
  	add_reference :opportunities, :employer, foreign_key: { to_table: :users }
  end
end
