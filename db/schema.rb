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

ActiveRecord::Schema.define(version: 2019_12_04_023936) do

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
    t.decimal "min_tx_fee", precision: 15, scale: 7
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "connected_platforms", force: :cascade do |t|
    t.integer "streamer_id"
    t.string "provider", null: false
    t.string "uid"
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
    t.integer "streamer_id"
    t.integer "coin_id"
    t.integer "withdrawal_id"
    t.string "state", default: "pending"
    t.decimal "amount", precision: 18, scale: 8, default: "0.0"
    t.string "tx_id"
    t.text "exception"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_crypto_withdrawals_on_coin_id"
    t.index ["streamer_id"], name: "index_crypto_withdrawals_on_streamer_id"
    t.index ["withdrawal_id"], name: "index_crypto_withdrawals_on_withdrawal_id"
  end

  create_table "donation_page_stylings", force: :cascade do |t|
    t.integer "streamer_id"
    t.string "bg", default: "#eff1f4"
    t.string "header_bg", default: "#122332"
    t.string "photo_border_color", default: "#fff"
    t.string "h1_color", default: "#fff"
    t.string "h2_color", default: "#eee"
    t.string "body_bg", default: "#fff"
    t.string "body_color", default: "#333"
    t.string "btn_bg", default: "#1652f0"
    t.string "btn_color", default: "#fff"
    t.integer "border_radius", default: 10
    t.integer "photo_border_radius", default: 8
    t.integer "photo_border_width", default: 4
    t.integer "photo_size", default: 85
    t.integer "h1_size", default: 20
    t.integer "h2_size", default: 14
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "info_text", default: "Thanks for your donation"
    t.index ["streamer_id"], name: "index_donation_page_stylings_on_streamer_id"
  end

  create_table "donation_payments", force: :cascade do |t|
    t.integer "coin_id"
    t.integer "donation_id"
    t.integer "incoming_transaction_id"
    t.string "state", default: "detected"
    t.string "tx_id", null: false
    t.decimal "amount", precision: 18, scale: 8
    t.decimal "usd_value", precision: 10, scale: 2
    t.integer "block"
    t.datetime "detected_at"
    t.datetime "confirmed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_donation_payments_on_coin_id"
    t.index ["donation_id"], name: "index_donation_payments_on_donation_id"
    t.index ["incoming_transaction_id"], name: "index_donation_payments_on_incoming_transaction_id"
  end

  create_table "donation_settings", force: :cascade do |t|
    t.integer "streamer_id"
    t.string "converted_currency", default: "USD"
    t.decimal "minimum_amount_for_notification", precision: 6, scale: 2, default: "1.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["streamer_id"], name: "index_donation_settings_on_streamer_id"
  end

  create_table "donations", force: :cascade do |t|
    t.integer "streamer_id"
    t.string "uuid", limit: 36, null: false
    t.string "state", default: "pending"
    t.string "name", limit: 22
    t.string "message"
    t.decimal "usd_value"
    t.boolean "alert_created", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["streamer_id"], name: "index_donations_on_streamer_id"
  end

  create_table "incoming_transactions", force: :cascade do |t|
    t.integer "coin_id"
    t.integer "payment_address_id", null: false
    t.string "state", default: "pending"
    t.string "address", null: false
    t.string "tx_id", null: false
    t.integer "block"
    t.decimal "amount", precision: 18, scale: 8
    t.integer "confirmations", default: 0
    t.boolean "bip125_replaceable", default: true
    t.boolean "trusted", default: false
    t.integer "received_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_incoming_transactions_on_coin_id"
    t.index ["payment_address_id"], name: "index_incoming_transactions_on_payment_address_id"
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

  create_table "payment_addresses", force: :cascade do |t|
    t.integer "coin_id", null: false
    t.integer "donation_id"
    t.string "address"
    t.boolean "used", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_payment_addresses_on_coin_id"
    t.index ["donation_id"], name: "index_payment_addresses_on_donation_id"
  end

  create_table "streamers", force: :cascade do |t|
    t.string "uuid", null: false
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
    t.integer "streamer_id"
    t.integer "coin_id"
    t.string "state", default: "unconfirmed"
    t.string "address", null: false
    t.decimal "amount", precision: 15, scale: 7
    t.decimal "fee", precision: 15, scale: 7
    t.decimal "withdrawal_amount", precision: 15, scale: 7
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_withdrawals_on_coin_id"
    t.index ["streamer_id"], name: "index_withdrawals_on_streamer_id"
  end

end
