class ChangeZipTypeInVenues < ActiveRecord::Migration[5.0]
  def change
  	change_column :venues, :zip, :string
  end
end
