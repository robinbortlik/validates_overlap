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

ActiveRecord::Schema.define(version: 20_150_707_155_107) do
  create_table 'active_meetings', force: :cascade do |t|
    t.date 'starts_at'
    t.date 'ends_at'
    t.boolean 'is_active'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'end_overlap_meetings', force: :cascade do |t|
    t.date 'starts_at'
    t.date 'ends_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'meetings', force: :cascade do |t|
    t.date 'starts_at'
    t.date 'ends_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'positions', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'time_slot_id'
    t.datetime 'created_at',   null: false
    t.datetime 'updated_at',   null: false
  end

  create_table 'secure_meetings', force: :cascade do |t|
    t.date 'starts_at'
    t.date 'ends_at'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'start_end_overlap_meetings', force: :cascade do |t|
    t.date 'starts_at'
    t.date 'ends_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'start_overlap_meetings', force: :cascade do |t|
    t.date 'starts_at'
    t.date 'ends_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'time_slots', force: :cascade do |t|
    t.date 'starts_at'
    t.date 'ends_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'user_meetings', force: :cascade do |t|
    t.integer 'user_id'
    t.date 'starts_at'
    t.date 'ends_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
