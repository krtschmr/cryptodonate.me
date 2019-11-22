class IncomingTransaction < ApplicationRecord

  belongs_to :coin, required: true
  belongs_to :donation, optional: true
  has_one :donation_payment, autosave: true

  validates :tx_id, presence: true
  validates :address, presence: true
  validates :amount, numericality: {greater_than: 0}
  validates :block, numericality: {greater_than: 0, allow_nil: true}
  validates :received_at, presence: true

  before_create {
    binding.pry
    # we set the donation, based on coin/address.
    # then we create a new donation payment which will be autosaved on creation
    self.donation = Donation.find_by!(coin: self.coin, payment_address: self.address)
    self.donation_payment = donation.donation_payments.new(incoming_transaction: self, tx_id: self.tx_id, amount: self.amount, detected_at: Time.now)
  }


  def confirmed?
    confirmations >= 1
  end

  def self.process!(coin, tx_id)
    TransactionService.new(coin).process!(tx_id)
  end

end

# == Schema Information
#
# Table name: incoming_transactions
#
#  id                 :integer          not null, primary key
#  address            :string           not null
#  amount             :decimal(18, 8)
#  bip125_replaceable :boolean          default(TRUE)
#  block              :integer
#  confirmations      :integer          default(0)
#  received_at        :integer          not null
#  state              :string           default("pending")
#  trusted            :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  coin_id            :integer
#  donation_id        :integer
#  tx_id              :string           not null
#
# Indexes
#
#  index_incoming_transactions_on_coin_id      (coin_id)
#  index_incoming_transactions_on_donation_id  (donation_id)
#
