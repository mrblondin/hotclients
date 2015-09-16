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

ActiveRecord::Schema.define(version: 20150914231855) do

  create_table "cities", force: true do |t|
    t.string   "region"
    t.string   "city"
    t.string   "city_code",  limit: 13
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["city_code"], name: "index_cities_on_city_code", using: :btree

  create_table "clients", force: true do |t|
    t.string   "surname"
    t.string   "name"
    t.string   "patronymic"
    t.date     "birth_date"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stage"
    t.date     "meeting_date"
    t.string   "operator_status"
    t.text     "operator_comment"
    t.string   "partner_status"
    t.text     "partner_comment"
    t.integer  "user_id"
    t.date     "statement_date"
    t.string   "city"
    t.string   "region"
    t.string   "city_code",        limit: 13
    t.string   "snils"
    t.text     "address"
  end

  add_index "clients", ["city_code"], name: "index_clients_on_city_code", using: :btree
  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "crypted_password"
    t.string   "role"
    t.string   "name"
    t.string   "surname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count",        default: 0, null: false
    t.integer  "failed_login_count", default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.integer  "partner_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["partner_id"], name: "index_users_on_partner_id", using: :btree

end
