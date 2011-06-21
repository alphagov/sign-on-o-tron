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

ActiveRecord::Schema.define(:version => 20110621091055) do

  create_table "oauth_access_tokens", :force => true do |t|
    t.integer  "authorization_id", :null => false
    t.string   "access_token",     :null => false
    t.string   "refresh_token"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauth_authorization_codes", :force => true do |t|
    t.integer  "authorization_id", :null => false
    t.string   "code",             :null => false
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "redirect_uri"
  end

  create_table "oauth_authorizations", :force => true do |t|
    t.integer  "client_id",           :null => false
    t.integer  "resource_owner_id"
    t.string   "resource_owner_type"
    t.string   "scope"
    t.datetime "expires_at"
  end

  create_table "oauth_clients", :force => true do |t|
    t.string "name"
    t.string "oauth_identifier",   :null => false
    t.string "oauth_secret",       :null => false
    t.string "oauth_redirect_uri"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                                                  :null => false
    t.string   "twitter"
    t.string   "github"
    t.boolean  "beard"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
