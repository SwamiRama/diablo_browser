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

ActiveRecord::Schema.define(version: 20160626132934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "careers", force: :cascade do |t|
    t.string   "battle_tag"
    t.integer  "paragon_level"
    t.integer  "paragon_level_hardcore"
    t.integer  "paragon_level_season"
    t.integer  "paragon_level_season_hardcore"
    t.string   "guild_name"
    t.text     "heroes"
    t.integer  "last_hero_played"
    t.integer  "last_updated"
    t.text     "kills"
    t.integer  "highest_hardcore_level"
    t.text     "time_played"
    t.text     "progression"
    t.text     "fallen_heroes"
    t.text     "blacksmith"
    t.text     "jeweler"
    t.text     "mystic"
    t.text     "blacksmith_hardcore"
    t.text     "jeweler_hardcore"
    t.text     "mystic_hardcore"
    t.text     "blacksmith_season"
    t.text     "jeweler_season"
    t.text     "mystic_season"
    t.text     "blacksmith_season_hardcore"
    t.text     "jeweler_season_hardcore"
    t.text     "mystic_season_hardcore"
    t.text     "seasonal_profiles"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string   "topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "heros", force: :cascade do |t|
    t.integer  "career_id"
    t.string   "name"
    t.string   "hero_class"
    t.integer  "gender"
    t.integer  "level"
    t.text     "kills"
    t.text     "paragon_level"
    t.string   "hardcore"
    t.string   "seasonal"
    t.integer  "season_created"
    t.text     "skills"
    t.text     "items"
    t.text     "followers"
    t.text     "legendary_powers"
    t.text     "stats"
    t.text     "progression"
    t.string   "dead"
    t.integer  "last_updated"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "chatroom_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
end
