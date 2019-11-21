class CreateCoins < ActiveRecord::Migration[6.0]
  def change
    create_table :coins do |t|
      t.string :name
      t.string :symbol
      t.text :description
      t.timestamps
    end

    Coin.create name: "Bitcoin", symbol: "BTC"
    Coin.create name: "Litecoin", symbol: "LTC"
    Coin.create name: "Doge Coin", symbol: "DOGE"
    Coin.create name: "BTrash", symbol: "BCH"
  end
end
