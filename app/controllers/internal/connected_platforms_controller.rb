class Internal::ConnectedPlatformsController < Internal::BaseController

  def index
    # list all
  end


  def disconnect
    # POST, disconnect
    connection = current_streamer.connected_platforms.find_by!(provider: params[:id])
    connection.destroy!
    redirect_to [:internal, :connected_platforms]
  end

end
