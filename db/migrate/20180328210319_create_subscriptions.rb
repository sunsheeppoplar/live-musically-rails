class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.string :type
      t.string :stripe_token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
