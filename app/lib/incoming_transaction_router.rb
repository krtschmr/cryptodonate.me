# takes a coin and a tx_id
# creates or updates an IncomingTransaction
# will be called via walletnotify='' from the daemon

class IncomingTransactionRouter

  def self.process(coin, tx_id)
    @coin = Coin.find_by(symbol: coin.to_s.upcase)

    service = WalletService.new(coin)
    tx = service.get_transaction(tx_id)

    incoming = IncomingTransaction.find_or_initialize_by(coin: @coin, tx_id: tx_id, address: tx["details"].first["address"]) do |t|
      t.bip125_replaceable = (tx["bip125-replaceable"] == "yes")
      t.received_at = tx["timereceived"]
      t.amount = tx["details"].first["amount"]
    end
    if tx["confirmations"] >= 1
      incoming.confirmations = tx["confirmations"]
      incoming.block = (service.blockheight - tx["confirmations"] + 1)
    end
    incoming.save
    incoming
  end

end
