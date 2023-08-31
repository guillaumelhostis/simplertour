# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_31_140458) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "concert_hotel_crews", force: :cascade do |t|
    t.bigint "concert_hotel_id", null: false
    t.bigint "crew_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concert_hotel_id"], name: "index_concert_hotel_crews_on_concert_hotel_id"
    t.index ["crew_id"], name: "index_concert_hotel_crews_on_crew_id"
  end

  create_table "concert_hotel_users", force: :cascade do |t|
    t.bigint "concert_hotel_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concert_hotel_id"], name: "index_concert_hotel_users_on_concert_hotel_id"
    t.index ["user_id"], name: "index_concert_hotel_users_on_user_id"
  end

  create_table "concert_hotels", force: :cascade do |t|
    t.bigint "concert_id", null: false
    t.bigint "hotel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concert_id"], name: "index_concert_hotels_on_concert_id"
    t.index ["hotel_id"], name: "index_concert_hotels_on_hotel_id"
  end

  create_table "concerts", force: :cascade do |t|
    t.date "date"
    t.string "location"
    t.string "name"
    t.bigint "tour_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "venue_id"
    t.index ["tour_id"], name: "index_concerts_on_tour_id"
    t.index ["venue_id"], name: "index_concerts_on_venue_id"
  end

  create_table "crew_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "crew_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crew_id"], name: "index_crew_users_on_crew_id"
    t.index ["user_id"], name: "index_crew_users_on_user_id"
  end

  create_table "crews", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "postcode"
    t.string "city"
    t.string "country"
    t.integer "standing"
    t.integer "tourman_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timetable_entries", force: :cascade do |t|
    t.bigint "concert_id", null: false
    t.text "information"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "hourminute"
    t.index ["concert_id"], name: "index_timetable_entries_on_concert_id"
  end

  create_table "tourmen", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "birth_day"
    t.string "address"
    t.integer "post_code"
    t.string "city"
    t.string "country"
    t.integer "phone_number"
    t.string "diet"
    t.index ["email"], name: "index_tourmen_on_email", unique: true
    t.index ["reset_password_token"], name: "index_tourmen_on_reset_password_token", unique: true
  end

  create_table "tours", force: :cascade do |t|
    t.string "title"
    t.string "artist"
    t.date "starting"
    t.date "ending"
    t.bigint "tourman_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "genre"
    t.bigint "crew_id"
    t.index ["crew_id"], name: "index_tours_on_crew_id"
    t.index ["tourman_id"], name: "index_tours_on_tourman_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "birth_day"
    t.string "address"
    t.integer "post_code"
    t.string "city"
    t.string "country"
    t.integer "phone_number"
    t.string "diet"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "postcode"
    t.string "city"
    t.string "country"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tourman_id"
  end

  add_foreign_key "concert_hotel_crews", "concert_hotels"
  add_foreign_key "concert_hotel_crews", "crews"
  add_foreign_key "concert_hotel_users", "concert_hotels"
  add_foreign_key "concert_hotel_users", "users"
  add_foreign_key "concert_hotels", "concerts"
  add_foreign_key "concert_hotels", "hotels"
  add_foreign_key "concerts", "tours"
  add_foreign_key "concerts", "venues"
  add_foreign_key "crew_users", "crews"
  add_foreign_key "crew_users", "users"
  add_foreign_key "timetable_entries", "concerts"
  add_foreign_key "tours", "crews"
  add_foreign_key "tours", "tourmen"
end
