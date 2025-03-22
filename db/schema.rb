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

ActiveRecord::Schema[8.0].define(version: 2025_03_22_143945) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "service_types", ["maintenance", "repair", "upgrade", "other"]

  create_table "invitations", force: :cascade do |t|
    t.bigint "user_id"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_invitations_on_code", unique: true
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "log_entries", force: :cascade do |t|
    t.bigint "vehicle_id", null: false
    t.integer "mileage", null: false
    t.date "performed_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id"], name: "index_log_entries_on_vehicle_id"
  end

  create_table "service_records", force: :cascade do |t|
    t.bigint "log_entry_id", null: false
    t.enum "service_type", default: "maintenance", null: false, enum_type: "service_types"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost_cents", default: 0, null: false
    t.string "cost_currency", default: "USD", null: false
    t.string "title", null: false
    t.index ["log_entry_id"], name: "index_service_records_on_log_entry_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "vin", null: false
    t.integer "year", null: false
    t.string "manufacturer", null: false
    t.string "model", null: false
    t.string "license_plate_number"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "vin"], name: "index_vehicles_on_user_id_and_vin", unique: true
    t.index ["user_id"], name: "index_vehicles_on_user_id"
    t.index ["vin"], name: "index_vehicles_on_vin"
  end

  add_foreign_key "invitations", "users"
  add_foreign_key "log_entries", "vehicles"
  add_foreign_key "service_records", "log_entries"
  add_foreign_key "sessions", "users"
  add_foreign_key "vehicles", "users"
end
