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

ActiveRecord::Schema.define(version: 20170602111048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.string   "rsvp_status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["event_id"], name: "index_attendees_on_event_id", using: :btree
    t.index ["user_id"], name: "index_attendees_on_user_id", using: :btree
  end

  create_table "decisions", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "decision_maker_id"
    t.integer  "decision_receiver_id"
    t.boolean  "like"
    t.boolean  "pending"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["decision_maker_id"], name: "index_decisions_on_decision_maker_id", using: :btree
    t.index ["decision_receiver_id"], name: "index_decisions_on_decision_receiver_id", using: :btree
    t.index ["event_id"], name: "index_decisions_on_event_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "fb_event_id"
    t.string   "name"
    t.integer  "attending_count"
    t.string   "start_time"
    t.string   "end_time"
    t.string   "cover"
    t.string   "place_name"
    t.float    "place_latitude"
    t.float    "place_longitude"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "user_1_id"
    t.integer  "user_2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_1_id"], name: "index_matches_on_user_1_id", using: :btree
    t.index ["user_2_id"], name: "index_matches_on_user_2_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_messages_on_match_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.string   "gender"
    t.json     "pictures"
    t.boolean  "admin",                  default: false, null: false
    t.string   "picture1"
    t.string   "picture2"
    t.string   "picture3"
    t.string   "picture4"
    t.string   "picture5"
    t.string   "picture6"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "attendees", "events"
  add_foreign_key "attendees", "users"
  add_foreign_key "decisions", "events"
  add_foreign_key "messages", "matches"
  add_foreign_key "messages", "users"
end
