class CreatePaymentAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_addresses do |t|
      t.belongs_to :coin, null: false, index: true
      t.belongs_to :donation, null: true, index: true
      t.string :address
      t.boolean :used, default: false
      t.timestamps
    end
    if Rails.env.development?
      b = Coin.first
      service = WalletService.new(:btc)
      25.times do |i|
        b.payment_addresses.create address: service.generate_address
      end
      Coin.where.not(symbol: "BTC").each do |c|
        100.times do |i|
          c.payment_addresses.create address: "address_#{c.symbol}_#{i}"
        end
      end
    end
  end
end
