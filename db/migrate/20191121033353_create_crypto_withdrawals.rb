class CreateCryptoWithdrawals < ActiveRecord::Migration[6.0]
  def change
    create_table :crypto_withdrawals do |t|
      t.belongs_to :streamer
      t.belongs_to :coin
      t.belongs_to :withdrawal
      t.string :state, default: "pending"
      t.decimal :amount, precision: 18, scale: 8, default: 0
      t.string :tx_id
      t.text :exception
      t.timestamps
    end
  end
end
