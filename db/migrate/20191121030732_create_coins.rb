class CreateCoins < ActiveRecord::Migration[6.0]
  def change
    create_table :coins do |t|
      t.string :name
      t.string :symbol
      t.text :description
      t.timestamps
    end

    Coin.create name: "Bitcoin", symbol: "BTC"
    Coin.create name: "Bitcoin Cash", symbol: "BCH"
    Coin.create name: "DogeCoin", symbol: "DOGE"
    Coin.create name: "DASH", symbol: "DASH"
    Coin.create name: "Litecoin", symbol: "LTC"
        
  end
end
