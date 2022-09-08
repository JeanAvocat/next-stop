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

ActiveRecord::Schema[7.0].define(version: 2022_09_08_150622) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "chifoumi_games", force: :cascade do |t|
    t.string "first_player_choice"
    t.string "second_player_choice"
    t.integer "play_round", default: 0
    t.integer "first_player_score", default: 0
    t.integer "second_player_score", default: 0
    t.bigint "first_player_id", null: false
    t.bigint "second_player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_player_id"], name: "index_chifoumi_games_on_first_player_id"
    t.index ["second_player_id"], name: "index_chifoumi_games_on_second_player_id"
  end

  create_table "game_matches", force: :cascade do |t|
    t.string "winner"
    t.string "matchable_type", null: false
    t.bigint "matchable_id", null: false
    t.bigint "trip_session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["matchable_type", "matchable_id"], name: "index_game_matches_on_matchable"
    t.index ["trip_session_id"], name: "index_game_matches_on_trip_session_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "trip_session_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_session_id"], name: "index_messages_on_trip_session_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "status"
    t.bigint "sender_id", null: false
    t.bigint "trip_session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sender_id"], name: "index_requests_on_sender_id"
    t.index ["trip_session_id"], name: "index_requests_on_trip_session_id"
  end

  create_table "tic_tac_toe_games", force: :cascade do |t|
    t.string "position_1"
    t.string "position_2"
    t.string "position_3"
    t.string "position_4"
    t.string "position_5"
    t.string "position_6"
    t.string "position_7"
    t.string "position_8"
    t.string "position_9"
    t.bigint "cross_player_id"
    t.bigint "circle_player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circle_player_id"], name: "index_tic_tac_toe_games_on_circle_player_id"
    t.index ["cross_player_id"], name: "index_tic_tac_toe_games_on_cross_player_id"
  end

  create_table "trip_sessions", force: :cascade do |t|
    t.string "status"
    t.bigint "creator_id", null: false
    t.bigint "joiner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_trip_sessions_on_creator_id"
    t.index ["joiner_id"], name: "index_trip_sessions_on_joiner_id"
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
    t.string "random_nickname"
    t.integer "score", default: 0
    t.string "phone_number"
    t.string "instagram_account"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chifoumi_games", "users", column: "first_player_id"
  add_foreign_key "chifoumi_games", "users", column: "second_player_id"
  add_foreign_key "game_matches", "trip_sessions"
  add_foreign_key "messages", "trip_sessions"
  add_foreign_key "messages", "users"
  add_foreign_key "requests", "trip_sessions"
  add_foreign_key "requests", "users", column: "sender_id"
  add_foreign_key "tic_tac_toe_games", "users", column: "circle_player_id"
  add_foreign_key "tic_tac_toe_games", "users", column: "cross_player_id"
  add_foreign_key "trip_sessions", "users", column: "creator_id"
  add_foreign_key "trip_sessions", "users", column: "joiner_id"
end
