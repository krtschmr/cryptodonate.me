class IncomingTransaction < ApplicationRecord

  belongs_to :coin, required: true
  belongs_to :payment_address, required: true
  has_one :donation_payment, autosave: true

  validates :tx_id, presence: true
  validates :address, presence: true
  validates :amount, numericality: {greater_than: 0}
  validates :block, numericality: {greater_than: 0, allow_nil: true}
  validates :received_at, presence: true

  before_validation :assign_payment_address, on: :create
  before_create :create_donation_payment
  after_commit :update_donation_payment!, on: :update, if: :confirmed?

  state_machine initial: "pending" do
    state "confirmed" do
      validates :confirmations, numericality: {greater_than: 0}
      validates :block, numericality: {greater_than: 0}
    end
    event :confirm do
      transition "pending" => "confirmed"
    end
  end

  private

  def update_donation_payment!
    donation_payment.block = self.block
    donation_payment.confirmed_at = Time.now
    donation_payment.confirm!
  end

  def assign_payment_address
    self.payment_address = coin.payment_addresses.find_by!(address: self.address)
  end

  def create_donation_payment
    self.donation_payment = payment_address.donation.donation_payments.new do |dp|
      dp.incoming_transaction = self
      dp.coin = coin
      dp.tx_id = tx_id
      dp.amount = amount
      dp.detected_at = Time.now
    end
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
