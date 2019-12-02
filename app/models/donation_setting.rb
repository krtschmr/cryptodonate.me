class DonationSetting < ApplicationRecord

  SUPPORTED_CURRENCIES = ["USD"]

  belongs_to :streamer

  validates :converted_currency, inclusion: { in: SUPPORTED_CURRENCIES }
  validates :minimum_amount_for_notification, numericality: { greater_than_or_equal_to: 0, less_than: 1_000 }
end

# == Schema Information
#
# Table name: donation_settings
#
#  id                              :integer          not null, primary key
#  converted_currency              :string           default("USD")
#  minimum_amount_for_notification :decimal(6, 2)    default(1.0)
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  streamer_id                     :integer
#
# Indexes
#
#  index_donation_settings_on_streamer_id  (streamer_id)
#
