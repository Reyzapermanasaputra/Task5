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

ActiveRecord::Schema.define(version: 20151031133214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "status"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "comment"
    t.string   "status"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "motors", force: :cascade do |t|
    t.integer  "employee_id"
    t.string   "brand"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "motors", ["employee_id"], name: "index_motors_on_employee_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "password_salt"
    t.string   "activation_token"
    t.string   "activation_status"
  end

  add_foreign_key "comments", "articles"
  add_foreign_key "motors", "employees"
end
