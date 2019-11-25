class Coin < ApplicationRecord

  has_many :donations
  has_many :donation_payments
  has_many :incoming_transactions

  def to_s
    symbol
  end

  def confirmations_required
    1
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
