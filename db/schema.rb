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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120705003938) do

  create_table "cases", :force => true do |t|
    t.string   "title"
    t.boolean  "closed"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cases_people", :force => true do |t|
    t.integer "case_id"
    t.integer "person_id"
  end

  create_table "documents", :force => true do |t|
    t.integer "person_id"
    t.integer "case_id"
    t.string  "document"
  end

  create_table "people", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.string  "surname"
    t.string  "email"
    t.string  "address"
    t.string  "phone_num"
    t.text    "description"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "case_id"
    t.integer  "responsible_id"
    t.integer  "person_id"
    t.string   "title"
    t.text     "description"
    t.datetime "expires_at"
    t.boolean  "closed"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "hashed_pass"
    t.string   "name"
    t.string   "surname"
    t.string   "secure_id"
    t.string   "salt"
    t.string   "role"
    t.datetime "expires_at"
  end

end
