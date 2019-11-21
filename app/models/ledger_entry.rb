# == Schema Information
#
# Table name: ledger_entries
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  coin_id           :integer
#  type              :string           not null
#  donation_id       :integer
#  crypto_payment_id :integer
#  withdrawal_id     :integer
#  amount            :decimal(18, 8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class LedgerEntry < ApplicationRecord
end
