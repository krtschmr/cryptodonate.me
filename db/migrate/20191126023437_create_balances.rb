class CreateBalances < ActiveRecord::Migration[6.0]
  def change
    create_table :balances do |t|
      t.references :streamer, null: false, index: true
      t.string :coin, limit: 20, null: false, index: true
      t.decimal :balance, precision: 18, scale: 8, default: 0
      t.decimal :reserved, precision: 18, scale: 8, default: 0
      t.decimal :available, precision: 18, scale: 8, default: 0
    end

    add_index :balances, [:streamer_id, :coin], unique: true
    
    # execute <<-SQL
    #   ALTER TABLE account_balances
    #    ADD CONSTRAINT coin_check
    #      CHECK (upper(asset) = asset);
    #   SQL
  end
end
