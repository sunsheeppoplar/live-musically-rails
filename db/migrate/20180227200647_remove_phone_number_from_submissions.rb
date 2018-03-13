class RemovePhoneNumberFromSubmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :submissions, :phone_number, :string
  end
end
