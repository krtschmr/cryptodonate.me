class CreateIncomingTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :incoming_transactions do |t|
      t.belongs_to :coin
      t.belongs_to :donation, null: true
      t.string :address, null: false
      t.string :tx_id, null: false
      t.integer :block
      t.decimal :amount, precision: 18, scale: 8
      t.integer :confirmations, default: 0
      t.string :state, default: "pending"
      t.boolean :bip125_replaceable, default: true
      t.boolean :trusted, default: false
      t.integer :received_at, null: false
      t.timestamps
    end
  end
end
