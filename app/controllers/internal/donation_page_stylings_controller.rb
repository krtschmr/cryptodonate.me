class Internal::DonationPageStylingsController < Internal::BaseController

  def edit
    current_streamer.build_donation_page_styling.save unless current_streamer.donation_page_styling.present?
  end

  def update
    current_streamer.donation_page_styling.update(update_params)
    redirect_to edit_internal_donation_page_styling_path
  end

  def destroy
    current_streamer.donation_page_styling.destroy
    redirect_to edit_internal_donation_page_styling_path
  end

  private

  def update_params
    params.require(:donation_page_styling).permit(DonationPageStyling.permitted_attributes)
  end


end
