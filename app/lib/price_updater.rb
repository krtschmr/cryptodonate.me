require "open-uri"

class PriceUpdater

  def self.run
    json = JSON.parse(open("https://api.latoken.com/v2/ticker").read)


    coins = Coin.pluck(:symbol).collect{|s|  "#{s.upcase}/USDT"}
    tickers = json.select{|v| coins.include?(v["symbol"]) }

    Coin.find_each do |coin|
      p "looking_for #{coin.symbol}/USDT"
      price = tickers.select{|v| v["symbol"] == "#{coin.symbol}/USDT"}.first["lastPrice"]
      coin.update(price: price)
    end

  end
end
