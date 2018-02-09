class CreateExternalLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :external_links do |t|
        t.references :user, foreign_key: true
        t.string :origin_site
        t.string :link_to_content
    end
  end
end
