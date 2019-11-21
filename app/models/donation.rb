class Donation < ApplicationRecord

  belongs_to :user, required: true
  belongs_to :coin, required: true
  has_many :crypto_payments

  alias_method :streamer, :user

  before_create {
    self.uuid ||= SecureRandom.uuid

  }

  def to_param
    uuid
  end

end

# == Schema Information
#
# Table name: donations
#
#  id                :integer          not null, primary key
#  alert_created     :boolean          default(FALSE)
#  amount            :decimal(9, 2)
#  counter           :string           default("1")
#  currency          :string
#  message           :string
#  name              :string(22)
#  payment_address   :string
#  state             :string           default("unpaid")
#  total_paid_crypto :decimal(18, 2)
#  total_paid_fiat   :decimal(9, 2)
#  uuid              :string(36)       not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  coin_id           :integer
#  user_id           :integer
#
# Indexes
#
#  index_donations_on_coin_id  (coin_id)
#  index_donations_on_user_id  (user_id)
#
