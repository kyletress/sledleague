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

ActiveRecord::Schema.define(:version => 20140320204212) do

  create_table "athletes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "country"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "league_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.integer  "manager_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "private",     :default => false
    t.integer  "max_teams",   :default => 0,     :null => false
    t.integer  "max_matches", :default => 0,     :null => false
    t.text     "description"
  end

  create_table "matches", :force => true do |t|
    t.integer  "league_id"
    t.integer  "race_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "matches", ["league_id"], :name => "index_matches_on_league_id"
  add_index "matches", ["race_id"], :name => "index_matches_on_race_id"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "team"
  end

  add_index "memberships", ["league_id"], :name => "index_memberships_on_league_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "picks", :force => true do |t|
    t.integer  "prediction_id"
    t.integer  "position"
    t.integer  "athlete_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "points"
  end

  add_index "picks", ["prediction_id"], :name => "index_picks_on_prediction_id"

  create_table "predictions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "membership_id"
    t.integer  "total_points"
  end

  add_index "predictions", ["match_id"], :name => "index_predictions_on_match_id"
  add_index "predictions", ["user_id"], :name => "index_predictions_on_user_id"

  create_table "races", :force => true do |t|
    t.string   "name"
    t.datetime "startdate"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "completed",  :default => false
  end

  create_table "results", :force => true do |t|
    t.integer  "race_id"
    t.integer  "athlete_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "results", ["athlete_id"], :name => "index_results_on_athlete_id"
  add_index "results", ["race_id"], :name => "index_results_on_race_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
