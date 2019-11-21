class CreateCryptoWithdrawals < ActiveRecord::Migration[6.0]
  def change
    create_table :crypto_withdrawals do |t|

      t.timestamps
    end
  end
end
