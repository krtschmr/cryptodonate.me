class NotificationTrigger

  attr_accessor :donation

  def self.call(donation)
    new(donation).process
  end

  def initialize(donation)
    self.donation = donation
  end

  def process
    if minimum_amount_reached?
      execute!
    end
  end

  def execute!
    # Push into active/connected overlays (streamlabs, streamelemetns)
    # Push into our own overlays

    # donation.user.connected_overlays.each(&:push_notification!, donation)
    # donation.user.overlays.active.each(&:push_notification!, donation)

    # test with streamlabs
    provider = :streamlabs
    "#{provider}_api".classify.constantize.push_donation(donation)
  end

  private

  def minimum_amount_reached?
    donation.above_minimum?
  end

end
