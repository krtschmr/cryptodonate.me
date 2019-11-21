class Withdrawal < ApplicationRecord
end

# == Schema Information
#
# Table name: withdrawals
#
#  id                   :integer          not null, primary key
#  address              :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  coin_id              :integer
#  crypto_withdrawal_id :integer
#  user_id              :integer
#
# Indexes
#
#  index_withdrawals_on_coin_id               (coin_id)
#  index_withdrawals_on_crypto_withdrawal_id  (crypto_withdrawal_id)
#  index_withdrawals_on_user_id               (user_id)
#
