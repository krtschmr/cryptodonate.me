class CreateDonations < ActiveRecord::Migration[6.0]
  def change
    create_table :donations do |t|
      t.belongs_to :streamer
      # t.belongs_to :coin

      t.string :uuid, null: false, limit: 36
      t.string :state, default: "unpaid"

      # t.string :counter, default: 1

      # who send the money?
      t.string :name, limit: 22
      t.string :message

      # Fiat conversion shizzle
      # t.decimal :amount, precision: 9, scale: 2
      # t.string :currency

      # internally everything gets converted to USD
      # based on USD value we need to convert to
      # bitcoin amount for the payment
      t.decimal :usd_value

      # where to send the money
      # t.string :payment_address
      # t.decimal :payment_amount, precision: 18, scale: 8


      # keep track of how much came to this
      # t.decimal :total_paid_fiat, precision: 9, scale: 2
      # t.decimal :total_paid_crypto, precision: 18, scale: 8

      t.boolean :alert_created, default: false

      t.timestamps
    end
  end
end
