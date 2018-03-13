class CreateSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :submissions do |t|
      t.string :phone_number
      t.string :email
      t.references :user, foreign_key: true
      t.references :opportunity, foreign_key: true

      t.timestamps
    end
  end
end
