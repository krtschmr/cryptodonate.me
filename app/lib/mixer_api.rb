class MixerApi

  def self.profile_photo(_name, uid)
    url = URI.parse("https://mixer.com/api/v1/users/#{uid}/avatar")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.get(url.path)['location']
  end

  private

end
