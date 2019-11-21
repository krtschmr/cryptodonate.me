# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  provider            :string           not null
#  uid                 :string           not null
#  remember_created_at :datetime
#  donation_url        :string
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :string
#  last_sign_in_ip     :string
#  name                :string           not null
#  email               :string           not null
#  description         :string
#  url                 :string
#  token               :string
#  refresh_token       :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class User < ApplicationRecord
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: %i[twitch mixer streamelements streamlabs]

  has_many :donations


  before_create {
    self.donation_url = name.downcase
  }


  def self.by_oauth(hash)
    find_by(provider: hash["provider"], uid: hash["uid"])
  end



end
