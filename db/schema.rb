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

ActiveRecord::Schema.define(version: 2021_06_26_014958) do

  create_table "guests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.text "phone"
    t.index ["email"], name: "index_guests_on_email", unique: true
  end

  create_table "reservations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "nights"
    t.integer "guests"
    t.integer "adults"
    t.integer "children"
    t.integer "infants"
    t.string "status"
    t.integer "guest_id"
    t.string "currency"
    t.string "payout_price"
    t.string "security_price"
    t.string "total_price"
    t.string "localized_description"
  end

end
