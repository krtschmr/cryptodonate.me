class ExchangeRate < ApplicationRecord

  def self.get_rate(from_iso_code, to_iso_code)
    rate = find_by(from: from_iso_code, to: to_iso_code)
    rate.present? ? rate.rate : nil
  end

  def self.add_rate(from_iso_code, to_iso_code, rate)
    exrate = find_or_initialize_by(from: from_iso_code, to: to_iso_code)
    exrate.rate = rate
    exrate.save!
  end
  
end

# == Schema Information
#
# Table name: exchange_rates
#
#  id   :integer          not null, primary key
#  from :string           not null
#  rate :decimal(15, 6)   not null
#  to   :string           not null
#
# Indexes
#
#  index_exchange_rates_on_from  (from)
#  index_exchange_rates_on_to    (to)
#
