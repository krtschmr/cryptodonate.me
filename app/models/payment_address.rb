class PaymentAddress < ApplicationRecord

  belongs_to :coin, required: true
  belongs_to :donation, optional: true
  has_many :incoming_transactions

  scope :unused, -> { where(donation_id: nil) }

end

# == Schema Information
#
# Table name: payment_addresses
#
#  id          :integer          not null, primary key
#  address     :string
#  used        :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  coin_id     :integer          not null
#  donation_id :integer
#
# Indexes
#
#  index_payment_addresses_on_coin_id      (coin_id)
#  index_payment_addresses_on_donation_id  (donation_id)
#
