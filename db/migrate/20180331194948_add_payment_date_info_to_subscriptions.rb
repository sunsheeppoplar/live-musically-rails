class AddPaymentDateInfoToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :date_paid, :datetime
    add_column :subscriptions, :date_paid_until, :datetime
  end
end
