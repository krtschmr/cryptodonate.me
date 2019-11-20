Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitch, ENV["TWITCH_CLIENT_ID"], ENV["TWITCH_SECRET"], callback_url: "/users/auth/twitch/callback"
  provider :mixer, ENV["MIXER_CLIENT_ID"], ENV["MIXER_SECRET"], callback_url: "/users/auth/mixer/callback"
end
