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

ActiveRecord::Schema.define(version: 20140927072037) do

  create_table "adunits", force: true do |t|
    t.string   "adUnitName"
    t.string   "description"
    t.string   "backupadtype"
    t.string   "alternateUrl"
    t.string   "fullbackground"
    t.string   "adtype"
    t.string   "devicetype"
    t.string   "format"
    t.string   "usertype"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "style_id"
  end

  add_index "adunits", ["style_id"], name: "index_adunits_on_style_id", using: :btree
  add_index "adunits", ["user_id"], name: "index_adunits_on_user_id", using: :btree

  create_table "bannersizes", force: true do |t|
    t.string   "devicetype"
    t.text     "sizes"
    t.text     "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversions", force: true do |t|
    t.string   "con_name"
    t.string   "con_type"
    t.string   "con_type_value"
    t.string   "revenue"
    t.string   "con_counting"
    t.string   "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_files", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fonts", force: true do |t|
    t.string   "name",        limit: 20
    t.string   "url"
    t.integer  "publisherid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publishers", force: true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publishersites", force: true do |t|
    t.string   "website_title"
    t.string   "website_url"
    t.text     "description"
    t.string   "channel"
    t.string   "language"
    t.string   "avg_mon_imps"
    t.string   "csrftoken"
    t.string   "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",        default: "Active"
  end

  create_table "retargets", force: true do |t|
    t.string   "retargetName"
    t.string   "duration"
    t.string   "retargetType"
    t.string   "path"
    t.string   "query"
    t.string   "event"
    t.string   "regex"
    t.string   "advertiserId"
    t.integer  "siteId"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "version"
    t.string   "retargetValue"
    t.string   "status"
  end

  create_table "sites", force: true do |t|
    t.string   "siteName"
    t.string   "siteUrl"
    t.text     "description"
    t.integer  "advertiserId"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "siteStatus"
  end

  create_table "styles", force: true do |t|
    t.integer  "user_id"
    t.string   "usertype"
    t.string   "styleName"
    t.string   "BorderColor"
    t.string   "TitleColor"
    t.string   "BackgroundColor"
    t.string   "TextColor"
    t.string   "urlColor"
    t.string   "cornerstyle"
    t.string   "fontfamily"
    t.string   "fontsize"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "userType"
    t.string   "firstName"
    t.string   "lastName"
    t.string   "userTimezone"
    t.string   "resetPasswordToken"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
