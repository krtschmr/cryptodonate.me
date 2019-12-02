Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitch, ENV["TWITCH_CLIENT_ID"], ENV["TWITCH_SECRET"], authorize_params: {force_verify: Rails.env.production?}
  provider :mixer, ENV["MIXER_CLIENT_ID"], ENV["MIXER_SECRET"], authorize_params: {force_verify: Rails.env.production?}

  provider :streamelements, ENV["STREAMELEMENTS_CLIENT_ID"], ENV["STREAMELEMENTS_SECRET"]
  provider :streamlabs, ENV["STREAMLABS_CLIENT_ID"], ENV["STREAMLABS_SECRET"], scope: 'donations.create'
end
