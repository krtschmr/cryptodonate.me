# == Schema Information
#
# Table name: coins
#
#  id          :integer          not null, primary key
#  name        :string
#  symbol      :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Coin < ApplicationRecord
end
