# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150604031729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_items", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "post_items", ["item_id"], name: "index_post_items_on_item_id", using: :btree
  add_index "post_items", ["post_id"], name: "index_post_items_on_post_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statics", force: :cascade do |t|
    t.string   "home"
    t.string   "about"
    t.string   "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_item_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "votes", ["post_item_id"], name: "index_votes_on_post_item_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  add_foreign_key "post_items", "items"
  add_foreign_key "post_items", "posts"
  add_foreign_key "posts", "users"
  add_foreign_key "votes", "post_items"
  add_foreign_key "votes", "users"
end
