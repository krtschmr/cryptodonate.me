class Streamer < ApplicationRecord
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: %i[twitch mixer streamelements streamlabs]

  has_many :balances
  has_many :donations
  has_many :connected_platforms
  has_many :ledger_entries
  has_one :donation_page_styling, dependent: :destroy
  has_one :donation_setting, dependent: :destroy

  has_many :withdrawals
  has_many :crypto_withdrawals

  before_create {
    self.uuid = SecureRandom.uuid
    self.donation_url = name.downcase
    build_donation_setting
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

  def connected_with?(provider)
    !!connection(provider)
  end

  def connection(provider)
    connected_platforms.find_by(provider: provider.to_s.downcase)
  end

  def provider_class
    "#{provider.classify}Api".constantize
  end

  def refresh_profile_photo!
    # todo
    # either call it async or call it async inside the login controller
    url = provider_class.profile_photo(name, uid)
    update(profile_photo_url: url)
  end

  # def balances(scope = nil)
  #   if scope
  #     balance(scope)
  #   else
  #     bal = active_assets_balances.pluck(:asset, :balance, :reserved, :available).map{|k,b,r,a|
  #       {k => {available: a, reserved: r, balance: b}}
  #     }.reduce(Hash.new, :merge)
  #     bal["BTC"] = {available: 0.0.to_d, reserved: 0.0.to_d, balance: 0.0.to_d}  unless bal["BTC"] # always include EUR or BTC
  #     bal["EUR"] = {available: 0.0.to_d, reserved: 0.0.to_d, balance: 0.0.to_d}  unless bal["EUR"] # always include EUR or BTC
  #     bal
  #   end
  # end

  def balance(coin)
    balances.find_by(coin: coin.to_s.upcase) || balances.create(coin: coin.to_s.upcase)
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
#  profile_photo_url   :string
#  provider            :string           not null
#  refresh_token       :string
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  token               :string
#  uid                 :string           not null
#  url                 :string
#  uuid                :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_streamers_on_provider          (provider)
#  index_streamers_on_provider_and_uid  (provider,uid) UNIQUE
#  index_streamers_on_uid               (uid)
#
