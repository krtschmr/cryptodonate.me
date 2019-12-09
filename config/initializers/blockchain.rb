 # bitcoind --testnet \
 # --bind=192.168.1.40 \
 # --rpcallowip=192.168.1.36 \
 # --rpcpassword=test \
 # --rpcuser=test \
 # --rpcport=20100 \
 # --rpcbind=192.168.1.40
 # --walletnotify="bash /bitcoin/notify.sh %s"

# notify.sh
# bin/rails runner "IncomingTransactionRouter.process(:btc, $1)"



$bitcoin_rpc = BitcoreRPC.new(
  user: (ENV['BITCOIN_RPC_USER'] || "test"),
  password: (ENV['BITCOIN_RPC_PASS'] || "test"),
  host: (ENV['BITCOIN_RPC_HOST'] || "192.168.1.40"),
  port: (ENV['BITCOIN_RPC_PORT'] || 20100),
  debug: Rails.env.development?
)
