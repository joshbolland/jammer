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

ActiveRecord::Schema.define(version: 2018_11_22_111515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instruments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jams", force: :cascade do |t|
    t.string "title"
    t.date "date"
    t.time "time"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.index ["user_id"], name: "index_jams_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "slot_id"
    t.string "status", default: "pending"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slot_id"], name: "index_requests_on_slot_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "slots", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "jam_id"
    t.bigint "instrument_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_slots_on_instrument_id"
    t.index ["jam_id"], name: "index_slots_on_jam_id"
    t.index ["user_id"], name: "index_slots_on_user_id"
  end

  create_table "user_instruments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "instrument_id"
    t.string "ability"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_user_instruments_on_instrument_id"
    t.index ["user_id"], name: "index_user_instruments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.text "bio"
    t.string "photo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "jams", "users"
  add_foreign_key "requests", "slots"
  add_foreign_key "requests", "users"
  add_foreign_key "slots", "instruments"
  add_foreign_key "slots", "jams"
  add_foreign_key "slots", "users"
  add_foreign_key "user_instruments", "instruments"
  add_foreign_key "user_instruments", "users"
end
