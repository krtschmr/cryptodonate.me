class LedgerEntry < ApplicationRecord

  belongs_to :coin, required: true
  belongs_to :streamer, required: true

  belongs_to :donation, optional: true
  belongs_to :donation_payment, optional: true
  belongs_to :withdrawal, optional: true

  validates :amount, presence: true, numericality: {other_than: 0}

  before_create :update_balances

  private

  def update_balances
    bal = streamer.balance(coin)
    if donation.present?
      bal.add!(amount)
    elsif withdrawal.present?
      bal.deduct!(amount)
    else
      raise "unknown relation"
    end
    self.balance = bal.balance #update new_balance
  end

end


# == Schema Information
#
# Table name: ledger_entries
#
#  id                  :integer          not null, primary key
#  amount              :decimal(18, 8)
#  balance             :decimal(18, 8)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  coin_id             :integer
#  donation_id         :integer
#  donation_payment_id :integer
#  streamer_id         :integer
#  withdrawal_id       :integer
#
# Indexes
#
#  index_ledger_entries_on_coin_id                              (coin_id)
#  index_ledger_entries_on_donation_id                          (donation_id)
#  index_ledger_entries_on_donation_payment_id                  (donation_payment_id)
#  index_ledger_entries_on_streamer_id                          (streamer_id)
#  index_ledger_entries_on_streamer_id_and_coin_id              (streamer_id,coin_id)
#  index_ledger_entries_on_streamer_id_and_donation_id          (streamer_id,donation_id)
#  index_ledger_entries_on_streamer_id_and_donation_payment_id  (streamer_id,donation_payment_id)
#  index_ledger_entries_on_withdrawal_id                        (withdrawal_id)
#
