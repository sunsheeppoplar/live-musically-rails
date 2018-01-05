class CreateOpportunities < ActiveRecord::Migration[5.0]
  def change
    create_table :opportunities do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
