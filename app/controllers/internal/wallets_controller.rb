class Internal::WalletsController < Internal::BaseController

  def index
  end

  def show
    @coin = Coin.find_by!(symbol: params[:id])
  end

end
