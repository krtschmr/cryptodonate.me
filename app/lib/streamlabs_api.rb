class StreamlabsApi

  def self.push_donation(donation)
    token = donation.streamer.connected_platforms.find_by(provider: :streamlabs).token

    uri = URI("https://streamlabs.com/api/v1.0/donations")
    #binding.pry
    params = {
      "name": donation.name,
      "message": donation.message,
      "identifier": (donation.email rescue "error@default.com"),
      "amount": donation.amount,
      "currency": donation.currency,
    }
    headers = {
        'Authorization'=>"Bearer #{token}",
        'Content-Type' =>'application/json',
        'Accept'=>'application/json'
    }
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    response = http.post(uri.path, params.to_json, headers)

  end

end
