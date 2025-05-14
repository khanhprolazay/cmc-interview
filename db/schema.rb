# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_13_130304) do
  create_table "asset_purchases", force: :cascade do |t|
    t.integer "asset_id"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asset_id"], name: "index_asset_purchases_on_asset_id"
    t.index ["customer_id"], name: "index_asset_purchases_on_customer_id"
  end

  create_table "assets", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "file_url"
    t.decimal "price", precision: 10, scale: 2
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_assets_on_creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "iam_id"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["iam_id"], name: "index_users_on_iam_id"
  end

  add_foreign_key "asset_purchases", "assets"
  add_foreign_key "asset_purchases", "users", column: "customer_id"
  add_foreign_key "assets", "users", column: "creator_id"
end
