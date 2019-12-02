class CreateWithdrawals < ActiveRecord::Migration[6.0]
  def change
    create_table :withdrawals do |t|
      t.belongs_to :streamer
      t.belongs_to :coin

      t.string :state, default: "unconfirmed"

      t.string :address, null: false
      t.decimal :amount, precision: 15, scale: 7
      t.decimal :fee, precision: 15, scale: 7
      t.decimal :withdrawal_amount, precision: 15, scale: 7

      t.timestamps
    end
  end
end
