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

ActiveRecord::Schema.define(version: 20150529221318) do

  create_table "member_types", force: true do |t|
    t.string   "easy_name"
    t.decimal  "price"
    t.boolean  "requires_previous"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "surname"
    t.string   "house_no"
    t.string   "street_name"
    t.string   "postcode"
    t.date     "date_of_birth"
    t.integer  "member_type_id"
    t.string   "contact_no"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "upgrade_date"
  end

  create_table "product_rental_items", force: true do |t|
    t.integer  "product_rental_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_rentals", force: true do |t|
    t.integer  "member_id"
    t.date     "start_date"
    t.date     "due_date"
    t.boolean  "returned"
    t.decimal  "total_price"
    t.decimal  "late_fees"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_types", force: true do |t|
    t.string   "easy_name"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.integer  "product_type_id"
    t.string   "name"
    t.string   "imdb_id"
    t.string   "age_rating"
    t.decimal  "star_rating"
    t.text     "synopsis"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_bookings", force: true do |t|
    t.integer  "member_id"
    t.date     "install_date"
    t.date     "collection_date"
    t.boolean  "deposit_paid"
    t.integer  "system_id"
    t.decimal  "total_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "systems", force: true do |t|
    t.text     "description"
    t.decimal  "audio_setup"
    t.boolean  "hd"
    t.decimal  "base_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "three_d"
  end

end
