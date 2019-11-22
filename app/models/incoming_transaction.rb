class IncomingTransaction < ApplicationRecord

  belongs_to :coin, required: true
  belongs_to :donation, optional: true

  validates :tx_id, presence: true
  validates :address, presence: true
  validates :amount, numericality: {greater_than: 0}
  validates :block, numericality: {greater_than: 0, allow_nil: true}
  validates :received_at, presence: true


  # alias_method :replaceable?, :bip125_replaceable?

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
