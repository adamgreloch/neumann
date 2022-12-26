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

ActiveRecord::Schema[7.0].define(version: 2022_12_26_210522) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_copies", force: :cascade do |t|
    t.bigint "realizes_id"
    t.bigint "owner_id"
    t.string "copy_id", null: false
    t.integer "condition", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_game_copies_on_owner_id"
    t.index ["realizes_id"], name: "index_game_copies_on_realizes_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "bgg_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "release_year", null: false
    t.decimal "bgg_rating", null: false
    t.integer "bgg_rated_count", null: false
    t.integer "bgg_ranking", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rental_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rentals", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_opinions", force: :cascade do |t|
    t.bigint "opinion_by_id"
    t.bigint "opinion_about_id"
    t.integer "contact_rating", null: false
    t.integer "compliance_rating", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["opinion_about_id"], name: "index_user_opinions_on_opinion_about_id"
    t.index ["opinion_by_id"], name: "index_user_opinions_on_opinion_by_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.decimal "deposit_amount", null: false
    t.decimal "deposit_paid", null: false
    t.decimal "deposit_deducted", null: false
    t.integer "activity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "game_copies", "games", column: "realizes_id"
  add_foreign_key "game_copies", "users", column: "owner_id"
  add_foreign_key "user_opinions", "users", column: "opinion_about_id"
  add_foreign_key "user_opinions", "users", column: "opinion_by_id"
end
