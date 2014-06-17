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

ActiveRecord::Schema.define(:version => 20120528181015) do

  create_table "comments", :force => true do |t|
    t.string   "comment"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "follows", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "following_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "follows", ["follower_id", "following_id"], :name => "index_follows_on_follower_id_and_following_id", :unique => true

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.text     "message"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "is_read",      :default => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.text     "notification"
    t.boolean  "is_read"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
  end

  create_table "user_images", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "private"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_searches", :force => true do |t|
    t.integer  "user_id"
    t.integer  "age_low"
    t.integer  "age_high"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "postal_code"
    t.integer  "distance"
    t.integer  "preferred_age_low"
    t.integer  "preferred_age_high"
    t.string   "sexually"
    t.string   "relationship"
    t.boolean  "online"
    t.integer  "signup_days"
    t.boolean  "photo"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.integer  "user_image_id"
    t.string   "profile_image"
    t.date     "birthday"
    t.integer  "weight"
    t.string   "weight_measurement",    :default => "Pounds"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.integer  "zip"
    t.string   "relationship"
    t.integer  "preferred_age_low"
    t.integer  "preferred_age_high"
    t.integer  "height"
    t.string   "height_measurement",    :default => "inches"
    t.string   "sexually"
    t.text     "profile_text"
    t.boolean  "profile_visible_all",   :default => false
    t.date     "membership_expiration"
    t.boolean  "unlimited_membership",  :default => false
    t.datetime "last_login"
    t.datetime "last_activity"
    t.string   "activation_code"
    t.datetime "activated_at"
    t.boolean  "remember_me",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "visitors", :force => true do |t|
    t.integer  "user_id"
    t.integer  "visited_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "visitors", ["user_id"], :name => "index_visitors_on_user_id"

end
