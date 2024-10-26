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

ActiveRecord::Schema[7.0].define(version: 2024_10_26_102759) do
  create_table "reviews", charset: "utf8", force: :cascade do |t|
    t.float "rating"
    t.text "comment"
    t.boolean "spoiler"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id_id", null: false
    t.bigint "user_id", null: false
    t.bigint "work_id", null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
    t.index ["user_id_id"], name: "index_reviews_on_user_id_id"
    t.index ["work_id"], name: "index_reviews_on_work_id"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "profile"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "works", charset: "utf8", force: :cascade do |t|
    t.string "title"
    t.integer "type"
    t.integer "api_id"
    t.string "genre"
    t.text "description"
    t.date "release_date"
    t.string "author_or_director"
    t.string "thumbnail_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "works"
end
