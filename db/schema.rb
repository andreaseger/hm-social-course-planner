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

ActiveRecord::Schema.define(:version => 20111024112507) do

  create_table "bookings", :force => true do |t|
    t.integer  "schedule_id"
    t.integer  "room_id"
    t.integer  "teacher_id"
    t.integer  "timeslot_id"
    t.integer  "weekday_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "label"
    t.string   "group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["group"], :name => "index_courses_on_group"
  add_index "courses", ["name"], :name => "index_courses_on_name", :unique => true

  create_table "days", :force => true do |t|
    t.string   "name"
    t.string   "label"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "days", ["name"], :name => "index_days_on_name", :unique => true

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.string   "label"
    t.string   "building"
    t.integer  "floor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rooms", ["name"], :name => "index_rooms_on_name", :unique => true

  create_table "schedules", :force => true do |t|
    t.string   "name"
    t.string   "label"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", :force => true do |t|
    t.string   "name"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teachers", ["name"], :name => "index_teachers_on_name", :unique => true

  create_table "timeslots", :force => true do |t|
    t.integer  "start_time"
    t.integer  "end_time"
    t.string   "start_label"
    t.string   "end_label"
    t.integer  "day_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timeslots", ["start_label", "end_label", "day_id"], :name => "index_timeslots_on_start_label_and_end_label_and_day_id", :unique => true

end
