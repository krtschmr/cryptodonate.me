class AddressGenerator

  def self.generate(coin, xpubkey, id)
    coin = coin.to_s
    raise ArgumentError.new("xpubkey missing") unless xpubkey.present?
    raise ArgumentError.new("id missing") unless id.present?
    adapter.generate_address(xpubkey, id)
  end

  private

  def self.adapter(coin)
    clazz = {
      "btc" => "bitcoin",
      "ltc" => "litecoin",
      "doge" => "dogecoin",
      "dash" => "dash",
      "bch" => "bitcoin_cash"
    }[coin.to_s.downcase]
    "#{clazz.classify}::AddressGenerator".constantize rescue raise("unknown adapter")
  end
end
