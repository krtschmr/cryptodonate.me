module Bitcoin::Wallet

  def generate_address
    $bitcoin_rpc.getnewaddress("myaddress", "bech32")
  end

  # def get_transaction(tx_id)
  #   $bitcoin_rpc.gettransaction(tx_id)
  # end
  #
  # def confirmed?(tx_id)
  #   confirmations(tx_id) > 0
  # end
  #
  # def confirmations(tx_id)
  #   get_transaction(tx_id)["confirmations"]
  # end
  #
  # def payment_amount(tx_id)
  #   get_transaction(tx_id)["amount"].to_d
  # end
  #
  # def blockheight
  #   $bitcoin_rpc.getblockchaininfo.fetch("blocks")
  # end
  #
  # def create_transaction!(args={})
  #   $bitcoin_rpc.sendtoaddress(args.fetch(:address), args.fetch(:amount))
  # end

end
