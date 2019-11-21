class User < ApplicationRecord
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: %i[twitch mixer streamelements streamlabs]

  has_many :donations


  def self.by_oauth(hash)
    find_by(provider: hash["provider"], uid: hash["uid"])
  end



end
