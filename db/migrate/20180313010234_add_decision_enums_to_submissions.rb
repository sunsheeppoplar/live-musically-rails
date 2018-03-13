class AddDecisionEnumsToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :artist_decision, :integer, default: 0
    add_column :submissions, :employer_decision, :integer, default: 0
  end
end
