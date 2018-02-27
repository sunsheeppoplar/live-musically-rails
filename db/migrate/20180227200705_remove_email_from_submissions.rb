class RemoveEmailFromSubmissions < ActiveRecord::Migration[5.0]
  def change
    remove_column :submissions, :email, :string
  end
end
