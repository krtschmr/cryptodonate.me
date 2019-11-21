class LedgerEntry < ApplicationRecord
end

# == Schema Information
#
# Table name: ledger_entries
#
#  id                :integer          not null, primary key
#  amount            :decimal(18, 8)
#  type              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  coin_id           :integer
#  crypto_payment_id :integer
#  donation_id       :integer
#  user_id           :integer
#  withdrawal_id     :integer
#
# Indexes
#
#  index_ledger_entries_on_coin_id                       (coin_id)
#  index_ledger_entries_on_crypto_payment_id             (crypto_payment_id)
#  index_ledger_entries_on_donation_id                   (donation_id)
#  index_ledger_entries_on_type                          (type)
#  index_ledger_entries_on_user_id                       (user_id)
#  index_ledger_entries_on_user_id_and_coin_id           (user_id,coin_id)
#  index_ledger_entries_on_user_id_and_coin_id_and_type  (user_id,coin_id,type)
#  index_ledger_entries_on_user_id_and_type              (user_id,type)
#  index_ledger_entries_on_withdrawal_id                 (withdrawal_id)
#
