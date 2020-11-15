class DonationsController <  ApplicationController
  layout "donation"

  def new
    @donation = streamer.donations.new
  end

  def create
    create_params = params.require(:donation).permit(:coin_id, :name, :message, :currency, :amount)
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

  rescue_from ActiveRecord::RecordNotFound do
    render "donations/404"
  end

  def streamer
    @streamer ||= Streamer.find_by!(donation_url: params[:donation_url ])
  end

end
