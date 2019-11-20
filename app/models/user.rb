class User < ApplicationRecord
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: %i[twitch mixer]

  def self.by_oauth(hash)
    find_by(provider: hash["provider"], uid: hash["uid"])
  end

end
