class Internal::DonationsController < Internal::BaseController

  def index
  end


  def show
    @donation = current_streamer.donations.find_by!(uuid: params[:id])
  end



end
