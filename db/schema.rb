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

ActiveRecord::Schema[7.0].define(version: 2022_04_13_053855) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "albums_id"
    t.bigint "orders_id"
    t.index ["albums_id"], name: "index_album_orders_on_albums_id"
    t.index ["orders_id"], name: "index_album_orders_on_orders_id"
  end

  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "artists_id"
    t.index ["artists_id"], name: "index_albums_on_artists_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "nationality"
    t.date "birth_date"
    t.string "death_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.boolean "active_flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.date "date"
    t.decimal "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customers_id"
    t.index ["customers_id"], name: "index_orders_on_customers_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "albums_id"
    t.index ["albums_id"], name: "index_songs_on_albums_id"
  end

  add_foreign_key "album_orders", "albums", column: "albums_id"
  add_foreign_key "album_orders", "orders", column: "orders_id"
  add_foreign_key "albums", "artists", column: "artists_id"
  add_foreign_key "orders", "customers", column: "customers_id"
  add_foreign_key "songs", "albums", column: "albums_id"
end
