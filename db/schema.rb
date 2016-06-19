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

ActiveRecord::Schema.define(version: 20160619111152) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 191
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 191,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 191
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", length: {"resource_type"=>nil, "resource_id"=>191}, using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "place",          limit: 255
    t.string   "address_type",   limit: 255
    t.decimal  "lat",                        precision: 11, scale: 8
    t.decimal  "lon",                        precision: 11, scale: 8
    t.integer  "user_id",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",           limit: 255
    t.integer  "application_id", limit: 4
    t.string   "note",           limit: 255
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 191, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 191
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "province_id",            limit: 4
    t.integer  "city_id",                limit: 4
    t.integer  "area_id",                limit: 4
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "announcements", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_payments", force: :cascade do |t|
    t.integer  "application_id", limit: 4
    t.integer  "payment_id",     limit: 4
    t.integer  "sort",           limit: 4, default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "app_payments", ["application_id"], name: "index_app_payments_on_application_id", using: :btree
  add_index "app_payments", ["payment_id"], name: "index_app_payments_on_payment_id", using: :btree

  create_table "app_versions", force: :cascade do |t|
    t.string   "file",        limit: 255
    t.string   "version",     limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applications", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "token",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "app_type",   limit: 255
  end

  create_table "areas", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "parent_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry",       limit: 191
    t.integer  "ancestry_depth", limit: 4,   default: 0
  end

  add_index "areas", ["ancestry"], name: "index_areas_on_ancestry", using: :btree
  add_index "areas", ["parent_id"], name: "index_areas_on_parent_id", using: :btree

  create_table "auth_codes", force: :cascade do |t|
    t.string   "phone",      limit: 255
    t.string   "code",       limit: 255
    t.datetime "expired_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banners", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.string   "link",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "big_customer_users", force: :cascade do |t|
    t.integer  "big_customer_id",      limit: 4
    t.string   "username",             limit: 255
    t.string   "phone",                limit: 255
    t.string   "email",                limit: 255
    t.string   "encrypted_password",   limit: 255
    t.integer  "sign_in_count",        limit: 4
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",   limit: 255
    t.string   "last_sign_in_ip",      limit: 255
    t.string   "authentication_token", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "big_customer_users", ["big_customer_id"], name: "index_big_customer_users_on_big_customer_id", using: :btree

  create_table "big_customers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "contacts",    limit: 255
    t.string   "phone",       limit: 255
    t.integer  "province_id", limit: 4
    t.integer  "city_id",     limit: 4
    t.integer  "area_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "big_customers", ["area_id"], name: "index_big_customers_on_area_id", using: :btree
  add_index "big_customers", ["city_id"], name: "index_big_customers_on_city_id", using: :btree
  add_index "big_customers", ["province_id"], name: "index_big_customers_on_province_id", using: :btree

  create_table "car_brands", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "first_letter", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_models", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "car_brand_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auto_type",    limit: 255
    t.string   "first_letter", limit: 255
  end

  create_table "cars", force: :cascade do |t|
    t.string   "license_tag",    limit: 255
    t.integer  "car_model_id",   limit: 4
    t.date     "buy_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",        limit: 4
    t.string   "color",          limit: 255
    t.integer  "application_id", limit: 4
    t.datetime "deleted_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "communities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.integer  "area_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat",        limit: 24
    t.float    "lon",        limit: 24
  end

  add_index "communities", ["area_id"], name: "index_communities_on_area_id", using: :btree

  create_table "coupons", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "system_coupon_id", limit: 4
    t.float    "amount",           limit: 24
    t.string   "state",            limit: 255
    t.string   "expired_at",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coupons", ["system_coupon_id"], name: "index_coupons_on_system_coupon_id", using: :btree
  add_index "coupons", ["user_id"], name: "index_coupons_on_user_id", using: :btree

  create_table "devices", force: :cascade do |t|
    t.string   "code",            limit: 255
    t.datetime "created_at"
    t.integer  "deviceable_id",   limit: 4
    t.string   "deviceable_type", limit: 255
    t.string   "device_type",     limit: 255
    t.string   "jpush",           limit: 255
  end

  create_table "docs", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "key",        limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer  "order_id",        limit: 4
    t.integer  "score",           limit: 4
    t.string   "note",            limit: 255
    t.datetime "created_at"
    t.integer  "user_id",         limit: 4
    t.integer  "store_id",        limit: 4
    t.integer  "application_id",  limit: 4
    t.integer  "store_user_id",   limit: 4
    t.integer  "score1",          limit: 4
    t.integer  "score2",          limit: 4
    t.integer  "score3",          limit: 4
    t.integer  "wash_machine_id", limit: 4
  end

  add_index "evaluations", ["order_id"], name: "index_evaluations_on_order_id", using: :btree
  add_index "evaluations", ["store_user_id"], name: "index_evaluations_on_store_user_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "application_id", limit: 4
    t.text     "content",        limit: 65535
    t.integer  "feedback_type",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["application_id"], name: "index_feedbacks_on_application_id", using: :btree
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "finances", force: :cascade do |t|
    t.integer  "financeable_id",   limit: 4
    t.string   "financeable_type", limit: 255
    t.float    "balance",          limit: 24,  default: 0.0
    t.float    "freeze_balance",   limit: 24,  default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: :cascade do |t|
    t.string   "file",       limit: 255
    t.integer  "filesize",   limit: 4
    t.integer  "item_id",    limit: 4
    t.string   "item_type",  limit: 191
    t.datetime "created_at"
    t.integer  "user_id",    limit: 4
  end

  add_index "images", ["item_id", "item_type"], name: "index_images_on_item_id_and_item_type", using: :btree
  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "login_histories", force: :cascade do |t|
    t.string   "device",         limit: 255
    t.string   "device_type",    limit: 255
    t.string   "ip",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "device_model",   limit: 255
    t.integer  "user_id",        limit: 4
    t.string   "user_type",      limit: 255
    t.integer  "application_id", limit: 4
  end

  create_table "month_card_orders", force: :cascade do |t|
    t.integer  "user_id",              limit: 4
    t.integer  "system_month_card_id", limit: 4
    t.integer  "car_id",               limit: 4
    t.integer  "month",                limit: 4
    t.integer  "price",                limit: 4
    t.string   "state",                limit: 255
    t.integer  "application_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "license_tag",          limit: 255
  end

  add_index "month_card_orders", ["application_id"], name: "index_month_card_orders_on_application_id", using: :btree
  add_index "month_card_orders", ["car_id"], name: "index_month_card_orders_on_car_id", using: :btree
  add_index "month_card_orders", ["system_month_card_id"], name: "index_month_card_orders_on_system_month_card_id", using: :btree
  add_index "month_card_orders", ["user_id"], name: "index_month_card_orders_on_user_id", using: :btree

  create_table "month_cards", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "car_id",         limit: 4
    t.string   "license_tag",    limit: 255
    t.datetime "started_at"
    t.datetime "expired_at"
    t.string   "use_count",            default: "0"
    t.string   "state"
    t.integer  "application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "product_id"
    t.integer  "system_month_card_id"
  end

  add_index "month_cards", ["car_id"], name: "index_month_cards_on_car_id", using: :btree
  add_index "month_cards", ["product_id"], name: "index_month_cards_on_product_id", using: :btree
  add_index "month_cards", ["system_month_card_id"], name: "index_month_cards_on_system_month_card_id", using: :btree
  add_index "month_cards", ["user_id"], name: "index_month_cards_on_user_id", using: :btree

  create_table "notify_logs", force: :cascade do |t|
    t.integer  "payment_id", limit: 4
    t.string   "type",       limit: 255
    t.text     "params",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notify_logs", ["payment_id"], name: "utf8mb4notify_logs_on_payment_id", using: :btree

  create_table "order_logs", force: :cascade do |t|
    t.integer  "order_id",      limit: 4
    t.integer  "user_id",       limit: 4
    t.string   "user_type",     limit: 255
    t.string   "state",         limit: 255
    t.string   "changed_state", limit: 255
    t.string   "remark",        limit: 255
    t.datetime "created_at"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "sn",                       limit: 255
    t.integer  "user_id",                  limit: 4
    t.integer  "store_id",                 limit: 4
    t.integer  "car_id",                   limit: 4
    t.string   "phone",                    limit: 255
    t.string   "place",                    limit: 255
    t.decimal  "lat",                                  precision: 11, scale: 8
    t.decimal  "lon",                                  precision: 11, scale: 8
    t.datetime "booked_at"
    t.string   "note",                     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                    limit: 255
    t.boolean  "is_underground_park",                                           default: false
    t.string   "carport",                  limit: 255
    t.string   "license_tag",              limit: 255
    t.integer  "car_model_id",             limit: 4
    t.string   "car_color",                limit: 255
    t.integer  "address_id",               limit: 4
    t.integer  "product_id",               limit: 4
    t.float    "total_amount",             limit: 24
    t.integer  "province_id",              limit: 4
    t.integer  "city_id",                  limit: 4
    t.integer  "area_id",                  limit: 4
    t.float    "original_price",           limit: 24
    t.integer  "product_type",             limit: 4,                            default: 1
    t.boolean  "is_include_interior",                                           default: false
    t.integer  "application_id",           limit: 4
    t.integer  "coupon_id",                limit: 4
    t.integer  "payment_id",               limit: 4
    t.datetime "deleted_at"
    t.integer  "store_user_id",            limit: 4
    t.integer  "month_card_id",            limit: 4
    t.integer  "service_ticket_id",        limit: 4
    t.float    "order_amount",             limit: 24
    t.datetime "booked_end_at"
    t.integer  "wash_machine_id",          limit: 4
    t.integer  "order_type",               limit: 4,                            default: 1
    t.string   "wash_machine_code",        limit: 255
    t.string   "wash_machine_random_code", limit: 255
  end

  add_index "orders", ["coupon_id"], name: "index_orders_on_coupon_id", using: :btree
  add_index "orders", ["deleted_at"], name: "index_orders_on_deleted_at", using: :btree
  add_index "orders", ["wash_machine_id"], name: "index_orders_on_wash_machine_id", using: :btree

  create_table "payment_logs", force: :cascade do |t|
    t.string   "sn",             limit: 255
    t.integer  "item_id",        limit: 4
    t.string   "item_type",      limit: 255
    t.integer  "payment_id",     limit: 4
    t.string   "state",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "payed_at"
    t.datetime "closed_at"
    t.string   "out_trade_no",   limit: 255
    t.text     "notify_params",  limit: 65535
    t.integer  "application_id", limit: 4
    t.string   "name",           limit: 255
    t.float    "amount",         limit: 24
    t.string   "pingxx",         limit: 255
  end

  create_table "payment_refund_logs", force: :cascade do |t|
    t.string   "sn",              limit: 255
    t.integer  "payment_id",      limit: 4
    t.integer  "payment_log_id",  limit: 4
    t.float    "amount",          limit: 24
    t.string   "state",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "refund_batch_id", limit: 4
    t.string   "out_trade_no",    limit: 255
    t.string   "pingxx",          limit: 255
  end

  add_index "payment_refund_logs", ["payment_id"], name: "index_payment_refund_logs_on_payment_id", using: :btree
  add_index "payment_refund_logs", ["payment_log_id"], name: "index_payment_refund_logs_on_payment_log_id", using: :btree

  create_table "payment_refund_logs_refund_batches", id: false, force: :cascade do |t|
    t.integer "payment_refund_log_id", limit: 4, null: false
    t.integer "refund_batch_id",       limit: 4, null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "description",  limit: 255
    t.string   "code",         limit: 255
    t.float    "pay_fee",      limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_show",                  default: true
    t.string   "payment_type", limit: 255
  end

  create_table "product_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "description",     limit: 65535
    t.float    "price",           limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "market_price",    limit: 24
    t.string   "image",           limit: 255
    t.integer  "product_type_id", limit: 4
    t.integer  "category_id",     limit: 4
    t.float    "suv_price",       limit: 24
    t.integer  "province_id",     limit: 4,     default: 916
    t.integer  "city_id",         limit: 4,     default: 917
  end

  add_index "products", ["city_id"], name: "index_products_on_city_id", using: :btree
  add_index "products", ["product_type_id"], name: "index_products_on_product_type_id", using: :btree
  add_index "products", ["province_id"], name: "index_products_on_province_id", using: :btree

  create_table "recharge_policies", force: :cascade do |t|
    t.integer  "amount",         limit: 4
    t.integer  "present_amount", limit: 4
    t.string   "note",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort",           limit: 4,   default: 0
    t.boolean  "show",                       default: true
  end

  create_table "recharge_policies_system_coupons", force: :cascade do |t|
    t.integer "recharge_policy_id", limit: 4,             null: false
    t.integer "system_coupon_id",   limit: 4,             null: false
    t.integer "number",             limit: 4, default: 1
  end

  create_table "recharges", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.float    "amount",             limit: 24
    t.string   "state",              limit: 255
    t.datetime "created_at"
    t.datetime "payed_at"
    t.integer  "recharge_policy_id", limit: 4
    t.integer  "application_id",     limit: 4
    t.integer  "payment_id",         limit: 4
    t.datetime "closed_at"
    t.integer  "present_amount",     limit: 4
  end

  add_index "recharges", ["user_id"], name: "index_recharges_on_user_id", using: :btree

  create_table "refund_batches", force: :cascade do |t|
    t.integer  "payment_id", limit: 4
    t.string   "sn",         limit: 255
    t.string   "state",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refund_batches", ["payment_id"], name: "index_refund_batches_on_payment_id", using: :btree

  create_table "service_ticket_batches", force: :cascade do |t|
    t.integer  "big_customer_id", limit: 4
    t.integer  "number",          limit: 4
    t.integer  "used_count",      limit: 4, default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_ticket_batches", ["big_customer_id"], name: "index_service_ticket_batches_on_big_customer_id", using: :btree

  create_table "service_tickets", force: :cascade do |t|
    t.integer  "big_customer_id",         limit: 4
    t.integer  "user_id",                 limit: 4
    t.integer  "service_ticket_batch_id", limit: 4
    t.string   "code",                    limit: 255
    t.string   "state",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "order_amount",            limit: 24
  end

  add_index "service_tickets", ["big_customer_id"], name: "index_service_tickets_on_big_customer_id", using: :btree
  add_index "service_tickets", ["service_ticket_batch_id"], name: "index_service_tickets_on_service_ticket_batch_id", using: :btree
  add_index "service_tickets", ["user_id"], name: "index_service_tickets_on_user_id", using: :btree

  create_table "store_users", force: :cascade do |t|
    t.integer  "store_id",             limit: 4
    t.string   "username",             limit: 255
    t.string   "phone",                limit: 255
    t.string   "email",                limit: 255, default: "",  null: false
    t.string   "encrypted_password",   limit: 255, default: "",  null: false
    t.integer  "sign_in_count",        limit: 4,   default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",   limit: 255
    t.string   "last_sign_in_ip",      limit: 255
    t.string   "authentication_token", limit: 255
    t.string   "gender",               limit: 255
    t.string   "nickname",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",                 limit: 4,   default: 1
    t.string   "avatar",               limit: 255
    t.integer  "orders_count",         limit: 4,   default: 0
    t.float    "score",                limit: 24,  default: 0.0
  end

  add_index "store_users", ["store_id"], name: "index_store_users_on_store_id", using: :btree

  create_table "stores", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "phone",         limit: 255
    t.string   "address",       limit: 255
    t.string   "description",   limit: 255
    t.float    "good_rate",     limit: 24,    default: 0.0
    t.integer  "collect_count", limit: 4,     default: 0
    t.float    "score",         limit: 24,    default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat",           limit: 24
    t.float    "lon",           limit: 24
    t.text     "service_area",  limit: 65535
    t.integer  "province_id",   limit: 4
    t.integer  "city_id",       limit: 4
    t.integer  "area_id",       limit: 4
    t.datetime "deleted_at"
    t.integer  "orders_count",  limit: 4,     default: 0
  end

  create_table "system_coupons", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "product_id",      limit: 4
    t.float    "amount",          limit: 24
    t.string   "description",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image",           limit: 255
    t.integer  "product_type_id", limit: 4
  end

  add_index "system_coupons", ["product_id"], name: "index_system_coupons_on_product_id", using: :btree
  add_index "system_coupons", ["product_type_id"], name: "index_system_coupons_on_product_type_id", using: :btree

  create_table "system_month_cards", force: :cascade do |t|
    t.integer  "province_id", limit: 4
    t.integer  "city_id",     limit: 4
    t.integer  "month",       limit: 4
    t.string   "name",        limit: 255
    t.integer  "price",       limit: 4
    t.integer  "sort",        limit: 4,   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_show",     default: true
    t.integer  "product_id"
  end

  add_index "system_month_cards", ["city_id"], name: "index_system_month_cards_on_city_id", using: :btree
  add_index "system_month_cards", ["product_id"], name: "index_system_month_cards_on_product_id", using: :btree
  add_index "system_month_cards", ["province_id"], name: "index_system_month_cards_on_province_id", using: :btree

  create_table "system_users", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trading_records", force: :cascade do |t|
    t.integer  "trading_type", limit: 4
    t.float    "amount",       limit: 24
    t.string   "name",         limit: 255
    t.integer  "object_id",    limit: 4
    t.string   "object_type",  limit: 255
    t.string   "remark",       limit: 255
    t.datetime "created_at"
    t.float    "start_amount", limit: 24
    t.float    "end_amount",   limit: 24
    t.integer  "finance_id",   limit: 4
    t.integer  "fund_type",    limit: 4,   default: 1, null: false
  end

  add_index "trading_records", ["finance_id"], name: "index_trading_records_on_finance_id", using: :btree

  create_table "upload_files", force: :cascade do |t|
    t.string   "file",           limit: 255
    t.integer  "filesize",       limit: 4
    t.datetime "created_at"
    t.integer  "application_id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 191, default: "",  null: false
    t.string   "encrypted_password",     limit: 255, default: "",  null: false
    t.string   "reset_password_token",   limit: 191
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone",                  limit: 255
    t.string   "authentication_token",   limit: 191
    t.float    "score",                  limit: 24,  default: 0.0
    t.string   "encrypted_pay_password", limit: 255
    t.string   "avatar",                 limit: 255
    t.string   "gender",                 limit: 255
    t.string   "nickname",               limit: 255
    t.string   "umeng",                  limit: 255
    t.integer  "application_id",         limit: 4
    t.integer  "orders_count",           limit: 4,   default: 0
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 191,   null: false
    t.integer  "item_id",    limit: 4,     null: false
    t.string   "event",      limit: 255,   null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object",     limit: 65535
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "wash_machines", force: :cascade do |t|
    t.string   "code",         limit: 255
    t.float    "lat",          limit: 24
    t.float    "lon",          limit: 24
    t.string   "address",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "province_id",  limit: 4
    t.integer  "city_id",      limit: 4
    t.integer  "area_id",      limit: 4
    t.integer  "score",        limit: 4,   default: 5
    t.integer  "price",        limit: 4
    t.integer  "orders_count", limit: 4,   default: 0
  end

end
