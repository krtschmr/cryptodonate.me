class Internal::DonationSettingsController < Internal::BaseController

  def edit    
  end

  def update
    current_streamer.donation_setting.update(update_params)
    redirect_to edit_internal_donation_setting_path
  end

  private

  def update_params
    params.require(:donation_setting).permit(:converted_currency, :minimum_amount_for_notification)
  end


end
