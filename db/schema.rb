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

ActiveRecord::Schema[8.1].define(version: 2026_01_20_120437) do
  create_table "note_shares", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "note_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["note_id", "user_id"], name: "index_note_shares_on_note_id_and_user_id", unique: true
    t.index ["note_id"], name: "index_note_shares_on_note_id"
    t.index ["user_id"], name: "index_note_shares_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.boolean "archived", default: false
    t.datetime "created_at", null: false
    t.datetime "deleted_at"
    t.text "description"
    t.boolean "favorite", default: false
    t.datetime "reminder_at"
    t.boolean "reminder_enabled"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "todo_items", force: :cascade do |t|
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.string "title"
    t.integer "todo_list_id", null: false
    t.datetime "updated_at", null: false
    t.index ["todo_list_id"], name: "index_todo_items_on_todo_list_id"
  end

  create_table "todo_lists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_todo_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "note_shares", "notes"
  add_foreign_key "note_shares", "users"
  add_foreign_key "notes", "users"
  add_foreign_key "todo_items", "todo_lists"
  add_foreign_key "todo_lists", "users"
end
