Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitch, ENV["TWITCH_CLIENT_ID"], ENV["TWITCH_SECRET"], callback_url: "/users/auth/twitch/callback"
  provider :mixer, ENV["MIXER_CLIENT_ID"], ENV["MIXER_SECRET"], callback_url: "/users/auth/mixer/callback"

  # provider :streamelements, ENV["STREAMELEMENTS_CLIENT_ID"], ENV["STREAMELEMENTS_SECRET"], callback_url: "/users/auth/streamelements/callback"
  # provider :streamlabs, ENV["STREAMLABS_CLIENT_ID"], ENV["STREAMLABS_SECRET"], callback_url: "/users/auth/streamlabs/callback"
end
