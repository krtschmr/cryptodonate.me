class Donation < ApplicationRecord

  belongs_to :user
  belongs_to :coin
  has_many :crypto_payments


  alias_method :streamer, :user

  before_create {
    self.uuid ||= SecureRandom.uuid
  }

  def to_param
    uuid
  end

end
