class CreateOauthIdentities < ActiveRecord::Migration[5.0]
  def change
    create_table :oauth_identities do |t|
      t.string :provider
      t.string :uid
      t.belongs_to :user, foreign_key: true
    end
  end
end
