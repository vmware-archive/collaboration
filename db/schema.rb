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

ActiveRecord::Schema.define(:version => 20110804222727) do

  create_table "apps", :force => true do |t|
    t.string   "display_name"
    t.string   "framework"
    t.string   "runtime"
    t.string   "state",        :default => "STOPPED"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "display_name", :null => false
    t.integer  "org_id",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orgs", :force => true do |t|
    t.string   "display_name", :null => false
    t.string   "avatar"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "owned_resources", :force => true do |t|
    t.string   "display_name"
    t.boolean  "marked_for_transfer"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner_type",          :null => false
    t.integer  "owner_id",            :null => false
    t.string   "resource_type",       :null => false
    t.integer  "resource_id",         :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "display_name", :null => false
    t.integer  "org_id",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resource_assignments", :force => true do |t|
    t.integer  "permission_set",    :default => 0
    t.integer  "project_id"
    t.integer  "entity_id"
    t.string   "entity_type"
    t.integer  "owned_resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "route"
  end

  create_table "services", :force => true do |t|
    t.string   "display_name"
    t.string   "url"
    t.boolean  "active",       :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "display_name"
    t.string   "avatar"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
