class Donation < ApplicationRecord

  TIME_LIMIT = 30

  belongs_to :streamer, required: true
  has_many :donation_payments
  has_many :payment_addresses

  scope :paid, -> { where(state: :paid) }

  validates :uuid, presence: true
  validates_length_of :name, minimum: 2, maximum: 22, allow_blank: true

  after_initialize do
    self.uuid ||= SecureRandom.uuid
    self.name = "Anonymous" unless name.present?
    expired?

  end

  after_create_commit :assign_payment_addresses
  after_commit :trigger_notification, on: :update, if: :can_trigger_notification?, unless: :alert_created?

  state_machine initial: "pending" do
    state "detected"
    state "paid"
    state "expired"

    event :detect do
      transition "pending" => "detected"
    end
    event :paid do
      transition ["pending", "detected"] => "paid"
    end
    event :expire do
      transition "pending" => "expired"
    end
  end

  def expired?
    expire_if_neccessary!
    super
  end

  def expire_if_neccessary!
    if state == "pending" && time_up?
      expire!
    end
  end

  def seconds_left
    seconds = ((created_at + TIME_LIMIT.minutes) - Time.now).to_i
    seconds > 0 ? seconds : 0
  end

  def time_up?
    created_at.present? && created_at < TIME_LIMIT.minutes.ago rescue false
  end

  def identifier
    uuid.split("-").first
  end

  def to_param
    uuid
  end

  def above_minimum?
    usd_value.to_d >= streamer.donation_setting.minimum_amount_for_notification
  end

  def can_trigger_notification?
    (paid? && above_minimum?) || streamer.donation_setting.allow_zero_conf
  end

  def trigger_notification(force=false)
    if (can_trigger_notification? && !alert_created?) || force
      trigger_notification!
    end
  end

  def recalculate_usd_value!
    self.update_columns(usd_value: donation_payments.confirmed.sum(:usd_value))
  end

  def converted_amount
    Money.new(usd_value * 100, "USD").exchange_to(converted_currency)
  end

  def converted_currency
    streamer.donation_setting.converted_currency
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

# == Schema Information
#
# Table name: donations
#
#  id            :integer          not null, primary key
#  alert_created :boolean          default(FALSE)
#  message       :string
#  name          :string(22)
#  state         :string           default("pending")
#  usd_value     :decimal(, )
#  uuid          :string(36)       not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  streamer_id   :integer
#
# Indexes
#
#  index_donations_on_streamer_id  (streamer_id)
#
