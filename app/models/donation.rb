# == Schema Information
#
# Table name: donations
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  coin_id           :integer
#  uuid              :string(36)       not null
#  state             :string           default("unpaid")
#  payment_address   :string
#  name              :string(22)
#  message           :string
#  currency          :string
#  amount            :decimal(9, 2)
#  total_paid_fiat   :decimal(9, 2)
#  total_paid_crypto :decimal(18, 2)
#  alert_created     :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

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
