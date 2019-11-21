class CreateDonations < ActiveRecord::Migration[6.0]
  def change
    create_table :donations do |t|
      t.belongs_to :user
      t.belongs_to :coin

      t.string :uuid, null: false, limit: 36
      t.string :state, default: "unpaid"

      t.string :counter, default: 1

      # where to send the money
      t.string :payment_address

      # who send the money?
      t.string :name, limit: 22
      t.string :message

      # Fiat conversion shizzle
      t.string :currency
      t.decimal :amount, precision: 9, scale: 2

      # keep track of how much came to this
      t.decimal :total_paid_fiat, precision: 9, scale: 2
      t.decimal :total_paid_crypto, precision: 18, scale: 2

      t.boolean :alert_created, default: false

      t.timestamps
    end
  end
end
