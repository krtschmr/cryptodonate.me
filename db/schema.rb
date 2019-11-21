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

ActiveRecord::Schema.define(version: 2019_11_21_033426) do

  create_table "coins", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "crypto_payments", force: :cascade do |t|
    t.integer "coin_id"
    t.integer "donation_id"
    t.string "state", default: "pending"
    t.string "tx_id", null: false
    t.decimal "amount", precision: 18, scale: 8
    t.integer "block"
    t.datetime "detected_at"
    t.datetime "confirmed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_crypto_payments_on_coin_id"
    t.index ["donation_id"], name: "index_crypto_payments_on_donation_id"
  end

  create_table "crypto_withdrawals", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "donations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "coin_id"
    t.string "uuid", limit: 36, null: false
    t.string "state", default: "unpaid"
    t.string "payment_address"
    t.string "name", limit: 22
    t.string "message"
    t.string "currency"
    t.decimal "amount", precision: 9, scale: 2
    t.decimal "total_paid_fiat", precision: 9, scale: 2
    t.decimal "total_paid_crypto", precision: 18, scale: 2
    t.boolean "alert_created", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_donations_on_coin_id"
    t.index ["user_id"], name: "index_donations_on_user_id"
  end

  create_table "ledger_entries", force: :cascade do |t|
    t.integer "user_id"
    t.integer "coin_id"
    t.string "type", null: false
    t.integer "donation_id"
    t.integer "crypto_payment_id"
    t.integer "withdrawal_id"
    t.decimal "amount", precision: 18, scale: 8
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_ledger_entries_on_coin_id"
    t.index ["crypto_payment_id"], name: "index_ledger_entries_on_crypto_payment_id"
    t.index ["donation_id"], name: "index_ledger_entries_on_donation_id"
    t.index ["type"], name: "index_ledger_entries_on_type"
    t.index ["user_id", "coin_id", "type"], name: "index_ledger_entries_on_user_id_and_coin_id_and_type"
    t.index ["user_id", "coin_id"], name: "index_ledger_entries_on_user_id_and_coin_id"
    t.index ["user_id", "type"], name: "index_ledger_entries_on_user_id_and_type"
    t.index ["user_id"], name: "index_ledger_entries_on_user_id"
    t.index ["withdrawal_id"], name: "index_ledger_entries_on_withdrawal_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "remember_created_at"
    t.string "donation_url"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name", null: false
    t.string "email", null: false
    t.string "description"
    t.string "url"
    t.string "token"
    t.string "refresh_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["uid"], name: "index_users_on_uid"
  end

  create_table "withdrawals", force: :cascade do |t|
    t.integer "user_id"
    t.integer "coin_id"
    t.integer "crypto_withdrawal_id"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_withdrawals_on_coin_id"
    t.index ["crypto_withdrawal_id"], name: "index_withdrawals_on_crypto_withdrawal_id"
    t.index ["user_id"], name: "index_withdrawals_on_user_id"
  end

end
