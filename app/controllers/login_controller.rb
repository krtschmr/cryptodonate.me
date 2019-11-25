class LoginController <  Devise::OmniauthCallbacksController


  def mixer
    login_with_oauth(:mixer)
  end

  def twitch
    login_with_oauth(:twitch)
  end


  def streamelements
    connect_with_platform
  end

  def streamlabs
    connect_with_platform
  end

  private

  def connect_with_platform
    raise "login required" unless current_streamer
    hash = request.env["omniauth.auth"]
    platform = current_streamer.connected_platforms.find_or_initialize_by(provider: hash["provider"])
    platform.token = hash["credentials"]["token"]
    platform.refresh_token = hash["credentials"]["refresh_token"]
    platform.name = hash["info"]["name"]
    platform.uid = hash["uid"]
    platform.save
    redirect_to [:internal, :connected_platforms]
  end

  def login_with_oauth(provider)
    streamer_by_oauth(provider)
    @streamer.refresh_profile_photo!
    sign_in(@streamer)
    redirect_to internal_root_path
  end

  def streamer_by_oauth(provider)
    hash = request.env["omniauth.auth"]
    @streamer = Streamer.by_oauth(hash) || Streamer.create do |u|
      u.provider = hash["provider"]
      u.uid = hash["uid"]
      u.name = hash["info"]["name"]
      u.email = hash["info"]["email"]
      u.url = hash["info"]["urls"][provider.to_s.capitalize]
      u.token = hash["credentials"]["token"]
      u.refresh_token = hash["credentials"]["refresh_token"]
    end
  end
end
