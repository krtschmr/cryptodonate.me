class Internal::DonationSettingsController < Internal::BaseController

  def edit
    @setting = current_streamer.donation_setting
  end

  def update
    @setting = current_streamer.donation_setting
    if @setting.update(update_params)
      redirect_to edit_internal_donation_setting_path
    else
      render action: :edit
    end
  end

  private

  def update_params
    params.require(:donation_setting).permit(:converted_currency, :minimum_amount_for_notification)
  end


end
