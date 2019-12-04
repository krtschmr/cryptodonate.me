class Internal::WithdrawalsController < Internal::BaseController

  def new
    @withdrawal = current_streamer.withdrawals.new(coin: current_coin)
  end

  def confirm
    @withdrawal = current_streamer.withdrawals.new create_params.merge(coin: current_coin)
    if @withdrawal.valid?
      render
    else
      render action: :new
    end
  end

  def create
    @withdrawal = current_streamer.withdrawals.new create_params.merge(coin: current_coin)
    if @withdrawal.save
      redirect_to internal_root_path
    else
      render action: :new
    end
  end


  private

  def create_params
    params.require(:withdrawal).permit(:address, :amount)
  end

  def current_coin
    @current_coin ||= Coin.find_by!(symbol: params[:wallet_id])
  end

end
