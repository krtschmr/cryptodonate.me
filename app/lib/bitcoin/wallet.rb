module Bitcoin::Wallet

  def valid_address?(address)
    $bitcoin_rpc.valid_address?(address)
  end

  def set_low_tx_fee
    $bitcoin_rpc.settxfee("0.00001000") # fee per KB equals 1 sat/vbyte
  end

  def blockheight
    $bitcoin_rpc.getblockcount
  end

  def generate_address(type="bech32")
    $bitcoin_rpc.getnewaddress("myaddress", type)
  end

  def get_transaction(tx_id)
    $bitcoin_rpc.gettransaction(tx_id)
  end

  def create_transaction!(args={})
    $bitcoin_rpc.sendtoaddress(args.fetch(:address), args.fetch(:amount))
  end

end
