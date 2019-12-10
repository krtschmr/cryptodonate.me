class StreamlabsApi

    def self.push_donation(donation)
      token = donation.streamer.connected_platforms.find_by(provider: :streamlabs).token

      uri = URI("https://streamlabs.com/api/v1.0/donations")
      params = {
        "name": donation.name,
        "message": donation.message,
        "identifier": (donation.email rescue "error@default.com"),
        "amount": donation.converted_amount.to_f,
        "currency": donation.converted_currency,
      }
      headers = {
          'Authorization'=>"Bearer #{token}",
          'Content-Type' =>'application/json',
          'Accept'=>'application/json'
      }
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      p "POST Donation to Streamlabs: #{params.inspect}" if Rails.env.development?
      response = http.post(uri.path, params.to_json, headers)

    end

end
