# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180502043652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_instruments", force: :cascade do |t|
    t.integer "instrument_id"
    t.integer "user_id"
    t.index ["instrument_id"], name: "index_artist_instruments_on_instrument_id", using: :btree
    t.index ["user_id"], name: "index_artist_instruments_on_user_id", using: :btree
  end

  create_table "artist_locations", force: :cascade do |t|
    t.integer "location_id"
    t.integer "user_id"
    t.index ["location_id"], name: "index_artist_locations_on_location_id", using: :btree
    t.index ["user_id"], name: "index_artist_locations_on_user_id", using: :btree
  end

  create_table "artist_opportunities", force: :cascade do |t|
    t.integer  "opportunity_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "artist_type"
    t.index ["opportunity_id"], name: "index_artist_opportunities_on_opportunity_id", using: :btree
    t.index ["user_id"], name: "index_artist_opportunities_on_user_id", using: :btree
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "external_links", force: :cascade do |t|
    t.integer "user_id"
    t.string  "origin_site"
    t.string  "link_to_content"
    t.index ["user_id"], name: "index_external_links_on_user_id", using: :btree
  end

  create_table "instruments", force: :cascade do |t|
    t.string "name"
  end

  create_table "locations", force: :cascade do |t|
    t.string "zipcode"
    t.string "zip_code_type"
    t.string "city"
    t.string "state"
    t.string "location_type"
    t.string "lat"
    t.string "long"
    t.string "world_region"
    t.string "country"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "oauth_identities", force: :cascade do |t|
    t.string  "provider"
    t.string  "uid"
    t.integer "user_id"
    t.index ["user_id"], name: "index_oauth_identities_on_user_id", using: :btree
  end

  create_table "opportunities", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.datetime "event_start_date"
    t.datetime "event_end_date"
    t.datetime "timeframe_of_post"
    t.integer  "employer_id"
    t.index ["employer_id"], name: "index_opportunities_on_employer_id", using: :btree
  end

  create_table "submissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "opportunity_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["opportunity_id"], name: "index_submissions_on_opportunity_id", using: :btree
    t.index ["user_id"], name: "index_submissions_on_user_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "duration"
    t.string   "stripe_token"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "date_paid"
    t.datetime "date_paid_until"
    t.index ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  end

  create_table "artist_profiles", force: :cascade do |t|
    t.text     "about"
    t.integer  "desired_compensation_lower_bound"
    t.integer  "desired_compensation_upper_bound"
    t.string   "youtube_link"
    t.string   "facebook_link"
    t.string   "instagram_link"
    t.integer  "user_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["user_id"], name: "index_artist_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "role"
    t.text     "about"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "stripe_customer_token"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "zip"
    t.integer  "category"
    t.integer  "opportunity_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "state"
    t.index ["opportunity_id"], name: "index_venues_on_opportunity_id", using: :btree
  end

  add_foreign_key "artist_instruments", "instruments"
  add_foreign_key "artist_instruments", "users"
  add_foreign_key "artist_locations", "locations"
  add_foreign_key "artist_locations", "users"
  add_foreign_key "external_links", "users"
  add_foreign_key "oauth_identities", "users"
  add_foreign_key "opportunities", "users", column: "employer_id"
  add_foreign_key "submissions", "opportunities"
  add_foreign_key "submissions", "users"
  add_foreign_key "subscriptions", "users"
end
