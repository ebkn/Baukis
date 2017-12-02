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

ActiveRecord::Schema.define(version: 20171129070927) do

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "customer_id",                null: false
    t.string   "type",                       null: false
    t.string   "postal_code",                null: false
    t.string   "prefecture",                 null: false
    t.string   "city",                       null: false
    t.string   "address1",                   null: false
    t.string   "address2",                   null: false
    t.string   "company_name",  default: "", null: false
    t.string   "division_name", default: "", null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["city"], name: "index_addresses_on_city", using: :btree
    t.index ["customer_id"], name: "index_addresses_on_customer_id", using: :btree
    t.index ["postal_code"], name: "index_addresses_on_postal_code", using: :btree
    t.index ["prefecture", "city"], name: "index_addresses_on_prefecture_and_city", using: :btree
    t.index ["type", "city"], name: "index_addresses_on_type_and_city", using: :btree
    t.index ["type", "customer_id"], name: "index_addresses_on_type_and_customer_id", unique: true, using: :btree
    t.index ["type", "prefecture", "city"], name: "index_addresses_on_type_and_prefecture_and_city", using: :btree
  end

  create_table "administrators", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                           null: false
    t.string   "email_for_index",                 null: false
    t.string   "hashed_password"
    t.boolean  "suspended",       default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["email_for_index"], name: "index_administrators_on_email_for_index", unique: true, using: :btree
  end

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",            null: false
    t.string   "email_for_index",  null: false
    t.string   "family_name",      null: false
    t.string   "given_name",       null: false
    t.string   "family_name_kana", null: false
    t.string   "given_name_kana",  null: false
    t.string   "gender"
    t.date     "birthday"
    t.integer  "birth_year"
    t.integer  "birth_month"
    t.integer  "birth_mday"
    t.string   "hashed_password"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["birth_mday", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_mday_nad_kana", using: :btree
    t.index ["birth_mday", "given_name_kana"], name: "index_customers_on_birth_mday_and_given_name_kana", using: :btree
    t.index ["birth_month", "birth_mday"], name: "index_customers_on_birth_month_and_birth_mday", using: :btree
    t.index ["birth_month", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_month_and_kana", using: :btree
    t.index ["birth_month", "given_name_kana"], name: "index_customers_on_birth_month_and_given_name_kana", using: :btree
    t.index ["birth_year", "birth_month", "birth_mday"], name: "index_customers_on_birth_year_and_birth_month_and_birth_mday", using: :btree
    t.index ["birth_year", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_year_and_kana", using: :btree
    t.index ["birth_year", "given_name_kana"], name: "index_customers_on_birth_year_and_given_name_kana", using: :btree
    t.index ["email_for_index"], name: "index_customers_on_email_for_index", unique: true, using: :btree
    t.index ["family_name_kana", "given_name_kana"], name: "index_customers_on_family_name_kana_and_given_name_kana", using: :btree
    t.index ["gender", "family_name_kana", "given_name_kana"], name: "index_customers_on_gender_and_kana", using: :btree
    t.index ["given_name_kana"], name: "index_customers_on_given_name_kana", using: :btree
  end

  create_table "phones", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "customer_id",                      null: false
    t.integer  "address_id"
    t.string   "number",                           null: false
    t.string   "number_for_index",                 null: false
    t.string   "last_four_digits",                 null: false
    t.boolean  "primary",          default: false, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["address_id"], name: "index_phones_on_address_id", using: :btree
    t.index ["customer_id"], name: "index_phones_on_customer_id", using: :btree
    t.index ["last_four_digits"], name: "index_phones_on_last_four_digits", using: :btree
    t.index ["number_for_index"], name: "index_phones_on_number_for_index", using: :btree
  end

  create_table "staff_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "staff_member_id"
    t.string   "type",            null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["created_at"], name: "index_staff_events_on_created_at", using: :btree
    t.index ["staff_member_id", "created_at"], name: "index_staff_events_on_staff_member_id_and_created_at", using: :btree
    t.index ["staff_member_id"], name: "index_staff_events_on_staff_member_id", using: :btree
  end

  create_table "staff_members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                            null: false
    t.string   "email_for_index",                  null: false
    t.string   "family_name",                      null: false
    t.string   "given_name",                       null: false
    t.string   "family_name_kana",                 null: false
    t.string   "given_name_kana",                  null: false
    t.string   "hashed_password"
    t.date     "start_date",                       null: false
    t.date     "end_date"
    t.boolean  "suspended",        default: false, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["email_for_index"], name: "index_staff_members_on_email_for_index", unique: true, using: :btree
    t.index ["family_name_kana", "given_name_kana"], name: "index_staff_members_on_family_name_kana_and_given_name_kana", using: :btree
  end

  add_foreign_key "addresses", "customers"
  add_foreign_key "phones", "addresses"
  add_foreign_key "phones", "customers"
  add_foreign_key "staff_events", "staff_members"
end
