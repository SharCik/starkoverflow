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

ActiveRecord::Schema.define(version: 20160523102705) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_votes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "answer_id"
    t.boolean "direction"
  end

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.text     "answer"
    t.integer  "rating",      default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id"
    t.integer  "count",       default: 0
    t.text     "code"
  end

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.text     "text"
    t.integer  "question_id"
  end

  create_table "question_tags", force: :cascade do |t|
    t.integer "question_id"
    t.integer "tag_id"
  end

  create_table "question_votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.boolean  "direction"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id"
    t.integer  "views",       default: 0
    t.integer  "count",       default: 0
    t.text     "code"
  end

  create_table "stars", force: :cascade do |t|
    t.integer "user_id"
    t.integer "question_id"
    t.integer "answer_id"
  end

  create_table "tags", force: :cascade do |t|
    t.text "name"
  end

  create_table "user_tags", force: :cascade do |t|
    t.integer "user_id"
    t.integer "tag_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "country"
    t.string   "picture"
    t.string   "job"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "views", force: :cascade do |t|
    t.integer "user_id"
    t.integer "question_id"
    t.integer "views",       default: 0
  end

end
