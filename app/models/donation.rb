class Donation < ApplicationRecord

  SUPPORTED_CURRENCIES = %W(USD EUR THB)

  belongs_to :streamer, required: true
  belongs_to :coin, required: true
  has_many :donation_payments #, class_name: "DonationPayment"

  scope :paid, -> { where "total_paid_crypto > 0" }


  validates :uuid, presence: true
  validates :amount, numericality: {greater_than: 0}
  validates :currency, inclusion: {in: SUPPORTED_CURRENCIES}
  validates_length_of :name, minimum: 2, maximum: 22, allow_blank: true

  # state_machine(initial: "unpaid") do
  #   # state :paid do
  #   #   validates :total_paid_crypto, numericality: {greater_than: 0}
  #   #   validates :total_paid_fiat, numericality: {greater_than: 0}
  #   # end
  #   # event :mark_as_paid do
  #   #   transition :unpaid => :paid
  #   # end
  # end

  before_validation do
    self.uuid ||= SecureRandom.uuid
  end

  before_create {
    set_payment_address
    set_counter
  }

  def to_param
    uuid
  end

  def above_minimum?
    # total_paid_fiat >= streamer.donation_settings.minimum_amount_for_notification
    true
  end

  def trigger_notification!
    NotificationTrigger.call(self)
  end

  private

  def set_counter
    # internal counter so the streamer can see how many donations came per coin.
    # we need this to actually derive addresses for his xPUBkey
    self.counter = streamer.donations.where(coin: coin).maximum(:counter).to_i.next
  end

  def set_payment_address
    self.payment_address = generate_payment_address
  end

  def generate_payment_address
    if streamer.provided_own_key?(coin)
      address = AddressGenerator.generate(coin, streamer.xpubkey(coin), counter)
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
#  payment_amount    :decimal(18, 8)
#  state             :string           default("unpaid")
#  total_paid_crypto :decimal(18, 8)
#  total_paid_fiat   :decimal(9, 2)
#  usd_value         :decimal(, )
#  uuid              :string(36)       not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  coin_id           :integer
#  streamer_id       :integer
#
# Indexes
#
#  index_donations_on_coin_id      (coin_id)
#  index_donations_on_streamer_id  (streamer_id)
#
