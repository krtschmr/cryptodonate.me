class Donation < ApplicationRecord

  # SUPPORTED_CURRENCIES = %W(AUD BRL CAD CHF CZK DKK EUR GBP HKD INR JPY MXN PHP RUB SGD THB USD)

  belongs_to :streamer, required: true
  has_many :donation_payments #, class_name: "DonationPayment"
  has_many :payment_addresses #, autosave: true

  scope :paid, -> { where(state: :paid) }

  validates :uuid, presence: true
  validates_length_of :name, minimum: 2, maximum: 22, allow_blank: true

  before_validation{
    self.uuid ||= SecureRandom.uuid
    self.name = "Anonymous" unless name.present?
  }
  after_commit :generate_payment_addresses, on: :create

  after_commit :try_to_trigger_notfication

  def to_param
    uuid
  end

  def above_minimum?
    # usd_value >= streamer.donation_settings.minimum_amount_for_notification
    true
  end

  def try_to_trigger_notfication
    if paid? && above_minimum? && !alert_created?
      trigger_notification!
    end
  end

  def trigger_notification!
    NotificationTrigger.call(self)
    self.update(alert_created: true)
  end

  def refresh_payment_data!
    self.update(usd_value: donation_payments.confirmed.sum(:usd_value))
  end

  def paid?
    state == "paid"
  end

  private

  # def set_counter
  #   # internal counter so the streamer can see how many donations came per coin.
  #   # we need this to actually derive addrespaid?ses for his xPUBkey
  #   self.counter = streamer.donations.where(coin: coin).maximum(:counter).to_i.next
  # end

  def generate_payment_addresses
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
#  state         :string           default("unpaid")
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
