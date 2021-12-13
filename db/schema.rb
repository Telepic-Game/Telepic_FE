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

ActiveRecord::Schema.define(version: 2021_12_13_163930) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.bigint "stack_id"
    t.string "name"
    t.json "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stack_id"], name: "index_cards_on_stack_id"
  end

  create_table "games", force: :cascade do |t|
    t.boolean "game_active", default: false
    t.boolean "all_players_ready", default: false
    t.bigint "waiting_room_id", null: false
    t.jsonb "game_players"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["waiting_room_id"], name: "index_games_on_waiting_room_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "permissions"
    t.string "password"
    t.string "username"
    t.string "room_code"
    t.bigint "waiting_room_id"
    t.boolean "player_ready", default: false
    t.string "game_id"
  end

  create_table "stacks", force: :cascade do |t|
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_stacks_on_player_id"
  end

  create_table "waiting_room_players", force: :cascade do |t|
    t.bigint "waiting_room_id", null: false
    t.bigint "player_id", null: false
    t.string "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "room_code"
    t.string "permissions"
    t.integer "stack_count"
    t.integer "card_count"
    t.index ["player_id"], name: "index_waiting_room_players_on_player_id"
    t.index ["waiting_room_id"], name: "index_waiting_room_players_on_waiting_room_id"
  end

  create_table "waiting_rooms", force: :cascade do |t|
    t.string "room_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "player_count"
  end

  add_foreign_key "cards", "stacks"
  add_foreign_key "games", "waiting_rooms"
  add_foreign_key "stacks", "players"
  add_foreign_key "waiting_room_players", "players"
  add_foreign_key "waiting_room_players", "waiting_rooms"
end
