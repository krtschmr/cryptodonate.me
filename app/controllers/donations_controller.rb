class DonationsController <  ApplicationController
  layout "donation"

  def new
    @donation = streamer.donations.new
  end

  def create
    @donation = streamer.donations.new(create_params)
    if @donation.save
      redirect_to donation_path(@donation.streamer.donation_url, @donation.uuid)
    else
      render action: :new
    end
  end

  def show
    @donation = streamer.donations.find_by!(uuid: params[:uuid])    
  end

  private

  def streamer
    @streamer ||= User.find_by!(donation_url: params[:donation_url ])
  end

  def create_params
    params.require(:donation).permit(:coin_id, :name, :message)
  end

end
