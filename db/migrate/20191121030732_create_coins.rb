class CreateCoins < ActiveRecord::Migration[6.0]
  def change
    create_table :coins do |t|
      t.string :name
      t.string :symbol
      t.text :description
      t.decimal :price, precision: 15, scale: 7
      t.decimal :min_tx_fee, precision: 15, scale: 7
      t.timestamps
    end

    Coin.create(name: "Bitcoin", symbol: "BTC", price: 10_000, min_tx_fee: 0.0002)
    Coin.create(name: "Bitcoin Cash", symbol: "BCH", price: 100, min_tx_fee: 0.04)
    Coin.create(name: "DogeCoin", symbol: "DOGE", price: 0.000025, min_tx_fee: 300)
    Coin.create(name: "DASH", symbol: "DASH", price: 75, min_tx_fee: 0.01)
    Coin.create(name: "Litecoin", symbol: "LTC", price: 50, min_tx_fee: 0.01)
  end
end
