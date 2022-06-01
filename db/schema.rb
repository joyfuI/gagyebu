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

ActiveRecord::Schema[7.0].define(version: 2022_06_01_141739) do
  create_table "account_groups", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.integer "order"
    t.boolean "enable", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_account_groups_on_user_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.integer "account_group_id", null: false
    t.integer "order"
    t.boolean "enable", default: true
    t.datetime "start_date", null: false
    t.integer "start_balance", default: 0
    t.integer "account_type", default: 0
    t.boolean "include", default: true
    t.boolean "income", default: true
    t.boolean "expense", default: true
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_group_id"], name: "index_accounts_on_account_group_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "account_groups", "users"
  add_foreign_key "accounts", "account_groups"
  add_foreign_key "accounts", "users"
end
