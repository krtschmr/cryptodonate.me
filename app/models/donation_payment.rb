class DonationPayment < ApplicationRecord

      belongs_to :coin, required: true
      belongs_to :donation, required: true
      belongs_to :incoming_transaction, required: true
      has_one :ledger_entry

      scope :confirmed, ->{ where state: :confirmed}

      after_initialize { self.coin ||= donation.coin }
      before_create :set_usd_value

      after_commit :detection_callback, on: :create
      after_commit :confirmation_callback, on: :update, if: :confirmed?

      state_machine initial: "detected" do
        state "confirmed" do
          validates :block, numericality: {greater_than: 0}
          validates :confirmed_at, presence: true
        end
        event :confirm do
          transition "detected" => "confirmed"
        end
      end

      private

      def set_usd_value
        self.usd_value = calculated_usd_value
      end

      def calculated_usd_value
        coin.price * amount
      end

      def detection_callback
        donation.detect!
      end

      def confirmation_callback
        create_ledger_entry!
        mark_donation_as_paid!
      end

      def create_ledger_entry!
        raise "already created ledger_entry" if ledger_entry.present?
        donation.streamer.ledger_entries.create!(coin: self.coin, donation: self.donation, donation_payment: self, amount: self.amount)
      end

      def mark_donation_as_paid!
        donation.recalculate_usd_value!
        donation.paid! unless donation.paid?
      end
end

# == Schema Information
#
# Table name: donation_payments
#
#  id                      :integer          not null, primary key
#  amount                  :decimal(18, 8)
#  block                   :integer
#  confirmed_at            :datetime
#  detected_at             :datetime
#  state                   :string           default("detected")
#  usd_value               :decimal(10, 2)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  coin_id                 :integer
#  donation_id             :integer
#  incoming_transaction_id :integer
#  tx_id                   :string           not null
#
# Indexes
#
#  index_donation_payments_on_coin_id                  (coin_id)
#  index_donation_payments_on_donation_id              (donation_id)
#  index_donation_payments_on_incoming_transaction_id  (incoming_transaction_id)
#
