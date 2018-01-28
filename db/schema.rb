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

ActiveRecord::Schema.define(version: 20180128202509) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_opportunities", force: :cascade do |t|
    t.integer  "opportunity_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "artist_type"
    t.index ["opportunity_id"], name: "index_artist_opportunities_on_opportunity_id", using: :btree
    t.index ["user_id"], name: "index_artist_opportunities_on_user_id", using: :btree
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
    t.string   "provider"
    t.string   "uid"
    t.integer  "instrument"
    t.text     "about"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.integer  "zip"
    t.integer  "category"
    t.integer  "opportunity_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "state"
    t.index ["opportunity_id"], name: "index_venues_on_opportunity_id", using: :btree
  end

  add_foreign_key "opportunities", "users", column: "employer_id"
end
