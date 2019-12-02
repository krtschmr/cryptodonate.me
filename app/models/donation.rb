class Donation < ApplicationRecord

  belongs_to :streamer, required: true
  has_many :donation_payments
  has_many :payment_addresses

  scope :paid, -> { where(state: :paid) }

  validates :uuid, presence: true
  validates_length_of :name, minimum: 2, maximum: 22, allow_blank: true

  after_initialize do
    self.uuid ||= SecureRandom.uuid
    self.name = "Anonymous" unless name.present?
  end

  after_create_commit :assign_payment_addresses
  after_commit :trigger_notification, if: :paid?, unless: :alert_created?

  state_machine initial: "pending" do
    state "paid"
    state "expired"

    event :paid do
      transition "pending" => "paid"
    end
    event :expire do
      transition "pending" => "expired"
    end
  end

  def to_param
    uuid
  end

  def above_minimum?
    # usd_value >= streamer.donation_settings.minimum_amount_for_notification
    true
  end

  def trigger_notification(force=false)
    if (paid? && above_minimum? && !alert_created?) || force
      trigger_notification!
    end
  end

  # def refresh_payment_data!
  #   self.update(usd_value: donation_payments.confirmed.sum(:usd_value))
  # end

  def converted_amount
    Money.new(usd_value * 100, "USD").exchange_to(display_currency)
  end

  def converted_currency
    "USD"
  end


  private

  def trigger_notification!
    NotificationTrigger.call(self)
    self.update_column(:alert_created, true)
  end

  # def set_counter
  #   # internal counter so the streamer can see how many donations came per coin.
  #   # we need this to actually derive addrespaid?ses for his xPUBkey
  #   self.counter = streamer.donations.where(coin: coin).maximum(:counter).to_i.next
  # end

  def assign_payment_addresses
    # if streamer.provided_own_key?(coin)
    #   address = AddressGenerator.generate(coin, streamer.xpubkey(coin), counter)
    #   # TODO
    #   # add this address into our node as an watchonly address
    #   address
    # else
      # WalletService.new(coin).generate_address\
    Coin.find_each do |coin|
      coin.payment_addresses.unused.first.update(donation: self)
    end
    # end
  end

end
