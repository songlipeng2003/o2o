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

ActiveRecord::Schema.define(version: 20150305050722) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "addresses", force: true do |t|
    t.string   "place"
    t.string   "address_type"
    t.decimal  "lat",          precision: 11, scale: 8
    t.decimal  "lon",          precision: 11, scale: 8
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "announcements", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applications", force: true do |t|
    t.string   "name"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "umeng_app_key"
    t.string   "app_type"
    t.string   "app_master_secret"
  end

  create_table "areas", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.integer  "ancestry_depth", default: 0
  end

  add_index "areas", ["ancestry"], name: "index_areas_on_ancestry", using: :btree
  add_index "areas", ["parent_id"], name: "index_areas_on_parent_id", using: :btree

  create_table "auth_codes", force: true do |t|
    t.string   "phone"
    t.string   "code"
    t.datetime "expired_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banners", force: true do |t|
    t.string   "image"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_brands", force: true do |t|
    t.string   "name"
    t.string   "first_letter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_models", force: true do |t|
    t.string   "name"
    t.integer  "car_brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auto_type"
    t.string   "first_letter"
  end

  create_table "cars", force: true do |t|
    t.string   "license_tag"
    t.integer  "car_model_id"
    t.date     "buy_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "color"
    t.integer  "application_id"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "communities", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat",        limit: 24
    t.float    "lon",        limit: 24
  end

  add_index "communities", ["area_id"], name: "index_communities_on_area_id", using: :btree

  create_table "coupons", force: true do |t|
    t.integer  "user_id"
    t.integer  "system_coupon_id"
    t.float    "amount",           limit: 24
    t.string   "state"
    t.string   "expired_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coupons", ["system_coupon_id"], name: "index_coupons_on_system_coupon_id", using: :btree
  add_index "coupons", ["user_id"], name: "index_coupons_on_user_id", using: :btree

  create_table "devices", force: true do |t|
    t.string   "code"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "created_at"
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "docs", force: true do |t|
    t.string   "title"
    t.string   "key"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", force: true do |t|
    t.integer  "order_id"
    t.integer  "score"
    t.string   "note"
    t.datetime "created_at"
    t.integer  "user_id"
    t.integer  "store_id"
    t.integer  "application_id"
  end

  add_index "evaluations", ["order_id"], name: "index_evaluations_on_order_id", using: :btree

  create_table "finances", force: true do |t|
    t.integer  "user_id"
    t.string   "user_type"
    t.float    "balance",    limit: 24
    t.float    "freeze",     limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "file"
    t.integer  "filesize"
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at"
    t.integer  "user_id"
  end

  add_index "images", ["item_id", "item_type"], name: "index_images_on_item_id_and_item_type", using: :btree
  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "login_histories", force: true do |t|
    t.integer  "user_id"
    t.string   "device"
    t.string   "device_type"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "device_model"
  end

  add_index "login_histories", ["user_id"], name: "index_login_histories_on_user_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "store_id"
    t.integer  "car_id"
    t.string   "phone"
    t.string   "place"
    t.decimal  "lat",                            precision: 11, scale: 8
    t.decimal  "lon",                            precision: 11, scale: 8
    t.datetime "booked_at"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.boolean  "is_underground_park",                                     default: false
    t.string   "carport"
    t.string   "license_tag"
    t.integer  "car_model_id"
    t.string   "car_color"
    t.integer  "address_id"
    t.integer  "product_id"
    t.float    "total_amount",        limit: 24
    t.integer  "province_id"
    t.integer  "city_id"
    t.integer  "area_id"
    t.float    "original_price",      limit: 24
    t.integer  "product_type",                                            default: 1
    t.boolean  "is_include_interior",                                     default: false
    t.integer  "application_id"
    t.integer  "coupon_id"
    t.integer  "payment_id"
    t.datetime "deleted_at"
  end

  add_index "orders", ["coupon_id"], name: "index_orders_on_coupon_id", using: :btree
  add_index "orders", ["deleted_at"], name: "index_orders_on_deleted_at", using: :btree

  create_table "payment_log", force: true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "payment_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "code"
    t.float    "pay_fee",     limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_show",                default: true
  end

  create_table "product_types", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "price",           limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "market_price",    limit: 24
    t.string   "image"
    t.integer  "product_type_id"
  end

  add_index "products", ["product_type_id"], name: "index_products_on_product_type_id", using: :btree

  create_table "recharge_policies", force: true do |t|
    t.integer  "amount"
    t.integer  "present_amount"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort",           default: 0
  end

  create_table "recharge_policies_system_coupons", force: true do |t|
    t.integer "recharge_policy_id",             null: false
    t.integer "system_coupon_id",               null: false
    t.integer "number",             default: 1
  end

  create_table "recharges", force: true do |t|
    t.integer  "user_id"
    t.integer  "amount"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "payed_at"
    t.integer  "recharge_policy_id"
    t.integer  "application_id"
    t.integer  "payment_id"
  end

  add_index "recharges", ["user_id"], name: "index_recharges_on_user_id", using: :btree

  create_table "store_users", force: true do |t|
    t.integer  "store_id"
    t.string   "username"
    t.string   "phone"
    t.string   "email",                default: "", null: false
    t.string   "encrypted_password",   default: "", null: false
    t.integer  "sign_in_count",        default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.string   "gender"
    t.string   "nickname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_users", ["store_id"], name: "index_store_users_on_store_id", using: :btree

  create_table "stores", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.string   "description"
    t.float    "good_rate",     limit: 24, default: 0.0
    t.integer  "collect_count",            default: 0
    t.float    "score",         limit: 24, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat",           limit: 24
    t.float    "lon",           limit: 24
    t.text     "service_area"
    t.integer  "province_id"
    t.integer  "city_id"
    t.integer  "area_id"
  end

  create_table "system_coupons", force: true do |t|
    t.string   "name"
    t.integer  "product_id"
    t.float    "amount",          limit: 24
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "product_type_id"
  end

  add_index "system_coupons", ["product_id"], name: "index_system_coupons_on_product_id", using: :btree
  add_index "system_coupons", ["product_type_id"], name: "index_system_coupons_on_product_type_id", using: :btree

  create_table "trading_records", force: true do |t|
    t.integer  "user_id"
    t.integer  "trading_type"
    t.integer  "amount"
    t.string   "name"
    t.integer  "object_id"
    t.string   "object_type"
    t.string   "remark"
    t.datetime "created_at"
    t.float    "start_amount", limit: 24
    t.float    "end_amount",   limit: 24
  end

  add_index "trading_records", ["user_id"], name: "index_trading_records_on_user_id", using: :btree

  create_table "upload_files", force: true do |t|
    t.string   "file"
    t.integer  "filesize"
    t.datetime "created_at"
    t.integer  "application_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                             default: "",  null: false
    t.string   "encrypted_password",                default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "authentication_token"
    t.float    "balance",                limit: 24, default: 0.0
    t.float    "score",                  limit: 24, default: 0.0
    t.string   "encrypted_pay_password"
    t.string   "avatar"
    t.string   "gender"
    t.string   "nickname"
    t.string   "umeng"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
