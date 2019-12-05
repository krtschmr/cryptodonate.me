class CryptoWithdrawal < ApplicationRecord

  belongs_to :streamer, required: true
  belongs_to :coin, required: true
  belongs_to :withdrawal, required: true

  scope :pending, -> { where state: :pending }

  validates :amount, numericality: { greater_than: 0 }

  def self.process!
    pending.each(&:try_to_pay_out!)
  end

  state_machine initial: "pending" do
    state "finished"  do
      validates :tx_id, presence: true
    end
    state "error"

    event :finished do
      transition "pending" => "finished"
    end
    event :error do
      transition "pending" => "error"
    end
  end

  def reset!
    update(state: "pending", exception: nil)
  end

  def try_to_pay_out!
    begin
      service = WalletService.new(coin)
      service.set_low_tx_fee
      self.tx_id = service.create_transaction!(address: withdrawal.address, amount: amount)
      finished!
      withdrawal.finished!
    rescue => e
      self.exception = e
      error!
    end
  end

end

# == Schema Information
#
# Table name: crypto_withdrawals
#
#  id            :integer          not null, primary key
#  amount        :decimal(18, 8)   default(0.0)
#  exception     :text
#  state         :string           default("pending")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  coin_id       :integer
#  streamer_id   :integer
#  tx_id         :string
#  withdrawal_id :integer
#
# Indexes
#
#  index_crypto_withdrawals_on_coin_id        (coin_id)
#  index_crypto_withdrawals_on_streamer_id    (streamer_id)
#  index_crypto_withdrawals_on_withdrawal_id  (withdrawal_id)
#
