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

ActiveRecord::Schema.define(version: 2019_11_26_023437) do

  create_table "balances", force: :cascade do |t|
    t.integer "streamer_id", null: false
    t.string "coin", limit: 20, null: false
    t.decimal "balance", precision: 18, scale: 8, default: "0.0"
    t.decimal "reserved", precision: 18, scale: 8, default: "0.0"
    t.decimal "available", precision: 18, scale: 8, default: "0.0"
    t.index ["coin"], name: "index_balances_on_coin"
    t.index ["streamer_id", "coin"], name: "index_balances_on_streamer_id_and_coin", unique: true
    t.index ["streamer_id"], name: "index_balances_on_streamer_id"
  end

  create_table "coins", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.text "description"
    t.decimal "price", precision: 15, scale: 7
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "connected_platforms", force: :cascade do |t|
    t.integer "streamer_id"
    t.string "provider", null: false
    t.integer "uid"
    t.string "name"
    t.string "token", null: false
    t.string "refresh_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider"], name: "index_connected_platforms_on_provider"
    t.index ["streamer_id", "provider"], name: "index_connected_platforms_on_streamer_id_and_provider", unique: true
    t.index ["streamer_id"], name: "index_connected_platforms_on_streamer_id"
  end

  create_table "crypto_withdrawals", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "donation_payments", force: :cascade do |t|
    t.integer "coin_id"
    t.integer "donation_id"
    t.integer "incoming_transaction_id"
    t.string "state", default: "pending"
    t.string "tx_id", null: false
    t.decimal "amount", precision: 18, scale: 8
    t.integer "block"
    t.datetime "detected_at"
    t.datetime "confirmed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_donation_payments_on_coin_id"
    t.index ["donation_id"], name: "index_donation_payments_on_donation_id"
    t.index ["incoming_transaction_id"], name: "index_donation_payments_on_incoming_transaction_id"
  end

  create_table "donations", force: :cascade do |t|
    t.integer "streamer_id"
    t.integer "coin_id"
    t.string "uuid", limit: 36, null: false
    t.string "state", default: "unpaid"
    t.string "counter", default: "1"
    t.string "name", limit: 22
    t.string "message"
    t.decimal "amount", precision: 9, scale: 2
    t.string "currency"
    t.decimal "usd_value"
    t.string "payment_address"
    t.decimal "payment_amount", precision: 18, scale: 8
    t.decimal "total_paid_fiat", precision: 9, scale: 2
    t.decimal "total_paid_crypto", precision: 18, scale: 8
    t.boolean "alert_created", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_donations_on_coin_id"
    t.index ["streamer_id"], name: "index_donations_on_streamer_id"
  end

  create_table "incoming_transactions", force: :cascade do |t|
    t.integer "coin_id"
    t.integer "donation_id"
    t.string "address", null: false
    t.string "tx_id", null: false
    t.integer "block"
    t.decimal "amount", precision: 18, scale: 8
    t.integer "confirmations", default: 0
    t.string "state", default: "pending"
    t.boolean "bip125_replaceable", default: true
    t.boolean "trusted", default: false
    t.integer "received_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_incoming_transactions_on_coin_id"
    t.index ["donation_id"], name: "index_incoming_transactions_on_donation_id"
  end

  create_table "ledger_entries", force: :cascade do |t|
    t.integer "streamer_id"
    t.integer "coin_id"
    t.integer "donation_id"
    t.integer "donation_payment_id"
    t.integer "withdrawal_id"
    t.decimal "amount", precision: 18, scale: 8
    t.decimal "balance", precision: 18, scale: 8
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_ledger_entries_on_coin_id"
    t.index ["donation_id"], name: "index_ledger_entries_on_donation_id"
    t.index ["donation_payment_id"], name: "index_ledger_entries_on_donation_payment_id"
    t.index ["streamer_id", "coin_id"], name: "index_ledger_entries_on_streamer_id_and_coin_id"
    t.index ["streamer_id", "donation_id"], name: "index_ledger_entries_on_streamer_id_and_donation_id"
    t.index ["streamer_id", "donation_payment_id"], name: "index_ledger_entries_on_streamer_id_and_donation_payment_id"
    t.index ["streamer_id"], name: "index_ledger_entries_on_streamer_id"
    t.index ["withdrawal_id"], name: "index_ledger_entries_on_withdrawal_id"
  end

  create_table "streamers", force: :cascade do |t|
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
    t.string "profile_photo_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider", "uid"], name: "index_streamers_on_provider_and_uid", unique: true
    t.index ["provider"], name: "index_streamers_on_provider"
    t.index ["uid"], name: "index_streamers_on_uid"
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
