class Coin < ApplicationRecord

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
#  symbol      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
