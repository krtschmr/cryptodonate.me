class Donation < ApplicationRecord

  SUPPORTED_CURRENCIES = %W(AUD BRL CAD CHF CZK DKK EUR GBP HKD INR JPY MXN PHP RUB SGD THB USD)


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
    set_payment_amount
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

  def refresh_payment_data!
    amount_received = donation_payments.confirmed.sum(:amount)
    self.total_paid_crypto = amount_received

    # the amount we received is the exact amount we asked for. the user didn't pay more or less
    # and the user paid within 10 minutes (TODO implemenmt time check!). so we can say, that the user paid the typed in fiat amount
    if amount_received != payment_amount
      # set the payment amount
      # calculate the USD Value of the donation
      # recalculate the fiat_value in the selected currency
      self.payment_amount = amount_received
      self.usd_value = payment_amount * coin.price
      self.amount = if currency == "USD"
        usd_value
      else
        Money.new(usd_value * 100, "USD").exchange_to(currency)
      end
    end
    self.state = "paid"
    self.save
  end

  def paid?
    total_paid_crypto.to_d > 0
  end

  private


  def set_payment_amount
    self.payment_amount = calculated_usd_value.to_d / coin.price
  end

  # 8b7182b86c6749cdb3c69175d201565d
  def calculated_usd_value
    if currency == "USD"
      amount
    else
      Money.new(amount * 100, currency).exchange_to("USD").to_d
    end
  end

  def set_counter
    # internal counter so the streamer can see how many donations came per coin.
    # we need this to actually derive addrespaid?ses for his xPUBkey
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
