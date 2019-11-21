class WalletService

  attr_reader :adapter, :coin

  def initialize(coin)
    @coin = coin
    @adapter = adapterize(coin)
    self.class.send(:include, @adapter)
  end

  private

  def adapterize(coin)
    clazz = {
      "btc" => "bitcoin",
      "ltc" => "litecoin",
      "doge" => "dogecoin",
      "dash" => "dash",
      "bch" => "bitcoin_cash"
    }[coin.to_s.downcase]
    "#{clazz.classify}::Wallet".constantize rescue raise("unknown adapter")
  end
end
