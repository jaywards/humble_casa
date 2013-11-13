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

ActiveRecord::Schema.define(:version => 20131113195547) do

  create_table "assignments", :force => true do |t|
    t.string   "category"
    t.integer  "property_id"
    t.integer  "service_id"
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
    t.boolean  "interested"
    t.boolean  "confirmed",                                           :default => false
    t.string   "note"
    t.decimal  "cost",                  :precision => 5, :scale => 2, :default => 0.0
    t.datetime "last_invoice_date"
    t.string   "stripe_customer_token"
  end

  add_index "assignments", ["property_id"], :name => "index_associations_on_property_id"
  add_index "assignments", ["service_id"], :name => "index_associations_on_service_id"

  create_table "employments", :force => true do |t|
    t.integer  "service_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "approved"
  end

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "property_id"
    t.integer  "service_request_id"
    t.integer  "service_id"
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
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.boolean  "all_assigned"
    t.integer  "active_request_id"
    t.boolean  "terms_agreement"
    t.boolean  "paused",                                           :default => false
    t.string   "time_zone"
    t.integer  "duration"
    t.boolean  "all_scheduled"
    t.decimal  "charge",             :precision => 5, :scale => 2, :default => 0.0
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
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "time_zone"
    t.boolean  "new_property",          :default => true
    t.string   "stripe_customer_token"
    t.string   "stripe_card_token"
    t.string   "card_type"
    t.string   "last_four"
    t.boolean  "active",                :default => false
  end

  add_index "properties", ["user_id"], :name => "index_properties_on_user_id"

  create_table "reportable_cache", :force => true do |t|
    t.string   "model_name",                        :null => false
    t.string   "report_name",                       :null => false
    t.string   "grouping",                          :null => false
    t.string   "aggregation",                       :null => false
    t.string   "conditions",                        :null => false
    t.float    "value",            :default => 0.0, :null => false
    t.datetime "reporting_period",                  :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "reportable_cache", ["model_name", "report_name", "grouping", "aggregation", "conditions", "reporting_period"], :name => "name_model_grouping_aggregation_period", :unique => true
  add_index "reportable_cache", ["model_name", "report_name", "grouping", "aggregation", "conditions"], :name => "name_model_grouping_agregation"

  create_table "rs_evaluations", :force => true do |t|
    t.string   "reputation_name"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.float    "value",           :default => 0.0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "rs_evaluations", ["reputation_name", "source_id", "source_type", "target_id", "target_type"], :name => "index_rs_evaluations_on_reputation_name_and_source_and_target", :unique => true
  add_index "rs_evaluations", ["reputation_name"], :name => "index_rs_evaluations_on_reputation_name"
  add_index "rs_evaluations", ["source_id", "source_type"], :name => "index_rs_evaluations_on_source_id_and_source_type"
  add_index "rs_evaluations", ["target_id", "target_type"], :name => "index_rs_evaluations_on_target_id_and_target_type"

  create_table "rs_reputation_messages", :force => true do |t|
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "receiver_id"
    t.float    "weight",      :default => 1.0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "rs_reputation_messages", ["receiver_id", "sender_id", "sender_type"], :name => "index_rs_reputation_messages_on_receiver_id_and_sender", :unique => true
  add_index "rs_reputation_messages", ["receiver_id"], :name => "index_rs_reputation_messages_on_receiver_id"
  add_index "rs_reputation_messages", ["sender_id", "sender_type"], :name => "index_rs_reputation_messages_on_sender_id_and_sender_type"

  create_table "rs_reputations", :force => true do |t|
    t.string   "reputation_name"
    t.float    "value",           :default => 0.0
    t.string   "aggregated_by"
    t.integer  "target_id"
    t.string   "target_type"
    t.boolean  "active",          :default => true
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "rs_reputations", ["reputation_name", "target_id", "target_type"], :name => "index_rs_reputations_on_reputation_name_and_target", :unique => true
  add_index "rs_reputations", ["reputation_name"], :name => "index_rs_reputations_on_reputation_name"
  add_index "rs_reputations", ["target_id", "target_type"], :name => "index_rs_reputations_on_target_id_and_target_type"

  create_table "service_requests", :force => true do |t|
    t.boolean  "assigned"
    t.boolean  "completed"
    t.integer  "property_id"
    t.integer  "service_id"
    t.datetime "service_start_date"
    t.datetime "service_end_date"
    t.text     "instructions"
    t.datetime "created_at",                                                                                :null => false
    t.datetime "updated_at",                                                                                :null => false
    t.datetime "completed_date"
    t.string   "request_id"
    t.boolean  "mailed_created",                                                         :default => false
    t.boolean  "mailed_assigned",                                                        :default => false
    t.boolean  "mailed_completed",                                                       :default => false
    t.boolean  "onetime"
    t.string   "frequency"
    t.string   "service_week_day"
    t.integer  "service_month_day",         :limit => 255
    t.boolean  "asap"
    t.datetime "first_scheduled"
    t.integer  "master_service_request_id"
    t.boolean  "all_assigned"
    t.string   "completion_note"
    t.string   "service_photo_1"
    t.string   "service_photo_2"
    t.string   "service_photo_3"
    t.boolean  "location_verified"
    t.boolean  "timestamp_verified"
    t.boolean  "paused"
    t.boolean  "scheduled",                                                              :default => false
    t.boolean  "mailed_scheduled",                                                       :default => false
    t.string   "time_zone"
    t.integer  "duration"
    t.boolean  "all_scheduled"
    t.decimal  "charge",                                   :precision => 5, :scale => 2, :default => 0.0
    t.string   "charge_notes"
    t.string   "charge_id"
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
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.text     "biz_description"
    t.string   "time_zone"
    t.string   "stripe_customer_token"
    t.boolean  "new_account",            :default => true
    t.boolean  "service_active",         :default => false
    t.string   "stripe_access_token"
    t.string   "stripe_publishable_key"
    t.string   "stripe_user_id"
    t.string   "stripe_refresh_token"
    t.string   "stripe_card_token"
    t.string   "last_four"
    t.string   "card_type"
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
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "primary_phone"
    t.string   "role"
    t.integer  "employer_id"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.boolean  "notify",            :default => true
    t.string   "time_zone"
    t.boolean  "new_account",       :default => true
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
