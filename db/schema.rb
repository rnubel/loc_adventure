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

ActiveRecord::Schema.define(:version => 20111224061549) do

  create_table "account_types", :force => true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts", :force => true do |t|
    t.integer  "account_type_id"
    t.float    "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "line_of_credit_id"
  end

  create_table "actions", :force => true do |t|
    t.integer  "line_of_credit_id"
    t.integer  "billing_period_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "created_on"
    t.integer  "type_id"
    t.integer  "status_id"
    t.date     "effective_on"
    t.decimal  "amount"
  end

  create_table "billing_periods", :force => true do |t|
    t.integer  "line_of_credit_id"
    t.date     "opened_on"
    t.date     "closed_on"
    t.float    "minimum_payment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lines_of_credit", :force => true do |t|
    t.date     "opened_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_id"
    t.integer  "credit_limit"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "action_id"
    t.float    "amount"
    t.integer  "debit_account_id"
    t.integer  "credit_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
