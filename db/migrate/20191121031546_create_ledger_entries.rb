class CreateLedgerEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :ledger_entries do |t|
      t.belongs_to :user, index: true
      t.belongs_to :coin, index: true
      t.string :type, null: false, index: true

      t.belongs_to :donation
      t.belongs_to :crypto_payment
      t.belongs_to :withdrawal

      t.decimal :amount, precision: 18, scale: 8
      t.timestamps
    end
    add_index :ledger_entries, [:user_id, :coin_id]
    add_index :ledger_entries, [:user_id, :coin_id, :type]
    add_index :ledger_entries, [:user_id, :type]
  end


end
