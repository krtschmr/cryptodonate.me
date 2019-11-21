class Donation < ApplicationRecord

  SUPPORTED_CURRENCIES = %W(USD EUR THB)

  belongs_to :user, required: true
  belongs_to :coin, required: true
  has_many :crypto_payments

  alias_method :streamer, :user

  validates :amount, numericality: {greater_than: 0}
  validates :currency, inclusion: {in: SUPPORTED_CURRENCIES}
  validates_length_of :name, minimum: 2, maximum: 22, allow_blank: true

  state_machine :initial => :unpaid do
    state :paid do
      validates :total_paid_crypto, numericality: {greater_than: 0}
      validates :total_paid_fiat, numericality: {greater_than: 0}
    end
    event :mark_as_paid do
      transition :unpaid => :paid
    end
  end

  before_create {
    self.uuid ||= SecureRandom.uuid
    set_counter
    set_payment_address
  }

  def to_param
    uuid
  end

  def donation.above_minimum?
    # total_paid_fiat >= user.donation_settings.minimum_amount_for_notification
  end

  def trigger_notification!
    NotificationTrigger.call(self)
  end

  private

  def set_counter
    # internal counter so the user can see how many donations came per coin.
    # we need this to actually derive addresses for his xPUBkey
    self.counter = user.donations.where(coin: coin).maximum(:counter).next
  end

  def set_payment_address
    self.payment_address = generate_payment_address
  end

  def generate_payment_address
    if user.provided_own_key?(coin)
      address = AddressGenerator.generate(coin, user.xpubkey(coin), counter)
      # TODO
      # add this address into our node as an watchonly address
      address
    else
      WalletService.new(coin).generate_address
    end
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
