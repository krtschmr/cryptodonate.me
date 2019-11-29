class Coin < ApplicationRecord

  has_many :donation_payments
  has_many :incoming_transactions
  has_many :payment_addresses

  def to_s
    symbol
  end

end

# == Schema Information
#
# Table name: coins
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  price       :decimal(15, 7)
#  symbol      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
