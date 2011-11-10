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

ActiveRecord::Schema.define(:version => 20111107235055) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "bookings", :force => true do |t|
    t.integer  "course_id"
    t.integer  "timeslot_id"
    t.integer  "room_id"
    t.integer  "group_id"
    t.string   "suffix"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookings", ["course_id"], :name => "index_bookings_on_course_id"
  add_index "bookings", ["group_id"], :name => "index_bookings_on_group_id"
  add_index "bookings", ["room_id"], :name => "index_bookings_on_room_id"
  add_index "bookings", ["timeslot_id"], :name => "index_bookings_on_timeslot_id"

  create_table "bookings_schedules", :id => false, :force => true do |t|
    t.integer "booking_id"
    t.integer "schedule_id"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["name"], :name => "index_courses_on_name", :unique => true

  create_table "days", :force => true do |t|
    t.string   "name"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "days", ["name"], :name => "index_days_on_name", :unique => true

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["name"], :name => "index_groups_on_name", :unique => true

  create_table "identities", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["email"], :name => "index_identities_on_email", :unique => true

  create_table "lectureships", :force => true do |t|
    t.integer "booking_id"
    t.integer "teacher_id"
  end

  add_index "lectureships", ["booking_id", "teacher_id"], :name => "index_lectureships_on_booking_id_and_teacher_id", :unique => true

  create_table "profiles", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "website"
    t.string   "twitter"
    t.text     "bio"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "classmate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["classmate_id"], :name => "index_relationships_on_classmate_id"
  add_index "relationships", ["user_id", "classmate_id"], :name => "index_relationships_on_user_id_and_classmate_id", :unique => true
  add_index "relationships", ["user_id"], :name => "index_relationships_on_user_id"

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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["user_id"], :name => "index_schedules_on_user_id"

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

  create_table "users", :force => true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
    t.string   "email"
  end

end
