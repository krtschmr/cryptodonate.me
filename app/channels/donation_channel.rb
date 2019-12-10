class DonationChannel < ApplicationCable::Channel
  def subscribed
    stream_from params[:uuid]
  end

  def receive(data)
    if data["uuid"]
      Donation.find_by(uuid: data["uuid"])  #calls expired? in initializer
    end
  end
  
end
