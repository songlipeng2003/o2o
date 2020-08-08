# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_07_152004) do

  create_table "active_admin_comments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "namespace", limit: 191
    t.text "body"
    t.string "resource_id", null: false
    t.string "resource_type", limit: 191, null: false
    t.integer "author_id"
    t.string "author_type", limit: 191
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", length: { resource_id: 191 }
  end

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "place"
    t.string "address_type"
    t.decimal "lat", precision: 11, scale: 8
    t.decimal "lon", precision: 11, scale: 8
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.integer "application_id"
    t.string "note"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "admin_users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "email", limit: 191, default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token", limit: 191
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "province_id"
    t.integer "city_id"
    t.integer "area_id"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "announcements", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_payments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "application_id"
    t.integer "payment_id"
    t.integer "sort", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["application_id"], name: "index_app_payments_on_application_id"
    t.index ["payment_id"], name: "index_app_payments_on_payment_id"
  end

  create_table "app_versions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "file"
    t.string "version"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applications", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "app_type"
  end

  create_table "areas", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "ancestry", limit: 191
    t.integer "ancestry_depth", default: 0
    t.index ["ancestry"], name: "index_areas_on_ancestry"
    t.index ["parent_id"], name: "index_areas_on_parent_id"
  end

  create_table "auth_codes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "phone"
    t.string "code"
    t.datetime "expired_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banners", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "image"
    t.string "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "big_customer_users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "big_customer_id"
    t.string "username"
    t.string "phone"
    t.string "email"
    t.string "encrypted_password"
    t.integer "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["big_customer_id"], name: "index_big_customer_users_on_big_customer_id"
  end

  create_table "big_customers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "contacts"
    t.string "phone"
    t.integer "province_id"
    t.integer "city_id"
    t.integer "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["area_id"], name: "index_big_customers_on_area_id"
    t.index ["city_id"], name: "index_big_customers_on_city_id"
    t.index ["province_id"], name: "index_big_customers_on_province_id"
  end

  create_table "car_brands", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "first_letter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_models", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.integer "car_brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "auto_type"
    t.string "first_letter"
  end

  create_table "car_styles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "car_brand_id"
    t.integer "car_model_id"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["car_brand_id"], name: "index_car_styles_on_car_brand_id"
    t.index ["car_model_id"], name: "index_car_styles_on_car_model_id"
  end

  create_table "cars", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "license_tag"
    t.integer "car_model_id"
    t.date "buy_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "color"
    t.integer "application_id"
    t.datetime "deleted_at"
    t.integer "car_style_id"
    t.index ["car_style_id"], name: "index_cars_on_car_style_id"
  end

  create_table "categories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.integer "assetable_id"
    t.string "assetable_type", limit: 30
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"
  end

  create_table "communities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "lat"
    t.float "lon"
    t.index ["area_id"], name: "index_communities_on_area_id"
  end

  create_table "coupons", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "user_id"
    t.integer "system_coupon_id"
    t.float "amount"
    t.string "state"
    t.string "expired_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["system_coupon_id"], name: "index_coupons_on_system_coupon_id"
    t.index ["user_id"], name: "index_coupons_on_user_id"
  end

  create_table "devices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at"
    t.integer "deviceable_id"
    t.string "deviceable_type"
    t.string "device_type"
    t.string "jpush"
  end

  create_table "docs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "title"
    t.string "key"
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "order_id"
    t.integer "score"
    t.string "note"
    t.datetime "created_at"
    t.integer "user_id"
    t.integer "store_id"
    t.integer "application_id"
    t.integer "store_user_id"
    t.integer "score1"
    t.integer "score2"
    t.integer "score3"
    t.index ["order_id"], name: "index_evaluations_on_order_id"
    t.index ["store_user_id"], name: "index_evaluations_on_store_user_id"
  end

  create_table "feedbacks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "user_id"
    t.integer "application_id"
    t.text "content"
    t.integer "feedback_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["application_id"], name: "index_feedbacks_on_application_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "finances", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "financeable_id"
    t.string "financeable_type"
    t.float "balance", default: 0.0
    t.float "freeze_balance", default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "file"
    t.integer "filesize"
    t.integer "item_id"
    t.string "item_type", limit: 191
    t.datetime "created_at"
    t.integer "user_id"
    t.index ["item_id", "item_type"], name: "index_images_on_item_id_and_item_type"
    t.index ["user_id"], name: "index_images_on_user_id"
  end

  create_table "login_histories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "device"
    t.string "device_type"
    t.string "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "device_model"
    t.integer "user_id"
    t.string "user_type"
    t.integer "application_id"
  end

  create_table "month_card_orders", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "user_id"
    t.integer "system_month_card_id"
    t.integer "car_id"
    t.integer "month"
    t.integer "price"
    t.string "state"
    t.integer "application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "license_tag"
    t.index ["application_id"], name: "index_month_card_orders_on_application_id"
    t.index ["car_id"], name: "index_month_card_orders_on_car_id"
    t.index ["system_month_card_id"], name: "index_month_card_orders_on_system_month_card_id"
    t.index ["user_id"], name: "index_month_card_orders_on_user_id"
  end

  create_table "month_cards", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "user_id"
    t.integer "car_id"
    t.string "license_tag"
    t.datetime "started_at"
    t.datetime "expired_at"
    t.string "use_count", default: "0"
    t.string "state"
    t.integer "application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.integer "product_id"
    t.integer "system_month_card_id"
    t.index ["car_id"], name: "index_month_cards_on_car_id"
    t.index ["product_id"], name: "index_month_cards_on_product_id"
    t.index ["system_month_card_id"], name: "index_month_cards_on_system_month_card_id"
    t.index ["user_id"], name: "index_month_cards_on_user_id"
  end

  create_table "notify_logs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "payment_id"
    t.string "type"
    t.text "params"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["payment_id"], name: "utf8mb4notify_logs_on_payment_id"
  end

  create_table "order_logs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "order_id"
    t.integer "user_id"
    t.string "user_type"
    t.string "state"
    t.string "changed_state"
    t.string "remark"
    t.datetime "created_at"
  end

  create_table "orders", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "sn"
    t.integer "user_id"
    t.integer "store_id"
    t.integer "car_id"
    t.string "phone"
    t.string "place"
    t.decimal "lat", precision: 11, scale: 8
    t.decimal "lon", precision: 11, scale: 8
    t.datetime "booked_at"
    t.string "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "state"
    t.boolean "is_underground_park", default: false
    t.string "carport"
    t.string "license_tag"
    t.integer "car_model_id"
    t.string "car_color"
    t.integer "address_id"
    t.integer "product_id"
    t.float "total_amount"
    t.integer "province_id"
    t.integer "city_id"
    t.integer "area_id"
    t.float "original_price"
    t.integer "product_type", default: 1
    t.boolean "is_include_interior", default: false
    t.integer "application_id"
    t.integer "coupon_id"
    t.integer "payment_id"
    t.datetime "deleted_at"
    t.integer "store_user_id"
    t.integer "month_card_id"
    t.integer "service_ticket_id"
    t.float "order_amount"
    t.datetime "booked_end_at"
    t.integer "order_type", default: 1
    t.index ["coupon_id"], name: "index_orders_on_coupon_id"
    t.index ["deleted_at"], name: "index_orders_on_deleted_at"
  end

  create_table "payment_logs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "sn"
    t.integer "item_id"
    t.string "item_type"
    t.integer "payment_id"
    t.string "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "payed_at"
    t.datetime "closed_at"
    t.string "out_trade_no"
    t.text "notify_params"
    t.integer "application_id"
    t.string "name"
    t.float "amount"
    t.string "pingxx"
  end

  create_table "payment_refund_logs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "sn"
    t.integer "payment_id"
    t.integer "payment_log_id"
    t.float "amount"
    t.string "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "refund_batch_id"
    t.string "out_trade_no"
    t.string "pingxx"
    t.index ["payment_id"], name: "index_payment_refund_logs_on_payment_id"
    t.index ["payment_log_id"], name: "index_payment_refund_logs_on_payment_log_id"
  end

  create_table "payment_refund_logs_refund_batches", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "payment_refund_log_id", null: false
    t.integer "refund_batch_id", null: false
  end

  create_table "payments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "code"
    t.float "pay_fee"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "is_show", default: true
    t.string "payment_type"
  end

  create_table "products", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "market_price"
    t.string "image"
    t.integer "category_id"
    t.float "suv_price"
    t.integer "province_id", default: 916
    t.integer "city_id", default: 917
    t.integer "product_type", default: 1
    t.integer "store_id"
    t.index ["city_id"], name: "index_products_on_city_id"
    t.index ["province_id"], name: "index_products_on_province_id"
  end

  create_table "recharge_policies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "amount"
    t.integer "present_amount"
    t.string "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sort", default: 0
    t.boolean "show", default: true
  end

  create_table "recharge_policies_system_coupons", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "recharge_policy_id", null: false
    t.integer "system_coupon_id", null: false
    t.integer "number", default: 1
  end

  create_table "recharges", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "user_id"
    t.float "amount"
    t.string "state"
    t.datetime "created_at"
    t.datetime "payed_at"
    t.integer "recharge_policy_id"
    t.integer "application_id"
    t.integer "payment_id"
    t.datetime "closed_at"
    t.integer "present_amount"
    t.index ["user_id"], name: "index_recharges_on_user_id"
  end

  create_table "refund_batches", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "payment_id"
    t.string "sn"
    t.string "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["payment_id"], name: "index_refund_batches_on_payment_id"
  end

  create_table "service_areas", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "product_id"
    t.string "name"
    t.string "areas"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_id"], name: "index_service_areas_on_product_id"
  end

  create_table "service_ticket_batches", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "big_customer_id"
    t.integer "number"
    t.integer "used_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["big_customer_id"], name: "index_service_ticket_batches_on_big_customer_id"
  end

  create_table "service_tickets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "big_customer_id"
    t.integer "user_id"
    t.integer "service_ticket_batch_id"
    t.string "code"
    t.string "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "order_amount"
    t.index ["big_customer_id"], name: "index_service_tickets_on_big_customer_id"
    t.index ["service_ticket_batch_id"], name: "index_service_tickets_on_service_ticket_batch_id"
    t.index ["user_id"], name: "index_service_tickets_on_user_id"
  end

  create_table "store_user_service_areas", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "store_user_id"
    t.integer "service_area_id"
    t.datetime "created_at"
    t.index ["service_area_id"], name: "index_store_user_service_areas_on_service_area_id"
    t.index ["store_user_id"], name: "index_store_user_service_areas_on_store_user_id"
  end

  create_table "store_users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "store_id"
    t.string "username"
    t.string "phone"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "authentication_token"
    t.string "gender"
    t.string "nickname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "role", default: 1
    t.string "avatar"
    t.integer "orders_count", default: 0
    t.float "score", default: 0.0
    t.index ["store_id"], name: "index_store_users_on_store_id"
  end

  create_table "stores", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.string "description"
    t.float "good_rate", default: 0.0
    t.integer "collect_count", default: 0
    t.float "score", default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "lat"
    t.float "lon"
    t.integer "province_id"
    t.integer "city_id"
    t.integer "area_id"
    t.datetime "deleted_at"
    t.integer "orders_count", default: 0
    t.integer "store_type", default: 1
  end

  create_table "system_coupons", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.integer "product_id"
    t.float "amount"
    t.string "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image"
    t.index ["product_id"], name: "index_system_coupons_on_product_id"
  end

  create_table "system_month_cards", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "province_id"
    t.integer "city_id"
    t.integer "month"
    t.string "name"
    t.integer "price"
    t.integer "sort", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "is_show", default: true
    t.integer "product_id"
    t.index ["city_id"], name: "index_system_month_cards_on_city_id"
    t.index ["product_id"], name: "index_system_month_cards_on_product_id"
    t.index ["province_id"], name: "index_system_month_cards_on_province_id"
  end

  create_table "system_users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trading_records", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "trading_type"
    t.float "amount"
    t.string "name"
    t.integer "object_id"
    t.string "object_type"
    t.string "remark"
    t.datetime "created_at"
    t.float "start_amount"
    t.float "end_amount"
    t.integer "finance_id"
    t.integer "fund_type", default: 1, null: false
    t.index ["finance_id"], name: "index_trading_records_on_finance_id"
  end

  create_table "upload_files", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "file"
    t.integer "filesize"
    t.datetime "created_at"
    t.integer "application_id"
  end

  create_table "user_stores", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["store_id"], name: "index_user_stores_on_store_id"
    t.index ["user_id"], name: "index_user_stores_on_user_id"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "email", limit: 191, default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token", limit: 191
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "phone"
    t.string "authentication_token", limit: 191
    t.float "score", default: 0.0
    t.string "encrypted_pay_password"
    t.string "avatar"
    t.string "gender"
    t.string "nickname"
    t.string "umeng"
    t.integer "application_id"
    t.integer "orders_count", default: 0
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "item_type", limit: 191, null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
