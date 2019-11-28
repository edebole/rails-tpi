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

ActiveRecord::Schema.define(version: 2019_11_27_054246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "cuil_cuit", null: false
    t.string "email"
    t.string "name"
    t.bigint "vat_condition_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vat_condition_id"], name: "index_clients_on_vat_condition_id"
  end

  create_table "contact_phones", force: :cascade do |t|
    t.string "phone", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_contact_phones_on_client_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "state", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_id", null: false
    t.index ["product_id"], name: "index_items_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "unique_code", null: false
    t.string "description"
    t.text "detail"
    t.decimal "unit_price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservation_details", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "reservation_id", null: false
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_reservation_details_on_item_id"
    t.index ["reservation_id"], name: "index_reservation_details_on_reservation_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.datetime "reservation_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_reservations_on_client_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "sell_details", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "sell_id", null: false
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_sell_details_on_item_id"
    t.index ["sell_id"], name: "index_sell_details_on_sell_id"
  end

  create_table "sells", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.bigint "reservation_id"
    t.datetime "sell_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_sells_on_client_id"
    t.index ["reservation_id"], name: "index_sells_on_reservation_id"
    t.index ["user_id"], name: "index_sells_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vat_conditions", force: :cascade do |t|
    t.string "code", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "clients", "vat_conditions"
  add_foreign_key "contact_phones", "clients"
  add_foreign_key "items", "products"
  add_foreign_key "reservation_details", "items"
  add_foreign_key "reservation_details", "reservations"
  add_foreign_key "reservations", "clients"
  add_foreign_key "reservations", "users"
  add_foreign_key "sell_details", "items"
  add_foreign_key "sell_details", "sells"
  add_foreign_key "sells", "clients"
  add_foreign_key "sells", "reservations"
  add_foreign_key "sells", "users"
end
