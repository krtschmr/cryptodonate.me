class CreateWithdrawals < ActiveRecord::Migration[6.0]
  def change
    create_table :withdrawals do |t|
      t.belongs_to :user
      t.belongs_to :coin
      t.belongs_to :crypto_withdrawal

      t.string :address
      # this comes latest

      t.timestamps
    end
  end
end
