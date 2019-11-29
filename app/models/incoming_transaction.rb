class IncomingTransaction < ApplicationRecord

  belongs_to :coin, required: true
  belongs_to :payment_address, required: true
  has_one :donation_payment, autosave: true

  before_validation :assign_payment_address, on: :create
  validates :tx_id, presence: true
  validates :address, presence: true
  validates :amount, numericality: {greater_than: 0}
  validates :block, numericality: {greater_than: 0, allow_nil: true}
  validates :received_at, presence: true


  state_machine initial: "pending" do
    state "confirmed" do
      validates :confirmations, numericality: {greater_than: 0}
    end

    event :confirm do
      transition "pending" => "confirmed"
    end
  end

  # before_create {
  #   self.donation_payment = payment_address.donation.donation_payments.new(
  #     incoming_transaction: self,
  #     coin: coin,
  #     tx_id: tx_id,
  #     amount: amount,
  #     detected_at: Time.now )
  # }
  before_save :try_to_confirm!
  # after_commit {
  #   donation_payment.try_to_confirm! if confirmed?
  # }

  def try_to_confirm!
    unless confirmed?
      self.state = "confirmed" if enough_confirmations?
    end
  end

  def enough_confirmations?
    confirmations >= 1
  end

  def assign_payment_address
    self.payment_address = coin.payment_addresses.find_by!(address: self.address)
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
#  payment_address_id :integer          not null
#  tx_id              :string           not null
#
# Indexes
#
#  index_incoming_transactions_on_coin_id             (coin_id)
#  index_incoming_transactions_on_payment_address_id  (payment_address_id)
#
