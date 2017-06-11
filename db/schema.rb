# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170610185953) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "platforms_video_games", id: false, force: :cascade do |t|
    t.bigint "platform_id", null: false
    t.bigint "video_game_id", null: false
    t.index ["platform_id"], name: "index_platforms_video_games_on_platform_id"
    t.index ["video_game_id"], name: "index_platforms_video_games_on_video_game_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", limit: 30, null: false
    t.text "review", null: false
    t.string "platform_ids", default: [], null: false, array: true
    t.integer "rating", default: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "role", default: "member", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "video_games", force: :cascade do |t|
    t.string "title", null: false
    t.string "developer", null: false
    t.text "description", null: false
    t.integer "genre_id", null: false
    t.date "release_date", null: false
    t.integer "rating", default: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["title"], name: "index_video_games_on_title", unique: true
  end

  create_table "video_games_reviews", force: :cascade do |t|
    t.bigint "video_game_id", null: false
    t.bigint "review_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_video_games_reviews_on_review_id"
    t.index ["video_game_id"], name: "index_video_games_reviews_on_video_game_id"
  end

end
