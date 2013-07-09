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

ActiveRecord::Schema.define(:version => 20130707003333) do

  create_table "assignments", :force => true do |t|
    t.string   "category"
    t.integer  "property_id"
    t.integer  "service_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "interested"
  end

  add_index "assignments", ["property_id"], :name => "index_associations_on_property_id"
  add_index "assignments", ["service_id"], :name => "index_associations_on_service_id"

  create_table "employments", :force => true do |t|
    t.integer  "service_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "master_service_requests", :force => true do |t|
    t.integer  "property_id"
    t.integer  "service_id"
    t.datetime "service_start_date"
    t.datetime "service_end_date"
    t.text     "instructions"
    t.string   "request_id"
    t.boolean  "onetime"
    t.string   "frequency"
    t.string   "service_week_day"
    t.integer  "service_month_day"
    t.datetime "first_scheduled"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.boolean  "all_assigned"
    t.integer  "active_request_id"
    t.boolean  "terms_agreement"
  end

  create_table "properties", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "instructions"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "properties", ["user_id"], :name => "index_properties_on_user_id"

  create_table "service_requests", :force => true do |t|
    t.boolean  "assigned"
    t.boolean  "completed"
    t.integer  "property_id"
    t.integer  "service_id"
    t.datetime "service_start_date"
    t.datetime "service_end_date"
    t.text     "instructions"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.datetime "completed_date"
    t.string   "request_id"
    t.boolean  "mailed_created",                           :default => false
    t.boolean  "mailed_assigned",                          :default => false
    t.boolean  "mailed_completed",                         :default => false
    t.boolean  "onetime"
    t.string   "frequency"
    t.string   "service_week_day"
    t.integer  "service_month_day",         :limit => 255
    t.boolean  "asap"
    t.datetime "first_scheduled"
    t.integer  "master_service_request_id"
    t.boolean  "all_assigned"
    t.string   "completion_note"
  end

  create_table "service_zips", :force => true do |t|
    t.string   "zip"
    t.integer  "service_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "service_zips", ["service_id"], :name => "index_service_zips_on_service_id"

  create_table "services", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.string   "category"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "services", ["user_id"], :name => "index_services_on_user_id"

  create_table "user_sessions", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "primary_phone"
    t.string   "role"
    t.integer  "employer_id"
  end

  create_table "work_assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "service_request_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "assignable_id"
    t.string   "assignable_type"
    t.integer  "master_service_request_id"
  end

end
