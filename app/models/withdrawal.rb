class Withdrawal < ApplicationRecord

  FEE_PERCENTAGE = 1

  belongs_to :streamer, required: true
  belongs_to :coin, required: true
  has_one :ledger_entry

  before_validation :calculate_fee, on: :create
  before_validation :calculate_withdrawal_amount, on: :create

  validates :address, presence: true, on: :create
  validates :amount, numericality: { greater_than: 0 }, on: :create
  validates :fee, numericality: { greater_than_or_equal_to: :fee_minimum }, on: :create
  validates :withdrawal_amount, numericality: { greater_than: 0 }, on: :create
  validate :valid_address, on: :create
  validate :enough_balance, on: :create

  after_create :block_amount!

  state_machine initial: "unconfirmed" do
    state "confirmed"
    state "cancelled"

    event :confirm do
      transition "unconfirmed" => "confirmed"
    end
    event :cancel do
      transition "unconfirmed" => "cancelled"
    end
  end

  def confirm!
    self.transaction do
      super
      streamer.balance(coin).unblock!( amount )
      create_ledger_entry!
    end
  end

  def fee_minimum
    coin.min_tx_fee
  end

  private

  def block_amount!
    # user.lock_balance!(asset.ticker) do
      streamer.balance(coin).block!( amount )
    # end
  end

  def enough_balance
    self.errors.add(:streamer, :insufficient_funds) unless enough_balance?
  end

  def enough_balance?
    streamer.balance(coin).available >= amount.to_f
  end

  def valid_address
    self.errors.add(:address, :invalid) unless valid_address?
  end

  def valid_address?
    # WalletService.new(coin).valid_address?(address)
    true
  end

  def calculate_fee
    if amount.to_d > 0
      fee_value = amount.to_d / 100.0 * FEE_PERCENTAGE
      fee_value = fee_minimum if fee_value < fee_minimum
      self.fee = fee_value
    end
  end

  def calculate_withdrawal_amount
    self.withdrawal_amount = amount - fee
  end

  def create_ledger_entry!
    raise "already created ledger_entry" if ledger_entry.present?
    streamer.ledger_entries.create!(coin: self.coin, withdrawal: self, amount: -self.amount)
  end

end

# == Schema Information
#
# Table name: withdrawals
#
#  id                :integer          not null, primary key
#  address           :string           not null
#  amount            :decimal(15, 7)
#  fee               :decimal(15, 7)
#  state             :string           default("unconfirmed")
#  withdrawal_amount :decimal(15, 7)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  coin_id           :integer
#  streamer_id       :integer
#
# Indexes
#
#  index_withdrawals_on_coin_id      (coin_id)
#  index_withdrawals_on_streamer_id  (streamer_id)
#
