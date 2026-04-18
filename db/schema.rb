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

ActiveRecord::Schema[8.1].define(version: 2026_04_12_114106) do
  create_table "assets", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.date "last_check_date", null: false
    t.string "name", null: false
    t.text "note"
    t.date "purchase_date", null: false
    t.decimal "purchase_price"
    t.integer "room_id", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_assets_on_code"
    t.index ["room_id"], name: "index_assets_on_room_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.date "added_date"
    t.integer "asset_id", null: false
    t.string "attachment_type"
    t.datetime "created_at", null: false
    t.text "description"
    t.datetime "updated_at", null: false
    t.index ["asset_id"], name: "index_attachments_on_asset_id"
  end

  create_table "audit_logs", force: :cascade do |t|
    t.string "action"
    t.integer "auditable_id", null: false
    t.string "auditable_type", null: false
    t.json "changed_field"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["auditable_type", "auditable_id"], name: "index_auditables_on_auditable"
    t.index ["user_id"], name: "index_audit_logs_on_user_id"
  end

    create_table "buildings", force: :cascade do |t|
      t.date "building_date", null: false
      t.string "city"
      t.string "code", null: false
      t.string "contact_email", null: false
      t.string "contact_phone", null: false
      t.datetime "created_at", null: false
      t.string "name", null: false
      t.string "street"
      t.datetime "updated_at", null: false
      t.integer "user_id",  null: false
      t.string "zip_code"
      t.index ["code"], name: "index_buildings_on_code"
      t.index ["user_id"], name: "index_buildings_on_user_id"
    end

  create_table "rooms", force: :cascade do |t|
    t.integer "building_id", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.date "room_date", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_rooms_on_building_id"
    t.index ["code"], name: "index_rooms_on_code"
  end

  create_table "users", force: :cascade do |t|
    t.string "api_key"
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role", default: "reader", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_users_on_code"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assets", "rooms"
  add_foreign_key "attachments", "assets"
  add_foreign_key "audit_logs", "users"
  add_foreign_key "buildings", "users"
  add_foreign_key "rooms", "buildings"
end
