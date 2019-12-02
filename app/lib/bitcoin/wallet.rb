module Bitcoin::Wallet

  # class Transaction < OpenStruct;end;
  # class Transaction::Details < Transaction;end;

  def self.valid_address?(address)
    $bitcoin_rpc.valid_address?(address)
  end


  def blockheight
    $bitcoin_rpc.getblockcount
  end

  def generate_address
    $bitcoin_rpc.getnewaddress("myaddress", "bech32")
    # "1BTC...."
  end

  def get_transaction(tx_id)
    tx = $bitcoin_rpc.gettransaction(tx_id)
    # tx["details"] = Transaction::Details.new(tx["details"].first)
    # Transaction.new(tx)
    tx
  end

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
