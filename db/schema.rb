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

ActiveRecord::Schema[7.0].define(version: 2023_08_08_105445) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crews", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crews_users", id: false, force: :cascade do |t|
    t.bigint "crew_id", null: false
    t.bigint "user_id", null: false
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

  add_foreign_key "tours", "tourmen"
end
