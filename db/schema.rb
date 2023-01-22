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

ActiveRecord::Schema[7.0].define(version: 2023_01_22_203553) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_emails", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_copies", force: :cascade do |t|
    t.bigint "realizes_id"
    t.bigint "owner_id"
    t.bigint "rented_to_id"
    t.integer "condition", null: false
    t.string "barcode", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_game_copies_on_owner_id"
    t.index ["realizes_id"], name: "index_game_copies_on_realizes_id"
    t.index ["rented_to_id"], name: "index_game_copies_on_rented_to_id"
  end

  create_table "game_copy_opinions", force: :cascade do |t|
    t.bigint "opinion_by_id"
    t.bigint "opinion_about_id"
    t.integer "condition", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["opinion_about_id"], name: "index_game_copy_opinions_on_opinion_about_id"
    t.index ["opinion_by_id"], name: "index_game_copy_opinions_on_opinion_by_id"
  end

  create_table "game_opinions", force: :cascade do |t|
    t.bigint "opinion_by_id"
    t.bigint "opinion_about_id"
    t.integer "rating", null: false
    t.integer "weight", null: false
    t.integer "playing_time", null: false
    t.integer "min_players", null: false
    t.integer "max_players", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["opinion_about_id"], name: "index_game_opinions_on_opinion_about_id"
    t.index ["opinion_by_id"], name: "index_game_opinions_on_opinion_by_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "bgg_id", null: false
    t.string "title", null: false
    t.integer "year_published"
    t.decimal "bgg_rating", precision: 3, scale: 1
    t.integer "bgg_rating_num"
    t.string "bgg_ranking"
    t.string "categories"
    t.string "mechanics"
    t.decimal "bgg_weight", precision: 2, scale: 1
    t.integer "playing_time"
    t.integer "min_players"
    t.integer "max_players"
    t.text "thumbnail_url"
    t.text "image_url"
    t.text "description"
    t.string "designer"
    t.string "publisher"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offered_per_rentals", force: :cascade do |t|
    t.integer "rental_id"
    t.integer "game_copy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_copy_id"], name: "index_offered_per_rentals_on_game_copy_id"
    t.index ["rental_id", "game_copy_id"], name: "index_offered_per_rentals_on_rental_id_and_game_copy_id", unique: true
    t.index ["rental_id"], name: "index_offered_per_rentals_on_rental_id"
  end

  create_table "offered_per_requests", force: :cascade do |t|
    t.integer "rental_request_id"
    t.integer "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_offered_per_requests_on_game_id"
    t.index ["rental_request_id", "game_id"], name: "index_offered_per_requests_on_rental_request_id_and_game_id", unique: true
    t.index ["rental_request_id"], name: "index_offered_per_requests_on_rental_request_id"
  end

  create_table "rental_requests", force: :cascade do |t|
    t.bigint "submitter_id"
    t.string "status", null: false
    t.text "description"
    t.date "rental_start", null: false
    t.date "rental_end", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["submitter_id"], name: "index_rental_requests_on_submitter_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.bigint "submitter_id"
    t.bigint "accepted_by_id"
    t.bigint "realizes_id"
    t.string "accepted_by_status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "submitter_status"
    t.string "status"
    t.index ["accepted_by_id"], name: "index_rentals_on_accepted_by_id"
    t.index ["realizes_id"], name: "index_rentals_on_realizes_id"
    t.index ["submitter_id"], name: "index_rentals_on_submitter_id"
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
    t.integer "deposit_amount", null: false
    t.integer "deposit_paid", default: 0, null: false
    t.integer "deposit_deducted", default: 0, null: false
    t.integer "activity", default: 0
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

  create_table "wanted_per_rentals", force: :cascade do |t|
    t.integer "rental_id"
    t.integer "game_copy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_copy_id"], name: "index_wanted_per_rentals_on_game_copy_id"
    t.index ["rental_id", "game_copy_id"], name: "index_wanted_per_rentals_on_rental_id_and_game_copy_id", unique: true
    t.index ["rental_id"], name: "index_wanted_per_rentals_on_rental_id"
  end

  create_table "wanted_per_requests", force: :cascade do |t|
    t.integer "rental_request_id"
    t.integer "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_wanted_per_requests_on_game_id"
    t.index ["rental_request_id", "game_id"], name: "index_wanted_per_requests_on_rental_request_id_and_game_id", unique: true
    t.index ["rental_request_id"], name: "index_wanted_per_requests_on_rental_request_id"
  end

  add_foreign_key "game_copies", "games", column: "realizes_id"
  add_foreign_key "game_copies", "users", column: "owner_id"
  add_foreign_key "game_copies", "users", column: "rented_to_id"
  add_foreign_key "game_copy_opinions", "game_copies", column: "opinion_about_id"
  add_foreign_key "game_copy_opinions", "users", column: "opinion_by_id"
  add_foreign_key "game_opinions", "games", column: "opinion_about_id"
  add_foreign_key "game_opinions", "users", column: "opinion_by_id"
  add_foreign_key "rental_requests", "users", column: "submitter_id"
  add_foreign_key "rentals", "rental_requests", column: "realizes_id"
  add_foreign_key "rentals", "users", column: "accepted_by_id"
  add_foreign_key "rentals", "users", column: "submitter_id"
  add_foreign_key "user_opinions", "users", column: "opinion_about_id"
  add_foreign_key "user_opinions", "users", column: "opinion_by_id"
end
