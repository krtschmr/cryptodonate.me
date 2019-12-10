class StreamelementsApi

  def self.push_donation(donation)
    auth = donation.streamer.connected_platforms.find_by(provider: :streamelements)

    token = auth.token

    uri = URI("https://api.streamelements.com/kappa/v2/tips/#{auth.uid}")
    params = {
      "currency": "USD", #streamelements only goes with USD. really really sad
      "user": {
          "username": donation.name,
          "email": "crypto@cryptodonate.me"
      },
      "amount": donation.usd_value,
      "message": donation.message,
      "provider": "bitcoin",
      "transactionId": "f64ae25bc2220a9af89c8ac10bdf31c5b320e64995f3a81d3d3a517ce3159331"
    }

    headers = {
        'Authorization'=>"OAuth #{token}",
        'Content-Type' =>'application/json',
        'Accept'=>'application/json'
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    p "POST Donation to streamelements: #{params.inspect}" if Rails.env.development?
    response = http.post(uri.path, params.to_json, headers)

  end

end
