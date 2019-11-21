# == Schema Information
#
# Table name: withdrawals
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  coin_id              :integer
#  crypto_withdrawal_id :integer
#  address              :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Withdrawal < ApplicationRecord
end
