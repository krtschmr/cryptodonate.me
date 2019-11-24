class TwitchApi

  def self.profile_photo(name)
    data(name).profile_image_url
  end

  private

  def self.data(name)
    client.get_users({login: name}).data.first
  end

  def self.client
    @client ||= Twitch::Client.new(client_id: ENV["TWITCH_CLIENT_ID"])
  end

end
