# == Schema Information
#
# Table name: crypto_payments
#
#  id           :integer          not null, primary key
#  coin_id      :integer
#  donation_id  :integer
#  state        :string           default("pending")
#  tx_id        :string           not null
#  amount       :decimal(18, 8)
#  block        :integer
#  detected_at  :datetime
#  confirmed_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CryptoPayment < ApplicationRecord

    belongs_to :donation, required: true
    belongs_to :coin, required: true





end
