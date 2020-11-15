class NotificationTrigger

  attr_accessor :donation

  def self.call(donation, force: false)
    new(donation).process(force: force)
  end

  def initialize(donation)
    self.donation = donation
  end

  def process(force: false)
    execute! if minimum_amount_reached? || force
  end

  def execute!
    # Push into active/connected overlays (streamlabs, streamelemetns)
    # Push into our own overlays
    [:streamlabs, :streamelements].each do |provider|
      if donation.streamer.connected_platforms.find_by(provider: provider).present?
        "#{provider}_api".classify.constantize.push_donation(donation)
      end
    end
  end

  private

  def minimum_amount_reached?
    donation.above_minimum?
  end

end
