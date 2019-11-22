class Streamer < ApplicationRecord
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: %i[twitch mixer streamelements streamlabs]

  has_many :donations


  before_create {
    self.donation_url = name.downcase
  }

  def self.by_oauth(hash)
    find_by(provider: hash["provider"], uid: hash["uid"])
  end


  def provided_own_key?(coin)
    xpubkey(coin).present?
  end

  def xpubkey(coin)
    # TODO
    # return the xpubkey for that coin
  end

end

# == Schema Information
#
# Table name: streamers
#
#  id                  :integer          not null, primary key
#  current_sign_in_at  :datetime
#  current_sign_in_ip  :string
#  description         :string
#  donation_url        :string
#  email               :string           not null
#  last_sign_in_at     :datetime
#  last_sign_in_ip     :string
#  name                :string           not null
#  provider            :string           not null
#  refresh_token       :string
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  token               :string
#  uid                 :string           not null
#  url                 :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_streamers_on_provider          (provider)
#  index_streamers_on_provider_and_uid  (provider,uid) UNIQUE
#  index_streamers_on_uid               (uid)
#
