class CreateExchangeRates < ActiveRecord::Migration[6.0]
  def change
    create_table :exchange_rates do |t|
      t.string :from, null: false, index: true
      t.string :to, null: false, index: true
      t.decimal :rate, null: false, precision: 15, scale: 6
    end
  end
end
