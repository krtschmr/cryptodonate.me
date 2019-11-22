class CryptoPayment < ApplicationRecord

    belongs_to :user, required: true
    belongs_to :donation, required: true
    belongs_to :coin, required: true




end

# == Schema Information
#
# Table name: crypto_payments
#
#  id           :integer          not null, primary key
#  amount       :decimal(18, 8)
#  block        :integer
#  confirmed_at :datetime
#  detected_at  :datetime
#  state        :string           default("pending")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  coin_id      :integer
#  donation_id  :integer
#  tx_id        :string           not null
#
# Indexes
#
#  index_crypto_payments_on_coin_id      (coin_id)
#  index_crypto_payments_on_donation_id  (donation_id)
#
