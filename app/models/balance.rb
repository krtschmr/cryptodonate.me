class Balance < ApplicationRecord
  class CantUpdate < StandardError; end;

  belongs_to :streamer, required: true
  validates :coin, presence: true
  validates_numericality_of :balance, greater_than_or_equal_to: 0
  validates_numericality_of :available, greater_than_or_equal_to: 0
  validates_numericality_of :reserved, greater_than_or_equal_to: 0

  before_validation do
    self.available = balance - reserved
  end

  def total
    balance
  end

  def referenced_coin
    Coin.find_by(symbol: coin)
  end

  def add!(amount)
    update( balance: balance+amount)
  end

  def deduct!(amount)
    amount = -amount if amount < 0 # ensure amount is positive
    update(balance: balance - amount)
  end

  def block!(amount)
    update(reserved: reserved+amount)
  end

  def unblock!(amount)
    update(reserved: reserved - amount)
  end

  def update(args)
    if super(args)
      self
    else
      raise CantUpdate.new("can't update balance #{self.errors}")
    end
  end

end

# == Schema Information
#
# Table name: balances
#
#  id          :integer          not null, primary key
#  available   :decimal(18, 8)   default(0.0)
#  balance     :decimal(18, 8)   default(0.0)
#  coin        :string(20)       not null
#  reserved    :decimal(18, 8)   default(0.0)
#  streamer_id :integer          not null
#
# Indexes
#
#  index_balances_on_coin                  (coin)
#  index_balances_on_streamer_id           (streamer_id)
#  index_balances_on_streamer_id_and_coin  (streamer_id,coin) UNIQUE
#
