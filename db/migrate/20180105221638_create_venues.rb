class CreateVenues < ActiveRecord::Migration[5.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.string :city
      t.integer :zip
      t.integer :category
      t.belongs_to :opportunity, index: true

      t.timestamps
    end
  end
end
