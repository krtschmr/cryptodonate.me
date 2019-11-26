class CreateLedgerEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :ledger_entries do |t|
      t.belongs_to :streamer, index: true
      t.belongs_to :coin, index: true

      t.belongs_to :donation, index: true
      t.belongs_to :donation_payment, index: true
      t.belongs_to :withdrawal

      t.decimal :amount, precision: 18, scale: 8
      t.decimal :balance, precision: 18, scale: 8
      t.timestamps
    end
    add_index :ledger_entries, [:streamer_id, :coin_id]
    add_index :ledger_entries, [:streamer_id, :donation_id]
    add_index :ledger_entries, [:streamer_id, :donation_payment_id]
  end


end
